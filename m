From: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/3] arm64: Enable OPP
Date: Fri, 9 May 2014 12:02:12 -0500
Message-ID: <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48029 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbaEIRCN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:02:13 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so2802062wib.1
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 10:02:12 -0700 (PDT)
In-Reply-To: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>

On Fri, May 9, 2014 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Some of the generic drivers used on ARM class systems use OPP so allow it
> to be selected in Kconfig. No code is required for this, it is not clear
> to me why there is config for this option.
If you mean why we have ARCH_HAS_OPP,
http://lists-archives.com/linux-kernel/27401148-pm-hide-opp-configuration-when-socs-do-not-provide-an-implementation.html

>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8ccdd2646ae3..8256d6d09d33 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@ config ARM64
>         def_bool y
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select ARCH_HAS_OPP
>         select ARCH_HAS_SG_CHAIN
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_WANT_OPTIONAL_GPIOLIB
> --
> 2.0.0.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
