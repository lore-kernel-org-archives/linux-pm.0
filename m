From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:53:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
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

In brief, I agree with almost everything you say...

On Wed, 21 Jun 2006, Linus Torvalds wrote:

> Well, naming this op seems to be really hard. In the end, I don't really =

> care.
> =

> What I want is really to haev modular, independent calls, that tell drive=
r =

> writers _exactly_ what is going on, and why they should do so. =


Isn't it true the only a small minority of drivers need to do anything
special during the save_state() callback?  In most cases all the necessary
state is already stored in the driver.  So instead of making this a
callback in struct device, how about creating a pre_suspend notifier chain
for drivers to register on?  And ditto for freeze()/unfreeze() -- almost
no drivers need to handle them.


> > Presumably remote wakeup (WOL, whatever) gets enabled as part of the =

> > suspend().
> =

> That's what I'd expect, yes. Clearly _managing_ that whole thing is a =

> totally separate issue, but right now we don't even do that within the =

> actual device infrastructure, but on a device-by-device basis (ie ethtool =

> for networking and perhaps the RTC tools for timed wakeups?).
> =

> In fact, exactly because different devices have so fundamentally differen=
t =

> notions of what a wakup event is, I think that's the only really workable =

> option: have a device-specific setup phase long before, and have =

> "suspend()" just then implement whatever that was.

There already is code present to manage this.  See the "wakeup" section
in drivers/base/power/sysfs.c.


> > > 	- resume() (and, to clarify my position, let's call it just =

> > > 	  "restore_state()" here, although I don't actually think renaming =

> > > 	  it is worth-while, but _mentally_ you should think of the =

> > > 	  "resume()" function as a state _restore_, not a "resume", =

> > > 	  exactly because it's not actually paired with the suspend, but =

> > > 	  with the "save_state()" function)
> > =

> > At what stage do you restore power to the device?
> =

> I am ambivalent about this.
> =

> In many cases, power _will_ have been enabled earlier (ie the =

> suspend-to-disk case will do it), so I _think_ that the answer is that a =

> robust driver just cannot depend on what the state of the device was =

> before, and that part of "restore_state()" is to also restore the power =

> state at the time of the "save_state()".

Hmm.  Be careful here.  The power level really isn't part of the "state"  =

that gets saved by save_state(), is it?  After all, it is still subject to
change from userspace after save_state() has finished.  It seems to me
that (for STD at least) you would want to restore the power level as of
the time immediately preceding the userspace/upper-layer freeze, not the
power level at the time of save_state().

> So we _may_ actually restore power to the device before even calling =

> "resume()", and the driver just doesn't know and shouldn't care. The only =

> _real_ semantics should be that the power state _after_ the restore_state =

> should be the same as it was when save_state was called.

So drivers will have to be very careful, because when restore_state() =

starts the device could be in any of several possible states.

> > > 	.. reboot ..
> > > 	restore snapshot from disk
> > =

> > Here you left out two steps.  First, drivers have to get their devices
> > back into working condition.  (They might be exactly as shutdown() left
> > them, or they might have been reset by the firmware.)  Second, you need=
 to
> > unfreeze all the upper layers.

> The "restore_state()" will get the devices back to working condition (by =

> definition, or the "save/restore" is clearly buggy). So there's no need t=
o =

> unfreeze devices (and that would, in fact, be a bug, since you'd unfreeze =

> them into some random state if you hadn't done the restore_state).
> =

> But yes, we need to unfreeze the upper layers, since the snapshot got don=
e =

> with them frozen.

There's an unforunate asymmetry in the design.  save_state() (or
pre_suspend or prepare_for_suspend() or whatever we call it) was done with
userspace and the upper layers all operational.  By symmetry, people
would expect restore_state() to operate in a similar environment.  But =

instead it has to happen earlier, since the upper levels mustn't get =

turned on until the devices are all working.

This argues for a similar asymmetry in naming.

Alan Stern
