From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Wed, 03 Apr 2013 14:23:23 +0200
Message-ID: <515C1F3B.5040008@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59555 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760273Ab3DCMX2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 08:23:28 -0400
Received: by mail-ea0-f175.google.com with SMTP id r16so623039ead.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2013 05:23:27 -0700 (PDT)
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, patches@linaro.org, linux-pm@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> The noop functions code is not necessary because the header file is
> included in files which are compiled when CONFIG_CPU_IDLE is on.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I have been involved in the development of this file. I know Rob is no
longer working on this neither monitoring the code.

Russell are you ok with this patch ? Rafael needs your ack to take this
patch into its tree.

Thanks

-- Daniel

> ---
>  arch/arm/include/asm/cpuidle.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cp=
uidle.h
> index 2fca60a..7367787 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -1,13 +1,8 @@
>  #ifndef __ASM_ARM_CPUIDLE_H
>  #define __ASM_ARM_CPUIDLE_H
> =20
> -#ifdef CONFIG_CPU_IDLE
>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index);
> -#else
> -static inline int arm_cpuidle_simple_enter(struct cpuidle_device *de=
v,
> -		struct cpuidle_driver *drv, int index) { return -ENODEV; }
> -#endif
> +				    struct cpuidle_driver *drv, int index);
> =20
>  /* Common ARM WFI state */
>  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

