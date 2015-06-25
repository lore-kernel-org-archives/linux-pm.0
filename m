From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Try power off masters in error path of __pm_genpd_poweron()
Date: Thu, 25 Jun 2015 13:17:07 +0200
Message-ID: <CAPDyKFo7OarmJpc7teHjOkxgoEToa_SJaRMRW-_cfSmJ-5MLtw@mail.gmail.com>
References: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
	<55798031.50205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34962 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbbFYLRI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 07:17:08 -0400
Received: by qgeu36 with SMTP id u36so23313618qge.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 04:17:07 -0700 (PDT)
In-Reply-To: <55798031.50205@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11 June 2015 at 14:33, Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:
> W dniu 11.06.2015 o 20:51, Ulf Hansson pisze:
>> While powering up a genpd, its domain masters are first being powered up.
>> In the error path of __pm_genpd_poweron(), we didn't care to try power off
>> these domain masters. Let's deal with that to avoid leaving unused PM
>> domains powered.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 30 +++++++++++++++++-------------
>>  1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 2327613..32dcb80 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -235,6 +235,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
>>  }
>>
>>  /**
>> + * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
>> + * @genpd: PM domait to power off.
>> + *
>> + * Queue up the execution of pm_genpd_poweroff() unless it's already been done
>> + * before.
>> + */
>> +static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
>> +{
>> +     queue_work(pm_wq, &genpd->power_off_work);
>> +}
>> +
>> +/**
>>   * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
>>   * @genpd: PM domain to power up.
>>   *
>> @@ -315,8 +327,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>>       return 0;
>>
>>   err:
>> -     list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
>> +     list_for_each_entry_continue_reverse(link,
>> +                                     &genpd->slave_links,
>> +                                     slave_node) {
>>               genpd_sd_counter_dec(link->master);
>> +             genpd_queue_power_off_work(link->master);
>
> It looks sensible to revert work already done however I wonder if this
> is necessary for each slave. The first successful call to
> pm_genpd_poweroff() will also walk through slave_links and queue the work.
>

For the current genpd, each slave link represents that the current
genpd is a subdomain to another genpd. The corresponding master for
each link is the "link->master". As genpds are allowed to have several
masters, we can't just try to power off one of them.

Sorry for a delayed response and thanks for your review!

Kind regards
Uffe
