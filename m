From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT] [PATCH 10/10] cpufreq: intel_pstate: enable boost for
 SKX
Date: Wed, 16 May 2018 09:49:48 +0200
Message-ID: <20180516074948.GZ12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-11-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-11-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 15, 2018 at 09:49:11PM -0700, Srinivas Pandruvada wrote:
> Enable HWP boost on Skylake server platform.

Why not unconditionally enable it on everything HWP ?
