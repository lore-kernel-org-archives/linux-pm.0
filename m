From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Mon, 7 May 2007 18:22:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705071746210.4301-100000@iolanthe.rowland.org>
References: <200705072329.22988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705072329.22988.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 May 2007, Rafael J. Wysocki wrote:

> > 	G3 = "mechanical off" = no wakeup devices are enabled,
> > 				safe to disassemble
> > 	G2/S5 = "soft off" = wakeup may be enabled, not safe to
> > 				disassemble
> > 	S4 = "non-volatile sleep" = hibernation, memory image is saved
> > 	S5 = "soft off" = almost the same as S4 except there is no
> > 				memory image
> > 
> > The spec does not explicitly associate S4 with either G2 or G3, and in
> > fact it contains language suggesting very strongly that the system could
> > be in either one.  The spec also uses the same name for G2 and for S5, no 
> > doubt leading to extra levels of confusion.
> 
> Well, it's quite clearly stated in 4.5 and in 15 that S4 belongs to G1.
> Moreover, it's reiterated several times in different places that
> S5 Soft off = G2.

More confusion in the spec...  It describes two different kinds of S4
states!

I was talking about "S4 Non-Volatile Sleep", defined on p.20 just above
Table 2-1.  The text says this:

	The machine will then enter the S4 state.  When the system
	leaves the Soft Off or Mechanical Off state,...

That's a pretty clear indication that S4-NVS involves G2 or G3.

You're talking about "S4 Sleeping State", defined on p.22, section 2.4.  
Evidently these two "S4" states are quite different.

> The problem is that ACPI insists on treating S4 as a sleeping state.

Section 2.4 is rather confusing.  What I gather is that S4 and S5 are 
essentially the same except for the presence or absence of a stored 
memory snapshot.  And yet S4 counts as a sleeping state while S5 doesn't.  
What's the explanation for that?

> Still, I agree that what we do in steps 1 - 5 should be independent of
> whether or not we're going to enter S4.  Devices should not be
> suspended before creating the image, because the system is not going to
> enter any power state *at that time*.  There seems to be no reason whatsoever
> for putting devices in low power states for creating the hibernation image.

Agreed.


> There's nothing like G2/S4 in ACPI and we shouldn't refer to such a notion to
> avoid confusion.

Except for the text on p.20.

> That's why I said that what we want to call 'hibernation' is and will probably
> always be different from an ACPI transition to S4 (at least until we make a
> bootloader capable of reading suspend images and ACPI-aware).

In what sense is the boot kernel different from a "bootloader"?  It 
certainly is capable of reading suspend images and is ACPI-aware.

Alan Stern
