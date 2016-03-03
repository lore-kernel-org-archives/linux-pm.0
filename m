From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC/RFT][PATCH 0/1] cpufreq: New governor based on
 scheduler-provided utilization data
Date: Thu, 3 Mar 2016 15:27:10 +0100
Message-ID: <20160303142709.GB10948@gmail.com>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5059413.77KZsd2lep@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>
List-Id: linux-pm@vger.kernel.org


So I wanted to give you some feedback for this, from the scheduler maintainer's 
POV.

Looks like there are two cpufreq modernization efforts, one is this series, the 
other is Steve Muckle's:

  [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency selection

What I'd like to see from a scheduler metrics usage POV is a single central place, 
kernel/sched/cpufreq.c, where all the high level ('governor') decisions are made.  
This is the approach Steve's series takes.

That is a central point that has ready access to the scheduler internal 
utilization metrics.

drivers/cpufreq/ would contain legacy governors plus low level drivers that do 
frequency switching with a well-defined interface.

Could you guys work out a single series that implements the sum of the two series? 
Looks like we are 90% 'there' already.

Thanks,

	Ingo
