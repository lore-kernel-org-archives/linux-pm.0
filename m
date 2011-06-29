From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Wed, 29 Jun 2011 23:37:33 +0530
Message-ID: <20110629180733.GF3646__40102.6192158044$1309371039$gmane$org@dirshya.in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
	<1309367184.11430.594.camel@nimitz>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1309367184.11430.594.camel@nimitz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Dave Hansen <dave@linux.vnet.ibm.com> [2011-06-29 10:06:24]:

> I was kinda hoping for something a bit simpler than that.  I'd boil down
> what you were saying to this:
> 
>      1. The kernel must be aware of how the pieces of hardware are
>         mapped in to the system's physical address space
>      2. The kernel must have a mechanism in place to minimize access to
>         specific pieces of hardware 
          (mainly by controlling allocations and reclaim)
                

>      3. For destructive power-down operations, the kernel should have a
>         mechanism in place to ensure that no valuable data is contained
>         in the memory to be powered down.
> 
> Is that complete?

At a high level these are the main requirements, except that different
operations/features can happen at different/higher granularity.  The
infrastructure should be able to related groups of regions and act
upon for a specific optimization.  Like granularity for (2) may be
512MB, while (3) could be a pair of 512MB blocks. This is relatively
a minor issue to solve.

> On Wed, 2011-06-29 at 18:30 +0530, Ankita Garg wrote:
> > 1) Dynamic Power Transition: The memory controller can have the ability
> > to automatically transition regions of memory into lower power states
> > when they are devoid of references for a pre-defined threshold amount of
> > time. Memory contents are preserved in the low power states and accessing
> > memory that is at a low power state takes a latency hit.
> > 
> > 2) Dynamic Power Off: If a region is free/unallocated, the software can
> > indicate to the controller to completely turn off power to a certain
> > region. Memory contents are lost and hence the software has to be
> > absolutely sure about the usage statistics of the particular region. This
> > is a runtime capability, where the required amount of memory can be
> > powered 'ON' to match the workload demands.
> > 
> > 3) Partial Array Self-Refresh (PASR): If a certain regions of memory is
> > free/unallocated, the software can indicate to the controller to not
> > refresh that region when the system goes to suspend-to-ram state and
> > thereby save standby power consumption.
> 
> (3) is simply a subset of (2), but with the additional restriction that
> the power off can only occur during a suspend operation.  
> 
> Let's say we fully implemented support for (2).  What would be missing
> to support PASR?

The similarity between (2) and (3) here is the need for accurate
statistics to know allocation status. The difference is the
actuation/trigger part... in case of (2) the trigger would happen
during allocation/free while in case of (3) it happens only at suspend
time.  Also the granularity could be different, generally PASR is very
fine grain as compared for power-off at controller level.

We can combine them and look at just how to track allocations at
different (or multiple) physical boundaries.

--Vaidy
