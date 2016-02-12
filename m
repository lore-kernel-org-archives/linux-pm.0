From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v6 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 23:25:18 -0800
Message-ID: <002601d16566$88455610$98d00230$@net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2111826.yKEUOzphHC@vostro.rjw.lan> <008201d16458$69b2a4f0$3d17eed0$@net> <7442347.PCmPlrAvBe@vostro.rjw.lan> <002101d1651e$8ff027c0$afd07740$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta4.telus.net ([209.171.16.77]:52496 "EHLO cmta4.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbcBLHZX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Feb 2016 02:25:23 -0500
In-Reply-To: <002101d1651e$8ff027c0$afd07740$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Thomas Gleixner' <tglx@linutronix.de>

On 2016.02.11 14:50 Doug Smythies wrote:
> On 2016.02.10 22:03 Srinivas Pandruvada wrote:
>> On Wednesday, February 10, 2016 03:11:43 PM Doug Smythies wrote:

>>> My test computer has an older model i7 (Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz)
>> Thanks Doug. If you have specific workloads, please compare performance.

> My work so far has been testing functionality, with unrealistic workloads specifically
> designed to exaggerate issues, in this case the duration problem.
>
> I'll look at some real world workload scenarios.

Turbostat used for package power, starts before Phoronix tests starts,
and ends after Phoronix test ends.

Control Sample: Kernel 4.5-rc3:
Phoronix ffmpeg: turbostat 180 Sec. 12.07 Sec. Ave. 27.14 Watts.
Phoronix apache: turbostat 200 Sec. 19797.0 R.P.S. Ave. 34.01 Watts.
Phoronix kernel: turbostat 180 Sec. 139.93 Sec. 49.09 Watts.
Phoronix Postmark (Disk Test): turbostat 200 Sec. 5813 T.P.S. Ave. 21.33 Watts.

Kernel 4.5-rc3 + RJW 3 patch set version 7:
Phoronix ffmpeg: turbostat 180 Sec. 11.67 Sec. Ave. 27.35 Watts.
Phoronix apache: turbostat 200 Sec. 19430.7 R.P.S. Ave. 34.18 Watts.
Phoronix kernel: turbostat 180 Sec. 139.81 Sec. 48.80 Watts.
Phoronix Postmark (Disk Test): turbostat 200 Sec. 5683 T.P.S. Ave. 22.41 Watts.

... Doug


