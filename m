From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 2/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Mon, 10 Apr 2017 09:24:05 +0100
Message-ID: <3135e238-48a3-3693-bb59-63bf2a6d8d0e@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <1490710443-27425-3-git-send-email-jonathanh@nvidia.com>
 <edbd9d3a-d978-6f64-b1aa-3b1ea226a8bd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15594 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdDJIYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 04:24:21 -0400
In-Reply-To: <edbd9d3a-d978-6f64-b1aa-3b1ea226a8bd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org


On 10/04/17 05:09, Rajendra Nayak wrote:
> Hey Jon,
> 
> On 03/28/2017 07:44 PM, Jon Hunter wrote:
>> The current generic PM domain framework (GenDP) only allows a single
>> PM domain to be associated with a given device. There are several
>> use-cases for various system-on-chip devices where it is necessary for
>> a PM domain consumer to control more than one PM domain where the PM
>> domains:
>> i).  Do not conform to a parent-child relationship so are not nested
>> ii). May not be powered on and off at the same time so need independent
>>      control.
>>
>> To support the above, add new APIs for GenPD to allow consumers to get,
>> power-on, power-off and put PM domains so that they can be explicitly
>> controlled by the consumer.
> 
> thanks for working on this RFC.
> 
> []..
>   
>> +/**
>> + * pm_genpd_get - Get a generic I/O PM domain by name
>> + * @name: Name of the PM domain.
>> + *
>> + * Look-ups a PM domain by name. If found, increment the device
>> + * count for PM domain to ensure that the PM domain cannot be
>> + * removed, increment the suspended count so that it can still
>> + * be turned off (when not in-use) and return a pointer to its
>> + * generic_pm_domain structure. If not found return ERR_PTR().
>> + */
>> +struct generic_pm_domain *pm_genpd_get(const char *name)
>> +{
>> +	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-EEXIST);
>> +
>> +	if (!name)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	mutex_lock(&gpd_list_lock);
>> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>> +		if (!strcmp(gpd->name, name)) {
>> +			genpd_lock(gpd);
>> +			gpd->device_count++;
> 
> There apis' should also take a device pointer as a parameter,
> so we can track all the devices belonging to a powerdomain.
> That would also mean keeping the genpd->dev_list updated instead of
> only incrementing the device_count here.

I had contemplated that and I am happy to do that if that is what the
consensus wants. However, my only reservation about doing that was it
only allows devices to call the APIs, but maybe that is ok. I was trying
to keep it similar to the clk and regulator APIs.

>> +			gpd->suspended_count++;
>> +			genpd_unlock(gpd);
>> +			genpd = gpd;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&gpd_list_lock);
>> +
>> +	return genpd;
> 
> Instead of returning a pointer to generic_pm_domain to all
> consumers (who are then free to poke around it) we should hide
> all internal structures handled by the framework and only expose
> some kind of a handle to all the consumers.
> That would also mean having a clear split of the headers to
> distinguish between what's accessible to consumers vs providers.

OK, I will take a look at that.

Cheers
Jon

-- 
nvpublic
