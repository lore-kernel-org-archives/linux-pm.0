From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Thu, 12 Feb 2015 14:26:43 +0100
Message-ID: <20150212132643.GY23123@twins.programming.kicks-ass.net>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
 <2407992.WHaFxrNaoa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44840 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792AbbBLN0v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 08:26:51 -0500
Content-Disposition: inline
In-Reply-To: <2407992.WHaFxrNaoa@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 05:04:17AM +0100, Rafael J. Wysocki wrote:
> @@ -131,28 +133,32 @@ static struct cpuidle_state nehalem_csta
>  		.flags = MWAIT2flg(0x00),
>  		.exit_latency = 3,
>  		.target_residency = 6,
> -		.enter = &intel_idle },
> +		.enter = &intel_idle,
> +		.enter_freeze = intel_idle_freeze, },
>  	{
>  		.name = "C1E-NHM",
>  		.desc = "MWAIT 0x01",
>  		.flags = MWAIT2flg(0x01),
>  		.exit_latency = 10,
>  		.target_residency = 20,
> -		.enter = &intel_idle },
> +		.enter = &intel_idle,
> +		.enter_freeze = intel_idle_freeze, },
>  	{
>  		.name = "C3-NHM",
>  		.desc = "MWAIT 0x10",
>  		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency = 20,
>  		.target_residency = 80,
> -		.enter = &intel_idle },
> +		.enter = &intel_idle,
> +		.enter_freeze = intel_idle_freeze, },
>  	{
>  		.name = "C6-NHM",
>  		.desc = "MWAIT 0x20",
>  		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
>  		.exit_latency = 200,
>  		.target_residency = 800,
> -		.enter = &intel_idle },
> +		.enter = &intel_idle,
> +		.enter_freeze = intel_idle_freeze, },
>  	{
>  		.enter = NULL }
>  };

Why bother with enter_freeze() for any but the deepest state (C6 in this
case)?

Also, should we ignore things like intel_idle.max_cstate for this
selection?
