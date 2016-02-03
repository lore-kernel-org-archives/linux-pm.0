From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 08/14] PM / Domains: Add function to remove a pm-domain
Date: Wed, 3 Feb 2016 10:51:40 +0000
Message-ID: <56B1DBBC.5020509@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFqJLdoee4a9819XukXTmYyd3pue452K_zbiV6XhfA=fTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqJLdoee4a9819XukXTmYyd3pue452K_zbiV6XhfA=fTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 02/02/16 15:35, Ulf Hansson wrote:
> On 28 January 2016 at 17:33, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> The genpd framework allows users to add power-domains via the
>> pm_genpd_init() function, however, there is no corresponding function
>> to remove a power-domain. For most devices this may be fine as the power
>> domains are never removed, however, for devices that wish to populate
>> the power-domains from within a driver, having the ability to remove a
>> power domain if the probing of the device fails or the driver is unloaded
>> is necessary. Therefore, add a function to remove a power-domain. Please
>> note that the power domain can only be removed if there are no devices
>> using the power-domain and it is not linked to another domain.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  5 +++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 45e3641b427d..b4120121bcac 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1529,6 +1529,32 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>  }
>>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>>
>> +/**
>> + * pm_genpd_remove - Remove a generic I/O PM domain object.
>> + * @genpd: PM domain object to remove.
>> + */
>> +int pm_genpd_remove(struct generic_pm_domain *genpd)
>> +{
>> +       if (IS_ERR_OR_NULL(genpd))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&genpd->lock);
> 
> pm_genpd_summary_show() first locks the gpd_list_lock, then the genpd lock.
> 
> Please preserve that order here as well, to prevent potential deadlocks.

Ok, yes good point.

>> +
>> +       if (!list_empty(&genpd->master_links)
>> +           || !list_empty(&genpd->slave_links) || genpd->device_count) {
>> +               mutex_unlock(&genpd->lock);
>> +               return -EBUSY;
>> +       }
>> +
>> +       mutex_lock_nested(&gpd_list_lock, SINGLE_DEPTH_NESTING);
> 
> Why the nesting, can this really cause lockdep warnings?

Hmmm, yes I don't believe that is needed here as it should be a
different class. Will fix.

>> +       list_del(&genpd->gpd_list_node);
>> +       mutex_unlock(&gpd_list_lock);
>> +       mutex_unlock(&genpd->lock);
> 
> Before returning, you need to make sure there isn't a scheduled work
> for powering off the genpd.
> That might happen for example happen via genpd_poweroff_unused().
> 
> Otherwise, the caller of pm_genpd_remove() might free the memory while
> the genpd struct is still in use...
> 
> I assume a cancel_delayed_work_sync() should do the trick here.

Good point. I will address that too.

Jon
