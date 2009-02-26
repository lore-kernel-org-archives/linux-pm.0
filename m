From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Thu, 26 Feb 2009 16:45:26 +0100
Message-ID: <20090226154526.GD352__6018.36399077928$1235663314$gmane$org@elte.hu>
References: <20090220141415.GA27381@dirshya.in.ibm.com>
	<20090220160737.GC11294@elte.hu>
	<20090220115745.43d202d6@infradead.org>
	<20090220215318.GA30665@elte.hu>
	<20090223075521.GA3725@balbir.in.ibm.com>
	<20090223091158.GJ9582@elte.hu>
	<20090223094850.GA10226@balbir.in.ibm.com>
	<20090223103814.GB8817@dirshya.in.ibm.com>
	<20090223110725.GB17312@elte.hu>
	<20090226085831.GA28397@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090226085831.GA28397@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: a.p.zijlstra@chello.nl, Suresh Siddha <suresh.b.siddha@intel.com>, Balbir Singh <balbir@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> On Mon, Feb 23, 2009 at 12:07:25PM +0100, Ingo Molnar wrote:
> > 
> > * Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
> > 
> > > * Identify set of idle CPUs (CPU package) from which timers 
> > >   can be removed
> > > * Identify a semi-idle or idle CPU package to which the timers
> > >   can be moved
> > > * Decide when to start moving timers as the system has large
> > >   number of idle CPUs
> > > * Decide when to stop migrating as system becomes less idle
> > >   and utilisation increases
> > > 
> > > Guiding all of the above decisions from user space may not be 
> > > fast enough.
> > 
> > Exactly.
> 
> That is true for power management. However there are other 
> situations where we may need targeted avoidance of timers. 
> Certain type of applications - HPC for example - prefer 
> avoidance of jitters due to periodic timers. It would be good 
> to be able to say "avoid these CPUs for timers" while they are 
> being used for HPC tasks.

Yes - but that kind of policy should be coupled and expressed 
via cpusets. /proc based irq_affinity is just a limited, 
inflexible hack. All things IRQ partitioning should be handled 
via cpusets - perhaps via the 'system sets' idea from Peter?

	Ingo
