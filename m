From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Thu, 21 Aug 2014 10:39:53 +0300
Message-ID: <53F5A249.7030008@nvidia.com>
References: <1407320706-17440-1-git-send-email-mperttunen@nvidia.com> <1407320706-17440-5-git-send-email-mperttunen@nvidia.com> <53F4FC18.90804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F4FC18.90804-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 20/08/14 22:50, Stephen Warren wrote:
> On 08/06/2014 04:25 AM, Mikko Perttunen wrote:
>> This adds support for the Tegra SOCTHERM thermal sensing and management
>> system found in the Tegra124 system-on-chip. This initial driver supports
>> temperature polling for four thermal zones.
>
> Since both the Tegra DT patches and this driver all rely on a new header
> added by patch 1/4, I guess this whole series needs to be applied in one
> branch. I think it makes sense to apply it to the Tegra since it's
> likely to have more conflicts there and fewer in the thermal
> maintainer's tree. It can be applied in a topic branch that can be
> merged into the thermal maintainer's tree if required to resolve
> conflicts there.
>
> Rui, Eduardo, do you agree?
>
>> diff --git a/drivers/thermal/tegra_soctherm.c
>> b/drivers/thermal/tegra_soctherm.c
>
>> +static struct of_device_id tegra_soctherm_of_match[] = {
>> +    { .compatible = "nvidia,tegra124-soctherm" },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
>> +
>> +static int thermctl_temp_offsets[] = {
>> +    SENSOR_TEMP1, SENSOR_TEMP2, SENSOR_TEMP1, SENSOR_TEMP2
>> +};
>> +
>> +static int thermctl_temp_shifts[] = {
>> +    16, 16, 0, 0
>> +};
>
> Can any/all of those be const?

Yes!

>
> I don't pretend to know anything about the soctherm HW, but I see no
> gross issues in the code structure, so,
> Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks; I'll need to do a v5 anyway, so I'll fix the things you 
mentioned while doing it.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
