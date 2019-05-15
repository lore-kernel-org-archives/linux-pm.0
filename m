From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
Date: Wed, 15 May 2019 18:30:32 +0200
Message-ID: <20190515163032.GU2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-3-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-3-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:18PM +0530, Parth Shah wrote:
> +void turbo_sched_get(void)
> +{
> +	spin_lock(&turbo_sched_lock);
> +	if (!turbo_sched_count++)
> +		static_branch_enable(&__turbo_sched_enabled);
> +	spin_unlock(&turbo_sched_lock);
> +}

Muwhahaha, you didn't test this code, did you?
