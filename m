From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 25/25] PM: Switch to use %pt
Date: Thu, 8 Jun 2017 19:16:45 +0200
Message-ID: <CAJZ5v0gXvB1LcSpe8Ze=et9Hd3aBraw+hYy8NrZYhHFBE_5yfg@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com> <20170608134811.60786-26-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35059 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdFHRQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 13:16:46 -0400
In-Reply-To: <20170608134811.60786-26-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Jun 8, 2017 at 3:48 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Use %pt instead of open coded variant to print content of
> struct rtc_time in human readable format.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/power/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index 1cda505d6a85..5e32a4f28a49 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
>         unsigned int val;
>
>         mc146818_get_time(&time);
> -       pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
> -               time.tm_hour, time.tm_min, time.tm_sec,
> -               time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
> +       pr_info("RTC time: %ptt, date: %ptd\n", &time, &time);
>         val = time.tm_year;                             /* 100 years */
>         if (val > 100)
>                 val -= 100;
> --
> 2.11.0
>
