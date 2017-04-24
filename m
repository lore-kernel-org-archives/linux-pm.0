From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Mon, 24 Apr 2017 08:20:28 -0300
Message-ID: <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34434 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168977AbdDXLU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 07:20:29 -0400
Received: by mail-io0-f174.google.com with SMTP id a103so187751818ioj.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 04:20:29 -0700 (PDT)
In-Reply-To: <20170424040709.GG26900@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Viresh,

On Mon, Apr 24, 2017 at 1:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> So as Rafael pointed out the problem doesn't happen if you stay at the max
> frequencies, but otherwise.
>
> You need to investigate on why that is the case. You can go to the cpufreq sysfs
> directory and see what frequencies are getting selected, etc..

Yes, when the CPU frequency stays at 996 MHz I do not see the
touchscreen failure. When it goes to 396MHz I do see see touchscreeen
events getting lost.

> Give me output of this for now:
>
> grep . /sys/devices/system/cpu/cpufreq/policy0/*
> grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*

Here it goes, thanks.

# grep . /sys/devices/system/cpu/cpufreq/policy0/*
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:396000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:996000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:396000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:109036
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:396000
792000 996000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand
performance
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:396000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:imx6q-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:996000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:396000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

# grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*
grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Permission denied
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:396000 2869
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:792000 76
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:996000 33
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:8
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
 396000    792000    996000
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   396000:
      0         2         0
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   792000:
      2         0         2
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   996000:
      1         1         0
