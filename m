From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 5/10] cpufreq: Move governor attribute set headers to
 cpufreq.h
Date: Fri, 4 Mar 2016 11:23:13 +0530
Message-ID: <20160304055313.GE27109@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <5093627.PgPWOgVgsM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5093627.PgPWOgVgsM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-03-16, 04:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move definitions and function headers related to struct gov_attr_set
> to include/linux/cpufreq.h so they can be used by (future) goverernors
> located outside of drivers/cpufreq/.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch.  Needed to move cpufreq_schedutil.c to kernel/sched/.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
