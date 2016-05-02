From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Mon, 2 May 2016 10:11:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1605021007310.3692@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com> <alpine.DEB.2.11.1604271216400.3941@nanos>
 <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com> <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com> <alpine.DEB.2.11.1604290240560.3718@nanos>
 <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40230 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEBIM4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 04:12:56 -0400
In-Reply-To: <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 29 Apr 2016, Lianwei Wang wrote:
> On Thu, Apr 28, 2016 at 5:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Wrong. This is the symptom. The root cause is in #1. Therefor you are trying
> > to fix the symptom and not the root cause
> >
> I don't understand why you keep saying that the issue is in the pm
> notifier callback. As I told you, the pm notifier return an error(or
> NOTIFY_BAD) on purpose to abort the suspend process. This is work as
> design. Any driver can abort the suspend process if it is not ready to
> suspend.

Right. That's not the issue. The issue is that as a consequence we end up with
an unbalanced count. So how do we end up with an unbalanced count? That's what
needs to be fixed and not worked around.

> > I completely understand that you are tyring to put the cart before the horse.
> No. Your understanding is wrong.

My understanding is very correct. We have a situation which leads to an
unbalanced count. Instead of fixing that, you fix up the unbalanced count.

Thanks,

	tglx
