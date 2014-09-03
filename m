From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH 1/3] sched: Add new API wake_up_if_idle() to wake up the
 idle cpu
Date: Wed, 3 Sep 2014 09:58:56 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A01E69C5E@SHSMSX101.ccr.corp.intel.com>
References: <1408351052-25075-1-git-send-email-chuansheng.liu@intel.com>
 <CALCETrWns2cPzS+goDmXjhVuxzD2OczxTF9UtARBFnw3hibjZg@mail.gmail.com>
 <20140903095410.GJ4783@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1989 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932645AbaICJ7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 05:59:12 -0400
In-Reply-To: <20140903095410.GJ4783@worktop.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Wang, Xiaoming" <xiaoming.wang@intel.com>, Ingo Molnar <mingo@redhat.com>, "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>, "Liu, Changcheng" <changcheng.liu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Wednesday, September 03, 2014 5:54 PM
> To: Andy Lutomirski
> Cc: Liu, Chuansheng; linux-pm@vger.kernel.org; Rafael J. Wysocki; Daniel
> Lezcano; Wang, Xiaoming; Ingo Molnar; Chakravarty, Souvik K; Liu, Changcheng;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] sched: Add new API wake_up_if_idle() to wake up the
> idle cpu
> 
> On Thu, Aug 21, 2014 at 02:21:51PM -0700, Andy Lutomirski wrote:
> > On Aug 18, 2014 3:52 AM, "Chuansheng Liu" <chuansheng.liu@intel.com>
> wrote:
> 
> > > +void wake_up_if_idle(int cpu)
> > > +{
> > > +       struct rq *rq = cpu_rq(cpu);
> > > +       unsigned long flags;
> > > +
> > > +       if (set_nr_if_polling(rq->idle)) {
> > > +               trace_sched_wake_idle_without_ipi(cpu);
> > > +       } else {
> > > +
> >
> > FWIW, adding:
> >
> > if (rq->curr != rq->idle)
> >     return;
> >
> > Right here could improve performance on large, mostly non-idle
> > systems.  It would skip the spinlock in most cases.
> >
> 
>  !is_idle_task() :-)
Thanks Peter and Andy, will refine the patches again:)


