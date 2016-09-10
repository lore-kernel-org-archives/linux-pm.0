From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 4/8] sched, x86: use arch_update_cpu_topology to
 indicate x86 need sched domain rebuild
Date: Sat, 10 Sep 2016 18:20:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609101532450.2804@nanos>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1473373615-51427-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1473373615-51427-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:

How is this related to sched? And please stop writing lengthy sentences in
the subject line.

> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Provides x86 with arch_update_cpu_topology function. This function
> allows us to indicate that a condition is detected that the sched
> domain of x86 needs a complete rebuild.

scheduler domains are not x86 specific .... 

> This is done by setting the x86_topology_update flag.

So without reading the patch I expect that the function sets the
x86_topology_update flag. Crap.

What you really want to say is:

  The scheduler calls arch_update_cpu_topology() to check whether the
  scheduler domains have to be rebuilt.

  So far x86 has no requirement for this, but the upcoming IMTI support
  makes this necessary.

  Request the rebuild when the x86 internal update flag is set.

Or something along these lines. Changelog is a important part of a patch,
really..

> +/* Flag to indicate if a complete sched domain rebuild is required */
> +bool x86_topology_update;
> +
> +int arch_update_cpu_topology(void)
> +{
> +	if (x86_topology_update) {
> +		x86_topology_update = false;
> +		return 1;
> +	} else
> +		return 0;

That lacks braces around the else path, but why aren't you just doing the
obvious:

	if (!x86_topology_update)
		return false;
	
	x86_topology_update = false;
	return true;

That would be too simple to read, right?;

Thanks,

	tglx
