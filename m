From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] ARM: shmobile: Ignore callbacks for subsys
 generic_pm_domain_data
Date: Mon, 14 Apr 2014 11:22:24 +0200
Message-ID: <CAPDyKFp76Z93tNhd5vBpTUVzF0Km9oMAmBbg0RCT+91V5J-jzw@mail.gmail.com>
References: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org>
 <1397230004-22306-2-git-send-email-ulf.hansson@linaro.org>
 <20140414012013.GB22411@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140414012013.GB22411@verge.net.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 14 April 2014 03:20, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Apr 11, 2014 at 05:26:41PM +0200, Ulf Hansson wrote:
>> There are no active users of these callbacks, thus there are no benefit
>> of trying to invoke them.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> I am seeking ack from the SOC maintainers since this needs to go with the other
>> patches in this patchset on the PM core.
>
> In order to reduce the possibility of conflicts I would prefer
> to take this patch through my tree.

Okay, go ahead!

Kind regards
Ulf Hansson

>
>> ---
>>  arch/arm/mach-shmobile/pm-rmobile.c |   38 +++--------------------------------
>>  1 file changed, 3 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
>> index 1fc05d9..f710235 100644
>> --- a/arch/arm/mach-shmobile/pm-rmobile.c
>> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
>> @@ -99,39 +99,7 @@ static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
>>
>>  static bool rmobile_pd_active_wakeup(struct device *dev)
>>  {
>> -     bool (*active_wakeup)(struct device *dev);
>> -
>> -     active_wakeup = dev_gpd_data(dev)->ops.active_wakeup;
>> -     return active_wakeup ? active_wakeup(dev) : true;
>> -}
>> -
>> -static int rmobile_pd_stop_dev(struct device *dev)
>> -{
>> -     int (*stop)(struct device *dev);
>> -
>> -     stop = dev_gpd_data(dev)->ops.stop;
>> -     if (stop) {
>> -             int ret = stop(dev);
>> -             if (ret)
>> -                     return ret;
>> -     }
>> -     return pm_clk_suspend(dev);
>> -}
>> -
>> -static int rmobile_pd_start_dev(struct device *dev)
>> -{
>> -     int (*start)(struct device *dev);
>> -     int ret;
>> -
>> -     ret = pm_clk_resume(dev);
>> -     if (ret)
>> -             return ret;
>> -
>> -     start = dev_gpd_data(dev)->ops.start;
>> -     if (start)
>> -             ret = start(dev);
>> -
>> -     return ret;
>> +     return true;
>>  }
>>
>>  static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>> @@ -140,8 +108,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>>       struct dev_power_governor *gov = rmobile_pd->gov;
>>
>>       pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>> -     genpd->dev_ops.stop             = rmobile_pd_stop_dev;
>> -     genpd->dev_ops.start            = rmobile_pd_start_dev;
>> +     genpd->dev_ops.stop             = pm_clk_suspend;
>> +     genpd->dev_ops.start            = pm_clk_resume;
>>       genpd->dev_ops.active_wakeup    = rmobile_pd_active_wakeup;
>>       genpd->dev_irq_safe             = true;
>>       genpd->power_off                = rmobile_pd_power_down;
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
