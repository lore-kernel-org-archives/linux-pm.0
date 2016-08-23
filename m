From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Tue, 23 Aug 2016 19:30:46 +0200
Message-ID: <1919195.z1pHchloxg@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1471925285.5747.5.camel@linux.intel.com> <CANRm+Cw1bVObw44akr0ofTyN=LDy-aoXYxNuSNmDQcg4byo3Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+Cw1bVObw44akr0ofTyN=LDy-aoXYxNuSNmDQcg4byo3Ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 23, 2016 12:50:14 PM Wanpeng Li wrote:
> 2016-08-23 12:08 GMT+08:00 Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
> > On Tue, 2016-08-23 at 11:48 +0800, Wanpeng Li wrote:
> >> Hi Rafael,
> >> 2016-08-01 7:38 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> >> >
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > The PID-base P-state selection algorithm used by intel_pstate for
> >> > Core processors is based on very weak foundations.  Namely, its
> >> > decisions are mostly based on the values of the APERF and MPERF
> >> > feedback registers and it only estimates the actual utilization to
> >> > check if it is not extremely low (in order to avoid getting stuck
> >> > in the highest P-state in that case).
> >> >
> >> > Since it generally causes the CPU P-state to ramp up quickly, it
> >> > leads to satisfactory performance, but the metric used by it is
> >> > only
> >> > really valid when the CPU changes P-states by itself (ie. in the
> >> > turbo
> >> > range) and if the P-state value set by the driver is treated by the
> >> > CPU as the upper limit on turbo P-states selected by it.
> >>
> >> Do you mean CPU will ignore the request value which is submitted by
> >> intel_pstate driver in the turbo range, but respect the upper limit
> >> on
> >> the turbo P-states which is submitted by intel_pstate driver?
> > Any request to request a P-state even upper limit can be totally
> > ignored in turbo range.
> 
> How to understand Rafael's description "if the P-state value set by
> the driver is treated by the CPU as the upper limit on the turbo
> P-states selected by it"? The upper limit will be totally ignored in
> turbo range.

It wasn't ignored, though, by some older CPU models.

Thanks,
Rafael
