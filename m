From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freq
Date: Fri, 1 Apr 2016 10:16:39 +0200
Message-ID: <20160401081639.GD3448@twins.programming.kicks-ass.net>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
 <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 01, 2016 at 12:37:00AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> For x86 processors with APERF/MPERF and TSC,
> return meaningful and consistent MHz in
> /proc/cpuinfo and
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> 
> MHz is computed like so:
> 
> MHz = base_MHz * delta_APERF / delta_MPERF
> 
> MHz is the average frequency of the busy processor
> over a measurement interval.  The interval is
> defined to be the time between successive reads
> of the frequency on that processor, whether from
> /proc/cpuinfo or from sysfs cpufreq/scaling_cur_freq.
> As with previous methods of calculating MHz,
> idle time is excluded.

Is this really a semantic you want to pin down?

Since we're looking at doing something like:

lkml.kernel.org/r/20160303162829.GB6375@twins.programming.kicks-ass.net

We could also just return cpu_khz * whatever fraction we store there,
knowing it is something recent.
