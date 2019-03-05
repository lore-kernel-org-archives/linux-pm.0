From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Tue, 5 Mar 2019 13:24:07 +0100
Message-ID: <20190305122407.GI32477@hirez.programming.kicks-ass.net>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 05, 2019 at 12:00:43PM +0000, Quentin Perret wrote:

> And btw why do you need 9 steps to reach MAX starting from 128 ? If we
> double the boost at each wakeup you'll do 128 -> 256 -> 512 -> 1024 no ?

Argh; I'm so full of fail this week; 10-7=3.
