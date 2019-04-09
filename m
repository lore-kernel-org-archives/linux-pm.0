From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the interconnect
 bandwidth
Date: Tue, 9 Apr 2019 17:37:12 +0300
Message-ID: <0cb2d777-4d05-2b06-e458-755d171b3436@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-3-georgi.djakov@linaro.org>
 <20190314063047.urmzez52bdyrkdsu@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314063047.urmzez52bdyrkdsu@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 3/14/19 08:30, Viresh Kumar wrote:
> On 13-03-19, 11:00, Georgi Djakov wrote:
>> The OPP bindings now support bandwidth values, so add support to parse it
>> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
>> is part of the dev_pm_opp.
>>
>> Also add and export the dev_pm_opp_set_path() and dev_pm_opp_put_path()
>> helpers, to set (and release) an interconnect path to a device. The
>> bandwidth of this path will be updated when the OPPs are switched.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/opp/core.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/opp/of.c       | 44 +++++++++++++++++++++++++++
>>  drivers/opp/opp.h      |  6 ++++
>>  include/linux/pm_opp.h | 14 +++++++++
>>  4 files changed, 131 insertions(+)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index e06a0ab05ad6..4b019cecaa07 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/export.h>
>> +#include <linux/interconnect.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/regulator/consumer.h>
>>  
>> @@ -1645,6 +1646,72 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
>>  
>> +/**
>> + * dev_pm_opp_set_path() - Set interconnect path for a device
>> + * @dev: Device for which interconnect path is being set.
>> + * @name: Interconnect path name or NULL.
>> + *
>> + * This must be called before any OPPs are initialized for the device.
>> + */
>> +struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name)
> 
> Maybe the OPP core can do it itself in a similar way to how we do
> clk_get() today ?

Do you mean to directly call of_icc_get() in _allocate_opp_table()?

[..]
>> +static int opp_parse_icc_bw(struct dev_pm_opp *opp, struct device *dev,
>> +			    struct opp_table *opp_table)
>> +{
>> +	struct property *prop = NULL;
>> +	char name[NAME_MAX];
>> +	int count;
>> +	u32 avg = 0;
>> +	u32 peak = 0;
> 
> Why init to 0 ?

Right, seems not necessary.

>> +
>> +	/* Search for "opp-bw-MBs" */
>> +	sprintf(name, "opp-bw-MBs");
>> +	prop = of_find_property(opp->np, name, NULL);
>> +
>> +	/* Missing property is not a problem */
>> +	if (!prop) {
>> +		dev_dbg(dev, "%s: Missing opp-bw-MBs\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	count = of_property_count_u32_elems(opp->np, name);
>> +	if (count != 2) {
>> +		dev_err(dev, "%s: Invalid number of elements in %s property\n",
>> +			__func__, name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	opp->bandwidth = kzalloc(sizeof(*opp->bandwidth), GFP_KERNEL);
> 
> You forgot to free it.

Will fix.

[..]>> +/**
>> + * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
>> + * @avg:	Average bandwidth corresponding to this OPP (in icc units)
>> + * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
>> + *
>> + * This structure stores the bandwidth values for a single interconnect path.
>> + */
>> +struct dev_pm_opp_icc_bw {
>> +	u32 avg;
>> +	u32 peak;
>> +};
> 
> There is only one user of this structure, maybe we can directly add
> the elements in teh dev_pm_opp structure.

Ok, will do it.

Thanks,
Georgi
