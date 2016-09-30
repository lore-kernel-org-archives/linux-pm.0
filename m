From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/4] PM / Domains: Some simplifications/clean-ups for genpd
Date: Fri, 30 Sep 2016 01:31:20 -0700
Message-ID: <7hintdhjqf.fsf@baylibre.com>
References: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
        <2878937.BEb84IEckp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34462 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcI3IbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 04:31:25 -0400
Received: by mail-pa0-f42.google.com with SMTP id dw4so22735919pac.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Sep 2016 01:31:21 -0700 (PDT)
In-Reply-To: <2878937.BEb84IEckp@vostro.rjw.lan> (Rafael J. Wysocki's message
        of "Fri, 23 Sep 2016 14:54 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Wednesday, September 21, 2016 03:38:49 PM Ulf Hansson wrote:
>> Ulf Hansson (4):
>>   PM / Domains: Simplify detaching a device from its genpd
>>   PM / Domains: Remove redundant system PM callbacks
>>   PM / Domains: Don't measure latency of ->power_on|off() during system
>>     PM
>>   PM / Domains: Rename pm_genpd_sync_poweron|poweroff()
>> 
>>  drivers/base/power/domain.c | 77 +++++++++++++++++++--------------------------
>>  1 file changed, 33 insertions(+), 44 deletions(-)
>
> This series is fine by me.
>
> If there are no objections from Kevin or others, I'll queue it up later today.
>

No objections.

Acked-by: Kevin Hilman <khilman@baylibre.com>
