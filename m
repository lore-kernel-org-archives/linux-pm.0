From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/2] sched: Document Energy Aware Scheduling
Date: Fri, 18 Jan 2019 13:34:09 +0100
Message-ID: <20190118123409.GI14385@localhost.localdomain>
References: <20190110110546.8101-1-quentin.perret@arm.com>
 <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain>
 <20190118091652.xn6iw52tccwh6vap@queper01-lin>
 <CAJZ5v0jw0BgmkwrtjuiC7YKO6A+k2eFfFDGtGsSWymW8PSTscA@mail.gmail.com>
 <20190118103359.jqctbopx25h3zvqs@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118103359.jqctbopx25h3zvqs@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Morten Rasmussen <morten.rasmussen@arm.com>, qais.yousef@arm.com, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 18/01/19 10:34, Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 18 Jan 2019 at 10:57:08 (+0100), Rafael J. Wysocki wrote:
> > On Fri, Jan 18, 2019 at 10:16 AM Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > Hi Juri,
> > >
> > > On Thursday 17 Jan 2019 at 16:51:17 (+0100), Juri Lelli wrote:
> > > > On 10/01/19 11:05, Quentin Perret wrote:
> > > [...]
> > > > > +The idea behind introducing an EM is to allow the scheduler to evaluate the
> > > > > +implications of its decisions rather than blindly applying energy-saving
> > > > > +techniques that may have positive effects only on some platforms. At the same
> > > > > +time, the EM must be as simple as possible to minimize the scheduler latency
> > > > > +impact.
> > > > > +
> > > > > +In short, EAS changes the way CFS tasks are assigned to CPUs. When it is time
> > > >
> > > > Not sure if we want to remark the fact that EAS is looking at CFS tasks
> > > > only ATM.
> > >
> > > Oh, what's wrong about mentioning it ? I mean, it is a fact ATM ...
> > 
> > But it won't hurt to mention that it may cover other scheduling
> > classes in the future.  IOW, the scope limit is not fundamental.
> 
> Agreed, I can do that.

Oh, sorry, bad phrasing from my side. I meant that we should probably
state clearly somewhere that EAS deals with CFS only ATM, but extending
it to other classes (DEADLINE in particular) makes certainly sense and
people are welcome to experiment with that.

So, yeah, I agree with both of you. :-)
