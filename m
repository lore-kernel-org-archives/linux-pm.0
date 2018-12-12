From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Wed, 12 Dec 2018 11:17:03 +0100
Message-ID: <CAJZ5v0gNqUO59_xQAdk-rVR6JJCZ4RfHbNJOUuBWSyy6yN6pjw@mail.gmail.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
 <20181210225134.GB24811@worktop.programming.kicks-ass.net>
 <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
 <20181212094610.GW5289@hirez.programming.kicks-ass.net> <CAPDyKFpPGosZ69ZgMZMASGZxTn1kxu5GrJ7rZoXKn8MC05SMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpPGosZ69ZgMZMASGZxTn1kxu5GrJ7rZoXKn8MC05SMTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 12, 2018 at 10:57 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 12 Dec 2018 at 10:46, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 11, 2018 at 10:51:48AM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 10, 2018 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Dunno; it could be cold cachelines, at which point it can be fairly
> > > > expensive. Also, being stuck with API is fairly horrible if you want to
> > > > 'fix' it.
> > >
> > > All of the cache lines involved should've been touched earlier in this
> > > code path by the governor.  At least menu and the new one both touch
> > > them.
> > >
> > > The API part I'm not too worried about.  I know it is useful and two
> > > other people have told that to me already. :-)
> >
> > Like said on IRC; I mostly wanted to raise the issue of overhead due to
> > stats and ABI -- it's something I've been bitten by too many times :/
> >
> > If you're confident you're hitting the same lines with the already
> > extant accouning (time and usage) and you cannot make the whole lot
> > conditional because of ABI (bah) then I'll not stand in the way here.
> >
> > I agree the numbers are useful, I'm just weary of overhead.
>
> I tend to agree. So then why not move this to debugfs, it seems like
> it's really there it belongs. No?

The "usage" and "time" counters are there in sysfs already and they
are ABI, so putting the new ones into debugfs only makes them harder
to use for no real gain.
