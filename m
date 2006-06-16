From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 13:33:53 +1000
Message-ID: <1150428833.7725.114.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
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

> Ok, take a deep breath, and think that thought through.
> =

> It turns out that _no_ drivers really need to save anything at all, excep=
t =

> the fundamental state that we cannot regenerate directly.

Agreed.

> Think about it.

Oh well, I'm the one to have killed save_state() in the first place
because I think it doesn't make sense most of the time.

> All the rest of the state is stuff that the driver knows to do, and it's =

> about _driver_ state, not hardware state.

In which case you don't need a special callback for that, at least not
named save_state() since most of that driver state is something the
driver should have already. Before you reply to that, pls read
further ...

> So let's just look at one really bad situation, which is USB. First off, =

> are we all in argeement that USB is important, and not likely to go away? =

> Are we also in agreement that it's entirely possible that the main system =

> disk is behind USB, and that it might be a good idea to support suspend t=
o =

> disk off such a thing?

Yup.

> So think about that. You're saying that is "impossible" to do, as is =

> apparently Pavel, because USB - in order to work - needs to have all its =

> DMA lists active.
> =

> I'm saying it's not impossible at all, and in fact, if you just shift you=
r =

> perceptions a bit, it turns out to fall right out of the whole "save the =

> state first, but don't shut down" approach.

But there is no state saving to do at all in most cases...

> I'll tell you the _simple_ solution first, just because the simple =

> solution actually explains what it is all about. It's not the perfect =

> solution, but once you actually understand the simple solution, it's also =

> very obvious how to get to better solutions - they're not fundamentally =

> different.
> =

> So the problem is, that we want to save the system image, but in order to =

> save it, USB has to be active, which means that the image we save is =

> "corrupt". The solution is to _let_ it be corrupt, and revel in the fact =

> that we don't need it to be some magic "snapshot in time".

Yes but... (see below :)

> What we do is:
> =

>  - we realize that all the USB command lists in memory are all totally =

>    uninteresting, BECAUSE WE GENERATED THEM OURSELVES. We say: "we will =

>    throw away all the command list on resume, instead of trying to =

>    continue using them".

Agreed and that's some stuff I partially fixed in the host drivers. At
suspend, pending commands get kicked with a specific error code.
 =

>    There's two things to notice: there's no _information_ in the command =

>    lists. We cannot have a USB event "active" over the reboot anyway, =

>    we'll need to re-connect all devices regardless, so any old command =

>    lists by definition don't actually _matter_.

Yeah though that's not entirely applicatble to STR where USB devices
stay connected but suspended. But that's almost a detail.

>    The other thing to notice is that none of this is "hardware state". So =

>    when we do the "save_state()" thing, that does _not_ imply saving off =

>    the USB command lists. Not at all. It means saving off things like the =

>    USB controller setup, things like where in PCI space its registers got =

>    mapped when we booted and did the original device discovery.

But there is mostly no save_state to be done for that. That is, pretty
much all we need to bring back the controller is already there in memory
and there is no specific ordering requirement with such a "saving"...
what I'm trying to say is that I think save_state is the wrong name for
a 2 step process, but I'll come back to that.;

>    We may choose to do that by just saving-and-restoring the actual PCI =

