From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 13:59:07 +1000
Message-ID: <1183694347.3388.114.camel__45935.3479709991$1183694637$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060913.05644.nigel@nigel.suspend2.net>
	<1183677643.3388.105.camel@localhost.localdomain>
	<200707060935.12706.nigel@nigel.suspend2.net>
	<CF60EC03-0171-4052-924D-57555A393168@mac.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CF60EC03-0171-4052-924D-57555A393168@mac.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> How about a freezer whose job it is to "wait for pending hard  
> interrupts to complete when we have already guaranteed that we won't  
> get any more"?  That part should be really *REALLY* easy.  You don't  
> need to care about either userspace processes or kernel threads at  
> all.  Specifically, Step 1 consists of:

Well, waiting for pending DMA and making sure to not trigger more
activity is what driver suspend() is supposed to do. With the ability
for simple drivers that can cope with it to just basically use a
late_suspend(), called after IRQs are off, that basically does what you
describe: wait for pending HW tasks to complete (polling) and turn the
damn thing off.

Note that the later is really a shortcut for somewhat dump and directly
accessible devices (PCI comes to mind). Things like USB has to use the
"normal" mechanism of blocking IOs etc... at suspend(), at least, USB
devices have to since the USB HC will not issue any new URBs. (And will
return them with a nice error code which is a perfect way to deal with
it in driver, been there, it works fine, once we fixed the races in the
USB host code itself, which I think we pretty much did by now).

> Scheduling and userspace are all still fully enabled in this  
> scenario.  Once all your devices are turned off, the only remaining  
> running threads will be those which haven't done IO since the  
> beginning of the suspend.  We can then disable preemption, turn off  
> the timer interrupts, and tell the other CPUs to park all their  
> remaining threads in schedule() and sleep.  Then we put the IRQ  
> controller to sleep and go to sleep ourselves.  If our driver model  
> locking is sufficient to handle putting a parent device to sleep  
> while threads are sleeping on a child device then there are exactly 0  
> problems.

What you propose is basically a slightly over-simplistic version of what
I think (and Paulus think) should be done. We do need to do it via
driver callbacks down the tree since only drivers can know how to deal
with their DMA etc... and ordering need to be respected, but that's
basically it.

And guess what ? It's what we do on powerbooks, and it works fine,
without a freezer :-)

Ben.
