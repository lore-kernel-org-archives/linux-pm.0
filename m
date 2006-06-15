From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 13:56:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Alan Stern wrote:
> =

> If this happens you're already in trouble.  It doesn't matter that the =

> unrelated devices aren't suspended; the fact that they have already saved =

> their state and will no longer respond to outside stimuli means they can'=
t =

> be used.  Not to mention that their I/O queues won't be running.

THEIR IO QUEUES ARE RUNNING!

Why are people being dense and stupid? I told you in the very first =

explanation that the IO state isn't suspended by "save_state()".

"save_state()" would not disable the device. It would not disable the =

queues. The device would remain usable, and 100% functional.

It also would NOT save any "queue state". That's a total software =

abstraction, and that's something that comes much later (if at all), when =

we actually need to save the memory image. The only thing the =

"save_state()" needs to save is the actual _hardware_ state, and not even =

all of that.

For example, on resume, if you have a network device, you SHOULD NOT EVEN =

TRY to resume the queue state. It's irrelevant. You should consider all =

queued packets (on a hardware level) from before the suspend to be _gone_. =

You re-initialize the hardware, but you need to restore things like the =

BAR's etc that were set up originally. =


If you screw up and stop devices from working in "save_state()", that =

would be a BUG. =


> Suppose a driver needs to store its state info on a networked drive and =

> the network interface has already saved _its_ state?  Or it needs to =

> access a USB drive and the USB controller is no longer doing DMA?

So? The network device didn't save the state of the _software_. It doesn't =

need to. It doesn't need to save the state of the DMA areas - they should =

be RE-DONE by the resume code. The only thing it needs to save is the =

actual state of the hardware itself, and in fact, if it knows the hardware =

intimately and there is no state that got set up "outside" of the driver, =

it doesn't need to save even that.

It's perfectly ok to save zero state at all, if you know that you can =

re-create the state from the "dev->resources[]" data, for example. =


> There is a clear need for a partial ordering of devices.  If device A =

> needs to use device B to save its state, then A's state must be saved =

> before B's.

NO. NO. NO!!

Get it though your head that savign state doesn't change it. Neither does =

normal operations. Because normal operations don't actually change the =

STATE of a device - they just change the immaterial details that your =

driver has to keep track of _independently_, and are things that a reset =

needs to set up _anyway_.

Realize that a "resume" event is not really any different from a "boot" =

event, except that =


 - you haven't had a firmware POST setting up the device (this is a _huge_ =

   issue for video devices, for example)

 - you have some previously cached state like virtual MMIO mappings etc =

   that you had set up one way before the resume, and that means that you =

   have to set up _those_ details the same way (or, you need to unmap the =

   old VM state and re-map it with the new one you create: that's a =

   perfectly valid operation too)

But things like queues etc are not about the device any more. You're =

literally better off just flushing them. Trying to save/restore =

bit-for-bit same exact state is impossible and/or just a huge waste of =

time.

			Linus
