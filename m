From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Fri, 20 Feb 2009 22:53:18 +0100
Message-ID: <20090220215318.GA30665__7155.19844457066$1235166975$gmane$org@elte.hu>
References: <20090220125516.GB10232@linux.vnet.ibm.com>
	<20090220132145.GF26418@elte.hu>
	<20090220141415.GA27381@dirshya.in.ibm.com>
	<20090220160737.GC11294@elte.hu>
	<20090220115745.43d202d6@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090220115745.43d202d6@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-pm@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Fri, 20 Feb 2009 17:07:37 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
> > 
> > > > I'd also suggest to not do that rather ugly 
> > > > enable_timer_migration per-cpu variable, but simply reuse 
> > > > the existing nohz.load_balancer as a target CPU.
> > > 
> > > This is a good idea to automatically bias the timers.  But 
> > > this nohz.load_balancer is a very fast moving target and we 
> > > will need some heuristics to estimate overall system idleness 
> > > before moving the timers.
> > > 
> > > I would agree that the power saving load balancer has a good 
> > > view of the system and can potentially guide the timer biasing 
> > > framework.
> > 
> > Yeah, it's a fast moving target, but it already concentrates 
> > the load somewhat.
> > 
> 
> I wonder if the real answer for this isn't to have timers be 
> considered schedulable-entities and have the regular scheduler 
> decide where they actually run.

hm, not sure - it's a bit heavy for that.

	Ingo
