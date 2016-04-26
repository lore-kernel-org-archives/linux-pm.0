From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpupower: Add cpuidle parts into library
Date: Tue, 26 Apr 2016 22:27:58 +0200
Message-ID: <2288985.5qQqHb7DEP@vostro.rjw.lan>
References: <1685056.NeGEfvDZMv@skinner> <3109572.conPodfd62@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63193 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751953AbcDZUY6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 16:24:58 -0400
In-Reply-To: <3109572.conPodfd62@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org

On Monday, April 25, 2016 04:34:02 PM Thomas Renninger wrote:
> This more or less is a renaming and moving of functions and should not
> introduce any functional change.
> 
> cpupower was built from cpufrequtils (which had a C library providing easy
> access to cpu frequency platform info). In the meantime it got enhanced
> by quite some neat cpuidle userspace tools.
> 
> Now the cpu idle functions have been separated and added to the cpupower.so
> library.
> So beside an already existing public header file:
> cpufreq.h
> cpupower now also exports these cpu idle functions in:
> cpuidle.h 
> 
> Here again pasted for better review of the interfaces: 
> 
> ======================================
> int cpuidle_is_state_disabled(unsigned int cpu,
>                                        unsigned int idlestate);
> int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
>                                    unsigned int disable);
> unsigned long cpuidle_state_latency(unsigned int cpu,
>                                                 unsigned int idlestate);
> unsigned long cpuidle_state_usage(unsigned int cpu,
>                                         unsigned int idlestate);
> unsigned long long cpuidle_state_time(unsigned int cpu,
>                                                 unsigned int idlestate);
> char *cpuidle_state_name(unsigned int cpu,
>                                 unsigned int idlestate);
> char *cpuidle_state_desc(unsigned int cpu,
>                                 unsigned int idlestate);
> unsigned int cpuidle_state_count(unsigned int cpu);
> 
> char *cpuidle_get_governor(void);
> char *cpuidle_get_driver(void);
> 
> ======================================
> 
> 
> Signed-off-by: Thomas Renninger <trenn@suse.com>

It doesn't apply on top of 4.6-rc5 for me.  Can you please rebase on top
of the current Linus' tree?

Thanks,
Rafael

