From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/7] cpufreq: remove redundant CPUFREQ_INCOMPATIBLE notifier event
Date: Thu, 10 Sep 2015 01:26:36 +0200
Message-ID: <4897937.47p7WB7CoU@vostro.rjw.lan>
References: <cover.1438571116.git.viresh.kumar@linaro.org> <406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Monday, August 03, 2015 08:36:14 AM Viresh Kumar wrote:
> What's being done from CPUFREQ_INCOMPATIBLE, can also be done with
> CPUFREQ_ADJUST. There is nothing special with CPUFREQ_INCOMPATIBLE
> notifier.

The above part of the changelog is a disaster to me. :-(

It not only doesn't explain what really goes on, but it's actively confusing.

What really happens is that the core sends CPUFREQ_INCOMPATIBLE notifications
unconditionally right after sending the CPUFREQ_ADJUST ones, so the former is
just redundant and it's more efficient to merge the two into one.

> Kill CPUFREQ_INCOMPATIBLE and fix its usage sites.
> 
> This also updates the numbering of notifier events to remove holes.

Why don't you redefine CPUFREQ_ADJUST as 1 instead?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/cpu-freq/core.txt       | 7 ++-----
>  drivers/acpi/processor_perflib.c      | 2 +-
>  drivers/cpufreq/cpufreq.c             | 4 ----
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 4 ++--
>  drivers/video/fbdev/pxafb.c           | 1 -
>  drivers/video/fbdev/sa1100fb.c        | 1 -
>  include/linux/cpufreq.h               | 9 ++++-----
>  7 files changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
> index 70933eadc308..ba78e7c2a069 100644
> --- a/Documentation/cpu-freq/core.txt
> +++ b/Documentation/cpu-freq/core.txt
> @@ -55,16 +55,13 @@ transition notifiers.
>  ----------------------------
>  
>  These are notified when a new policy is intended to be set. Each
> -CPUFreq policy notifier is called three times for a policy transition:
> +CPUFreq policy notifier is called twice for a policy transition:
>  
>  1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
>      they see a need for this - may it be thermal considerations or
>      hardware limitations.
>  
> -2.) During CPUFREQ_INCOMPATIBLE only changes may be done in order to avoid
> -    hardware failure.
> -
> -3.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
> +2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
>     - if two hardware drivers failed to agree on a new policy before this
>     stage, the incompatible hardware shall be shut down, and the user
>     informed of this.
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 47af702bb6a2..bb01dea39fdc 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -83,7 +83,7 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
>  	if (ignore_ppc)
>  		return 0;
>  
> -	if (event != CPUFREQ_INCOMPATIBLE)
> +	if (event != CPUFREQ_ADJUST)
>  		return 0;
>  
>  	mutex_lock(&performance_mutex);
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 76a26609d96b..293f47b814bf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2206,10 +2206,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  			CPUFREQ_ADJUST, new_policy);
>  
> -	/* adjust if necessary - hardware incompatibility*/
> -	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -			CPUFREQ_INCOMPATIBLE, new_policy);
> -
>  	/*
>  	 * verify the cpu speed can be set within this limit, which might be
>  	 * different to the first one
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> index d29e8da396a0..7969f7690498 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> @@ -97,8 +97,8 @@ static int pmi_notifier(struct notifier_block *nb,
>  	struct cpufreq_frequency_table *cbe_freqs;
>  	u8 node;
>  
> -	/* Should this really be called for CPUFREQ_ADJUST, CPUFREQ_INCOMPATIBLE
> -	 * and CPUFREQ_NOTIFY policy events?)
> +	/* Should this really be called for CPUFREQ_ADJUST and CPUFREQ_NOTIFY
> +	 * policy events?)
>  	 */
>  	if (event == CPUFREQ_START)
>  		return 0;
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 7245611ec963..94813af97f09 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -1668,7 +1668,6 @@ pxafb_freq_policy(struct notifier_block *nb, unsigned long val, void *data)
>  
>  	switch (val) {
>  	case CPUFREQ_ADJUST:
> -	case CPUFREQ_INCOMPATIBLE:
>  		pr_debug("min dma period: %d ps, "
>  			"new clock %d kHz\n", pxafb_display_dma_period(var),
>  			policy->max);
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index 89dd7e02197f..dcf774c15889 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1042,7 +1042,6 @@ sa1100fb_freq_policy(struct notifier_block *nb, unsigned long val,
>  
>  	switch (val) {
>  	case CPUFREQ_ADJUST:
> -	case CPUFREQ_INCOMPATIBLE:
>  		dev_dbg(fbi->dev, "min dma period: %d ps, "
>  			"new clock %d kHz\n", sa1100fb_min_dma_period(fbi),
>  			policy->max);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index bde1e567b3a9..bedcc90c0757 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -369,11 +369,10 @@ static inline void cpufreq_resume(void) {}
>  
>  /* Policy Notifiers  */
>  #define CPUFREQ_ADJUST			(0)
> -#define CPUFREQ_INCOMPATIBLE		(1)
> -#define CPUFREQ_NOTIFY			(2)
> -#define CPUFREQ_START			(3)
> -#define CPUFREQ_CREATE_POLICY		(4)
> -#define CPUFREQ_REMOVE_POLICY		(5)
> +#define CPUFREQ_NOTIFY			(1)
> +#define CPUFREQ_START			(2)
> +#define CPUFREQ_CREATE_POLICY		(3)
> +#define CPUFREQ_REMOVE_POLICY		(4)
>  
>  #ifdef CONFIG_CPU_FREQ
>  int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
