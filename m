From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu
 topology for ITMT
Date: Sat, 10 Sep 2016 15:13:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609101512390.2804@nanos>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51159 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbcIJNPq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 09:15:46 -0400
In-Reply-To: <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com

On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
>  
>  void set_sched_topology(struct sched_domain_topology_level *tl)
>  {
> +	if (WARN_ON_ONCE(sched_smp_initialized))
> +		return;
> +
>  	sched_domain_topology = tl;
>  }

This change has nothing to do with $subject. Seperate patch please.

Thanks,

	tglx
