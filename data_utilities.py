# %%
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import folium
from folium.plugins import MarkerCluster, GroupedLayerControl

# %% [markdown]
# # Data Cleaning and Processing

# %%
# Data source: https://data.winnipeg.ca/Contact-Centre-311/311-Service-Request/4her-3th5
DF = pd.read_csv("./assets/311_Service_Request.csv")
DF.drop(["Zip Codes", "Location 1", "Wards", "Neighborhoods", "Electoral Ward 2018"], axis=1, inplace=True)
DF["Date"] = DF["Date"].astype("datetime64") # type: ignore
DF["Service Area and Request"] = DF["Service Request"].map(str) + ", " + DF["Service Area"]
DF.dropna(inplace=True)

DF["Neighbourhood"].replace("Logan-C.p.r.", "Logan-C.P.R.", inplace=True)

# %% [markdown]
# ## Helper functions

# %%
# Bar chart of Service Request for certain neighbourhoods
def column_contains(column: str, neighbourhoods: list) -> str:
    ret = ""
    for neighbourhood in neighbourhoods:
        ret += f' or `{column}`.str.contains("{neighbourhood}", regex=False, na=False)'
    return ret[4:]

def top_n(n: int, group_by: str, ascending = False) -> list:
    return [key for key in DF.groupby(group_by).size().sort_values().nlargest(n).to_dict()] if not ascending else [key for key in DF.groupby(group_by).size().sort_values().nsmallest(n).to_dict()]


# %% [markdown]
# ## Services

# %%
# services = DF["Service Area and Request"].unique().tolist()
services = DF["Service Request"].unique().tolist()
services.sort()

services.insert(3, services[3])

def print_services():
    for i, item in enumerate(services):
        print(f'{i}: {item}')