>    config space (which is easy, and you can use a generic helper for that=
, =

>    so that's probably the way to go), or we could just decide that we =

>    don't want to do even that, because we can just re-write the =

>    information using the device resources, which we already save off (and =

>    which, unlike things like the URB lists themselves, are _not_ =

>    changeable, so there's no problem with saving them off)

Yup.

> See? If you take this approach, you do actually end up saving off memory =

> that may be changing as you save it (imagine, for example, writing to dis=
k =

> the very memory that contains the URB that does the writing itself, and =

> that will change from "ready" to "completed" after the write), AND IT =

> DOESN'T MATTER. Because, on resume, you don't actually use it, you =

> re-create it all.

There is still a problem with the memory snapshot for STR. See below.

> Btw, most devices don't even _have_ this issue. Most devices don't _have_ =

> memory that ends up changing, or if they have, they're not actually going =

> to be part of the write-out, so when they resume, they don't need to worr=
y =

> about their memory being part of what got changed/freed.
> =

> Basically, devices that don't hold on to pointers to data areas in memory =

> will never see this issue. USB, in many ways, is the worst possible case =

> (a lot of other devices will obviously similarly do command structures in =

> memory, but a lot of _those_ do it purely to statically allocated memory, =

> so they can just clear the thing on resume, and start again).

Yes. We still need to keep the device-list and driver bindings and the
endpoints they created etc... since we don't need to actually _remove_
and _rediscover_ the block devices (ask Al Viro what he thinks of
letting a block device go a way and try to re-attach to the filesystem
later), but we can probably restore all the TD lists yes and trash all
URBs.

> See? Suddenly, by accepting the fact that you don't have to get an "atomi=
c =

> snapshot", you are freed to do things much more easily.

You do for _some_ things. =


> Now, what are the real problems? The thing I glossed over in the above =

> explanation is that the simple approach will leak memory. Once we're in =

> the "write memory" phase, what we can _not_ allow is to save off a memory =

> management description that isn't valid. So while we're in the writeout, =

> we cannot mark the temporary memory that we free after writeout as =

> "freed", because that could cause some _important_ memory data to be =

> incoherent. Similarly, we have to be very careful to allocate any new =

> memory (that will be thrown away) without corrupting the page/kmalloc =

> lists that we may be in the process of writing.

Yes. These and filesystem/block layer.

> In other words, it's a MM problem. We have to snapshot the MM state at =

> some point, and that's going to be the state we resume with, even if some =

> memory got freed, or some device temporary memory got allocated. We don't =

> care about the allocated, because when we resume, we're supposed to throw =

> it away _anyway_, but the point is, we have to throw it away whether we =

> strictly needed to or not.
> =

> Avoiding that _memory_leak_ is much harder than the device resume itself, =

> I believe. It needs some clever work, marking the memory that can be =

> safely re-used by having it in a special memory pool or something.. So =

> there are solutions, but they are definitely harder than not doing it.

So there are several issues at hand. One is the problem of the atomic
snapshot. At least _some_ data structures need to be snapshotted
atomically or the system will just blow out of its brains. The main
problem is block IOs. We need to have some kind of consistency of the
file system data structures (journals etc...) buffer cache, page cache,
and IOs vs. the memory snapshot. If we let IOs run when doing the memory
image, we might be in the middle of writing out a page or faulting one
in or that sort of thing and might end up with an "interesting"
incosistent state of various kernel data structures vs. actual stored
data structures (filesystem, swap, ..) on resume.

Thus we need at least _some_ kind of stop-it-all, then, snapshot.

That's exactly where the problem is... because that was the simple
approach, we did this freeze thing as a suspend callback considering
that suspending everything was a good enough way of "stopping it all".

That might be solvable by just acting at the block layer level instead
of drivers though... maybe sending a barrier/flush down all queues and
block them all, then taking the snapshot, and using a bypass to the
queue of the suspend device to save the image...

Now, there is _another_ problem which is different and might mandate a
separate callback for both suspend and resume, which is where I tend to
think you mixed up a bit the concept of save state and "prepare for
suspend" (and the opposite restore_state and "resume finished". See my
other email on the subject. It's essentially boils down to telling
drivers "heh, the system is about to start suspending, userland can't be
relied to be there anymore so if you need your userland helper to do
something, do it now, GFP_KERNEL might block forever now, thus
pre-allocate any memory you may need to operate from now on or at least
be ready to not use GFP_KERNEL, that sort of thing...). Typically
drivers that need to load firmware might want to pre-load it at this
point to make sure they have it at hand on resume(). That's the only way
you can resume safely if your root or swap device, for example, is on
that same device that needs a firmware d/l to come back. =


And of course the opposite at the end of the resume cycle.

Ben.
