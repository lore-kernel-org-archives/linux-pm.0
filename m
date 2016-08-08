From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] power: reset: reboot mode: fix build error of missing ioremap/iounmap on UM
Date: Mon, 08 Aug 2016 09:25:27 +0200
Message-ID: <32A6A724-2EDF-4371-A248-CF5B950160A8@gmail.com>
References: <1470575661-22325-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32917 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcHHHZe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2016 03:25:34 -0400
In-Reply-To: <1470575661-22325-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, sre@kernel.org
Cc: richard@nod.at, moritz.fischer@ettus.com, fengguang.wu@intel.com, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, k.kozlowski@samsung.com, dwmw2@infradead.org, nicolas.ferre@atmel.com



On August 7, 2016 3:14:21 PM CEST, Andy Yan <andy.yan@rock-chips.com> wrote:
>Add missing HAS_IOMEM dependency for MFD_SYSCON to fix the
>um-allyesconfig
>build error:
>
>drivers/mfd/syscon.c: In function 'of_syscon_register':
>drivers/mfd/syscon.c:67:9: error: implicit declaration of function
>'ioremap' [-Werror=implicit-function-declaration]
>  base = ioremap(res.start, resource_size(&res));
>         ^
>drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from
>integer without a cast [-Wint-conversion]
>  base = ioremap(res.start, resource_size(&res));
>       ^
>drivers/mfd/syscon.c:109:2: error: implicit declaration of function
>'iounmap' [-Werror=implicit-function-declaration]
>  iounmap(base);
>  ^
>
>Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Normally when sending a fix you specify:
commit sha ("commit subject")

regards,
Matthias

>---
>
> drivers/power/reset/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>index 7053abc..1388be3 100644
>--- a/drivers/power/reset/Kconfig
>+++ b/drivers/power/reset/Kconfig
>@@ -190,6 +190,7 @@ config REBOOT_MODE
> config SYSCON_REBOOT_MODE
> 	tristate "Generic SYSCON regmap reboot mode driver"
> 	depends on OF
>+	depends on HAS_IOMEM
> 	select REBOOT_MODE
> 	select MFD_SYSCON
> 	help

