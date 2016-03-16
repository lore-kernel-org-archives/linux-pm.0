From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 16 Mar 2016 23:39:16 +0100
Message-ID: <20160316223916.GK6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <11678919.CQLTrQTYxG@vostro.rjw.lan>
 <20160316175211.GF6344@twins.programming.kicks-ass.net>
 <1520262.pnveEYDEnp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520262.pnveEYDEnp@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 10:38:14PM +0100, Rafael J. Wysocki wrote:
> > If you care what cpu the work runs on, you should schedule_work_on(),
> > regular schedule_work() can end up on any random cpu (although typically
> > it does not).
> 
> I know, but I don't care too much.
> 
> "ondemand" and "conservative" use schedule_work() for the same thing, so
> drivers need to cope with that if they need things to run on a particular
> CPU.

Or are just plain buggy -- like a lot of code that uses schedule_work()
for per-cpu thingies; that is, its a fairly common bug and only recently
did we add that RR thing.

