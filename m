From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 19:01:55 +0530
Message-ID: <CAKohponRwcd8C-OyhrY2ExgMUP-WcrYo641j6osXekmRTc4m6A@mail.gmail.com>
References: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
	<537A0247.1030503@ti.com>
	<CAKohpoknoFuz8qnDpunA7oxr5E_18=+EQsFEy0P39fcU=4Ps9w@mail.gmail.com>
	<CAGo_u6o+Vysq0LkdFTrP82WOpS1TT-=MD+zgP+Q_L=3RV8x5hA@mail.gmail.com>
	<CAKohponAx=Hi_Ywgg4hXxrpmmaqy5=pYnb3nSBNUP3KtADTEeA@mail.gmail.com>
	<CAKohpomKvPcioNmfzvx7vqJHqs_TrhnHH6yYb5w_0f+YvA5hvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64139 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaETNb4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 09:31:56 -0400
Received: by mail-oa0-f46.google.com with SMTP id i4so501536oah.5
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 06:31:55 -0700 (PDT)
In-Reply-To: <CAKohpomKvPcioNmfzvx7vqJHqs_TrhnHH6yYb5w_0f+YvA5hvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 20 May 2014 17:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Though after more thought into this I feel this must also be done:
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index bdf09f5..3f540d8 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -453,9 +453,13 @@ int dev_pm_opp_add(struct device *dev, unsigned
> long freq, unsigned long u_volt)
>         }
>
>         if (new_opp->rate == opp->rate) {
> +               int ret = 0;
> +
> +               if (new_opp->u_volt == opp->u_volt)
> +                       ret = -EEXIST;
>                 mutex_unlock(&dev_opp_list_lock);
>                 kfree(new_opp);
> -               return 0;
> +               return ret;

Ahh, sorry gentlemen. I have screwed up yet again.

I meant this instead:

> +               if (new_opp->u_volt != opp->u_volt)
> +                       ret = -EEXIST;

Otherwise we are trying to add same OPP again and we can
return zero.
