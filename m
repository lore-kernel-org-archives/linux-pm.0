From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [update,
	rev. 6] Re: [PATCH 1/10] PM: Rework handling of	interrupts during
	suspend-resume (rev. 5)
Date: Fri, 13 Mar 2009 01:39:50 +0100
Message-ID: <20090313003950.GB19544__47546.6617769145$1236905177$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112342440.29264@localhost.localdomain>
	<200903121436.21504.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903122243.27452.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Thursday 12 March 2009, Rafael J. Wysocki wrote:
> > On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > > On Wed, 11 Mar 2009, Thomas Gleixner wrote:
> > > > On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:
> > > > > On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > > > > > > +EXPORT_SYMBOL_GPL(suspend_device_irqs);
> > > > > > 
> > > > > >   I'm not too enthusiastic about this open coded implementation of
> > > > > >   disable_irq() with slightly different semantics.
> > > > > 
> > > > > The difference in semantics is important IMO, otherwise I woulndn't have
> > > > > done that.  In particular, IMO, the condition should be under the spinlock IMO
> > > > > and I'd rather not synchronize all interrupts we don't really disable here.
> > > > 
> > > > I don't say that the difference is not relevant. But the code is
> > > > almost the same and disable_irq() could have the sync_irq optimization
> > > > as well.
> > > 
> > > Thought more about that. Avoiding the sync_irq() for irqs which have
> > > no action associated is fine, but you need to catch the following case
> > > as well:
> > > 
> > >    driver code calls disable_irq_nosyc() from the handler (which is
> > >    still running)
> > > 
> > >    suspend code skips the sync due to depth > 0
> > > 
> > > The sync operation is not that expensive.
> > 
> > OK, what about this (untested, irrelevant parts skipped)?
> 
> Well, I guess I need to assume that no reaction means it's fine. ;-)
> 
> Below is the complete patch.  Thomas, Ingo, please let me know 
> it it is fine with you.

looks good - but you sure want to split it up some more, right?

> 13 files changed, 195 insertions(+), 47 deletions(-)

We want the non-intrusive 'add new APIs' bits [which give most 
of the linecount] separated from the 'all hell breaks lose' 
functional changes ;-) Makes it easier to revert, bisect, etc.

	Ingo
