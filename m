From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 10:43:41 -0700
Message-ID: <200606231043.42256.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
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
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 June 2006 10:04 am, Linus Torvalds wrote:
> On Wed, 21 Jun 2006, Alan Stern wrote:
> > =

> > At what stage do you restore power to the device?
> =

> I am ambivalent about this.

Good, because it's not necessarily the right question.  On most
SOC systems, the right question relates to clock gating.  As in,
"when do you re-enable the device's clocks?"  And disabling the
clocks doesn't necessarily imply losing any device state.  It will
mean the hardware state machines stop transitioning, but there are
devices (like MMC/SD controllers) where that doesn't matter since
the controller is a pure cpu slave.

Plus there are nuances like "which clocks do you enable when" ...
you may want to keep a controller-specific PLL off most of the
time, but leave the the registers (and basic hardware state machine)
clocked all the time except during sleep states.  (And maybe not
turn it off even then, if that device should be a wakeup event
source.  Of course, leaving it clocked during sleep states costs
maybe a couple milliAmps per device...)


> > How does the handling differ when you are doing runtime (AKA dynamic AK=
A =

> > selective) suspend/resume?
> =

> I think that you should be perfectly able to do a single-device "shut tha=
t =

> device off" with a simple:
> =

> 	save_state(dev);
> 	suspend(dev);
> 	..
> 	restore_state(dev);

Separating the save/restore state for STR seems dubious to me.  I've not
seen hardware where it's necessary ... in large part because the point of
runtime PM is less about "shut it off" and more just "conserve power".  And
the hardware folk tend to do the right thing there, so that low power modes
don't imply losing any state.  (PCI drivers may need to care about D3 vs D2
of course, since D3 allows state trashing that D2 doesn't.  But that's a
separate discussion.)

 =

> without having any other suspend going on and without iterating over any =

> other devices.
> =

> Of course, whoever does this needs to verify that the device itself is =

> quiescent (or able to wake up itself and force its own "restore_state()").
> =

> I don't see any real issues there, do you?

Child devices need to be suspended first, which is an issue the current
PM core completely ignores.  Until it does, any driver supporting runtime
suspend needs to at least verify that a device's children were suspended
before it tries to suspend that device.

- Dave
