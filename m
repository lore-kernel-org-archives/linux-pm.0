From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 13:59:56 +1000
Message-ID: <1150862396.12507.103.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<1150858653.12507.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202008290.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202008290.5498@g5.osdl.org>
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


> If that is really how people expect things to happen, and if people are =

> _happy_ with that, then I can only throw up my hands in disgust.

I'm not saying it's all that should happen and I agree with some of your
aguments below that doing some system level quiesce of subsystems will
make life easier for the memory snapshot of STD. But it's not enough
imho. I'll try to calmly explain why I think so below.
 =

> Dammit, if we want to make a machine quiescent enough to take a memory =

> snapshot, the only sane way to do that is to do it with proper scoping of =

> the problems.
> =

> A global memory snapshot is not a "device model" thing.
> =

> It's a _system_ event.

Yes, it is. Agreed.

> The same way the device models try to create a hierarchy, there's a much =

> higher-level hierarchy there that should also be respected. Devices (even =

> in the device model) are just about the lowest of the low. Before we tell =

> devices to be quiet, we tell the upper layers to be quiet.

In fact, that's not always true depending on how you look at things :)

If you look at it from a consumer<->provider perspective (which is
pretty much the bus hierarchy as exposed by the device model and
reflects the HW dependencies pretty well in most cases), the subsystems,
like block layer, etc.. are actually clients of the drivers.

Toplevel is your toplevel system bus, you get your bridges etc... you
get to the actual, for example, PCI devices. Some of them are leafs,
some are controllers (like USB) that lead to more devices etc... all the
way down to ... a disk driver, which itself provides services to the
system block layer, then to a filesytem etc... In that picture, your
"high level" things like the block layer and filesystems, and IO
scheduler go all the way to the bottom.

Of course, there are various things in between, and annoying things,
like device-mapper, multipath, that make the picture less than perfect.

That's why it would make it very useful, indeed, especially in the
context of suspend to disk where a stable memory image is needed, to
have a way to quiesce subsystems (what you call high level but which is
not necessarily above the drivers, depends how you decide to look at
things), before drivers get their go.

But there are very good reasons why the suspend process is driven by the
drivers in the first place, for big bold dependencies on parent busses
based on the above model. And in that picture, it's actually very easy
and works pretty well to have a given driver, when asked to suspend, to
then call it's own "customers" to tell them to shut up (example; a
network driver calling netif_stop_queue() before suspending).

If we had implemented the power tree all the way as we envisioned it
with Patrick years ago, in fact, it would have been a dependency graph
and the "core" would have taken care of calling the appropriate
suspend() callback of all dependents before a driver goes down, thus
potentially _including_ things like the block layer or network layer. In
the end, things were done in a much more simpler/incremental way. I
agree what we have now is not perfect, but don't throw it all away, it
has some very good reasons to be that way and it works very well in many
cases.

But it does not lift the requirement of drivers, in the general suspend
case (and by extension in the freeze case as well I'd say) to also do
some of the work locally, simply because, there isn' always a "high
level" layer between the driver guts and whatever feeds it with
requests.

(I'm using "request" here in a very broad sense -> any call into a
driver that would normally cause it to go whack the hardware).

It goes from drivers feeding themselves with requests (for various
reasons, think about network drivers polling their PHY state, or other
drivers having some sort of keepalive protocol with their hardware),
direct ioctl interfaces to userland (unless you keep the concept of
freezing userland before the suspend process, though beware of things
like nfs server etc... we need to be careful about all these kernel own
services that may try to hit drivers at any time), ...

> That's why we freeze processes. =


I though you agreed a while ago that in a perfect world, freezing
processes shouldn't be necessary ? We get away pretty well with not
doing it on powermac.

> That's why we try to clean out the memory  management.

We aren't doing enough there though.

>  That's why we do things like shut down the console layer (not =

> the _device_ layer - the whole logic for "printk()" etc gets shut up).

It's not been shut up before and I didn't need it to be shut up on
powermac provided the low level driver (fbdev in our case) took care of
not hitting the hardware once that hardware is suspended.

> Stop blathering about "chains". There's no "chains". We're talking about =

> much higher-level things: getting the requests to GO AWAY in the first =

> place at the highest level, and waiting for the queues to drain.
>
> That can (and should) happen without devices being involved with it AT =

> ALL. It doesn't _matter_ if there's a chain of devices (say, raid queues =

> feeding into some multipath queue, feeding into a low-level queue). The =

> way you empty a block device queue is totally independent of any devices =

> anywhere:
> =

>  - you stop feeding it
>  - you unplug it
>  - you wait for it to drain.
> =

