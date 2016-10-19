From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 4.8.1 regression with cpufreq governors
Date: Wed, 19 Oct 2016 19:36:08 +0530
Message-ID: <20161019140608.GA11766@vireshk-i7>
References: <20161018004606.GA5559@comcast.net>
 <2549240.nvakNXlyKF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33834 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755784AbcJSOLi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 10:11:38 -0400
Received: by mail-pf0-f182.google.com with SMTP id r16so17050992pfg.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 07:11:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2549240.nvakNXlyKF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tim Walberg <twalberg@comcast.net>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 18-10-16, 23:10, Rafael J. Wysocki wrote:
> On Monday, October 17, 2016 07:46:06 PM Tim Walberg wrote:
> > May or may not be related to similar reports, but here's what I've just observed
> > on my system. Built a stock kernel from tags/v4.8.1, relevant cpufreq bits:
> > 
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_CPU_FREQ=y
> > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > CONFIG_CPU_FREQ_GOV_COMMON=y
> > CONFIG_CPU_FREQ_STAT=y
> > CONFIG_CPU_FREQ_STAT_DETAILS=y
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> > CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> > CONFIG_CPU_FREQ_GOV_USERSPACE=m
> > CONFIG_CPU_FREQ_GOV_ONDEMAND=m
> > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
> > # CONFIG_X86_PCC_CPUFREQ is not set
> > CONFIG_X86_ACPI_CPUFREQ=m
> > CONFIG_X86_ACPI_CPUFREQ_CPB=y
> > 
> > 
> > Conservative is set as default governer, yet when boot completes, all CPUs are
> > pegged at the highest frequency. Changing governor to powersave knocks them all
> > down to the lowest available frequency. Putting them back on conservative (or
> > ondemand) results in no change in frequency, despite generating load. Switching
> > to performance of course kicks them back up to high frequency. Basically, the
> > governors don't seem to be ... governing.
> 
> The "convervative" governor issue seems to be the one fixed recently
> (http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-cpufreq&id=abb6627910a1e783c8e034b35b7c80e5e7f98f41).
> 
> I'm not sure why "ondemand" behaves incorrectly for you though.

@Tim: Can you please try this as well:

https://marc.info/?l=linux-kernel&m=147624218132250&w=2

Subject: [PATCH V2] cpufreq: skip invalid entries when searching the frequency

-- 
viresh
