From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Mon, 24 Apr 2017 09:37:09 +0530
Message-ID: <20170424040709.GG26900@vireshk-i7>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:34866 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbdDXEHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 00:07:13 -0400
Received: by mail-it0-f48.google.com with SMTP id 70so42727225ita.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2017 21:07:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 21-04-17, 13:11, Fabio Estevam wrote:
> Hi,
> 
> Running 4.11-rc7 on a imx6q-sabresd board I notice that egalax
> touchscreen stops generating evtest events after a random period of
> time.
> 
> This problem can be avoided if I unselect CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND:
> 
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -54,7 +54,6 @@ CONFIG_CMA=y
>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_ARM_IMX6Q_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
> 
> With this change evtest always capture all touchscreen events. No
> single failure is seen.
> 
> I could see the same behavior with all mainline kernels I tested (4.9 and 4.10).
> 
> Any ideas as to how fix this bug when CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y?

So as Rafael pointed out the problem doesn't happen if you stay at the max
frequencies, but otherwise.

You need to investigate on why that is the case. You can go to the cpufreq sysfs
directory and see what frequencies are getting selected, etc..

Give me output of this for now:

grep . /sys/devices/system/cpu/cpufreq/policy0/*
grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*

-- 
viresh
