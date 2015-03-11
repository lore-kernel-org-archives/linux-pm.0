From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed
 yet, defer.
Date: Wed, 11 Mar 2015 23:14:05 +0100
Message-ID: <CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com>
References: <1426087648-3862-1-git-send-email-eric@anholt.net>
	<6516096.HanqZ05BXy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35797 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbCKWOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 18:14:36 -0400
In-Reply-To: <6516096.HanqZ05BXy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eric Anholt <eric@anholt.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Mar 11, 2015 at 11:08 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> More CCes.
>
> On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
>> If we've declared a power domain in the OF, and the OF node is found
>> but the requested domain hasn't been registered on it yet, then we
>> probably have just tried to probe before the power domain driver has.
>> Defer our device's probe until it shows up.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Kevin, Ulf, any chance to have a look at this, please?
>
>> ---
>>
>> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
>> USB poweron support in the DWC2 controller to an OF-based power domain
>> declaration.

I guess you are initializing the PM domains from module_init()?

I use core_initcall() in arch/arm/mach-shmobile/pm-rmobile.c to make sure it's
initialized earlier, as e.g. the interrupt controller uses postcore_initcall().

>> drivers/base/power/domain.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index ba4abbe..2b93c98 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>  struct generic_pm_domain *of_genpd_get_from_provider(
>>                                       struct of_phandle_args *genpdspec)
>>  {
>> -     struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
>> +     struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);

Currently platform_drv_probe() just continues if dev_pm_domain_attach() returns
a different error than -EPROBE_DEFER, which is what you are seeing.

Your change does have the side effect that a new DT with PM domains won't
work on an older kernel that doesn't have the PM domain driver yet.

Whether this is a good or a bad thing depends on your bootloader. If all PM
domains are powered when Linux boots, it can work without PM domain driver.
Since DT PM domains are quite recent, I guess this is the case for most
existing SoCs.

>>       struct of_genpd_provider *provider;
>>
>>       mutex_lock(&of_genpd_mutex);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
