From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH V3]hrtimer: Fix a performance regression by disable
 reprogramming in remove_hrtimer
Date: Mon, 07 Oct 2013 06:41:41 +0200
Message-ID: <1381120901.9926.11.camel@marge.simpson.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61249 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3JGEmj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 00:42:39 -0400
In-Reply-To: <CABawtvMo+NtTv3a3jj=YTg-Om=MzHhVDARdtTA-DtTMzNeNAJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rjw@sisk.pl, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, lenb@kernel.org

On Fri, 2013-10-04 at 20:06 +0800, Ethan Zhao wrote: 
> Mike, Peter,
>    Seems lots of work has been done these days, studious guys. those
> patches merged in last stable/dev branch (fix performance regression
> caused by extra rtimer programming and rescheduling IPI,confusing
> idle... etc) ? So I could just do a lazy pull for test with my
> environment.  I need catch up with other mail loops with my vacation
> again.

Massive timer overhead seems to have crawled off and died while I wasn't
looking.  Peter's fix for IPI woes..

tip commit ea811747 sched, idle: Fix the idle polling state logic

..hasn't yet swum upstream.

-Mike

