From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Mon, 23 Feb 2009 12:07:25 +0100
Message-ID: <20090223110725.GB17312__32514.6874333315$1235387413$gmane$org@elte.hu>
References: <20090220125516.GB10232@linux.vnet.ibm.com>
	<20090220132145.GF26418@elte.hu>
	<20090220141415.GA27381@dirshya.in.ibm.com>
	<20090220160737.GC11294@elte.hu>
	<20090220115745.43d202d6@infradead.org>
	<20090220215318.GA30665@elte.hu>
	<20090223075521.GA3725@balbir.in.ibm.com>
	<20090223091158.GJ9582@elte.hu>
	<20090223094850.GA10226@balbir.in.ibm.com>
	<20090223103814.GB8817@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090223103814.GB8817@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Balbir Singh <balbir@linux.vnet.ibm.com>, tglx@linutronix.de, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> My understanding is that we will certainly have a sysfs 
> tunable to 'enable' timer migration or consolidation, similar 
> to the sched_mc=2 policy, but the actual set of CPUs to 
> evacuate and the correct set of target CPUs to consolidate 
> should come from the scheduler and not necessarily from the 
> user space.

Yes.

> The scheduler should be able to figure out the following 
> parameters:
> 
> * Identify set of idle CPUs (CPU package) from which timers 
>   can be removed
> * Identify a semi-idle or idle CPU package to which the timers
>   can be moved
> * Decide when to start moving timers as the system has large
>   number of idle CPUs
> * Decide when to stop migrating as system becomes less idle
>   and utilisation increases
> 
> Guiding all of the above decisions from user space may not be 
> fast enough.

Exactly.

	Ingo
