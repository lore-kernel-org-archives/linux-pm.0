From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Mon, 26 Aug 2013 19:45:33 +0530
Message-ID: <CAK9yfHz37Z3B5YM0fEoD9D7GoBjFJquJeYRJCmtHZJ0B8sjAsw@mail.gmail.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:51355 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3HZOPe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2013 10:15:34 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so3629872oag.31
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2013 07:15:33 -0700 (PDT)
In-Reply-To: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Patch Tracking <patches@linaro.org>

Hi,

On 19 August 2013 11:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Fixes some trivial typos.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> This series is based on next branch of below tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>
> This is tested on Exynos4210 and 5250 based boards.
> ---
>  drivers/thermal/samsung/Kconfig |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
> index b653f15..92492e4 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
>         depends on ARCH_HAS_BANDGAP
>         help
>           If you say yes here you get support for the TMU (Thermal Management
> -         Unit) driver for SAMSUNG EXYNOS series of soc. This driver initialises
> +         Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
>           the TMU, reports temperature and handles cooling action if defined.
> -         This driver uses the exynos core thermal API's and TMU configuration
> -         data from the supported soc's.
> +         This driver uses the Exynos core thermal APIs and TMU configuration
> +         data from the supported SoCs.
>
>  config EXYNOS_THERMAL_CORE
> -       bool "Core thermal framework support for EXYNOS SOC's"
> +       bool "Core thermal framework support for EXYNOS SOCs"
>         depends on EXYNOS_THERMAL
>         help
>           If you say yes here you get support for EXYNOS TMU
>           (Thermal Management Unit) common registration/unregistration
>           functions to the core thermal layer and also to use the generic
> -         cpu cooling API's.
> +         CPU cooling APIs.
> --
> 1.7.9.5
>

Any comments on this series?


-- 
With warm regards,
Sachin
