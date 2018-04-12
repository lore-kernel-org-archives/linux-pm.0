From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Thu, 12 Apr 2018 05:38:43 -0700
Message-ID: <9c325ee245344f67f2115367b63b86fd2bc1aed8.camel@perches.com>
References: <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
         <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
         <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
         <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
         <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
         <20180411170049.GR4082@hirez.programming.kicks-ass.net>
         <20180412074719.pmcddramzyikppco@gmail.com> <20180412093521.GA6427@andrea>
         <20180412115022.GL4043@hirez.programming.kicks-ass.net>
         <a8677d8c351e4cb49907f9a8addcc261d810655a.camel@perches.com>
         <20180412120832.GZ4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412120832.GZ4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, webmaster <webmaster@kernel.org>, postmaster@kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-04-12 at 14:08 +0200, Peter Zijlstra wrote:
> On Thu, Apr 12, 2018 at 05:01:37AM -0700, Joe Perches wrote:
> > On Thu, 2018-04-12 at 13:50 +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 12, 2018 at 11:35:21AM +0200, Andrea Parri wrote:
> > > > Is there a better or recommended way to reference posts on LKML in commit
> > > > messages? (I do like the idea of linking to previous discussions, results,
> > > > ...)
> > > 
> > > Yes:
> > > 
> > >   https://lkml.kernel.org/r/$MSGID
> > > 
> > > that has the added benefit that it immediately includes the msg-id, so
> > > even if you don't have tubes, you can search for it in your local
> > > mailboxes.
> > > 
> > > Also, since we (kernel.org) control the redirection (currently
> > > marc.info) we can always point it to a life archive.
> > 
> > Message IDs are not useful unless you subscribe and
> > keep your emails.
> 
> I happen to do so..

As do I for mailing list threads I reply to, but keeping all email
threads locally is not not practicable on limited storage systems.

> > It'd be _much_ nicer if vger.kernel.org stored every email
> > it sent and had a search mechanism available rather than
> > relying on external systems.
> 
> People are looking at that afaik.

Looking and doing are unfortunately different.

Back when gmane died a couple years ago, I made the same suggestion
to webmaster@kernel.org, postmaster@kernel.org and cc'd lkml

https://lkml.org/lkml/2016/8/3/484

Never heard back.

Maybe it's the proper time now to revisit this.
