From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Fri, 06 May 2016 21:36:24 +0200
Message-ID: <24377595.I7DSN3sTTg@vostro.rjw.lan>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan> <20160506190825.GA15729@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160506190825.GA15729@sky.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, May 06, 2016 12:08:25 PM Steve Muckle wrote:
> Looks good to me.
> 
> Also re-tested with intel_pstate on i7-3630QM !SMP, confirmed issue
> is resolved.

Thanks!
