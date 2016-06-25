From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4][RFC v2] PM / sleep: Avoid accessing frozen_cpus if
 it is NULL
Date: Sat, 25 Jun 2016 18:51:13 +0200
Message-ID: <20160625165113.GA4362@amd>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <f9847b8bd15ad5056255150c71df37f2f74bc080.1466844557.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45491 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcFYQvR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2016 12:51:17 -0400
Content-Disposition: inline
In-Reply-To: <f9847b8bd15ad5056255150c71df37f2f74bc080.1466844557.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org

On Sun 2016-06-26 00:18:30, Chen Yu wrote:
> frozen_cpus might be NULL if the allocation in previous
> alloc_frozen_cpus failed, when CONFIG_CPUMASK_OFFSTACK
> is set.
> 
> This patch avoid accessing this cpumask if it is NULL.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d948e44..d25266e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1021,6 +1021,8 @@ int disable_nonboot_cpus(void)
>  {
>  	int cpu, first_cpu, error = 0;
>  
> +	if (frozen_cpus == NULL)
> +		return -ENOMEM;
>  	cpu_maps_update_begin();
>  	first_cpu = cpumask_first(cpu_online_mask);
>  	/*

I'd say that whoever allocates frozen_cpus should just abort the
hibernation if there's not enough memory for the operation...? This
seems like checking for the problem too late.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
