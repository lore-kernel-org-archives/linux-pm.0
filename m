From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 2/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Mon, 10 Apr 2017 20:48:38 +0100
Message-ID: <578a6dfc-226f-adf0-5405-279e116a821d@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <1490710443-27425-3-git-send-email-jonathanh@nvidia.com>
 <edbd9d3a-d978-6f64-b1aa-3b1ea226a8bd@codeaurora.org>
 <3135e238-48a3-3693-bb59-63bf2a6d8d0e@nvidia.com>
 <673fbd2f-3fcb-453b-be84-668ce659abb4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <673fbd2f-3fcb-453b-be84-668ce659abb4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 10/04/17 11:02, Rajendra Nayak wrote:
> 
> 
> On 04/10/2017 01:54 PM, Jon Hunter wrote:
>>
>> On 10/04/17 05:09, Rajendra Nayak wrote:
>>> Hey Jon,
>>>
>>> On 03/28/2017 07:44 PM, Jon Hunter wrote:
>>>> The current generic PM domain framework (GenDP) only allows a single
>>>> PM domain to be associated with a given device. There are several
>>>> use-cases for various system-on-chip devices where it is necessary for
>>>> a PM domain consumer to control more than one PM domain where the PM
>>>> domains:
>>>> i).  Do not conform to a parent-child relationship so are not nested
>>>> ii). May not be powered on and off at the same time so need independent
>>>>      control.
>>>>
>>>> To support the above, add new APIs for GenPD to allow consumers to get,
>>>> power-on, power-off and put PM domains so that they can be explicitly
>>>> controlled by the consumer.
>>>
>>> thanks for working on this RFC.
>>>
>>> []..
>>>   
>>>> +/**
>>>> + * pm_genpd_get - Get a generic I/O PM domain by name
>>>> + * @name: Name of the PM domain.
>>>> + *
>>>> + * Look-ups a PM domain by name. If found, increment the device
>>>> + * count for PM domain to ensure that the PM domain cannot be
>>>> + * removed, increment the suspended count so that it can still
>>>> + * be turned off (when not in-use) and return a pointer to its
>>>> + * generic_pm_domain structure. If not found return ERR_PTR().
>>>> + */
>>>> +struct generic_pm_domain *pm_genpd_get(const char *name)
>>>> +{
>>>> +	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-EEXIST);
>>>> +
>>>> +	if (!name)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	mutex_lock(&gpd_list_lock);
>>>> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>>>> +		if (!strcmp(gpd->name, name)) {
> 
> Also looking up the powerdomain this way means the consumers need
> to know the _exact_ name with which the providers have registered
> the powerdomains?

Yes, this provides a means for someone not using DT to lookup a PM
domain. How else would you do it?

Patch 3/4 allows you to use DT instead, which I imagine anyone using DT
would use.

Jon

-- 
nvpublic
