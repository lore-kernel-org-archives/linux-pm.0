From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] TWL4030 charger
Date: Mon, 23 Feb 2015 12:25:02 +0100
Message-ID: <CAJKOXPc5mFf3yjCy1_SRyKW4f0AQ3bEy9BzedCUH81Ls2GAmzQ@mail.gmail.com>
References: <54E8F58D.8060506@laposte.net>
	<54E9C271.1080902@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:62580 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbBWLZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 06:25:04 -0500
Received: by mail-vc0-f172.google.com with SMTP id kv7so7092060vcb.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2015 03:25:02 -0800 (PST)
In-Reply-To: <54E9C271.1080902@laposte.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas JOURDEN <nicolas.jourden@laposte.net>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, notasas@gmail.com

2015-02-22 12:50 GMT+01:00 Nicolas JOURDEN <nicolas.jourden@laposte.net=
>:
> Hello,
>
> Looks like my mailer changed the format/indent for the patch.
> This patch fix the TWL4030 charger module for the RTC battery.
>

Could you put a proper title for this patch describing in few words
what is fixed? Additionally could you describe the exact fix details
in commit message. For example these details could be useful:
1. What is the problem,
2. When the problem appears (or how the problem can be reproduced).
3. What is the "fix".

I am asking for these details to better understand the error you found
and the fix for it.

Best regards,
Krzysztof

>
> Signed-off-by: Nicolas JOURDEN <nicolas.jourden@laposte.net>
> ---
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 2598c58..89184ae 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -719,10 +719,11 @@ static struct platform_driver twl4030_bci_drive=
r =3D {
>                 .owner  =3D THIS_MODULE,
>                 .of_match_table =3D of_match_ptr(twl_bci_of_match),
>         },
> +       .probe  =3D twl4030_bci_probe,
>         .remove =3D __exit_p(twl4030_bci_remove),
>  };
>
> -module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
> +module_platform_driver(twl4030_bci_driver);
>
>  MODULE_AUTHOR("Gra=C3=85=C2=BEvydas Ignotas");
>  MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
