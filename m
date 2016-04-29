From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 29 Apr 2016 02:44:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604290240560.3718@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com> <alpine.DEB.2.11.1604271216400.3941@nanos>
 <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com> <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60669 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcD2AqX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 20:46:23 -0400
In-Reply-To: <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, 28 Apr 2016, Lianwei Wang wrote:
> On Wed, Apr 27, 2016 at 11:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 27 Apr 2016, Lianwei Wang wrote:
> >> Yes. In our project, there is a kernel driver which register a pm
> >> notifier. On some conditions this pm notifier will return an error and
> >> abort the suspend process. The counter will be unbalanced in case it
> >> happened.
> >
> > So what? You wreckaged your driver, so you fix it and be done with it.
> 
> Do you mean no pm_notifier callback can return an error or NOTIFY_BAD
> to abort the suspend process?
> 
> It's not the driver issue. The driver return an error to abort the
> suspend process on purpose. Why do you think it is not allowed to
> return an error to abort suspend?
> 
> The issue is very clear as described below.
> 1. How the issue happened?
> One of the pm notifier return error to abort suspend before
> cpu_hotplug_disable() is called on PM_SUSPEND_PREPARE.
> 
> 2. What's the result?
> CPU hotplug work in a wrong way, or it doesn't work anymore. No way to
> recover it.
> 
> 3. The root cause is that there is no any handling for the unbalanced
> cpu_hotplug_disable/enable calling. This patch add a protection for
> such issue.

Wrong. This is the symptom. The root cause is in #1. Therefor you are trying
to fix the symptom and not the root cause
 
> Anything not clear?

No. 

I completely understand that you are tyring to put the cart before the horse.

Thanks,

	tglx
