From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Mon, 24 Apr 2017 08:37:05 -0300
Message-ID: <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:32838 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168575AbdDXLhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 07:37:06 -0400
Received: by mail-io0-f178.google.com with SMTP id k87so190234201ioi.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 04:37:06 -0700 (PDT)
In-Reply-To: <20170424112906.GR26900@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 24, 2017 at 8:29 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> So clearly the system isn't changing the frequency a lot here and you stayed at
> the min freq for ever. Please give output of this as well:
>
> grep . /sys/devices/system/cpu/cpufreq/ondemand/*

#  grep . /sys/devices/system/cpu/cpufreq/ondemand/*
/sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:0
/sys/devices/system/cpu/cpufreq/ondemand/min_sampling_rate:10000
/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:109000
/sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95

> I am also worried if the interrupts from the touchscreen will be enough to boost
> the frequency of the CPU ?

It does not seem that the interrupts from the touchscreen boost the
frequency of the CPU.

When I keep touching the panel, the CPU frequency stays at 396 MHz.

Thanks
