From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 13/13] arm64: add CPU power management menu/entries
Date: Thu, 17 Oct 2013 11:21:29 +0200
Message-ID: <525FAC19.40503@linaro.org>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com> <1381748590-14279-14-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:53645 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3JQJVe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2013 05:21:34 -0400
Received: by mail-wi0-f171.google.com with SMTP id h11so3756642wiv.16
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2013 02:21:32 -0700 (PDT)
In-Reply-To: <1381748590-14279-14-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On 10/14/2013 01:03 PM, Lorenzo Pieralisi wrote:
> This patch provides a menu for CPU power management options in the
> arm64 Kconfig and adds an entry to enable the generic CPU idle config=
uration.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm64/Kconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index be88acd..785132d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -288,6 +288,12 @@ config ARM64_CPU_SUSPEND
>
>   endmenu
>
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>   source "net/Kconfig"
>
>   source "drivers/Kconfig"
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

