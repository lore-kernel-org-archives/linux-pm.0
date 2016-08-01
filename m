From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC][PATCH 0/7] cpufreq / sched: cpufreq_update_util() flags and iowait boosting
Date: Mon, 1 Aug 2016 08:26:54 -0700
Message-ID: <000001d1ec09$254ed840$6fec88c0$@net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:43756 "EHLO cmta20.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbcHAP2J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Aug 2016 11:28:09 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM list' <linux-pm@vger.kernel.org>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>

On 2016.07.31 16:32 Rafael J. Wysocki wrote:

> Hi,
>
> Admittedly, this hasn't been tested yet, so no promises and you have been
> warned.  It builds, though (on x86-64 at least).

It would not build for me until I changed the kernel configuration file like so:

$ scripts/diffconfig .config .config_rjw_b_2
 CPU_FREQ_GOV_SCHEDUTIL m -> y

(the above is actually backwards, it is "y" that works.)

Otherwise I got:

Kernel: arch/x86/boot/bzImage is ready  (#86)
  MODPOST 3318 modules
ERROR: "dl_bw_cpus" [kernel/sched/cpufreq_schedutil.ko] undefined!
ERROR: "dl_bw_of" [kernel/sched/cpufreq_schedutil.ko] undefined!
ERROR: "runqueues" [kernel/sched/cpufreq_schedutil.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed
make[4]: *** [__modpost] Error 1
Makefile:1186: recipe for target 'modules' failed

... Doug


