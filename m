From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 4/4] MIPS: BMIPS: enable CPUfreq
Date: Tue, 7 Feb 2017 09:49:59 +0530
Message-ID: <20170207041959.GP3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-5-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36075 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbdBGEUC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 23:20:02 -0500
Received: by mail-pg0-f43.google.com with SMTP id v184so34655542pgv.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 20:20:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-5-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Enable all applicable CPUfreq options.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 3be15cb..3cefa6b 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -15,6 +15,14 @@ CONFIG_EXPERT=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> +CONFIG_BMIPS_CPUFREQ=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_PACKET_DIAG=y

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
