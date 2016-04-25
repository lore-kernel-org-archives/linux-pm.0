From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Mon, 25 Apr 2016 10:22:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604251018090.3941@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59682 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbcDYIYn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 04:24:43 -0400
In-Reply-To: <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 22 Apr 2016, Lianwei Wang wrote:
> Any way is Ok for debugging purpose. But think the kernel run on a
> customer machine, such as PC, Mobile phone or other devices. How we
> let the customer debug it but not recover it smartly?

There is nothing smart here. Restoring the count is a bandaid and has nothing
to do with recovery. If that WARN_ON triggers then other stuff is going to be
more fundamentally wrong so restoring the count is the least of our worries.

> Anyway, from a product perspective way, if we don't want to restore
> the unbalanced counter to 0, then maybe a BUG_ON is more reasonable
> than WARN_ON.

Not at all. BUG_ON is the last resort if we have no other way to handle an
issue.

Thanks,

	tglx
