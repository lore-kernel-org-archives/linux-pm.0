From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Thu, 5 May 2016 14:13:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1605051404290.3540@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com> <alpine.DEB.2.11.1604271216400.3941@nanos>
 <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com> <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com> <alpine.DEB.2.11.1604290240560.3718@nanos>
 <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com> <alpine.DEB.2.11.1605021007310.3692@nanos> <CAJFUiJizA=ZxXh5BNj-eL6xsVrNEbTnd0Z5yePPDxAR8YjGibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55215 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbcEEMOx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 08:14:53 -0400
In-Reply-To: <CAJFUiJizA=ZxXh5BNj-eL6xsVrNEbTnd0Z5yePPDxAR8YjGibw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 4 May 2016, Lianwei Wang wrote:
> In this example, the unbalanced count is caused by the
> cpu_hotplug_pm_callback pm notifier callback function.

I doubt that.

> We can add a variable to avoid the unbalanced call of cpu_hotplug_enable
> ,e.g.

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3e3f6e49eabb..aa6694f0e9d3 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1140,16 +1140,21 @@ static int
>  cpu_hotplug_pm_callback(struct notifier_block *nb,
>                         unsigned long action, void *ptr)
>  {
> +       static int disabled;
> +
>         switch (action) {
> 
>         case PM_SUSPEND_PREPARE:
>         case PM_HIBERNATION_PREPARE:
>                 cpu_hotplug_disable();
> +               disabled = 1;
>                 break;
> 
>         case PM_POST_SUSPEND:
>         case PM_POST_HIBERNATION:
> -               cpu_hotplug_enable();
> +               if (disabled)
> +                       cpu_hotplug_enable();
> +               disabled = 0;
>                 break;
> 
>         default:
> 
> Please let me know if you like to fix it in this way.

So you are moving the work around one step down w/o providing any reasonable
explanation how this asymetric call of that callback can happen.

Can you eventually come up with a coherent explanation of the problem down to
the root cause or are we going to play this "move the workaround one step
down" game for another 10 rounds?
 
> +static void _cpu_hotplug_enable(void)
> +{
> +       if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
> +               return;
> +
> +       cpu_hotplug_disabled--;
> +}
> 
> I like to fix it in the cpu_hotplug_enable because it is a public

You CANNOT fix it there. The problem is the call site and NOT
cpu_hotplug_enable(). Can you finally accept this?

> kernel API and fix in it can prevent any other unbalanced calling. I

It cannot prevent any unbalanced calls. It mitigates the issue, but that's a
different problem.

We can discuss that seperately after fixing the offending call site.

Thanks,

	tglx
