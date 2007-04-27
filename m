From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 08:41:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704270833270.9964@woody.linux-foundation.org>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<1177684764.3565.20.camel@johannes.berg>
	<1177685391.3565.22.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177685391.3565.22.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <npiggin@suse.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 27 Apr 2007, Johannes Berg wrote:
> 
> Eh, the point I actually wanted to make is that many drivers don't care
> for the irqs disabled case and would have to add code to exclude it.

You really *really* want to do a two-phase thing, at least for the case I 
care about. Whether that snapshotting thing does or not, I could care 
less.

There's a damn good reason why the kernel uses 

	/* phase 1 */
	for_each_dev()
		dev->suspend(dev);

	cli();
	/* phase 2 */
	for_each_dev()
		dev->suspend_late(dev);

(and the reverse case on resume).

The reason is simply that there are two totally different cases: things 
like disks etc want to spin down and do slow and high-level operations, 
while things like USB controllers and console devices do *not* want to be 
suspended early, because if you do, you lose debuggability.

So some things really *really* want to be done when they know that there 
isn't anything else going on any more, and they want to delay the shutdown 
to the very end. While other things really *require* that they can send 
requests that can take time, and cannot run with interrupts disabled.

I actually think that "snapshot" is totally different, exactly because for 
snapshotting, the slow operations like spinning down disks etc probably 
don't really even exist, and would always be no-ops. But who knows..

Anyway, I do have a final comment: 

     DO NOT PASS "STATE FLAGS" TO DRIVERS 

(or, even worse, assume that drivers would test "implicit" state by 
calling the same function under two different states, and then have the 
drivers test for "are interrupts disabled? Then I need to do something 
else").

If drivers are possibly going to do two different things, make it two 
different entry-points. There's absolutely no downsides. It's _clearer_ to 
the device writer when he gets called two different ways that it's not the 
same case, and in case a particular device can do the same thing for both 
cases, he can just set the function pointer to the same entry for both.

Never EVER pass dynamic flags that modify behaviour. It's simply bad 
programming. A function should do *one* thing, and do it well. 

		Linus
