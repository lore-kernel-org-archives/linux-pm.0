From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 11:32:44 +1000
Message-ID: <1183944764.3388.330.camel__5589.66533649272$1183944816$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<1183929611.3388.303.camel@localhost.localdomain>
	<200707090006.32712.rjw@sisk.pl>
	<1183941217.3388.324.camel@localhost.localdomain>
	<FFA29D56-3400-4EA3-8CE8-C1EF75484510@mac.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <FFA29D56-3400-4EA3-8CE8-C1EF75484510@mac.com>
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


> You could do this with a straight mutex except for the  
> dev_suspend_trylock/unlock bit in uninterruptable contexts, but I  
> seem to recall somebody saying that could be made to work if there  
> was a real need for it.  Alternatively you could just drive the  
> "Generic Mutex" guys up the wall by inventing your own pseudo-mutex  
> with a spinlock, a boolean value, and a waitqueue.

Most of the time, the interrupt/atomic contexts are part of what I call
the "main path" of the driver, which doesn't need most of this stuff.

Depending on what is "upstream" from the driver, you typically set a
condition stopping the flow of "interrupt" activity and wait for it to
drain in suspend. For example, a block driver would instruct the driver
to stop processing the request queue and wait for pending in flight
requests to drain, or a network driver would stop the tx queue and wait
for pending/concurrent xmit() callbacks to complete (basically sync. bh
and sync. with NAPI poll).

In both examples, helpers can be provided in the block layer or network
stack to make that easier.

In many cases, the driver may just turn off something in the chip in
"suspend" (using a low level spinlock that it already has if it has an
irq path to sync. HW access) and set some flag/state to instruct the irq
handler to not restart, then synchronize_irq().

All those techniques are fairly simple and well known. The main source
of problems are the "sideband" channels, such as sysfs accesses to
driver tunables, ioctl's, etc... for which I believe mutexes can solve
90% of them.

Ben.
