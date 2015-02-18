#### Fuse CXF DEMO

http://localhost:8181/cxf/camel-example-cxf-blueprint/webservices/incident?wsdl

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:rep="http://reportincident.example.camel.apache.org">
   <soapenv:Header/>
   <soapenv:Body>
      <rep:inputReportIncident>
         <incidentId>?</incidentId>
         <incidentDate>?</incidentDate>
         <givenName>?</givenName>
         <familyName>?</familyName>
         <summary>?</summary>
         <details>?</details>
         <email>?</email>
         <phone>?</phone>
      </rep:inputReportIncident>
   </soapenv:Body>
</soapenv:Envelope>

<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
   <soap:Body>
      <ns2:outputReportIncident xmlns:ns2="http://reportincident.example.camel.apache.org">
         <code>OK10</code>
      </ns2:outputReportIncident>
   </soap:Body>
</soap:Envelope>


http://localhost:8181/cxf/camel-example-cxf-blueprint/webservices/ticket?wsdl

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cre="http://createticket.example.camel.apache.org">
   <soapenv:Header/>
   <soapenv:Body>
      <cre:inputCreateTicket>
         <summary>?</summary>
      </cre:inputCreateTicket>
   </soapenv:Body>
</soapenv:Envelope>

<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
   <soap:Body>
      <ns2:outputCreateTicket xmlns:ns2="http://reportincident.example.camel.apache.org">
         <code>3</code>
      </ns2:outputCreateTicket>
   </soap:Body>
</soap:Envelope>

