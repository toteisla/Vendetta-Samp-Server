#include <a_samp>

#define YELLOW 0xFBFB00FF

//------------------------------------------------------------------------------

public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print("         Hospital Interior by PawNFoX");
        print("--------------------------------------\n");
        CreateObject(14671, 1920.316406, -2111.019531, -18.329149, 0.0000, 0.0000, 0.0000);
        CreateObject(2146, 1944.652588, -2118.698730, -19.825382, 0.0000, 0.0000, 0.0000);
        CreateObject(1801, 1941.835327, -2122.621094, -20.306990, 0.0000, 0.0000, 90.0001);
        CreateObject(1801, 1941.803345, -2119.290527, -20.306990, 0.0000, 0.0000, 90.0000);
        CreateObject(1801, 1941.794434, -2115.735107, -20.306990, 0.0000, 0.0000, 90.0000);
        CreateObject(2514, 1943.145264, -2123.997070, -20.311726, 0.0000, 0.0000, 180.0000);
        CreateObject(2517, 1942.205322, -2124.545898, -20.318745, 0.0000, 0.0000, 0.0000);
        CreateObject(2596, 1945.220703, -2121.968262, -17.919817, 0.0000, 0.0000, 270.0000);
        CreateObject(2632, 1942.522705, -2124.765625, -20.364603, 0.0000, 0.0000, 270.0000);
        CreateObject(2842, 1939.127808, -2117.917969, -20.328419, 0.0000, 0.0000, 0.0000);
        CreateObject(2596, 1945.143799, -2118.519287, -17.919847, 0.0000, 0.0000, 270.0000);
        CreateObject(2596, 1945.196411, -2115.144287, -17.919802, 0.0000, 0.0000, 270.0000);
        CreateObject(2225, 1938.298096, -2116.243408, -20.311415, 0.0000, 0.0000, 90.0000);
        CreateObject(2225, 1938.476074, -2119.879883, -20.311415, 0.0000, 0.0000, 90.0000);
        CreateObject(2225, 1938.521118, -2123.184326, -20.311415, 0.0000, 0.0000, 90.0000);
        CreateObject(2190, 1938.570557, -2123.019287, -19.554298, 0.0000, 0.0000, 90.0000);
        CreateObject(2190, 1938.473145, -2119.803711, -19.604298, 0.0000, 0.0000, 90.0000);
        CreateObject(2190, 1938.301392, -2116.178955, -19.579298, 0.0000, 0.0000, 90.0000);
        CreateObject(2294, 1945.059814, -2123.857910, -20.311970, 0.0000, 0.0000, 270.0000);
        CreateObject(2842, 1939.164429, -2114.377686, -20.328419, 0.0000, 0.0000, 0.0000);
        CreateObject(2842, 1939.084473, -2121.369385, -20.328419, 0.0000, 0.0000, 0.0000);
        CreateObject(1998, 1935.449463, -2123.040527, -20.310932, 0.0000, 0.0000, 270.0000);
        CreateObject(7191, 1937.824463, -2133.861084, -18.336254, 0.0000, 0.0000, 0.0000);
        CreateObject(7191, 1961.554321, -2111.843994, -18.336254, 0.0000, 0.0000, 90.0000);
        CreateObject(1491, 1939.418701, -2111.810791, -20.322823, 0.0000, 0.0000, 180.0000);
        CreateObject(18084, 1939.069092, -2112.719482, -16.948509, 0.0000, 0.0000, 180.0000);
        CreateObject(18084, 1942.698730, -2112.763184, -16.025635, 0.0000, 0.0000, 180.0000);
        CreateObject(7191, 1912.582275, -2111.933105, -18.336254, 0.0000, 0.0000, 270.0000);
        CreateObject(1491, 1937.745239, -2111.849365, -20.322823, 0.0000, 0.0000, 180.0000);
        CreateObject(1491, 1934.720337, -2111.907715, -20.322823, 0.0000, 0.0000, 0.0000);
        CreateObject(7191, 1914.986450, -2103.937256, -18.336254, 0.0000, 0.0000, 0.0000);
        CreateObject(7191, 1930.189209, -2135.669922, -18.336254, 0.0000, 0.0000, 360.0000);
        CreateObject(1491, 1930.197388, -2113.569092, -20.322823, 0.0000, 0.0000, 90.0000);
        CreateObject(2007, 1932.147949, -2124.126953, -20.315323, 0.0000, 0.0000, 180.0000);
        CreateObject(2007, 1931.255249, -2124.123047, -20.315323, 0.0000, 0.0000, 180.0000);
        CreateObject(2000, 1930.540161, -2124.092529, -20.315323, 0.0000, 0.0000, 180.0000);
        CreateObject(2161, 1937.727173, -2120.712158, -20.276737, 0.0000, 0.0000, 270.0000);
        CreateObject(2162, 1937.727173, -2118.948242, -20.295057, 0.0000, 0.0000, 270.0000);
        CreateObject(2164, 1937.659912, -2117.182373, -20.317530, 0.0000, 0.0000, 270.0000);
        CreateObject(2167, 1937.699585, -2116.249512, -20.341284, 0.0000, 0.0000, 270.0000);
        CreateObject(2200, 1930.431274, -2122.004395, -20.311747, 0.0000, 0.0000, 90.0000);
        CreateObject(2164, 1930.342041, -2119.809570, -20.326447, 0.0000, 0.0000, 90.0000);
        CreateObject(2167, 1930.360352, -2118.052979, -20.316284, 0.0000, 0.0000, 90.0000);
        CreateObject(2161, 1937.727173, -2120.708252, -18.921749, 0.0000, 0.0000, 270.0000);
        CreateObject(2162, 1930.291992, -2119.827148, -18.546812, 0.0000, 0.0000, 90.0000);
        CreateObject(2163, 1935.516479, -2124.581055, -18.372620, 0.0000, 0.0000, 180.0000);
        CreateObject(2008, 1933.625366, -2123.063721, -20.310932, 0.0000, 0.0000, 0.0000);
        CreateObject(1806, 1934.677612, -2123.904297, -20.291283, 0.0000, 0.0000, 0.0000);
        CreateObject(1806, 1935.804810, -2123.996582, -20.291283, 0.0000, 0.0000, 270.0000);
        CreateObject(3383, 1920.587036, -2108.663818, -20.310932, 0.0000, 0.0000, 0.0000);
        CreateObject(3383, 1920.568359, -2105.134033, -20.310932, 0.0000, 0.0000, 180.0000);
        CreateObject(3383, 1926.522217, -2105.201660, -20.310932, 0.0000, 0.0000, 180.0000);
        CreateObject(3383, 1926.520874, -2108.529053, -20.310932, 0.0000, 0.0000, 0.0000);
        CreateObject(1708, 1930.946655, -2115.770752, -20.310976, 0.0000, 0.0000, 90.0000);
        CreateObject(1708, 1930.964111, -2117.300781, -20.310976, 0.0000, 0.0000, 90.0000);
        CreateObject(1722, 1934.053345, -2112.539063, -20.310730, 0.0000, 0.0000, 180.0000);
        CreateObject(1722, 1933.075195, -2112.566162, -20.310730, 0.0000, 0.0000, 180.0000);
        CreateObject(1722, 1937.521362, -2115.071045, -20.310730, 0.0000, 0.0000, 90.0000);
        CreateObject(1722, 1937.506592, -2114.116699, -20.310730, 0.0000, 0.0000, 90.0000);
        CreateObject(2146, 1930.821533, -2103.184570, -19.825382, 0.0000, 0.0000, 270.0000);
        CreateObject(2146, 1923.793457, -2103.090088, -19.825382, 0.0000, 0.0000, 270.0000);
        CreateObject(2146, 1922.961548, -2111.129395, -19.825382, 0.0000, 0.0000, 270.0000);
        CreateObject(2008, 1915.549927, -2106.774414, -20.310932, 0.0000, 0.0000, 0.0000);
        CreateObject(2008, 1917.386475, -2107.597168, -20.310932, 0.0000, 0.0000, 270.0000);
        CreateObject(2008, 1917.374878, -2109.526611, -20.310932, 0.0000, 0.0000, 270.0000);
        CreateObject(2190, 1928.039795, -2105.195313, -19.259876, 0.0000, 0.0000, 45.0000);
        CreateObject(2190, 1927.658325, -2108.213135, -19.259876, 0.0000, 0.0000, 135.0000);
        CreateObject(2190, 1921.692017, -2108.441162, -19.259876, 0.0000, 0.0000, 135.0000);
        CreateObject(2190, 1921.979736, -2105.015381, -19.259876, 0.0000, 0.0000, 45.0000);
        CreateObject(2164, 1927.085083, -2100.907227, -20.317530, 0.0000, 0.0000, 0.0000);
        CreateObject(2164, 1915.134766, -2103.808838, -20.317530, 0.0000, 0.0000, 90.0000);
        CreateObject(2164, 1915.130371, -2105.539551, -20.317530, 0.0000, 0.0000, 90.0000);
        CreateObject(2162, 1916.946899, -2102.523438, -20.315102, 0.0000, 0.0000, 0.0000);
        CreateObject(2162, 1915.080322, -2110.733887, -20.255934, 0.0000, 0.0000, 90.0000);
        CreateObject(2164, 1915.132446, -2108.978271, -20.317530, 0.0000, 0.0000, 90.0000);
        CreateObject(7191, 1932.774170, -2088.226563, -18.336254, 0.0000, 0.0000, 180.0001);
        CreateObject(1491, 1932.853760, -2111.863037, -20.322823, 0.0000, 0.0000, 90.0000);
        CreateObject(2371, 1920.384155, -2101.982422, -18.938208, 0.0000, 275.7753, 90.0000);
        CreateObject(2381, 1919.809448, -2103.027100, -19.436613, 0.0000, 0.0000, 0.0000);
        CreateObject(2394, 1919.782471, -2102.995850, -18.812122, 0.0000, 0.0000, 0.0000);
        CreateObject(7191, 1959.890015, -2111.812012, -14.454750, 0.0000, 0.0000, 90.0000);
        CreateObject(7191, 1915.707642, -2111.859863, -14.511251, 0.0000, 0.0000, 270.0000);
        CreateObject(1726, 1944.788208, -2103.902344, -20.318518, 0.0000, 0.0000, 270.0000);
        CreateObject(1726, 1944.766479, -2107.554688, -20.318518, 0.0000, 0.0000, 270.0000);
        CreateObject(1727, 1942.064453, -2103.629395, -20.318504, 0.0000, 0.0000, 0.0000);
        CreateObject(1726, 1933.975952, -2103.002930, -20.318518, 0.0000, 0.0000, 0.0000);
        CreateObject(1726, 1933.392578, -2105.606445, -20.318518, 0.0000, 0.0000, 90.0000);
        CreateObject(1726, 1933.367676, -2107.885742, -20.318518, 0.0000, 0.0000, 90.0000);
        CreateObject(7191, 1945.648193, -2124.174805, -18.336254, 0.0000, 0.0000, 180.0000);
        CreateObject(7191, 1937.120728, -2102.420654, -18.336254, 0.0000, 0.0000, 270.0000);
        CreateObject(7191, 1924.752808, -2102.423828, -14.404360, 0.0000, 0.0000, 270.0000);
        CreateObject(7191, 1932.470093, -2124.592285, -18.336254, 0.0000, 0.0000, 90.0000);
        CreateObject(2762, 1942.792480, -2108.818115, -19.905745, 0.0000, 0.0000, 270.0000);
        CreateObject(2763, 1942.559814, -2105.382568, -19.905745, 0.0000, 0.0000, 0.0000);
        CreateObject(2762, 1936.399170, -2105.094238, -19.905745, 0.0000, 0.0000, 0.0000);
        CreateObject(2762, 1935.838989, -2106.598389, -19.905745, 0.0000, 0.0000, 270.0000);
        CreateObject(2762, 1939.278687, -2107.175293, -19.905745, 0.0000, 0.0000, 270.0000);
        CreateObject(2762, 1938.222412, -2107.176758, -19.905745, 0.0000, 0.0000, 270.0000);
        CreateObject(1727, 1939.295410, -2109.203125, -20.318504, 0.0000, 0.0000, 180.0000);
        CreateObject(1727, 1938.331421, -2105.366455, -20.318504, 0.0000, 0.0000, 0.0000);
        CreateObject(1727, 1940.374634, -2106.602783, -20.318504, 0.0000, 0.0000, 270.0000);
        CreateObject(2164, 1939.757080, -2102.644043, -20.317530, 0.0000, 0.0000, 0.0000);
        CreateObject(2164, 1938.021973, -2102.647461, -20.317530, 0.0000, 0.0000, 0.0000);
        CreateObject(2162, 1938.975342, -2102.545166, -18.484613, 0.0000, 0.0000, 0.0000);
        CreateObject(2816, 1939.097290, -2106.793701, -19.487812, 0.0000, 0.0000, 0.0000);
        CreateObject(2813, 1938.396362, -2107.639404, -19.487682, 0.0000, 0.0000, 0.0000);
        CreateObject(2826, 1935.880615, -2105.389648, -19.487720, 0.0000, 0.0000, 0.0000);
        CreateObject(2827, 1942.507446, -2105.374756, -19.473944, 0.0000, 0.0000, 0.0000);
        CreateObject(2829, 1942.880981, -2108.282715, -19.487682, 0.0000, 0.0000, 337.5000);
        CreateObject(2853, 1935.820923, -2107.167480, -19.487741, 0.0000, 0.0000, 0.0000);
        CreateObject(2855, 1933.463257, -2107.478027, -19.798683, 0.0000, 0.0000, 337.5000);
        CreateObject(2297, 1941.693237, -2111.447021, -20.316912, 0.0000, 0.0000, 135.0000);
        CreateObject(18084, 1936.491089, -2112.775635, -17.060766, 0.0000, 0.0000, 180.0000);
        CreateObject(18084, 1935.038696, -2112.785889, -17.063675, 0.0000, 0.0000, 180.0000);
        CreateObject(18084, 1933.684326, -2110.609619, -17.010744, 0.0000, 0.0000, 270.0000);
        CreateObject(18084, 1931.040161, -2113.303223, -16.951126, 0.0000, 0.0000, 270.0000);
        CreateObject(12842, 1924.250854, -2119.015381, -19.856260, 0.0000, 0.0000, 180.0000);
        CreateObject(2457, 1918.963501, -2113.575195, -20.311718, 0.0000, 0.0000, 90.0000);
        CreateObject(2457, 1918.974854, -2115.503418, -20.311718, 0.0000, 0.0000, 90.0000);
        CreateObject(2457, 1918.996948, -2117.375732, -20.311718, 0.0000, 0.0000, 90.0000);
        CreateObject(2454, 1918.842529, -2118.440186, -20.315512, 0.0000, 0.0000, 0.0000);
        CreateObject(2455, 1917.941650, -2118.427979, -20.300747, 0.0000, 0.0000, 0.0000);
        CreateObject(2455, 1917.013184, -2118.421387, -20.300747, 0.0000, 0.0000, 0.0000);
        CreateObject(1514, 1917.999390, -2118.455078, -19.006407, 0.0000, 0.0000, 0.0000);
        CreateObject(955, 1918.965454, -2123.842285, -19.907885, 0.0000, 0.0000, 180.0000);
        CreateObject(956, 1917.437866, -2123.937500, -19.906919, 0.0000, 0.0000, 191.2500);
        CreateObject(2431, 1915.089111, -2114.595459, -17.892643, 0.0000, 0.0000, 90.0000);
        CreateObject(2430, 1915.089111, -2118.682373, -17.928322, 0.0000, 0.0000, 90.0000);
        CreateObject(2431, 1915.662354, -2112.035889, -17.884180, 0.0000, 0.0000, 0.0000);
        CreateObject(1481, 1915.464966, -2112.625977, -19.607807, 0.0000, 0.0000, 90.0000);
        CreateObject(2130, 1915.601563, -2114.627930, -20.311216, 0.0000, 0.0000, 90.0000);
        CreateObject(2127, 1915.581055, -2116.603027, -20.311970, 0.0000, 0.0000, 90.0000);
        CreateObject(1481, 1915.498413, -2117.738281, -19.607807, 0.0000, 0.0000, 90.0000);
        CreateObject(1649, 1923.880371, -2124.462891, -18.457897, 0.0000, 0.0000, 180.0000);
        CreateObject(1649, 1915.169312, -2106.339844, -18.275267, 0.0000, 0.0000, 90.0000);
        CreateObject(1649, 1927.627075, -2102.599121, -18.316463, 0.0000, 0.0000, 360.0000);
        CreateObject(1649, 1945.530762, -2105.665771, -18.132938, 0.0000, 0.0000, 269.9999);
        CreateObject(1649, 1941.359497, -2124.473145, -18.169756, 0.0000, 0.0000, 180.0001);
        CreateObject(955, 1933.301880, -2109.120850, -19.907885, 0.0000, 0.0000, 90.0000);
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/hospital", cmdtext, true, 10) == 0)
        {
            new name[MAX_PLAYER_NAME],string[128];
            GetPlayerName(playerid,name,sizeof(name));
            format(string,sizeof(string),"*** %s has teleported to the Hospital! (/hospital)",name);
            SendClientMessage(playerid,YELLOW,string);
            SetPlayerPos(playerid,1935.4089,-2110.2100,-19.3109);
            SetPlayerFacingAngle(playerid,322.2638);
            return 1;
        }
        return 0;
}