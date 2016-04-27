From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Wed, 27 Apr 2016 12:17:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604271216400.3941@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51522 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbcD0KSx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 06:18:53 -0400
In-Reply-To: <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 25 Apr 2016, Lianwei Wang wrote:
> On Mon, Apr 25, 2016 at 1:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Anyway, from a product perspective way, if we don't want to restore
> >> the unbalanced counter to 0, then maybe a BUG_ON is more reasonable
> >> than WARN_ON.
> >
> > Not at all. BUG_ON is the last resort if we have no other way to handle an
> > issue.
> Actually to the customer, you do nothing currently at all, and once it
> happened then there is no way for the customer to recover it except do
> a power cycle. A BUG_ON can trigger a power cycle and recover it.

Do you have a single incident where this happened?

Thanks,

	tglx
