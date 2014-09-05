From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 13/15] drivers: sh: Leave disabling of unused PM domains
 to genpd
Date: Fri, 5 Sep 2014 10:23:04 +0200
Message-ID: <CAPDyKFr2MT9TRt_OXgeWMyoaK1-PrJrTYEFrwyDi4YELgjqe3w@mail.gmail.com>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
	<1409741551-16437-14-git-send-email-ulf.hansson@linaro.org>
	<20140904003351.GB13821@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140904003351.GB13821@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 September 2014 02:33, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 03, 2014 at 12:52:29PM +0200, Ulf Hansson wrote:
>> Since genpd at late init, will try to disable unused PM domains we
>> don't need to do it from here as well.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>

Simon, thanks for your ack!

When you have time, would you please also have a look at the two patches below:

[PATCH 04/15] ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd config
[PATCH 05/15] ARM: shmobile: Drop dev_irq_safe from R-mobile genpd config

Kind regards
Uffe

>> ---
>>  drivers/sh/pm_runtime.c | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
>> index 72f6381..fe2c2d5 100644
>> --- a/drivers/sh/pm_runtime.c
>> +++ b/drivers/sh/pm_runtime.c
>> @@ -75,8 +75,6 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
>>       .con_ids = { NULL, },
>>  };
>>
>> -static bool default_pm_on;
>> -
>>  static int __init sh_pm_runtime_init(void)
>>  {
>>       if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
>> @@ -96,16 +94,7 @@ static int __init sh_pm_runtime_init(void)
>>                       return 0;
>>       }
>>
>> -     default_pm_on = true;
>>       pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
>>       return 0;
>>  }
>>  core_initcall(sh_pm_runtime_init);
>> -
>> -static int __init sh_pm_runtime_late_init(void)
>> -{
>> -     if (default_pm_on)
>> -             pm_genpd_poweroff_unused();
>> -     return 0;
>> -}
>> -late_initcall(sh_pm_runtime_late_init);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
