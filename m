From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH V2 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Tue, 2 Apr 2013 09:34:53 -0500
Message-ID: <20130402143453.GA19613@jshin-Toonie>
References: <1364495057-14939-1-git-send-email-jacob.shin@amd.com>
 <1364495057-14939-3-git-send-email-jacob.shin@amd.com>
 <4985234.c9GFoGKqo8@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:9009
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761234Ab3DBOfA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 10:35:00 -0400
Content-Disposition: inline
In-Reply-To: <4985234.c9GFoGKqo8@skinner.arch.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Tue, Apr 02, 2013 at 01:40:13PM +0200, Thomas Renninger wrote:
> On Thursday, March 28, 2013 01:24:17 PM Jacob Shin wrote:
> > Future AMD processors, starting with Family 16h, can provide software
> > with feedback on how the workload may respond to frequency change --
> > memory-bound workloads will not benefit from higher frequency, where
> > as compute-bound workloads will. This patch enables this "frequency
> > sensitivity feedback" to aid the ondemand governor to make better
> > frequency change decisions by hooking into the powersave bias.
> If I read this correctly, nothing changes even if the driver is loaded,
> unless user modifies:
> /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
> is this correct?

Hi, yes that is correct.

> 
> I wonder who should modify:
> /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
> Even cpupower is not aware of this very specific tunable.

Hmm .. I had thought that end user or distros would already know about
it/use it since the powersave_bias tunable sysfs already exists.

I guess not?

> 
> Also, are you sure cpufreq subsystem will be the only user
> of this one?
> Or could cpuidle or others also make use of this somewhen in the future?

I think so, since this register deals with how the workload is
affected by frequency changes -- cpufreq.

> 
> Then this could more be done like:
> drivers/cpufreq/mperf.c
> And scheduler, cpuidle, cpufreq or whatever could use this as well.
> 
> Just some thinking:
> I wonder how one could check/verify that the right thing is done
> (by CPU and kernel). Ideally it would be nice to have the CPU register
> appended to a cpufreq or cpuidle event trace.
> But this very (AMD or X86 only?) specific data would not look nice there.
> An arch placeholder value would be needed or similar?
> 
> ...
> > +}
> > +
> > +static int __init amd_freq_sensitivity_init(void)
> > +{
> > +	int i;
> > +	u32 eax, edx, dummy;
> > +
> > +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > +		return -ENODEV;
> > +
> > +	cpuid(0x80000007, &eax, &dummy, &dummy, &edx);
> If this really should be a separate module:
> Does/will Intel have the same (feature/cpuid bit)?
> Anyway, this should get a general AMD or X86 CPU capability flag.

As far as I know, this is AMD specific, yes I'll add the AMD vendor
check.

> 
> Then you can also autoload this driver similar to how it's done in acpi-
> cpufreq:
> static const struct x86_cpu_id acpi_cpufreq_ids[] = {
>         X86_FEATURE_MATCH(X86_FEATURE_ACPI),
>         X86_FEATURE_MATCH(X86_FEATURE_HW_PSTATE),
>         {}
> };
> MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);

Okay.

Thanks.

> 
>        Thomas
> 

