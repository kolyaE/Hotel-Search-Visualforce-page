public class MyController {
    
    String hotelName;
    public Integer quantity;
    Date dateFrom;
    Date dateTo;
    List<PriceWrapper> wrappedList = new List<PriceWrapper>();
    List<Booked_Room__c> checkedList = new List<Booked_Room__c>();
    Integer costTripPrice, sellingTripPrice;
    Trip__c newTrip;
    
    public MyController () { 
    }
    
    public String getHotelName () {
        return hotelName;
    }
    
    public void setHotelName (String hotelInputValue) {
        hotelName = hotelInputValue;
    }
    
    public Integer getQuantity () {
        return quantity;
    }
    
    public void setQuantity (Integer quantityInputValue) {
        quantity = quantityInputValue;
    }
    
    public Date getDateTo () {
        return dateTo;
    }
    
    public void setDateTo (Date dateToInputValue) {
        dateTo = dateToInputValue;
    }
    
    public Date getDateFrom () {
        return dateFrom;
    }
    
    public void setDateFrom (Date dateFromInputValue) {
        dateFrom = dateFromInputValue;
    }
    
    public List<PriceWrapper> getResults () {
        return wrappedList;
        
    }
    
    public PageReference searchMe() {
        wrappedList.clear();
        if (dateFrom <= dateTo && quantity > 0) {
            for (Price__c p : [SELECT Room__r.Name, 
                               Cost_Value__c, 
                               Sell_Value__c, 
                               Room__r.Hotel__c, 
                               Room__r.Id	
                               FROM Price__c 
                               WHERE (Room__r.Hotel__r.Name = :hotelName 
                                      AND Date_from__c < :dateFrom 
                                      AND Date_to__c > :datetO)]) {
                                          wrappedList.add(new PriceWrapper(p, quantity));
                                      }
        } else {
            //invalid data input
        }        
        return null;
    }
    
    public PageReference saveToBooked() { 
        checkedList.clear();
        costTripPrice = 0;
        sellingTripPrice = 0;
        newTrip = new Trip__c(Name = 'Trip ' + Math.random()*Math.random()*100);
        for (PriceWrapper pw : wrappedList) {
            if (pw.isChecked == true) {
                costTripPrice += pw.costTotalPrice;
                sellingTripPrice += pw.sellingTotalPrice;
                Booked_Room__c newBR = new Booked_Room__c(Name = pw.price.Room__r.Name, 
                                                          Cost_Value__c = pw.costTotalPrice, 
                                                          Sell_Value__c = pw.sellingTotalPrice, 
                                                          Revenue__c = pw.sellingTotalPrice - pw.costTotalPrice, 
                                                          Room__c = pw.roomc.Id,
                                                          Hotel__c = pw.hotelc.Id, 
                                                          Quantity__c = pw.quantity);
                checkedList.add(newBR);
            }           
        }
        newTrip.Cost__c = costTripPrice;
        newTrip.Sell__c = sellingTripPrice;
        newTrip.Revenue__c = sellingTripPrice - costTripPrice;
        if (checkedList.size() > 0) {
            insertData();
        } else {
            // nothing to insert
        }
        return null;
    }
    
    public void insertData() {
        insert newTrip;
        for (Booked_Room__c newB : checkedList) {
            newB.Trip__c = newTrip.Id;
            insert newB;
        }
    }
    
    public class PriceWrapper {
        public Price__c price{get; set;}
        public Boolean isChecked{get; set;}
        public Integer costTotalPrice{get; set;}
        public Integer sellingTotalPrice{get; set;}
        public Integer quantity{get; set;}
        public Hotel__c hotelc{get; set;}
        public Room__c roomc{get; set;}
        
        public PriceWrapper(Price__c pr, Integer qua) {
            price = pr;
            quantity = qua;
            isChecked = false;
            costTotalPrice = (pr.Cost_Value__c * qua).intValue();
            sellingTotalPrice = (pr.Sell_Value__c * qua).intValue();
            hotelc = new Hotel__c(Id = pr.Room__r.Hotel__c);
            roomc = new Room__c(Id = pr.Room__r.Id);
        }
    }
}