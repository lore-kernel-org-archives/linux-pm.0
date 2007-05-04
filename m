From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 10:51:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705041040540.3417-100000@iolanthe.rowland.org>
References: <200705031333.37471.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031333.37471.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 May 2007, David Brownell wrote:

> On Thursday 03 May 2007, Alan Stern wrote:
> 
> > In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
> > same as a normal non-hibernate poweroff? 
> 
> No.  One of the differences between ACPI S4 (hibernate)
> and S5 (poweroff) states is for example how wakeup behaves.
> Look for example at /proc/acpi/wakeup and see how many
> devices are listed as "can wake from S5" vs from S4 ...
> most systems support some S4 events, not so for S5.
> 
> Another is that S4 can consume more power.

You are describing the difference between ACPI S4 and S5, but I was 
talking about the difference between "normal" poweroff and "hibernate" 
poweroff.  There doesn't seem to be any reason why we must always have

	hibernate = S4    and     normal = S5.

> Non-ACPI systems can make the same natural distinctions.

On such systems there seems to be even less reason for those equalities 
(or rather, their analogs).


> > We are letting ourselves in for problems if we say that when the snapshot
> > is restored, devices may or may not need to be reinitialized. 
> 
> We have those problems already.

Exactly because we are waffling on this issue.  If we settled the matter 
once and for all (devices must ALWAYS be reinitialized after the snapshot 
is restored) then we wouldn't have those problems.  (We might have other 
problems though...)


> > Even worse, the device may _appear_ not 
> > to need reinitialization because the firmware (BIOS) has already
> > initialized it but left it in a state that's useless for the kernel's
> > purposes.  (That's part of the reason why PRETHAW was added.)
> 
> That's *ALL* of the reason for PRETHAW.  I asked the
> guy who did it.  ;)

Well, be fair.  If your resume methods had some way to know whether or not 
a snapshot had just been restored then you wouldn't have needed to add 
PRETHAW.  So another part of the reason is that restore() methods don't 
take a pm_message_t argument.


> > Why shouldn't the same devices work for wakeup from hibernate and wakeup 
> > from normal poweroff?
> 
> You're suggesting Linux not use the S5 state, essentially.

No, I'm suggesting that the user should be able to control whether Linux 
uses S4 vs. S5 at poweroff time.  If the user selected always to use S4 
then wakeup devices would function in both hibernation and normal 
shutdown.  If the user selected always to use S5 then wakeup devices would 
not function in either hibernation or normal shutdown.

> So the question is really "why should Linux use S5 (and similar
> states on non-ACPI systems), instead of disregarding the ACPI
> spec?"
> 
> The short answer:  having a "true OFF" state is valuable, if
> for no other reason than to cope with buggy "partial-ON" states
> like S4.  Also, it's not clear that disregarding ACPI's guidance
> here would be a good thing.

Which part of ACPI's so-called guidance are you referring to?

Alan Stern
