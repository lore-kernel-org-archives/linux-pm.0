From: Mark Lord <lkml@rtr.ca>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Thu, 06 Mar 2008 10:58:30 -0500
Message-ID: <47D014A6.9090300__2683.67905305258$1204819251$gmane$org@rtr.ca>
References: <Pine.LNX.4.44L0.0803031207120.3611-100000@iolanthe.rowland.org>
	<alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0803030921420.17889@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 3 Mar 2008, Alan Stern wrote:
>> Consider a routine like the following:
>>
>> 	static task_struct *the_task;
>>
>> 	void store_task(void)
>> 	{
>> 		the_task = current;
>> 	}
>>
>> Is it possible to say whether readers examining "the_task" are 
>> guaranteed to see a coherent value?
> 
> Yes, we do depend on this.  All the RCU stuff (and in general *anything* 
> that depends on memory ordering as opposed to full locking, and we have 
> quite a lot of it) is very fundamentally dependent on the fact that things 
> like pointers get read and written atomically.
..

But also consider something like this:

 	void store_task(void)
 	{
 		*the_task = current;
 	}

In this case, there is no guarantee that the assignment
can be done atomically on all CPU types.  Some RISC archs
(eg. MIPS R2xxx) require an (interruptible) instruction pair
to store values to a potentially unaligned address.

This was a BIG issue on a different system that I once worked on.

Cheers
