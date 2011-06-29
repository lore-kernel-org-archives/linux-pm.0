From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Wed, 29 Jun 2011 10:06:24 -0700
Message-ID: <1309367184.11430.594.camel__7941.34996035627$1309367271$gmane$org@nimitz>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110629130038.GA7909@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ankita Garg <ankita@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

I was kinda hoping for something a bit simpler than that.  I'd boil down
what you were saying to this:

     1. The kernel must be aware of how the pieces of hardware are
        mapped in to the system's physical address space
     2. The kernel must have a mechanism in place to minimize access to
        specific pieces of hardware 
     3. For destructive power-down operations, the kernel should have a
        mechanism in place to ensure that no valuable data is contained
        in the memory to be powered down.

Is that complete?

On Wed, 2011-06-29 at 18:30 +0530, Ankita Garg wrote:
> 1) Dynamic Power Transition: The memory controller can have the ability
> to automatically transition regions of memory into lower power states
> when they are devoid of references for a pre-defined threshold amount of
> time. Memory contents are preserved in the low power states and accessing
> memory that is at a low power state takes a latency hit.
> 
> 2) Dynamic Power Off: If a region is free/unallocated, the software can
> indicate to the controller to completely turn off power to a certain
> region. Memory contents are lost and hence the software has to be
> absolutely sure about the usage statistics of the particular region. This
> is a runtime capability, where the required amount of memory can be
> powered 'ON' to match the workload demands.
> 
> 3) Partial Array Self-Refresh (PASR): If a certain regions of memory is
> free/unallocated, the software can indicate to the controller to not
> refresh that region when the system goes to suspend-to-ram state and
> thereby save standby power consumption.

(3) is simply a subset of (2), but with the additional restriction that
the power off can only occur during a suspend operation.  

Let's say we fully implemented support for (2).  What would be missing
to support PASR?

-- Dave
