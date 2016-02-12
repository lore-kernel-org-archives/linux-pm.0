From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v6 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 17:02:28 -0800
Message-ID: <002501d16531$0cad6c70$26084550$@net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>	<2111826.yKEUOzphHC@vostro.rjw.lan>	<008201d16458$69b2a4f0$3d17eed0$@net>	<7442347.PCmPlrAvBe@vostro.rjw.lan>	<002101d1651e$8ff027c0$afd07740$@net> <CAJZ5v0h5QS5xO4EGSCO0POJQq7fPN+yyr6ER8b0isU_ZfsPHWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta14.telus.net ([209.171.16.87]:36395 "EHLO cmta14.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbcBLBCc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Feb 2016 20:02:32 -0500
In-Reply-To: <CAJZ5v0h5QS5xO4EGSCO0POJQq7fPN+yyr6ER8b0isU_ZfsPHWw@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Thomas Gleixner' <tglx@linutronix.de>

On 2016.02.11 15:28 Rafael J. Wysocki wrote:
> On 2106.02.11 14:50 Doug Smythies wrote:

>> What I do have from my 2 hour idle tests is the of total number of passes through
>> the intel_pstate driver:
>>
>> Control sample: Kernel 4.3-rc3: 37949 passes.
>> Kernel 4.3-rc3 + rjw 3 patch set v5: 180355 passes
>> Kernel 4.3-rc3 + rjw 3 patch set v6: 201307 passes
>> Kernel 4.3-rc3 + rjw 3 patch set v7: 203619 passes

> That reflects how things work with the changes.  The driver is called
> more often now and has to decide whether or not to take a sample.

Opps. I didn't understand that point, and so only now looked more
closely at the code.

> It would be interesting to see how many of those were samples that
> were actually taken if you can instrument that.

So, those are samples that were taken. There is no trace information
acquired when the new code decides not to take a sample (or so is my
understanding from a quick look).

I did find a couple of cases where the duration (elapsed time between
samples on a given CPU) was less than the nominal sample time. The search
was not exhaustive. (Likely O.K. within expected jitter, just noting
is all. The post processing tools use the kernel clock to do the
calculation, as the duration calculated by the driver is not in the trace
data.)

2 hour idle test: v5 patch 9.955 mSec sample 10078 CPU 1
2 hour idle test: v7 patch 9.968 mSec sample 49476 CPU 3
Duration load test: v7 patch 9.982 mSec sample 10997 CPU 2

... Doug


