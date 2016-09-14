From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: create link to policy only for registered CPUs
Date: Wed, 14 Sep 2016 03:00:55 +0200
Message-ID: <1733771.eFmsFmZ21e@vostro.rjw.lan>
References: <20160819110032.GM1041@n2100.armlinux.org.uk> <59daae7da84077fbf845b1aad2962933585f8e35.1473662181.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63692 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753442AbcINAys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:54:48 -0400
In-Reply-To: <59daae7da84077fbf845b1aad2962933585f8e35.1473662181.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Monday, September 12, 2016 12:07:05 PM Viresh Kumar wrote:
> If a cpufreq driver is registered very early in the boot stage (e.g.
> registered from postcore_initcall()), then cpufreq core may generate
> kernel warnings for it.
> 
> In this case, the CPUs are brought online, then the cpufreq driver is
> registered, and then the CPU topology devices are registered. However,
> by the time cpufreq_add_dev() gets called, the cpu device isn't stored
> in the per-cpu variable (cpu_sys_devices,) which is read by
> get_cpu_device().
> 
> So the cpufreq core fails to get device for the CPU, for which
> cpufreq_add_dev() was called in the first place and we will hit a
> WARN_ON(!cpu_dev).
> 
> Even if we reuse the 'dev' parameter passed to cpufreq_add_dev() to
> avoid that warning, there might be other CPUs online that share the
> policy with the cpu for which cpufreq_add_dev() is called. Eventually
> get_cpu_device() will return NULL for them as well, and we will hit the
> same WARN_ON() again.
> 
> In order to fix these issues, change cpufreq core to create links to the
> policy for a cpu only when cpufreq_add_dev() is called for that CPU.
> 
> Reuse the 'real_cpus' mask to track that as well.
> 
> Note that cpufreq_remove_dev() already handles removal of the links for
> individual CPUs and cpufreq_add_dev() has aligned with that now.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

