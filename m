From: Sergio P <sergio.pieiga@gmail.com>
Subject: Re: cpufreq and boost with amd ryzen
Date: Mon, 3 Jul 2017 07:21:42 -0400
Message-ID: <CAFFvMK1zUZhKAqFMxSWjbW7Bb-j0Odr0DjmTiC8DbqKonNL+Kg@mail.gmail.com>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
 <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34969 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbdGCLVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 07:21:43 -0400
Received: by mail-vk0-f43.google.com with SMTP id 191so93645137vko.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2017 04:21:43 -0700 (PDT)
In-Reply-To: <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Viresh, thank you for responding.

/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/bios_limit:3400000
/sys/devices/system/cpu/cpu0/cpufreq/cpb:0
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:3400000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:3400000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:2200000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu0/cpufreq/freqdomain_cpus:0 1
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:3400000
3000000 2200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:userspace
powersave conservative ondemand performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:3400000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:3400000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:2200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory




On Mon, Jul 3, 2017 at 12:25 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Sun, Jul 2, 2017 at 8:04 PM, Sergio P <sergio.pieiga@gmail.com> wrote:
>> I was wondering why cpufreq is not creating
>> /sys/devices/system/cpu/cpufreq/boost for an AMD Ryzen processor? I am
>> running kernel 4.11.  I do see cpb (AMD's legacy core performance
>> boost) in each individual profile*/ but regardless, it does not seem
>> to boost.  (fyi no overclocking going on).
>>
>> cpupower frequency-info reports
>>   boost state support:
>>     Supported: no
>>     Active: no
>
> Please give output of:
>
> grep . /sys/devices/system/cpu/cpu0/cpufreq/*
>
> I want to see what driver is running and what features are available.
>
> --
> viresh
