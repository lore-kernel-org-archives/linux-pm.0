From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] PM / OPP: Make OPP invisible to users in Kconfig
Date: Fri, 9 May 2014 13:56:13 -0500
Message-ID: <CAGo_u6pz_bd6JC3yqVkWBCv6OMcYip8iXLLXURKY=Rn6D5u8vA@mail.gmail.com>
References: <1399659488-13974-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:53389 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbaEIS4O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 14:56:14 -0400
Received: by mail-we0-f176.google.com with SMTP id q59so4249628wes.7
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 11:56:13 -0700 (PDT)
In-Reply-To: <1399659488-13974-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linaro Kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@linaro.org>

On Fri, May 9, 2014 at 1:18 PM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The OPP code is an in kernel library selected by its users, there is no
> no architecture code required to implement it and enabling it without a
> user just increases the kernel size. Since the users select rather than
> depend on it just remove the ability to directly set the option from
> Kconfig.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>
> This leaves the ARCH_HAS_OPP symbol since removing that requires
> updating the relevant architectures, if this is OK I can sumbit a
> followup patch cleaning that up.
>

Acked-by: Nishanth Menon <nm@ti.com>
>  kernel/power/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 2fac9cc79b3d..9a83d780facd 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -257,8 +257,7 @@ config ARCH_HAS_OPP
>         bool
>
>  config PM_OPP
> -       bool "Operating Performance Point (OPP) Layer library"
> -       depends on ARCH_HAS_OPP
> +       bool
>         ---help---
>           SOCs have a standard set of tuples consisting of frequency and
>           voltage pairs that the device will support per voltage domain. This
> --
> 2.0.0.rc2
>
