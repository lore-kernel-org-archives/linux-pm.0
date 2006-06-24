From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 14:52:20 +1000
Message-ID: <1151124740.10141.49.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
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

/me puts ego on hold and tries to be constructive without ranting...

> in my current tree I have
> =

>  - suspend_prepare (I went with Ben's name, maybe that strokes his ego =

>    enough that he'll admit it's better now)

Heh.

>  - suspend (same as old)

Ok. Well, most of my latest burst was about blocking of incoming
"requests" but we can discuss that separately. Indeed, just adding the
other calls don't break anything as it is.

>  - suspend_late

Ok, so this is a cleanup over the old stuff we had for returning a
special error from suspend to be called again later with interrupts off.
I agree it sucked, though I never actually used it. Better have it well
defined this way. Now wether or when drivers shall use it and when they
shall do so is a different question :) (Obviously, not drivers that rely
on a complex parent bus like USB, firewire, etc etc... but more like PCI
drivers, though there is also the problem of how does that
"suspend_late" fits in the context of dynamic PM in a live system. But
we can re-discuss that later.

>  - resume_early

Same as above.

>  - resume (same as old)
> =

> (and I really wanted to do a "resume_finish()" too after user-land resume=
, =

> just to have the "reverse" three phases of resume as I have of suspend, =

> but I decided I didn't have any driver that I would make use of it =

> personally)

This one will be needed as soon as we tackle the problem of devices that
do request_firmware and/or communicate with userland. I have one user at
least already for it on powerpc which is the APM emulation (I
emulate /dev/apm_bios for the few userland stuffs that do care about
suspend/resume).

I think most wireless drivers that need firmwares should be fixed to use
prepare/finish to preload the firmware in memory and get rid of that
preloaded image. That way, their resume can use the preloaded firmware
rather than deadlock/fail in request_firmware() bcs userland isn't in a
state where it can service it. First candidate for me here is bcm43xx

There is also my idea that bus drivers could stop inserting new devices
after prepare(), not something I'm necessarily very firm on, it's just
an idea that I though might make life easier but can definitely be
debated.

> > One thing that might help us get there is if we passed a suspend notifi=
cation
> > to the class devices (i.e. the higher level subsystems).
> =

> Good point. We probably should. That really really makes sense, and that =

> also automagically solves the "network device" issue.
> =

> I'll do that too, it actually looks pretty simple (famous last words).

Yes, that would be definitely a good thing, though while adding the
callback is simple, when to call it is not... (or rather is not with the
current implementation). It seems to me that class devices as
essentially the childs of the device as far as PM is concerned
(suspended before the device and resumed after). Thus they should be
inserted in the PM tree at the right place. Right now, they are not.

I wonder if we shall bite the bullet and finally go for a completely
separate PM "tree" structure (or worse, a dependency graph that some
embedded people ask for but I dislike it). Right now, we have a list and
we hope we always insert things at the right place. Not sure it can
accomodate class devices though.

> > I'm curious about your thoughts on runtime suspending of devices are, s=
uch as
> > the resource rebalancing or cpufreq cases I suggested earlier. =

> =

> I really don't see that as my primary worry. Runtime suspend is "nice", =

> but it's not a _primary_ goal for me.

Ok. It's been one for embedded and handhelds folks though lately and is
necessary for a few things today like shutting down your wireless
interface in a place (yeah, stupid, but heh !). In most case, it can be
handled totally locally to a given driver though. But we have been
looking into making it better by properly using the PM core to
"escalate" power state changes of drivers, allowing things like entire
busses to be unclocked when all devices on them are off, that sort of
thing.
 =

> I think it should be pretty easy to implement, and I think your subsystem =

> suspend notification thing would help a lot (to basically guarantee that =

> the subsystem doesn't try to use it).

Yes. Though we are talking about two slightly different things: class
device and subsystems. In the first case, we have an entity that could
be considered as a funcitonal child of the device (netdev class devices
etc...) and get called before. In the later case, we have a subsystem
routine that is explicitely called by the driver at suspend to ask the
subsystem to leave it alone. Unless you want to suspend all subsystem's
before you suspend all drivers but I'm not sure that will not lead into
various sort of problems where subsystems are part of a transport layer
needed by some drivers to suspend...

But it's essentiall the same idea.

That is definitely a good way to split suspend() and make it safer,
because it would provide proper blocking of requests etc... that I'm so
big about, at the sysbsytem or class device layer.

In fact, it's more/or less how I did IDE back then (not with class
devices but by having 2 devices separate for the disk and the
controller, sounds logical today, wasn't back then in the state where
the IDE layer was). The disk gets suspended first, then the controller.
By the time the controller suspend is called, it doesn't have to worry
about requests or anything like that, it just change the power state.
The disk drivers gets the complicated logic of blocking queues, sending
spindown commands, etc... Which is cool, there is _one_ disk driver to
debug and dozens of controller drivers.

That sort of split, I'm all about. That is, not splitting suspend() into
different sub-callbacks to the same driver, which for the various
reasons I already went on too much about, I think isn't necessarily a
solution, but by splitting the functionality between different drivers.

Network is definitely something we could handle in part by having
suspend/resume at the generic eth level (netdev class device). There
would still be a little care to take in drivers about things like
ioctl's (for those who still take thse, though I suppose even there, the
netdev layer might be able to block them) and drivers that have their
own timer/workqueues/threads to do link management (though we have been
working toward a generic PHY layer that makes the various PHYs separate
drivers, so heh, here again, we _can_ split the complicated work, but
not within a driver, between layers of drivers).

