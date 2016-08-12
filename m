From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v1] power: reset: reboot mode: fix build error of missing
 ioremap/iounmap on UM
Date: Fri, 12 Aug 2016 14:48:40 +0200
Message-ID: <df657519-da7b-dbf3-1096-54253cb289c1@samsung.com>
References: <1470996110-8550-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9602 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbcHLMsp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 08:48:45 -0400
In-reply-to: <1470996110-8550-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, sre@kernel.org
Cc: matthias.bgg@gmail.com, dbaryshkov@gmail.com, richard@nod.at, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, nicolas.ferre@atmel.com

On 08/12/2016 12:01 PM, Andy Yan wrote:
> commit 4fcd504edbf7 ("power: reset: add reboot mode driver") uses api from
> syscon, and syscon uses ioremap/iounmap which depends on HAS_IOMEM, so
> let's depend on MFD_SYSCON instead of selecting it directly to avoid the
> um-allyesconfig like build error on archs that without iomem:
> 
> drivers/mfd/syscon.c: In function 'of_syscon_register':
> drivers/mfd/syscon.c:67:9: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]
>   base = ioremap(res.start, resource_size(&res));
>          ^
> drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   base = ioremap(res.start, resource_size(&res));
>        ^
> drivers/mfd/syscon.c:109:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>   iounmap(base);
>   ^
> 
> Reported-by: Kbuild test robot <fengguang.wu@intel.com>
> Fixes: 4fcd504edbf7("power: reset: add reboot mode driver")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v1:
> - let this driver depend on MFD_SYSCON
> - add Reported-by tag, which suggested by Krzysztof Kozlowski
> - add Fixes tag, which suggested by Matthias Brugger
> 
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