> "Look, ma, no hands!"
> =

> None of those operations have anything to do with devices at all (well, =

> the unplug ends up telling something to start, but it has nothing to do =

> with any special operation).
>
> And none of those operations are in any way "special" as far as the devic=
e =

> is concerned. The exact same thing actually happens for any normal IO. If =

> some process does a "read" and wants to wait for the result, it ends up =

> doing exactly that, indirectly.
> =

> In other words, THIS HAS NOTHING TO DO WITH THE DEVICE MANAGEMENT. It's =

> all a much higher-level issue. It should _literally_ be a question of =

> freezing processes (so that they can't be generating more information), =

> and then waiting for all the reachable queues (which is about iterating =

> the known devices) to become empty. =


And make sure nobody feeds them anymore (thus in-kernel things like
anticipatory scheduler, nfs server, etc... need to be
frozen/stopped/suspended/whatever too) but yes, possible. The network
layer would need to have a concept of stopping to feed drivers too. And
others...

> At that point, any lower-level queues will be empty too, because the only =

> way they are reachable is indirectly through a higher-level queue.
> =

> > And how do you make sure there is no request coming from the above when
> > a given segment of a bus is going offline or being power managed or
> > whatever and thus a given driver needs to make sure it's not fed any
> > requests ? stop the entire system block layer ? What if it's not a block
> > driver ?
> =

> We were talking about IDE, weren't we? Last I saw, it was a block driver..
> =

> And yes, that can (and should) be done without ANY DRIVER ACCESS =

> WHAT-SO-EVER.

Note that IDE uses it's own block layer queue to send itself commands
(as do a lot of drivers), including ... the suspend command (to spin
down the platter). Can be worked around, but it could be a problem in
the general/scsi case if the queues have been stopped etc...

> The fact is, if we call down to a driver with something that a driver =

> should not have to worry about, it's a _failure_. =

> =

> Why? =

> =

> Count the number of drivers. Then count them again. Then count the upper =

> layers. And realize that if we can do things at upper layers without ever=
y =

> invocing a driver for an op, we're _much_ better off.
> =

> And tell me why the above isn't much simpler than asking drivers to shut =

> up on their own? Tell me _one_ reason why an IDE freeze/unfreeze should b=
e =

> anything but a no-op, in other words.

If we agree that:

 - userland need to be stopped in all cases (STD and STR)
 - that you manage to get every single "subsystem" stopped from touching
drivers
     * block layer/fs
     * network layers with all their little things going on in the
background like wireless threads/work queues stuff etc...)
     * whatever else drivers create threads/workqueus/timers for to muck
around in the background
  - have a way to properly synchronize with every of these subsytems to
"drain" their queues (that is, stopping userland feeding them with
requests isn't enough, you need to make sure your sound driver actually
finished playing the last buffers enqueued for example, etc...)

Then you still have to handle things like:

  - drivers who continuously talk to their device/bus regardless of
"upstream" activity (USB is a good example but not the only one)

  - drivers who get inbound requests (you need your network driver to
stop receiving packets for example, that is disable your interrupts at
least, timers and other things you do independently of high-level
triggered "requests" when doing freeze)

So yes, _maybe_ your way is better/nicer for driver, but there is a lot
of work to do to get at least the block and network layers (especially
the network stuff I foresee as being a mess) to play your game, and
we'll still need to deal with all the drivers that don't fit the "easy"
scenario.

In the end, it's my experience that having the drivers themselves block
incoming requests is easy in most cases (network is trivial), in some
case could easily be done via "helpers" from the higher level (block),
and gives you something that works, is robust, and you don't have to go
muck around with all kernel subsystems (which I didn't want to do back
then) nor stop userland...

Now I may be biased, after all, I had very good suspend/resume
implemented on powerbooks but it was with a limited and fairly well
controlled set of drivers (excect for USB :) so it was easy for me to
make sure they are all fixed and well behaved...

I understand that you are trying to do things so that drivers writers
don't have to understand the stuff and you may well end up with
something that works fine for system suspend/resume, but that doesn't
mean that the approach we have been following so far is idiotic (thank
you very much), and it also doesn't quite handle things we have started
talking about/tackling lately like partial tree suspend/resume,
individual device PM, etc etc... where there is also some need of
synchronisation between child and parent devices and putting on hold
requests, at least during the necessary power state transitions before a
driver is ready to process them. Thus, that logic _will_ have to reach
drivers.

This is why I still prefer the approach of having the driver be in
control of stopping its providers, though I do agree that it would be
very nice to have simple helpers to make it easy for drivers to stop &
synchronize their request queues etc...

Ben.
