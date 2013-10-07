From: Ethan Zhao <ethan.kernel@gmail.com>
Subject: Re: [PATCH V3]hrtimer: Fix a performance regression by disable
 reprogramming in remove_hrtimer
Date: Mon, 7 Oct 2013 12:57:54 +0800
Message-ID: <CABawtvN-rO+YAy55+W-oxgtibh=9ZDnqNMGcreg6u==C3Cr7xA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381120901.9926.11.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <bitbucket@online.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rjw@sisk.pl, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

Got it.

On Mon, Oct 7, 2013 at 12:41 PM, Mike Galbraith <bitbucket@online.de> wrote:
> On Fri, 2013-10-04 at 20:06 +0800, Ethan Zhao wrote:
>> Mike, Peter,
>>    Seems lots of work has been done these days, studious guys. those
>> patches merged in last stable/dev branch (fix performance regression
>> caused by extra rtimer programming and rescheduling IPI,confusing
>> idle... etc) ? So I could just do a lazy pull for test with my
>> environment.  I need catch up with other mail loops with my vacation
>> again.
>
> Massive timer overhead seems to have crawled off and died while I wasn't
> looking.  Peter's fix for IPI woes..
>
> tip commit ea811747 sched, idle: Fix the idle polling state logic
>
> ..hasn't yet swum upstream.
>
> -Mike
>
