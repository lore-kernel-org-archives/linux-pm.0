From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Date: Fri, 3 Feb 2017 09:59:17 +0530
Message-ID: <20170203042917.GL7458@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-4-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36788 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbdBCE3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 23:29:20 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so2724064pfu.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2017 20:29:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202010601.75995-4-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 01-02-17, 17:06, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Enable all applicable CPUfreq options.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 4eb5d6e..6fda604 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -26,6 +26,16 @@ CONFIG_INET=y
>  # CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_BMIPS_CPUFREQ=y
>  CONFIG_CFG80211=y
>  CONFIG_NL80211_TESTMODE=y
>  CONFIG_MAC80211=y

Rebase your stuff over pm/linux-next and you will see some changes here. Also
schedutil is the new governor in town, you must give it a try.

-- 
viresh