That doesn't necessarily fix the main debuggability problem which is the
console though. fbdev will have a hard time being suspended "late"
because it needs to take the console semaphore to do the suspend safely
and it's difficult to do so with interrupts disabled (you can try to get
it, but you can't just call acquire_console_semaphore, unless you go
silencing a lot of atomicity warnings we have all over the place). I
suppose pure PCI network drivers could suspend "late" using your second
callback mecanism, thus allowing netconsole to survive a bit longer,
though as I mentioned earlier, that scheme doesn't quite fit with the
needs of runtime/dynamic PM... at least if the driver _assumes_ it has
interrupts off.

However, we could just do a 2 pass mecanism instaed with the second pass
sitll not having irqs off, but having shut down all clients of "directly
mapped" devices (PCI etc...) and thus letting those be suspended _after_
all the others. In our above examples, we would get the first pass do

 - usb devices, firewire devices, all devices depending on an upper
transport driver basically
 - the class devices like netdev's (maybe with tweaks so that netconsole
is still operational via hacks in the driver tho)
 =

And the second pass would do

 - pci devices (network drivers typically, fbdev's)
 - pci bridges

In addition, we might want this "irq off" pass for low level system
things (like the PIC themselves) or broken legacy devices. Could be a
3rd pass. Right now, we have both the dodgy "return that error from
suspend to be called later with irq offs" hack _and_ the sysdevs. I hate
the sysdev's because they are just duplicate of some of the struct
device logic with another name, and just don't fit well in the picture.
I'd rather have had a separate callback to struct device and have them
be normal struct device. They've also been abused by cpufreq which cause
regulary problems with suspend. So cleanup in that area is welcome. =


Now there is still the question of how things like usb controllers would
fit in the above picture. Different problems. USB has it's own issues
that it mgith want itself to be split between a toplevel that is
suspended in the first pass (request processing etc..) and a bottom
level that happens in the second pass (actual controller D3).

> > Do you have any opinions on how this might be handled?  So far, I've =

> > been favoring usage of the same sort of freeze() mechanism used for =

> > preparing for memory snapshots etc.
> =

> Let me reboot my current kernel to test my current five-phase thing, and =

> I'll do the subsystem thing too.
> =

> My off-the-cuff plan for that is to just add a "suspend(dev, state)" =

> callback to the subsystem structure, and have device_suspend() call the =

> subsystem suspend function before it even calls the actual device suspend =

> function (and in reverse order on resume, of course).
>
> Again - I'm not actually planning on doing very many individual drivers =

> (that's the point I _don't_ care about), I want the support infrastructur=
e =

> to be sane.
> =

> (That, btw, obviously indirectly means that I'm not willing to break =

> existing drivers - my infrastructure is strictly a _superset_ of what the=
y =

> get now).
> =

> 			Linus
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
