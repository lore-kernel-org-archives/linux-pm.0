From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 02/12] PM / Domains: Support IRQ safe PM domains
Date: Tue, 1 Mar 2016 10:44:22 -0700
Message-ID: <20160301174422.GJ1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-3-git-send-email-lina.iyer@linaro.org>
 <20160226181753.GU28849@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160226181753.GU28849@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26 2016 at 11:17 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
>> index 8ba6625..c06f0b6 100644
>> --- a/Documentation/power/devices.txt
>> +++ b/Documentation/power/devices.txt
>> @@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharing a power resource can be put
>>  into a low-power state together at the same time by turning off the shared
>>  power resource.  Of course, they also need to be put into the full-power state
>>  together, by turning the shared power resource on.  A set of devices with this
>> -property is often referred to as a power domain.
>> +property is often referred to as a power domain. A power domain may also be
>> +nested inside another power domain.
>> +
>> +Devices, by default, operate in process context and if a device can operate in
>> +IRQ safe context, has to be explicitly set as IRQ safe. Power domains by
>
>Devices, by default, operate in process context. If a device can
>operate in IRQ safe context that has to be explicitly indicated
>by setting the irq_safe boolean inside struct generic_pm_domain
>to true. Power domains typically operate in process context...
>
Done.

>> +default, operate in process context but could have devices that are IRQ safe.
>> +Such power domains cannot be powered on/off during runtime PM. On the other
>> +hand, an IRQ safe PM domains that have IRQ safe devices may be powered off
>
>On the other hand, IRQ safe PM domains that have ..
>
Done.

>> +when all the devices are in idle. An IRQ safe domain may only be attached as a
>
>all the devices in the domain?
>
Devices need not be IRQ safe.

<...>

>> +static struct genpd_lock_fns no_sleep_lock = {
>
>const?
>
OK

...

>> +	/*
>> +	 * As we dont power off a non IRQ safe domain, which holds
>
>s/dont/don't/
>
>> +	 * an IRQ safe device, we dont need to restore power to it.
>
>s/dont/don't/
>
Done to both.
>> +	 */
>> +	if (dev->power.irq_safe && !genpd->irq_safe) {
>>  		timed = false;
>>  		goto out;
>>  	}
>> @@ -1296,6 +1359,13 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>>  		return -EINVAL;
>>
>> +	if (genpd->irq_safe && !dev->power.irq_safe) {
>> +		dev_err(dev,
>> +			"PM Domain %s is IRQ safe; device has to IRQ safe.\n",
>
>has to be?
>
This is a remenant. This limitation need not exist. Removed.

>> +			genpd->name);
>> +		return -EINVAL;
>> +	}
>> +
>>  	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
>>  	if (IS_ERR(gpd_data))
>>  		return PTR_ERR(gpd_data);
>> @@ -1394,6 +1464,17 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>  	    || genpd == subdomain)
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * If the domain can be powered on/off in an IRQ safe
>> +	 * context, ensure that the subdomain can also be
>> +	 * powered on/off in that context.
>> +	 */
>> +	if (!genpd->irq_safe && subdomain->irq_safe) {
>> +		WARN("Parent %s of subdomain %s must be IRQ-safe\n",
>
>Nitpick! IRQ-safe or IRQ safe? Use one consistently please.
>
Sorry. It will be IRQ safe.

Thank,
Lina
