From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 6 May 2016 09:18:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1605060908350.3540@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com> <alpine.DEB.2.11.1604271216400.3941@nanos>
 <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com> <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com> <alpine.DEB.2.11.1604290240560.3718@nanos>
 <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com> <alpine.DEB.2.11.1605021007310.3692@nanos> <CAJFUiJizA=ZxXh5BNj-eL6xsVrNEbTnd0Z5yePPDxAR8YjGibw@mail.gmail.com> <alpine.DEB.2.11.1605051404290.3540@nanos>
 <CAJFUiJhryV7vHAofFSCc8iEL2FgYQ-qt8xzW3vPj9EQ3di-51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58042 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbcEFHT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 03:19:57 -0400
In-Reply-To: <CAJFUiJhryV7vHAofFSCc8iEL2FgYQ-qt8xzW3vPj9EQ3di-51g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 6 May 2016, Lianwei Wang wrote:
> On Thu, May 5, 2016 at 5:13 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Can you eventually come up with a coherent explanation of the problem down to
> > the root cause or are we going to play this "move the workaround one step
> > down" game for another 10 rounds?
> >
> Do you agree that any driver can abort the suspend process by
> returning an error or NOTIFY_BAD if it is not ready to suspend?
> I have explain it and I also copied the example code that abort
> suspend by returning an error or NOTIFY_BAD in the pm notifier
> callback function.

I don't need copied example code which does not tell me what the real problem
is.

> The cpu_hotplug_disable and cpu_hotplug_enable are called in one of
> the PM notifier callback. And they are called from two difference
> place.
> Below is how it happened:
>   pm_suspend
>     |--enter_state
>         |--suspend_prepare
>             |--pm_notifier_call_chain(PM_SUSPEND_PREPARE)
>             |    |--call_back_1
>             |    |--call_back_..
>             |    |--call_back_n ===> return NOTIFY_BAD to abort call chain and
>             |    |                                suspend process here
>             |    |--cpu_hotplug_pm_callback()
>             |    |   |--cpu_hotplug_disable  =====> remember it is not
> called yet
>             |    |--call_back_..
>             |
>             |--pm_notifier_call_chain(PM_POST_SUSPEND)
>             |    |--call_back_1
>             |    |--call_back_..
>             |    |--call_back_n
>             |    |--cpu_hotplug_pm_callback()
>             |    |   |--cpu_hotplug_enable  =====> Here it is unbalanced called
>             |    |--call_back_..
>             |
> So, keep in mind that for pm notifier call chain, the
> PM_SUSPEND_PREPARE notifier and PM_POST_SUSPEND notifier is not always
> paired called. Sometimes for a driver's pm notifier callback, the
> PM_POST_SUSPEND is called without PM_SUSPEND_PREPARE.

So that is the real problem: cpu_hotplug_pm_callback(PM_POST_SUSPEND) can be
called w/o a previous call to cpu_hotplug_pm_callback(PM_SUSPEND_PREPARE).
 
> > It cannot prevent any unbalanced calls. It mitigates the issue, but that's a
> > different problem.
> It did not migrate the issue. It give a warning message to log the
> unbalanced issue and it also make sure the cpu hotplug continue to
> work well even someone do an unbalanced call. It is a good checking as
> the enable_irq/disable_irq do. There are some other unbalanced
> checking in kernel too. All make sure the kernel has a better
> stability.

I'm not opposed to do that and I said so several times. But I said as well,
that we do not add this without fixing the problem which made you write that
patch in the first place.

So we have a proper explanation for the real problem now, but we have no
fix. 

And again: Your patch is NOT a fix. Simply because it will emit a warning
everytime the above happens. And that's wrong because the abort is a
legitimate scenario.

So please come up with a sensible fix for the suspend abort issue and then we
can add the balance check/fixup to the hotplug_disable/enable() code.

Thanks,

	tglx


