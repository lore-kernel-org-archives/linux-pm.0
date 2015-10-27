From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v10 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Tue, 27 Oct 2015 15:40:50 +0100
Message-ID: <CAAObsKBcb1-xmEtHB9xVF+_WBUQNFOvaEtzFVGSJJ18nUE-P-w@mail.gmail.com>
References: <1445441654-31778-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445441654-31778-4-git-send-email-tomeu.vizoso@collabora.com> <CAGS+omBt56EH2z_jj4ZOaJHqtBcst=EfAyxAK0nC71Ex3Q=55g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omBt56EH2z_jj4ZOaJHqtBcst=EfAyxAK0nC71Ex3Q=55g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>
List-Id: linux-pm@vger.kernel.org

On 26 October 2015 at 13:56, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Tomeu,
>
> On Wed, Oct 21, 2015 at 11:34 PM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> If a suitable prepare callback cannot be found for a given device and
>> its driver has no PM callbacks at all, assume that it can go direct to
>> complete when the system goes to sleep.
>>
>> The reason for this is that there's lots of devices in a system that do
>> no PM at all and there's no reason for them to prevent their ancestors
>> to do direct_complete if they can support it.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>
> [snip...]
>
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index a70f8a5cdfd7..763eee24cb95 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -14,6 +14,8 @@
>>  #include <linux/acpi.h>
>>  #include <linux/pm_domain.h>
>>
>> +#include "power.h"
>> +
>>  /**
>>   * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
>>   * @dev: Device to handle.
>> @@ -147,5 +149,6 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
>>         WARN(device_is_bound(dev),
>>              "PM domains can only be changed for unbound devices\n");
>>         dev->pm_domain = pd;
>> +       device_pm_check_callbacks(dev);
>
> device_pm_check_callbacks(dev) grabs spin_lock_irq(&dev->power.lock);
>
> But, one of the callers of dev_pm_domain_set() that you just added in
> the previous patch "PM / Domains: add setter for dev.pm_domain" also
> grabs this same spinlock:
>
> --------------------
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 16550c63d611..b75d02aa8d93 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1240,7 +1240,7 @@  static struct generic_pm_domain_data
> *genpd_alloc_dev_data(struct device *dev,
>   }
>
>   dev->power.subsys_data->domain_data = &gpd_data->base;
> - dev->pm_domain = &genpd->domain;
> + dev_pm_domain_set(dev, &genpd->domain);
>
>   spin_unlock_irq(&dev->power.lock);
> --------------------
>
> At least on the board I am testing, this causes a deadlock on boot.

Thanks Daniel,

have moved in v11 the calls to dev_pm_domain_set in that file out from the lock.

Regards,

Tomeu
