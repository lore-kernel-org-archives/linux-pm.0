From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [UPDATE][RFC/RFT][PATCH 07/10] cpufreq: intel_pstate: HWP boost
 performance on busy task migrate
Date: Thu, 17 May 2018 10:23:53 +0200
Message-ID: <20180517082353.GN12217@hirez.programming.kicks-ass.net>
References: <20180516205111.22231-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516205111.22231-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 16, 2018 at 01:51:11PM -0700, Srinivas Pandruvada wrote:
> @@ -263,6 +264,7 @@ struct cpudata {
>  	call_single_data_t csd;
>  	bool hwp_boost_active;
>  	u64 last_io_update;
> +	bool migrate_hint;
>  };

You want to look at that structure layout...
