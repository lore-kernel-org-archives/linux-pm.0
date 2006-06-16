From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 16:18:02 +1000
Message-ID: <1150438682.23600.34.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
	<200606152135.49527.david-b@pacbell.net>
	<Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
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


> I think we do that separately as a totally user-land "prepare to suspend" =

> functionality, long before we even get to suspend, right now?
> =

> Maybe I'm confused. I've never used it, but from my understanding of =

> drivers, I thought that was one of the things you would do with ethtool.
> =

> (ie this particular facility very much has that "prepare" phase already ;)

Yes, pretty much. The fact that WOL has been requested hsa to be
somewhat stored in the driver instance data since it affects the way the
chip is put to suspend, but that's it. It's pretty much orthogonbal to
everything else.

> > USB does however rely on hardware state during true sleep states.
> > For example, that hardware state is what makes remote wakeup work.
> =

> But that's state that we already know, no? =


I'm not sure I've totally followed the issues involved there... Again,
"state" is used to mean way too many things. We should step back and
look _precisely_ what USB does and what can cannot be done.

But then, again, we are hitting a fundamental difference between STR and
STD... With STR, we prepare, we suspend, we come back, wahtever we did
is still there in memory, we know what we did and where we come from,
our lists of urbs, TDs, EDs etc... are still sane etc...

With STD, there is this "magic" step after prepare() and before
suspend() where system memory will be snapshot.

That means that at a point in time, the USB chip is possibly doing all
sort of things including DMA'ing to the HCCA in memory, scrubbing ED and
TD lists, transmitting things, etc...

If we want any chance of resuming properly (and not leaking memory), we
need at least _some_ sychronisation with the atomic snapshot of memory.
We need to make sure we aren't in the middle of processing some packets,
that is all possible upstream "clients" submitting IOs (block, etc...)
have stopped doing so and we have flushed the necessary queues.

That means that our child drivers (who are the ones submitting those
IOs) are sort-of quiescent. For block devices, that looks a bit like
your "phase 2" thing, though I'm not quite sure yet wether you envision
that involving a driver callback or purely at the core. But there are
plenty others we need to be a bit careful with. I think it boils down to
wether a given driver queue holds lossy or lossless informations.

 - Block devices must be lossless. There must be a strict
synchronisation between the atomic memory image (page cache, buffer
cache, etc...) and what's on the platter or filesystems might be corrupt
etc...

 - Network devices are lossy, we can just "pull the plug" and be done
with it

 - etc... (policy to be defined per device class I suppose)

> > No.  Last time this was discussed, the conclusion was that it was not
> > currently supportable.    The issues are shared with all removable media
> > volumes:  MMC/SD, Firewire disks, IDE cartridges, external SATA, and mo=
re;
> > not just USB.
> > =

> > One of the basic issues is that _resume_ from such media is problematic.
> =

> I agree that it probably won't work now, and that it's certainly one of =

> the worst cases. It's obviously why I chose it.

It should be workable though, I agree. Same with firewire. Heh, after
all, it works in <insert competition> operating systems :) And there is
a lot of incentive nowadays to boot machines on things like USB sticks
etc...

> You may call it "best" from a PM standpoint, and I'll agree with you from =

> a "discuss the issues" standpoint, but I think I'll still just call it =

> "worst" from a purely complexity standpoint ;^/

Yup. But if we get that right, we are pretty confident that we'll have
everything else right :)

> That said, I think it's not unreasonable to want to be able to resume fro=
m =

> a USB disk at least in theory. Even if the rules very much would be that =

> you'd better not move that disk to any other machine, or do other strange =

> things. I think those rules would be _very_ understandable to your averag=
e =

> user, who wouldn't really even expect it to work.

Agreed. It might even be possible to "detect" misuse (filesytems, before
suspend, could write a marker that gets cleared on mount or something
like that, and check on resume and issue a big fat warning (remounting
r/o and invalidating all cached pages / inodes is an option).

> (Evil thought: It _would_ be pretty cool if you could take your work with =

> you home by moving the resume disk to an identical machine at home ;)

Yeah, it would be :) Let's not dream to far right now :) It might even
be possible in _some_ circumstances but heh...

> > >    There's two things to notice: there's no _information_ in the comm=
and =

> > >    lists.
> > =

> > ... except from buggy device drivers which didn't abort all their pendi=
ng
> > commands when they got told to suspend.  (OK, that's the current model,
> > not quite what you're talking about here, but this is a real-world case
> > that currently gets handled that way.
> =

> Yeah. I also suspect that in practice it would actually work, because the =

> devices would have been quiet, so the fact that we didn't suspend then =

> didn't actually matter.

Yeah, we are often lucky. =


> (That's the same thing we now do for the suspend disk: whether we just =

> avoid suspending it, _or_ we re-animate it before writing the suspend =

> image to it, it obviously ends up beign active while the write happens. =

> Nobody really _cares_, because it doesn't really affect any end result in =

> practice for something simple like IDE).
> =

> > Going that "re-write" route implies the driver init and re-init logic
> > gets handled much more cleanly than it ever has been.  It's a fine noti=
on,
> > but currently not as practical as the save/restore config space approac=
h.
> =

> I do believe that for a lot of drivers, there really is no difference.
> =

> You see all the complexities of USB, and that really _is_ not just the =

> worst case, it's generally a million times worse than just about any othe=
r =

> driver. =

> =

> 			Linus
