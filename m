From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Mon, 7 May 2007 23:29:22 +0200
Message-ID: <200705072329.22988.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705071426090.3429-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705071426090.3429-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 May 2007 20:46, Alan Stern wrote:
> On Sun, 6 May 2007, David Brownell wrote:
> 
> > On Saturday 05 May 2007, Alan Stern wrote:
> > 
> > > But who says that hibernate has to use "Non-Volatile Sleep" and normal 
> > > shutdown has to use software-controlled "poweroff"?  Why shouldn't the 
> > > user be able to do it the other way 'round?
> > 
> > Well, the definition of NVS matches hibernation, and
> > the definition of soft-off matches poweroff.
> 
> Okay, I read sections 2.2 and 2.4 of the ACPI 3.0 spec.  Here's the story
> in a nutshell:
> 
> 	G3 = "mechanical off" = no wakeup devices are enabled,
> 				safe to disassemble
> 	G2/S5 = "soft off" = wakeup may be enabled, not safe to
> 				disassemble
> 	S4 = "non-volatile sleep" = hibernation, memory image is saved
> 	S5 = "soft off" = almost the same as S4 except there is no
> 				memory image
> 
> The spec does not explicitly associate S4 with either G2 or G3, and in
> fact it contains language suggesting very strongly that the system could
> be in either one.  The spec also uses the same name for G2 and for S5, no 
> doubt leading to extra levels of confusion.

Well, it's quite clearly stated in 4.5 and in 15 that S4 belongs to G1.
Moreover, it's reiterated several times in different places that
S5 Soft off = G2.

> So there's no question that S4 = NVS = hibernation.  But hibernation
> can involve either G2 or G3.

Not according to ACPI.

> And there's no question (in my mind at least) that normal shutdown should
> be able to involve either G2/S5 or G3.  So although the spec doesn't put 
> things quite this way, we could say:
> 
> 	hibernation = S4 = G2/S4 or G3/S4,
> 
> 	shutdown = S5 = G2/S5 or G3/S5.
> 
> Thus the choice between S4 vs. S5 is made at the very start, and steps 1-5 
> are executed only for S4.  The choice between G2 vs. G3 can be (and should 
> be!) deferred until steps 6-7.

The problem is that ACPI insists on treating S4 as a sleeping state.

Still, I agree that what we do in steps 1 - 5 should be independent of
whether or not we're going to enter S4.  Devices should not be
suspended before creating the image, because the system is not going to
enter any power state *at that time*.  There seems to be no reason whatsoever
for putting devices in low power states for creating the hibernation image.

> > > > That's a different suggestion, yes.  I'm not sure I see any
> > > > benefit of that flexibility for "soft off" states though,
> > > > especially if it made "off" consume more power.
> > > 
> > > The benefit is that it allows more devices to function as wakeup sources, 
> > > right?
> > 
> > With downsides of "more power consumed during 'off' states"
> > and "invalidating documentation, training, and expectations".
> 
> Okay, let's clear up the confusion.  The additional flexibility I'm 
> suggesting for "soft off" = G2 states is that we should allow both G2/S4 
> and G2/S5.  They would consume the same amount of power since they are 
> both G2 states; the difference is that G2/S4 involves saving and restoring 
> a memory image and G2/S5 does not.

There's nothing like G2/S4 in ACPI and we shouldn't refer to such a notion to
avoid confusion.

That's why I said that what we want to call 'hibernation' is and will probably
always be different from an ACPI transition to S4 (at least until we make a
bootloader capable of reading suspend images and ACPI-aware).

Greetings,
Rafael
