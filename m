From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 16:02:35 +1000
Message-ID: <1150437756.23600.18.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<20060615191925.GA1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
	<1150421189.7725.81.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151927580.5498@g5.osdl.org>
	<1150429033.7725.118.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606152057140.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152057140.5498@g5.osdl.org>
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


> And I think it's better to make things explicit for driver writers than =

> expect them to get it right implicitly. Especially since in many cases th=
e =

> state you want to restore ends up depending on a lot of other things, it'=
s =

> often just _easier_ to have a "save state" phase that the driver writer =

> knows is called before suspend, and which can (for example), just blindly =

> save off the config space, and then at resume time we just blast it back =

> out.

I'd rather call it "prepare" than "save state" then...  It's both not
always and much more than just saving a state :) =


> Same goes for just saving/restoring some firmware memory area or similar, =

> for example. Yeah, we could ask user space to do it for us, but wouldn't =

> it be nice if "it just worked", and we made the interfaces obvious enough =

> that it's easy for a writer to make it so?
> =

> In contrast, keeping track of things one field at a time is actually =

> pretty painful, even if you do have all the information, and even if you =

> don't strictly need to save off what ends up being just another way of =

> saying the same thing..

Yup.

> And, btw, I think "prepare_for_suspend()" is a perfectly fine alternate =

> name for "save_state". Maybe even better. I don't at all disagree about =

> that approach or the naming.

Good :)

> > I'm still not sure I totally understand what save_state exactly _is_ in
> > your view of things since most of the time there is either no state to
> > "save" or it makes no sense to save stuff that will get invalidated and
> > need to be reconstructed as you properly explained...
> =

> Basically, outside of power management, there is a lot of state that =

> simply doesn't need to _ever_ be saved, exactly because we don't actually =

> lose that state.
> =

> So I would want us to have an explicit callback to save any potential =

> state and just generally tell the driver to perhaps disconnect from any =

> user-level stuff etc, rather than have the driver have to keep track of =

> and remember that on its own.
> =

> But yes, if you think it would be more obvious to call it =

> "prepare_for_suspend", I have no problem with that. It doesn't change the =

> basic functionality.

Excellent. Then we agree 100%. Have you read my other email titled
"suspend/resume issue (Was: [linux-pm] [PATCH 2/2] Fix console handling
during suspend/resume)" ? I expose a couple of issues we still have that
are related to request_firmware() in resume() and other similar issues
with hotplug... =


prepare() would allow to work around some of those by allowing drivers
to clean things us vs. userland communication (or notify a userland
counterpart etc...) and to pre-load necessary firmwares. However,we
should also have a pending finish() imho to inform drivers that we are
now outside of the suspend/resume transition and such things can be
released (and normal request_firmware can be done again).

There is still the problem with hotplug. I'm tempted to make an extra
requirement for bus drivers here (drivers that may expose other drivers,
like USB hubs). After prepare(), they still operate but are forbidden to
plug a new device in (unplug is probably still ok). That is, on, resume,
they'll have to do a quick discovery phase to find out if things have
been plug (they have to anyway since things can be plugged during
suspend).

There are gazillion of issues if we allow new devices/drivers in while
we are suspending, and I think the best approach here is to just not do
it, let them be discovered after resume (in this case, after finish(),
not resume() of the controller, let's be sane all the way til userland
can react).

Note that all of this is good for STR. There are still issues with STD
and the need to have some kind of atomic image of system memory vs.
filesystems etc... as discussed separately. But let's keep that a
separate issue. I think a lot of the confusion in this thread is that we
mix too many things (because the current calls do mix a lot of semantics
at once, which I agree isn't optimal :)

> I would want most devices to be able to have a suspend function that =

> _literally_ just does
> =

> 	pcibios_enable_device(dev, PCI_D0);

Hrm... where is the stopping of IO queues, sync'ing with them,
adadada ... ? As you said, it isn't part of prepare_suspend(), thus it
shall be part of suspend(). See my example about IDE injeting a suspend
request in the queue. Network drivers must at least make sure xmit() is
no longer called once the HW is quiscent, that sort of thing.

> and it would be clear that interrupts have long since been disabled

How so ? A USB device suspend() may want to send commands to the device
to put it into low power state or to spin down a disk or whatever ...
will never happen if interrupts are disabled :)

>  and  there can be no memory allocations

That I can buy, at least no blocking memory allocations... The above
example with USB means we still need a few urbs... those could have been
pre-allocated by prepare() to make sure the driver can continue
proceeding with IOs after prepare(), but in many case, drivers might
still just successfully do GFP_NOIO or GFP_ATOMIC allocations... in the
STR case.

Now if you are talking about the STD case, there is the need for that
atmic snapshot we talked about that involves also some kind of atomic
state from drivers for those same reasons I suppose... A slightly more
complex issue.

 >and by then "printk()" won't actually =

> show anything at all, and you cannot return an error, because we have lon=
g =

> since passed the point of no return.

You can return an error, and the system will just wake up... no ? well,
that's a detail, doesn't really matter at this point.

> THAT is what I care about. The current setup actually works for me, but i=
t =

> works at least partially exactly because I basically shut off the console =

> "too early". I would really have preferred to shut off the console much =

> much later, but since currently all the preparatory work actually also =

> ends up shutting things down, that simply isn't an issue.
> =

> So for any individual driver, the split into "prepare" and "suspend" will =

> never help. That's not the point. The point is purely that we can do =

> general and global things in _between_ the point where "all drivers are =

> prepared and have said that they are ready to suspend", and the final "go =

> go go" moment.

Yes.

> I suspect a lot of drivers don't even need much of a prepare. And others =

> will _literally_ just do something simple and stupid like
> =

> 	static int prepare_to_suspend(struct pci_dev *dev, pm_message_t state)
> 	{
> 		pci_power_t pstate =3D pci_choose_state(pdev, state);
> =

> 		if (state !=3D PCI_D3hot && state !=3D PCI_D3cold)
> 			return -EINVAL;
> 		.. allocate save area for IO registers, save them there ..
> 		pci_save_state(dev);
> 		return 0;
> 	}
> =

> exactly so that we can tell _ahead_ of time if something would fail, and =

> so that we can keep the console open longer.

Drivers that use a separate firmware would use the above to request it,
so it's available on resume, etc...

> In my crazier moments, I actually want to do _three_ phases: my really =

> preferred thing would be
> =

>  - phase 1: allocate memory, save state, and return errors
> =

>    After phase 1, we are guaranteed to not need any more memory =

>    allocations.

Yes.

>  - phase 2: send commands to flush write caches, spin down
> =

>    After phase 2, we know we don't have to wait any more, and this is the =

>    point where we disable the console and disable all interrupts

Does the above involve talking to drivers ? Because that's where things
like IO queues have to be stopped etc... unless it's driver specific
policy, that means that child devices can't talk to their HW after that
stage.

>  - phase 3: actually power down chips.
> =

>    There is no "after phase 3". The CPU powering down was the last part.

Ok well, there is some issues in splitting 2 and 3 ... makes sense for
some devices, not others, not necessarily clear. I suppose there is need
to have something like 2. at the core that stops filesystems, flush
dirty pages, freeze IOs etc... whatever for STD. For STR, there is no
real distinction between 2 and 3.

> but I'm still busy trying to just push for a second phase, so I'm not eve=
n =

> going to mention that next crazy plan to you.
> =

> Oops.
> =

> 		Linus
