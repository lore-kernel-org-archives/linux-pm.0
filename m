From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 09:43:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606220922570.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<200606212252.31918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606212252.31918.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jun 2006, David Brownell wrote:
> =

> By which you mean I think the request queues?  Those do need clearly
> defined sequence points for an atomic snapshot.

If you mean the actual USB command queues, you do realize that that is =

physically impossible for suspend-to-disk on a USB device, don't you? By =

definition, the actual USB packets that the other end will see _will_ =

differ from the memory snapshot, since packets _will_ be sent to the =

device just to save the image.

That's true today, and it's not something we can physically change.

So the device on the other end will - by definition - be out-of-sync with =

the driver state at "resume()" time for suspend-to-disk (not for STR, of =

course, since the memory image will always match everything that has =

happened).

The solution is either:
 - don't care about suspend-to-disk
 - make sure that the driver can recover from things like the toggle bit
   mismatch after resume (ie, the device didn't get unplugged, power has =

   been applied all the time, but when you resume and start sending data =

   to its control point, it might return with an error all the time just
   because you had an odd number of packets after the freeze, and as a =

   result you're now sending new packets with the wrong toggle bit as =

   far as the device is concerned).

If that wasn't what you meant, but you meant that the memory image that =

got snapshotted has to be "consistent" with _some_ driver state, then we =

do actually have that sequence point.

It would be "freeze()" for suspend-to-disk and "suspend()" for STR. In =

both cases, that's the time that the memory image (aka "driver state") =

will be frozen. So you know that when "resume()" happens, it will happen =

in some state that you had control over, and you can at least make sure =

that the USB in-memory command queues weren't half-way done or anything =

like that.

But:
 - your driver state won't necessarily match the actual _hardware_ state =

   (see above on _one_ example of why this is fundamental and not fixable)
 - it also wouldn't match whatever you saved off in "save_state" (ie you =

   must _not_ "save_state()" driver state).

Neither of these are fundamental problems, they just mean that some care =

is needed. Any "driver state" needs to be in regular memory (whether the =

driver _normally_ maintains it in regular memory or not: if the driver =

state is only kept in MMIO space, it needs to be saved into memory) by the =

time freeze()/suspend() returns. And "resume()" obviously needs to move =

that driver state back into the device if that's where it is.

(Ie this would be things like "where is my packet queue" etc.)

> Nope ... setpci may have been used to tweak things at runtime, and
> in ways that affect system correctness.  Admittedly that's not the
> most common scenario, but I've had to use it on some systems.
> =

> So saving PCI config space "late" is a far better approach.  It's
> hardware state that _can_ be snapshotted, with care.

Yes. We _could_ save it basically at driver initialization time, but since =

the time you have to save it is basically your choice, it's just _better_ =

to save it later rather than earlier. Exactly if some config stuff is done =

that changes things - you should still get a working setup even if you =

drop it, but it's obviously better and has no real downsides to make that =

"drop config stuff" window smaller.

At worst, people can re-do their setpci or whatever, but at best, they =

simply wouldn't have to.

			Linus
