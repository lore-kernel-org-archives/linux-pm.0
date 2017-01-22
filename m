From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM
 phases
Date: Sun, 22 Jan 2017 11:34:32 +0800
Message-ID: <58842848.5090806@rock-chips.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com> <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Feng Xiao <xf@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, xxx@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 01/20/2017 09:16 PM, Ulf Hansson wrote:
> On 20 January 2017 at 03:21, Elaine Zhang <zhangqing@rock-chips.com> wrote:
>> If a PM domain is powered off before system suspend,
>> we hope do nothing in system runtime suspend noirq phase
>> and system runtime resume noirq phase.
>
> One can hope, but that isn't good enough. :-)
>
>
>>
>> This modify is to slove system resume issue for RK3399.
>> RK3399 SOC pd_gpu have voltage domain vdd_gpu,
>> so we must follow open vdd_gpu and power on pd_gpu,
>> power off pd_gpu and disable vdd_gpu.
>> Fix up in runtime resume noirq phase power on all PDs.
>
> This doesn't make any sense to me. Can please try to explain this is
> in great more detail, then I can try to help.
>
For example:
-->device suspend
    (mali gpu driver set pd_gpu off by pm_runtime_put_sync(),
     and then disabled the vdd_gpu by regulator_disable().)
	--> system suspend
		-->prepare
			-->suspend_noirq():
			(power off all pds)
	-->system resume
		-->resume_noirq():
		(power up all pds)
		(in this case the vdd_gpu is still disabled,
		 if power on the pd_gpu maybe make the system crash)
	-->complete : power off the not used pd
-->device resuem
    (mali gpu driver enable vdd_gpu by regulator_enable(),
     and then power up the pd_gpu by pm_runtime_get_sync())

So for RK3399 soc, if to set pd_gpu the vdd_gpu must be enabled, or else 
will can't get the ack back.
I hope the pd_gpu power up/off by the driver itself.

May be I solution is not the optimal solution,Do you have better suggestion?

>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   drivers/base/power/domain.c | 10 +++++++---
>>   include/linux/pm_domain.h   |  1 +
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 5711708532db..81351eec570f 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -842,8 +842,10 @@ static int pm_genpd_prepare(struct device *dev)
>>
>>          genpd_lock(genpd);
>>
>> -       if (genpd->prepared_count++ == 0)
>> +       if (genpd->prepared_count++ == 0) {
>>                  genpd->suspended_count = 0;
>> +               genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
>> +       }
>>
>>          genpd_unlock(genpd);
>>
>> @@ -877,7 +879,8 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>>          if (IS_ERR(genpd))
>>                  return -EINVAL;
>>
>> -       if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
>> +       if (genpd->suspend_power_off ||
>> +           (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
>>                  return 0;
>
> This isn't going to work, because the PM domain might have been powered on.
>
> There is simply no guarantee to that the PM domain remains powered off
> during the system PM suspend phases. For example, any device in the PM
> domain that get runtime resumed after the ->prepare() callback is
> invoked this, will of course also trigger the PM domain to be powered
> on.
>
>>
>>          if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>> @@ -914,7 +917,8 @@ static int pm_genpd_resume_noirq(struct device *dev)
>>          if (IS_ERR(genpd))
>>                  return -EINVAL;
>>
>> -       if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
>> +       if (genpd->suspend_power_off ||
>> +           (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
>>                  return 0;
>
> Ditto, for the same reasons as above.
>
>>
>>          /*
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 81ece61075df..9c0dc364f089 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -62,6 +62,7 @@ struct generic_pm_domain {
>>          unsigned int device_count;      /* Number of devices */
>>          unsigned int suspended_count;   /* System suspend device counter */
>>          unsigned int prepared_count;    /* Suspend counter of prepared devices */
>> +       bool suspend_power_off; /* Power status before system suspend */
>>          int (*power_off)(struct generic_pm_domain *domain);
>>          int (*power_on)(struct generic_pm_domain *domain);
>>          struct gpd_dev_ops dev_ops;
>> --
>> 1.9.1
>>
>>
>
> Kind regards
> Uffe
>
>
>
