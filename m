From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v5 1/2] cpumask: export cpumask_any_but
Date: Wed, 02 Mar 2016 14:11:53 +1030
Message-ID: <878u21mtq6.fsf@rustcorp.com.au>
References: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com> <1456261152-21907-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456261152-21907-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Jacob Pan <jacob.jun.pan@linux.intel.com> writes:
> Export cpumask_any_but() for module use. This will be used by drivers
> such as intel_rapl to locate an active cpu on a socket.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks!
Rusty.

> ---
>  lib/cpumask.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 5a70f61..81dedaa 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -41,6 +41,7 @@ int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
>  			break;
>  	return i;
>  }
> +EXPORT_SYMBOL(cpumask_any_but);
>  
>  /* These are not inline because of header tangles. */
>  #ifdef CONFIG_CPUMASK_OFFSTACK
> -- 
> 1.9.1
