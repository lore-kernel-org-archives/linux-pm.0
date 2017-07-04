From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq and boost with amd ryzen
Date: Tue, 4 Jul 2017 11:40:00 +0530
Message-ID: <20170704061000.GE3532@vireshk-i7>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
 <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
 <CAFFvMK1zUZhKAqFMxSWjbW7Bb-j0Odr0DjmTiC8DbqKonNL+Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33433 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGDGKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 02:10:04 -0400
Received: by mail-pg0-f41.google.com with SMTP id k14so29414290pgr.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2017 23:10:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFFvMK1zUZhKAqFMxSWjbW7Bb-j0Odr0DjmTiC8DbqKonNL+Kg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergio P <sergio.pieiga@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On 03-07-17, 07:21, Sergio P wrote:
> Hi Viresh, thank you for responding.
> 
> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
> /sys/devices/system/cpu/cpu0/cpufreq/bios_limit:3400000
> /sys/devices/system/cpu/cpu0/cpufreq/cpb:0
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:3400000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:3400000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:2200000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu0/cpufreq/freqdomain_cpus:0 1
> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:3400000
> 3000000 2200000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:userspace
> powersave conservative ondemand performance schedutil
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:3400000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:ondemand
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:3400000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:2200000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory

You need to help debugging a bit. Looks like you are returning early from
acpi_cpufreq_boost_init() (in drivers/cpufreq/acpi-cpufreq.c). Can you please
check if acpi_cpufreq_driver.set_boost is getting set ? Without that boost
wouldn't work.

-- 
viresh
