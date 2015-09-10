From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/17] thermal: spear: allow compile test
Date: Thu, 10 Sep 2015 09:53:43 +0530
Message-ID: <CAOh2x=k8sHbffbBsn106jQi4JhYpqRxp_qP2HLg35f0VaWTjUg@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33604 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbIJEXq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 00:23:46 -0400
In-Reply-To: <1441858273-4017-3-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 9:40 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Adding COMPILE_TEST flag to spear driver to facilitate
> maintenance.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index f2b1d31..0334886 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -182,7 +182,7 @@ config IMX_THERMAL
>
>  config SPEAR_THERMAL
>         bool "SPEAr thermal sensor driver"
> -       depends on PLAT_SPEAR
> +       depends on PLAT_SPEAR || COMPILE_TEST
>         depends on OF
>         help
>           Enable this to plug the SPEAr thermal sensor driver into the Linux

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
