From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 11:31:55 +1000
Message-ID: <1150421516.7725.88.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Why are people being dense and stupid? I told you in the very first =

> explanation that the IO state isn't suspended by "save_state()".
> =

> "save_state()" would not disable the device. It would not disable the =

> queues. The device would remain usable, and 100% functional.

But what is the point ? What is the relevance of a state saved if it can
be made invalid right away by processing of IOs ? I can save state at
any time and suspend 2 hours later, how relevant that state is ? Why not
save the state at boot and re-use it later ? Doesn't make sense to me :)

> It also would NOT save any "queue state". That's a total software =

> abstraction, and that's something that comes much later (if at all), when =

> we actually need to save the memory image. The only thing the =

> "save_state()" needs to save is the actual _hardware_ state, and not even =

> all of that.

But the hardware state changes as soon as you process requests (run IO
queues).

> For example, on resume, if you have a network device, you SHOULD NOT EVEN =

> TRY to resume the queue state. It's irrelevant. You should consider all =

> queued packets (on a hardware level) from before the suspend to be _gone_.

Sure, you don't save the content of the queue for network. At least the
drivers I've cared about so far don't bother, they just drop packets.
But block drivers need to block the queue as they can't afford to lose
requests.

> You re-initialize the hardware, but you need to restore things like the =

> BAR's etc that were set up originally. =

>
> If you screw up and stop devices from working in "save_state()", that =

> would be a BUG. =


Saving the PCI interface "state" (BARs etc...) is a very small subset of
the HW state. That one could probably be done out of line vs. the rest.
In fact, that specific state can probably even be saved once at driver
init time and be done with it :)

> Get it though your head that savign state doesn't change it. Neither does =

> normal operations. Because normal operations don't actually change the =

> STATE of a device

Of course they do. Or we have a different notion of what you call
"state" here...

>  - they just change the immaterial details that your =

> driver has to keep track of _independently_, and are things that a reset =

> needs to set up _anyway_.
> =

> Realize that a "resume" event is not really any different from a "boot" =

> event, except that =

> =

>  - you haven't had a firmware POST setting up the device (this is a _huge=
_ =

>    issue for video devices, for example)
> =

>  - you have some previously cached state like virtual MMIO mappings etc =

>    that you had set up one way before the resume, and that means that you =

>    have to set up _those_ details the same way (or, you need to unmap the =

>    old VM state and re-map it with the new one you create: that's a =

>    perfectly valid operation too)
> =

> But things like queues etc are not about the device any more. You're =

> literally better off just flushing them. Trying to save/restore =

> bit-for-bit same exact state is impossible and/or just a huge waste of =

> time.
> =

> 			Linus
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
