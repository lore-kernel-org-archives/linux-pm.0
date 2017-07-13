From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Thu, 13 Jul 2017 07:11:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707130655200.2332@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <20170708000303.21863-5-dbasehore@chromium.org> <alpine.DEB.2.20.1707130003150.2510@nanos> <CAGAzgsqZvfR9WtYDq5yaSDiKK8LSivE5uOTsUorVtWxfy18SEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdGMFLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 01:11:34 -0400
In-Reply-To: <CAGAzgsqZvfR9WtYDq5yaSDiKK8LSivE5uOTsUorVtWxfy18SEA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, 12 Jul 2017, dbasehore . wrote:
> On Wed, Jul 12, 2017 at 3:16 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > There are more issues with this: If there is a hrtimer scheduled on that
> > last CPU which enters the idle freeze state and that timer is 10 minutes
> > away, then the check timer can't be programmed and the system will happily
> > stay for 10 minutes in some shallow C state without notice. Not really
> > useful.
> 
> Are hrtimers not suspended after timekeeping_suspend is called?

They are. As I said I forgot about the inner workings and that check for
state != shutdown confused me even more, as it just looked like this might
be a valid state.

> > You know upfront whether the i915 power wells (or whatever other machinery)
> > is not powered off to allow the system to enter a specific power state. If
> > you think hard enough about creating infrastructure which allows you to
> > register power related facilities and then check them in that idle freeze
> > enter state, then you get immediate information WHY this happens and not
> > just the by chance notification about the fact that it happened.
> 
> It's not always something that can be checked by software. There was
> one case where an ordering for powering down audio hardware prevented
> proper PC10 entry, but there didn't seem to be any way to check that.
> Hardware watchdogs also have the same lack of clarity, but most if not
> all desktop and mobile processors ship with one. Overall, this seems
> to be the best that can be done at this point in freeze, and we can't
> really rely on every part of the system properly validating it's state
> in its suspend operation.

So if I understand correctly, this is the last resort of catching problems
which can't be detected upfront or are caused by a software bug.

I'm fine with that, but please explain and document it proper. The current
explanation is confusing at best.

Thanks,

	tglx
