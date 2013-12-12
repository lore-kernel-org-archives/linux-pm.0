From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH V3]hrtimer: Fix a performance regression by disable
 reprogramming in remove_hrtimer
Date: Thu, 12 Dec 2013 15:42:02 +0100
Message-ID: <1386859322.6056.83.camel@marge.simpson.net>
References: <24EECBCC-F655-404F-8946-73CC36095A5F@gmail.com>
	 <1378362989.18435.2.camel@marge.simpson.net>
	 <20130905111428.GB23362@gmail.com>
	 <1378386697.6567.9.camel@marge.simpson.net>
	 <20130905133750.GA26637@gmail.com>
	 <1378445942.5434.31.camel@marge.simpson.net>
	 <20130909122325.GX31370@twins.programming.kicks-ass.net>
	 <1378730538.5586.30.camel@marge.simpson.net>
	 <20130909133044.GB31370@twins.programming.kicks-ass.net>
	 <20130909134635.GB26785@twins.programming.kicks-ass.net>
	 <20130911085643.GS26785@twins.programming.kicks-ass.net>
	 <1378895123.5476.83.camel@marge.simpson.net>
	 <CABawtvMo+NtTv3a3jj=YTg-Om=MzHhVDARdtTA-DtTMzNeNAJA@mail.gmail.com>
	 <1381120901.9926.11.camel@marge.simpson.net>
	 <CABawtvN-rO+YAy55+W-oxgtibh=9ZDnqNMGcreg6u==C3Cr7xA@mail.gmail.com>
	 <CABawtvNf5k8pKY6ioa8GdUzOn7h3aOBsWhSUNgmfuQSj+xtUbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64207 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3LLOmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2013 09:42:13 -0500
In-Reply-To: <CABawtvNf5k8pKY6ioa8GdUzOn7h3aOBsWhSUNgmfuQSj+xtUbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rjw@sisk.pl, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, 2013-12-12 at 22:14 +0800, Ethan Zhao wrote: 
> Mike,
>     it seems the IPI issue got root cause (cpu hardware errata ) now ?
> I only catch some pieces of the mails, is that to say the crazy horse
> made by Intel will wake up unexpected, and eat too much reschedule
> IPI, then the horse got hotter, performance down, and so the fix would
> be a 'CFLUSH' to all the buggy CPU, is that right ?

You're mixing a couple different issues together, but yeah, close
enough.  The barking amazonian tree guppy is being saved as we speak.

-Mike 

