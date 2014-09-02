From: "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: [Patch v3] 3/7] thermal: Remove ARCH_KIRKWOOD dependency
Date: Tue, 2 Sep 2014 07:53:14 -0400
Message-ID: <CAC-25o8UaK0gdysSk399Y29OAcQikDerc0b8xbzLiPjT44p0ew@mail.gmail.com>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
	<1409417172-6846-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:42119 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaIBLxP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 07:53:15 -0400
Received: by mail-lb0-f172.google.com with SMTP id 10so7402649lbg.17
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2014 04:53:14 -0700 (PDT)
In-Reply-To: <1409417172-6846-4-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Andrew,

On Sat, Aug 30, 2014 at 12:46 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> Depend on MACH_KIRKWOOD, which will be set when kirkwood is built as
> part of ARCH_MVEBU.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 693208eb9047..ef5587fe2c69 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -143,7 +143,7 @@ config RCAR_THERMAL
>
>  config KIRKWOOD_THERMAL
>         tristate "Temperature sensor on Marvell Kirkwood SoCs"
> -       depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
> +       depends on MACH_KIRKWOOD

I have no objections with this change. So, wrt thermal:
Acked-by: Eduardo Valentin <edubezval@gmail.com>

>         depends on OF
>         help
>           Support for the Kirkwood thermal sensor driver into the Linux thermal
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Eduardo Bezerra Valentin
