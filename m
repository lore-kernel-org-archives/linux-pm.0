From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 10:16:46 -0700
Message-ID: <200606181016.47561.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 16 June 2006 11:31 am, Linus Torvalds wrote:
> =

> On Fri, 16 Jun 2006, David Brownell wrote:
> > =

> > It's not so different from what Linus has been sketching, except
> > for the actual turn-off-DMA step.  (Needed because you want to get
> > an atomic snapshot.)  In terms of $SUBJECT the gain is that you
> > actually get a debuggable suspend sequence.
> =

> Actually, if the _only_ thing STD wants to do, why not just have a
> =

> 	->freeze(dev)
> 	->unfreeze(dev)
> =

> call-in?

That would be Pavel's question to answer.  ISTR discussing the benefits
of general "quiesce that driver!" calls previously, and we ended up
concluding that splitting it out wouldn't exactly be a win

However, I liked Ben's comment there:  making freeze() be a mode of
suspend() processing ensures that the 95% (by my recent audit) of Linux
drivers that really don't know anything about power management will be
doing something sane, because they'll treat FREEZE requests by default
the same way they treat SUSPEND ones.

Agreed that it's overkill; but it's not incorrect.  Which means it's a
huge win, since the number of driver developers who know enough to do
any kind of _smart_ power management is disappointingly small.


> The thing is, if you don't actally want to suspend, just freeze the thing =

> _temporarily_, you can do that so so so much easier than actually =

> suspending.
> =

> For UHCI, I think a "freeze" is basically two lines:
> =

>  - write "stop" command to command register (actually, it's "clear the ru=
n =

>    bit" or something)
>  - wait for a microsecond to guarantee that the engine actually stopped =

>    (I think it will run to completion for whatever queue entry it's =

>    working on, and poll the stop bit only in between).
> =

> ie I think it's literally an "outl()" followed by a "udelay()", and there =

> is basically _zero_ room for problems.

Well, in general with USB that should be an msleep(1) not a udelay(),
since I don't think any of the silicon guarantees responses before
the next frame.  Plus, see below.


> The "unfreeze" is then just  =

> setting the "run controller" bit again.
> =

> (Ok, so it's been about five years since I did anything with UHCI, and th=
e =

> USB stack has changed radically since, so my memory may be bad).

In this case your memory seems good enough.  In fact all the PCI based
controllers have similar bits.  But EHCI also expects some handshaking
before the host can rely on the engine actually shutting down, and OHCI
has needed a wait-for-pending-IRQs step (I've been burned by not having
that in a few cases, there were nasssty oopsing races) that can take up
to 6 msecs (because of IRQ mitigation that's a win in pretty much all
other runtime cases).


So the downside of that observation is that all that "make sure the
controller is fully quiesced" work is already the time-consuming part
of HCD suspend handling.  It's packaged in the root hub suspend logic.

Plus, as Ben commented, the quiescence must not be limited to that
particular driver.  For USB, "khubd" has to know not to autoresume
the root hub associated with that controller ... and the IRQ handler
needs to avoid its normal processing.


> In other words, if you really just want to stop the devices in order to d=
o =

> a memory snapshot, doing a "suspend" + "resume" is _way_way_way_ overkill=
, =

> and really really fragile because it is so much more complicated. A simpl=
e =

> "stop" and "continue" is for a lot of PCI devices a total no-op, and for =

> others it's literally a matter of setting a stop bit or similar.
> =

> IOW, USB, which usually is the "device from hell" in this kind of setting=
, =

> can basically do both the stop and resume in one single machine =

> instruction!

Plus the delays needed to make sure that the USB engine has fully
responded to that instruction, and associated handshaking... which
includes other parts of the driver stack.

- Dave



> So if you're using "suspend/resume" to actually just copy a static image, =

> you're really doing silly things.
> =

> 		Linus
> =
