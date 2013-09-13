From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
Date: Fri, 13 Sep 2013 13:53:56 +0200
Message-ID: <5232FCD4.2070802@free-electrons.com>
References: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44829 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755270Ab3IMLyK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 07:54:10 -0400
In-Reply-To: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Lorenzo,

On 13/09/2013 13:32, Lorenzo Pieralisi wrote:
> Following the reorganization of CPU idle drivers configurations into an ARM
> specific Kconfig, the existing idle drivers Kconfig entries were renamed and
> moved to the Kconfig.arm file. Makefile entries were updated accordingly.
> 
> This patch renames the entries in Kconfig.arm and makefile to make the newly
> added big.LITTLE CPUidle driver compliant with the new naming convention.

Do you also consider to reorder the entries in alphabetic order?
It should help to reduce the merge conflict.

Regards,

> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig.arm | 2 +-
>  drivers/cpuidle/Makefile    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 8e36603..ea0f045 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -27,7 +27,7 @@ config ARM_U8500_CPUIDLE
>  	help
>  	  Select this to enable cpuidle for ST-E u8500 processors
>  
> -config CPU_IDLE_BIG_LITTLE
> +config ARM_BIG_LITTLE_CPUIDLE
>  	bool "Support for ARM big.LITTLE processors"
>  	depends on ARCH_VEXPRESS_TC2_PM
>  	select ARM_CPU_SUSPEND
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index cea5ef5..3c693c2 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -11,4 +11,4 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
> -obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
> +obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
