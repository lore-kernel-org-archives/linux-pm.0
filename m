From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Thu, 26 Feb 2009 17:12:55 +0100
Message-ID: <20090226161255.GA15390@elte.hu>
References: <20090220115745.43d202d6@infradead.org>
	<20090220215318.GA30665@elte.hu>
	<20090223075521.GA3725@balbir.in.ibm.com>
	<20090223091158.GJ9582@elte.hu>
	<20090223094850.GA10226@balbir.in.ibm.com>
	<20090223103814.GB8817@dirshya.in.ibm.com>
	<20090223110725.GB17312@elte.hu>
	<20090226085831.GA28397@in.ibm.com> <20090226154526.GD352@elte.hu>
	<1235664169.4948.319.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1235664169.4948.319.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, Arjan van de Ven <arjan@infradead.org>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Thu, 2009-02-26 at 16:45 +0100, Ingo Molnar wrote:
> 
> > Yes - but that kind of policy should be coupled and expressed 
> > via cpusets. /proc based irq_affinity is just a limited, 
> > inflexible hack. All things IRQ partitioning should be handled 
> > via cpusets - perhaps via the 'system sets' idea from Peter?
> 
> all we got out of that idea was the default_smp_affinity thing 
> in /proc/irq and a head-ache trying to work out silly details.
> 
> Maybe we ought to try again,..

Your system sets patch was actually very sane, it just fell 
victim to a merge window i think. Mind re-sending it?

	Ingo
