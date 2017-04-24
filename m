From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Mon, 24 Apr 2017 16:59:06 +0530
Message-ID: <20170424112906.GR26900@vireshk-i7>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
 <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37934 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168450AbdDXLbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 07:31:07 -0400
Received: by mail-it0-f43.google.com with SMTP id e132so52412896ite.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 04:31:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24-04-17, 08:20, Fabio Estevam wrote:
> Here it goes, thanks.
> 
> # grep . /sys/devices/system/cpu/cpufreq/policy0/*
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:996000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:109036
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:396000
> 792000 996000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand
> performance
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:imx6q-cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:996000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> 
> # grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*
> grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Permission denied
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:396000 2869
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:792000 76
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:996000 33
> /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:8

So clearly the system isn't changing the frequency a lot here and you stayed at
the min freq for ever. Please give output of this as well:

grep . /sys/devices/system/cpu/cpufreq/ondemand/*

I am also worried if the interrupts from the touchscreen will be enough to boost
the frequency of the CPU ?

-- 
viresh
