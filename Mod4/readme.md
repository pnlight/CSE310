# Overview

In this module I am using PostgreSQL to create and host a geodatabase in ArcGIS. A geodatabase is a specialized database designed for geographic data, incorporating spatial and attribute information. 

This module would be very rudimentary but it's the building block for my module 5 and 6 project which would be a full ArcGIS server implementation with custom mobile and web applications.

This is also what I would be doing when I graduate in five weeks. I just accepted a job as a GIS coordinator for a city here in Idaho.

This will be a multi-part project.

[Software Demo Video](http://youtube.link.goes.here)

# Relational Database

PostgreSQL is an open-source relational database known for its versatility, handling complex queries and transactions. PostGIS, an extension for PostgreSQL, enhances its capabilities by adding support for geographic objects, making it ideal for spatial data management. Together, PostgreSQL and PostGIS create a powerful solution for handling both traditional and geospatial information. This combination is particularly valuable in applications like ArcGIS, where seamless integration of relational and spatial data is essential for tasks such as mapping and spatial analysis. The synergy between PostgreSQL and PostGIS allows for efficient storage, indexing, and querying of diverse data types within a single database system.

I am using data that my team and I have gathered and local files that the school GIS Coordinator provided to me. I'll be using this to create layers to do GIS analysis later.

# Development Environment

I'm using ArcGIS Enterprise to do the analysis from the SQL tables I'll be creating. 

Most of the work in the backend will be handled by PostgreSQL and PostGIS. The analysis and hosting will be handled by ArcGIS Enterprise. As I mentioned the other part of this project will be spatial analysis which will be tackled next module.

## ArcGIS Products
- [ArcGIS Portal](https://www.arcgis.com/)
- [ArcGIS Server](https://www.esri.com/en-us/arcgis/products/arcgis-server/overview)
- [ArcGIS Web Adaptor](https://enterprise.arcgis.com/en/web-adaptor/latest/install/iis/what-is-web-adaptor-.htm)

## Database and Geospatial Tools
- [PostgreSQL](https://www.postgresql.org/)
- [PostGIS](https://postgis.net/)
- [OpenSSL](https://www.openssl.org/)

# Future Work

- Enable fieldmaps
- Enable GPS collection and data store in Postgres