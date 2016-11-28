From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 4/8] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Mon, 28 Nov 2016 09:56:08 +0100
Message-ID: <20161128085608.v7ujy5j2iftn6qs5@pd.tnic>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <07cc62426a28bad57b01ab16bb903a9c84fa5421.1479844244.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <07cc62426a28bad57b01ab16bb903a9c84fa5421.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 12:23:56PM -0800, Tim Chen wrote:
> Intel Turbo Boost Max Technology 3.0 (ITMT) feature
> allows some cores to be boosted to higher turbo
> frequency than others.
> 
> Add /proc/sys/kernel/sched_itmt_enabled so operator
> can enable/disable scheduling of tasks that favor cores
> with higher turbo boost frequency potential.
> 
> By default, system that is ITMT capable and single
> socket has this feature turned on.  It is more likely
> to be lightly loaded and operates in Turbo range.
> 
> When there is a change in the ITMT scheduling operation
> desired, a rebuild of the sched domain is initiated
> so the scheduler can set up sched domains with appropriate
> flag to enable/disable ITMT scheduling operations.
> 
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/include/asm/topology.h |   7 ++-
>  arch/x86/kernel/itmt.c          | 108 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 112 insertions(+), 3 deletions(-)

...

> +/*
> + * Boolean to control whether we want to move processes to cpu capable
> + * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
> + * Technology 3.0.
> + *
> + * It can be set via /proc/sys/kernel/sched_itmt_enabled
> + */
> +unsigned int __read_mostly sysctl_sched_itmt_enabled;

Err, can we not have the boolean in the name itself?

I.e., have it called sysctl_sched_itmt and 1 means enabled and 0
disabled? I.e., the classic thing. :)

Ditto for the sysctl name?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
