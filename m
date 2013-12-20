From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q-cpufreq driver is reused on i.MX6 series SoCs
Date: Fri, 20 Dec 2013 10:42:42 +0530
Message-ID: <CAKohponf0n93Vmpqiq6kZ8DKtTRaEQ0k1Jm9nLUTWeB2m21P=Q@mail.gmail.com>
References: <1387505536-22720-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41617 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab3LTFMm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 00:12:42 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so2195823obc.37
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 21:12:42 -0800 (PST)
In-Reply-To: <1387505536-22720-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, John Tobias <john.tobias.ph@gmail.com>, Anson Huang <b20788@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 20 December 2013 07:42, Shawn Guo <shawn.guo@linaro.org> wrote:
> The imx6q-cpufreq driver nowadays is not only running on imx6q but also
> other i.MX6 series SoCs like imx6dl and imx6sl.  Update Kconfig prompt
> and help text to make it clear to users.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index ce52ed9..3ba5dcc 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -79,11 +79,11 @@ config ARM_HIGHBANK_CPUFREQ
>           If in doubt, say N.
>
>  config ARM_IMX6Q_CPUFREQ
> -       tristate "Freescale i.MX6Q cpufreq support"
> -       depends on SOC_IMX6Q
> +       tristate "Freescale i.MX6 cpufreq support"
> +       depends on ARCH_MXC
>         depends on REGULATOR_ANATOP
>         help
> -         This adds cpufreq driver support for Freescale i.MX6Q SOC.
> +         This adds cpufreq driver support for Freescale i.MX6 series SoCs.
>
>           If in doubt, say N.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
