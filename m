From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Mon, 10 Apr 2017 15:32:32 +0530
Message-ID: <673fbd2f-3fcb-453b-be84-668ce659abb4@codeaurora.org>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <1490710443-27425-3-git-send-email-jonathanh@nvidia.com>
 <edbd9d3a-d978-6f64-b1aa-3b1ea226a8bd@codeaurora.org>
 <3135e238-48a3-3693-bb59-63bf2a6d8d0e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3135e238-48a3-3693-bb59-63bf2a6d8d0e-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
Cc: stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 04/10/2017 01:54 PM, Jon Hunter wrote:
> 
> On 10/04/17 05:09, Rajendra Nayak wrote:
>> Hey Jon,
>>
>> On 03/28/2017 07:44 PM, Jon Hunter wrote:
>>> The current generic PM domain framework (GenDP) only allows a single
>>> PM domain to be associated with a given device. There are several
>>> use-cases for various system-on-chip devices where it is necessary for
>>> a PM domain consumer to control more than one PM domain where the PM
>>> domains:
>>> i).  Do not conform to a parent-child relationship so are not nested
>>> ii). May not be powered on and off at the same time so need independent
>>>      control.
>>>
>>> To support the above, add new APIs for GenPD to allow consumers to get,
>>> power-on, power-off and put PM domains so that they can be explicitly
>>> controlled by the consumer.
>>
>> thanks for working on this RFC.
>>
>> []..
>>   
>>> +/**
>>> + * pm_genpd_get - Get a generic I/O PM domain by name
>>> + * @name: Name of the PM domain.
>>> + *
>>> + * Look-ups a PM domain by name. If found, increment the device
>>> + * count for PM domain to ensure that the PM domain cannot be
>>> + * removed, increment the suspended count so that it can still
>>> + * be turned off (when not in-use) and return a pointer to its
>>> + * generic_pm_domain structure. If not found return ERR_PTR().
>>> + */
>>> +struct generic_pm_domain *pm_genpd_get(const char *name)
>>> +{
>>> +	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-EEXIST);
>>> +
>>> +	if (!name)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	mutex_lock(&gpd_list_lock);
>>> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>>> +		if (!strcmp(gpd->name, name)) {

Also looking up the powerdomain this way means the consumers need
to know the _exact_ name with which the providers have registered
the powerdomains?

>>> +			genpd_lock(gpd);
>>> +			gpd->device_count++;
>>
>> There apis' should also take a device pointer as a parameter,
>> so we can track all the devices belonging to a powerdomain.
>> That would also mean keeping the genpd->dev_list updated instead of
>> only incrementing the device_count here.
> 
> I had contemplated that and I am happy to do that if that is what the
> consensus wants. However, my only reservation about doing that was it
> only allows devices to call the APIs, but maybe that is ok. I was trying
> to keep it similar to the clk and regulator APIs.
> 
>>> +			gpd->suspended_count++;
>>> +			genpd_unlock(gpd);
>>> +			genpd = gpd;
>>> +			break;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&gpd_list_lock);
>>> +
>>> +	return genpd;
>>
>> Instead of returning a pointer to generic_pm_domain to all
>> consumers (who are then free to poke around it) we should hide
>> all internal structures handled by the framework and only expose
>> some kind of a handle to all the consumers.
>> That would also mean having a clear split of the headers to
>> distinguish between what's accessible to consumers vs providers.
> 
> OK, I will take a look at that.
> 
> Cheers
> Jon
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
