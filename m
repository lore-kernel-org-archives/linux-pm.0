From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Patch v3] 1/7] cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
Date: Wed, 03 Sep 2014 15:45:06 +0200
Message-ID: <54071B62.6070303@linaro.org>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch> <1409417172-6846-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35964 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbaICNpK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 09:45:10 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so8390558wgg.21
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 06:45:08 -0700 (PDT)
In-Reply-To: <1409417172-6846-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 08/30/2014 06:46 PM, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu=
=2E
> Use MACH_KIRKWOOD, which is set when kirkwood is built as part of
> mach-mvebu.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/Kconfig.arm | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 38cff69ffe06..58bcd0d166ec 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -28,7 +28,7 @@ config ARM_HIGHBANK_CPUIDLE
>
>   config ARM_KIRKWOOD_CPUIDLE
>   	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> -	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
> +	depends on MACH_KIRKWOOD
>   	help
>   	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

