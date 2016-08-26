From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH] thermal: hisilicon: fix COMPILE_TEST dependencies
Date: Fri, 26 Aug 2016 22:42:36 +0530
Message-ID: <CAP245DWoQA+dqa09T+FpLRhH5P57pV15X5graazR=aJnqE9haA@mail.gmail.com>
References: <20160826154434.992160-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35072 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbcHZRMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 13:12:37 -0400
Received: by mail-it0-f53.google.com with SMTP id x131so1901273ite.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2016 10:12:37 -0700 (PDT)
In-Reply-To: <20160826154434.992160-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Leo Yan <leo.yan@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Aug 26, 2016 at 9:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> As we now 'select STUB_CLK_HI6220', all dependencies for that driver have
> to be present in order to enable HISI_THERMAL, as pointed out by
> Kconfig:
>
> warning: (HISI_THERMAL) selects STUB_CLK_HI6220 which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_HI6220 && MAILBOX)
>
> This rearranges the dependencies for this symbol, so all the dependencies
> aside from ARCH_HISI are always met when building it for compile testing.
> This mainly helps for randconfig testing, as an "allmodconfig" kernel will
> enable them anyway.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5f63581ce68e ("thermal: hisilicon: Add dependency on the clock driver to allow frequency scaling")

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5cba072c3a62..3c8607c07352 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -177,7 +177,8 @@ config THERMAL_EMULATION
>
>  config HISI_THERMAL
>         tristate "Hisilicon thermal driver"
> -       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
> +       depends on ARCH_HISI || COMPILE_TEST
> +       depends on CPU_THERMAL && OF && COMMON_CLK_HI6220 && MAILBOX
>         depends on HAS_IOMEM
>         select STUB_CLK_HI6220
>         help
> --
> 2.9.0
>
