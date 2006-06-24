From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 16:30:43 +1000
Message-ID: <1151130644.10141.70.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
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

On Fri, 2006-06-23 at 22:18 -0700, Linus Torvalds wrote:
> =

> On Sat, 24 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > >  - suspend_late
> > =

> > Ok, so this is a cleanup over the old stuff we had for returning a
> > special error from suspend to be called again later with interrupts off.
> > I agree it sucked, though I never actually used it.
> =

> I don't think it _could_ be used. =

> =

> Or rather, you'd have to have done some really really insane things like
> =

> 	if (!interrupt_disabled())
> 		return -EAGAIN;

Agreed, it was totally broken.

> in the suspend() routine, and live with the fact that cleanup - and =

> ordering - would be impossible and/or very hard to figure out.

Yup

> I bet nobody ever used it.

Heh, quite possibly :)

> > However, we could just do a 2 pass mecanism instaed with the second pass
> > sitll not having irqs off, but having shut down all clients of "directly
> > mapped" devices (PCI etc...) and thus letting those be suspended _after_
> > all the others. In our above examples, we would get the first pass do
> > =

> >  - usb devices, firewire devices, all devices depending on an upper
> > transport driver basically
> >  - the class devices like netdev's (maybe with tweaks so that netconsole
> > is still operational via hacks in the driver tho)
> >  =

> > And the second pass would do
> > =

> >  - pci devices (network drivers typically, fbdev's)
> >  - pci bridges
> =

> I'm pretty sure that would suck, and be a lot less flexible than the much =

> simpler setup.
> =

> I bet you we'll have devices that want to be in both classes. For example=
, =

> I would expect a network driver to set up it's "PCI state" in the early =

> resume, but possibly do something like it's PHY probing etc in the =

> "normal" resume when interrupts are on, because it may need to do =

> "msleep()" etc to do that part.
> =

> In fact, I can also point you to a device that is at least two _different=
_ =

> classes: the graphics thing.
> =

> Take a close look at where "device_prepare_suspend()" is, and where the
> "device_finish_resume()" callback would be.
> =

> Hint: they match "pm_prepare_console()" and "pm_restore_console()" =

> _exactly_. =


Yes. They do.

> It's not just "close". It's right there.

Yes, it's the same concept of dealing with userland, the same reason apm
emulation needs to be there etc... agreed there.
 =

> In other words, if we added a "resume_finish()" method, we could handle X =

> and the screen _without_any_special_cases_, as the perfectly normal phase=
s =

> of suspending the video device.

Yes. I totally agree there.

> You could _literally_ make the "prepare" =

> be the "switch consoles" of the current pm_prepare_consoles, and the =

> "suspend_late()" would be the actual "go to D3cold" part.
>
> I talked about this a lot earlier. Very early in this thread, I pointed =

> out that X really shouldn't need to be a special case.

Well, console switch is generic way of dealing with X and other things
that may use directfb etc... as long as they are sane enough to honor
the console switch requests. So yes, in that sense, it's not a special
case. Now, where the console switch however doesn't quite "fit" in the
model at this point is that I don't think there is any relationship
currently between the VT subsystem and the driver model. Thus there is
no struct device/driver to attach a suspend_prepare and a resume_finish
hook. I'm not sure where we would hook one... If you have fbdev's, we
could have something on fbcon itself, though even how to do that isn't
obvious in the details.

Any idea there ?

> And the "suspend_late()" thing really is fundamentally different from =

> "suspend()". As mentioned several times, splitting suspend() up is what =

> allows us to, very specifically, avoid having to shut down the console =

> early. I want to be able to do printk() until as late in the game as =

> possible, and preferably as early in the game as possible. =

>
> And splitting suspend was the way to do that. And when I actually started =

> doing that, splitting resume (which is even _better_) actually fell out o=
f =

> it automatically - I needed to do that just to handle the nested error =

> cases correctly (which I had earlier thought I'd just punt entirely, and =

> require that we do errors in the "prepare/save_state" phase only).
> =

> In other words, I think that this patch will allow us to resume, say VGA =

> early, and reliably, and get a working console by the time we resume USB.

So your resume_early is equivalent to my pmac specific hack to resume
the fbdev early (except that my hack is really very very very early :)
Before I even bring the L2 cache back, but that's almost a detail. After
all, nothing says the L2 cache couldn't be just another driver with a
suspend and a resume method :)

However, I do still think that this late/early business is problematic
with "runtime/dynamic" suspend of individual devices or sub-trees
because of the "irq off" requirement of the late round of calls and I'm
not necessarily fan of having drivers split themselves between the 2
phases. If there is a case where we would be tempted to do that, then I
tend to prefer splitting into 2 drivers instead. The PHY example is a
good one: move the PHY suspend/resume to the new PHY layer and have
proper PHY drivers with their suspend/resume etc... (reminds me I sitll
need to port sungem to that new stuff... )

> Now, it does require that PCI buses (and preferably other devices) go to =

> D3 only in suspend_late(), and come back in resume_early(), so that VGA i=
s =

> reachable. So that _will_ require driver modifications.

Yes, though doing the PCI busses that way is fair enough provided we
don't get into semaphore/msleep/etc... vs. interrupt off kind of issues.
I really don't think we need irq off for that late phase :) Let's just
quickly look at the reason why you want IRQs off. I think that it's a
way to avoid being hit by requests etc... right ?

Now, if instead, we make sure the subsystem handles that, either by
having a class device that has been suspended before the device we care
about or a subsystem call the driver can just call into at suspend time,
We can move all of the complexity of blocking user requests etc... to
that once subsystem/class device implementation and out of the driver.
That's what I demonstrated with IDE with the disk/controller split (the
2 layers of drivers case) and that's what some network drivers do quite
successfully with a single call to netif_device_detach() (the subsystem
helper case).

I'm not saying we _must_ have irqs on... I'm just wondering wether this
irq off business might actually make our lives more complicated. Another
example is the fbdev suspend/resume stuff (thus the console suspend
resume stuff). As you explained, we want that late/early. But it also
need to take the console semaphore before calling fb_set_suspend (which
is the subystem helper to have subsequent printk's not touch the
hardware) or you'll get WARN_ON's all over the damn place and same on
resume (since we repaint the screen using the console code so you _do_
get the very late messages of suspend displayed early on resume, but
that needs the console sem. held too). Thus I still think that we should
really be careful about this "no interrupts" business. Two phases, ok, I
can buy that and it might indeed make things easier. But interrupts off,
I'm really not sure.

> But I think it will actually fall out of just moving where the "default =

> PCI suspend/resume" thing gets handled (ie move -that- from the current =

> standard suspend/resume, to be in the late/early suspend/resume).

Yup.

> In other words, I've not tested it, but I suspect something as simple as =

> this migt just do 99% of it. Teach some other core PCI devices (a network =

> driver or two) about the late/early stuff, and I suspect you'll find it a =

> _lot_ easier to debug USB suspend and resume, because things like =

> netconsole suddenly start working _during_ suspend.

Of course that won't help netconsole over a usb network device but I'm
being an ass here :)

> (And btw, this patch is _totally_ untested. This is the point where we =

> actually start modifying what we do. But it doesn't look "obviously wrong=
" =

> to me - I think it falls solidly in the "it might just work" category).

Ben.
