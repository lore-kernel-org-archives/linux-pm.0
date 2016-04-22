From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 22 Apr 2016 18:37:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604221834430.3941@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54718 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbcDVQjb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 12:39:31 -0400
In-Reply-To: <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 22 Apr 2016, Lianwei Wang wrote:

> On Thu, Apr 21, 2016 at 3:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Apr 20, 2016 at 09:56:07PM -0700, Lianwei Wang wrote:
> >> Currently it just print a warning message but did not
> >> reset cpu_hotplug_disabled when the enable/disable is
> >> unbalanced. The unbalanced enable/disable will lead
> >> the cpu hotplug work abnormally.
> >>
> >> Reset it to 0 when an unablanced enable detected.
> >
> > How can this happen in the first place?
> 
> That's is my question too, and why we check it with WARN_ON here?
> Obviously it is possible to happened because the
> cpu_hotplug_disable/enable are both kernel API and any driver can call
> it. A unbalanced check is a good way to handle it.
> 
> The actually problem here is that what we do in case it happened? Just
> give a warning or do some error handling and recover it back? This's
> my focus..

Actually we do nothing if it happens. We just emit a warning and that's good
enough because the machine is still accessible and therefor debugable. It just
renders cpu hotplug useless, but that's not a fundamental problem. If you look
at the checks we do with preempt count, where we actually restore the counter
that's a different issue. If we would not do that we simply would break the
machine completely and end up in an endless storm of warnings. Different
story, but that hotplug thing is just not in that class of problems.

Thanks,

	tglx
