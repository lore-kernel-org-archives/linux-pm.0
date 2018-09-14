From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Date: Fri, 14 Sep 2018 14:41:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809141438560.10480@nanos.tec.linutronix.de>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan> <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com> <1831106.CYv9dyYV15@aspire.rjw.lan> <e028742e-cd42-24a7-0da1-4fa12d8c9d7c@nextfour.com> <CAJZ5v0gRjfGDSyZXRwGgF9dOBR9OJbfYE8Dbpqdx6oCMN1XUVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1763824608-1536928900=:10480"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gRjfGDSyZXRwGgF9dOBR9OJbfYE8Dbpqdx6oCMN1XUVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mika.penttila@nextfour.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1763824608-1536928900=:10480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Sep 2018, Rafael J. Wysocki wrote:
> On Fri, Sep 14, 2018 at 11:53 AM Mika Penttilä

> > >> But doesn't injecting sleep time here make monotonic clock too large
> > >> by the amount of sleeptime?  tick_freeze() / tick_unfreeze() already
> > >> injects the sleeptime (otherwise delta would be 0).  > > >
> > >
> > > No, it doesn't.
> > >
> > > The delta here is the extra time taken by the loop which hasn't been counted
> > > as sleep time yet.
> >

> > I said incorrectly monotonic clock, but
> > timekeeping_inject_sleeptime64() forwards the wall time, by the amount
> > of delta.  Why wouldn't some other cpu update xtime when one cpu is in
> > the loop? And if all cpus enter s2idle, tick_unfreeze() injects
> > sleeptime. My point is that this extra injection makes wall time wrong,
> > no?
>  
> OK, you're right.  I got that the other way around.
> 
> So, the patch is withdrawn.

I just tried to wrap my brain around that whole thing and utterly
failed, so I can't give any recommendations right now.

Rafael, could you please enable some lightweight instrumentation which lets
me see the longer sequence of events which are leading to this or tell me
what I need to do to reproduce that myself?

Thanks,

	tglx
--8323329-1763824608-1536928900=:10480--
