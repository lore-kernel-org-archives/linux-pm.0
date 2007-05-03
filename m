From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 13:33:36 -0700
Message-ID: <200705031333.37471.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 03 May 2007, Alan Stern wrote:

> In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
> same as a normal non-hibernate poweroff? 

No.  One of the differences between ACPI S4 (hibernate)
and S5 (poweroff) states is for example how wakeup behaves.
Look for example at /proc/acpi/wakeup and see how many
devices are listed as "can wake from S5" vs from S4 ...
most systems support some S4 events, not so for S5.

Another is that S4 can consume more power.

(Although I believe I noticed a regression there in recent
kernels ... previously I was able to trigger wakeup from
hibernation using the RTC, but not with 2.6.21 patches.)

Non-ACPI systems can make the same natural distinctions.


> We are letting ourselves in for problems if we say that when the snapshot
> is restored, devices may or may not need to be reinitialized. 

We have those problems already.  Of course, most of the
time S4/hibernate involves device re-init, while S3/STR
doesn't.


> Drivers 
> might not be able to tell which, so they would have to reinitialize
> regardless, losing any advantage.

For those specific devices.  Of course, not many drivers
are power-aware enough to notice.  Most will re-init.
On PCs the exceptions are USB and, maybe, network drivers.

Drivers for embedded platforms more often leverage the
"retention" states which don't require complete re-init,
since those systems generally don't "hibernate".


> Even worse, the device may _appear_ not 
> to need reinitialization because the firmware (BIOS) has already
> initialized it but left it in a state that's useless for the kernel's
> purposes.  (That's part of the reason why PRETHAW was added.)

That's *ALL* of the reason for PRETHAW.  I asked the
guy who did it.  ;)


> If the only remaining difference between poweroff for hibernate and normal 
> poweroff is which wakeup devices will function, then it seems pointless.

There's the additional power usage involved in enabling additional
wakeup sources, plus the additional system components that are
expected (possibly unreasonably!) to work.


> Why shouldn't the same devices work for wakeup from hibernate and wakeup 
> from normal poweroff?

You're suggesting Linux not use the S5 state, essentially.

So the question is really "why should Linux use S5 (and similar
states on non-ACPI systems), instead of disregarding the ACPI
spec?"

The short answer:  having a "true OFF" state is valuable, if
for no other reason than to cope with buggy "partial-ON" states
like S4.  Also, it's not clear that disregarding ACPI's guidance
here would be a good thing.

- Dave
