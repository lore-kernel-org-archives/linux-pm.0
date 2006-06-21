From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 14:45:31 +1000
Message-ID: <1150865132.12507.131.camel@localhost.localdomain>
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
	<1150862396.12507.103.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
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


> I absolutely agree that on a _suspend_ level, it makes sense to do it =

> device-model-centric.

Ok.

> But I think the basic disconnect here is that I simply do not believe tha=
t =

> the "image save" has _anything_ to do with "suspend".

Ok, well, I can get that.

> Let's cut right to the chase:
>  - I think "image save" is snapshotting
>  - I think snapshotting is well-defined (and possibly useful) without any =

>    suspend activity what-so-ever.
>  - I think that anybody who confuses and mixes the two is (a) missing the =

>    real potential of snapshotting, but even more importantly (b) making i=
t =

>    much more complex by having the wrong mental model.

I'll say a) then :)

> Mental models are supremely important. Often you can say that they don't =

> actually matter, because the end result should be the same, but the fact =

> is, they have a huge impact on _how_ people think, and on how you get to =

> the end result. =

> =

> The fact is, suspend has nothing to do with the "save to disk" part. I =

> think the whole Linux kernel suspend code has been _destroyed_ by the STD =

> code. Exactly because the STD people have thought that the save-to-disk =

> part was somehow part of "suspend", when it has _nothing_ to do with it =

> other than a very incidental connection.

I wouldn't go that far. The linux suspend model has been designed for
STR. STD was a late addition (including that "freeze" argument). Most
drivers don't care. There haven't been much damage :) The requirement of
blocking device providers (call them queues if you like), comes from
STR, not STD in the first place. It comes from the need of not having
something try to get your driver to muck around with the hardware after
said hardware has been powered off basically. It's deadly on various
platforms including most powerpc.

It's been sort-of an afterthough that a "degraded" suspend could be used
to stop DMA's and allow a fairly reliably snapshot for STD.

There are two other circumstances where that notion of "freeze" has
proven useful in the sense of "stop all DMA activity" (which is a subset
of the snapshot requirements): kexec and various cases of cpufreq (where
DMA cache snooping is lost during the frequency transition).

Now, I agree that wanting to completely separate those two concepts do
make sense. But that doesn't remove the need of suspend() to suspend
both the device ... and the driver :) That is to have the driver ensure
that nothing will hit the hardware. Yes the kernel can help by quiescing
higher level things, but I don't think relying entirely on that is safe
and that doesn't handle the partial suspend and dynamic power management
issues.

But if you want to separate the requirements of snapshotting from the
requirements of suspend, then ok, I can buy that. It's yet to be figured
out which one will best fit the needs of kexec and those cpufreq
implementations, but it does make sense, I agree.

> The sad part is that STR (aka "real suspend") has been made much more =

> complex because allt he things THAT HAVE NOTHING TO DO WITH SUSPENDING A =

> DEVICE have been pushed into the STR path.

No, as I said earlier, most of the ideas of stopping device queues have
been pushed (and in part by myself) for STR. Because I didn't want to
muck around with higher level too much (think about trying the make the
entire network stack quiescent) and because I think it's a better model
in the long run since it allows fine grained suspend of individual
devices or parts of the tree. I agree that some of the stuff in things
like IDE could use "helpers" so that the driver job of quiescing queues
etc... boils down to calling that helper to tell the upper level to shut
up, but it should still orginate from the driver imho.

That's what I did for fbdev's for examples: radeonfb suspend() gets
called, it tells the fbdev layer that the framebuffer is going offline,
and then suspends itself. The fbdev layer will then avoid touching an
offline framebuffer (but still stores console output from prinkt & all
in the text/attribute buffer so that the display can be completely
restored  _with_ up to date console infos as soon as radeonfb tells
fbdev that it's back online).

> Think about the "snapshotting" idea for a while. =

> =

> I claim, that the only _sane_ way to do STD is to create a snapshot, and =

> resume that snapshot. But notice how "suspendign" isn't part of that =

> picture AT ALL. Really. =


Yes, I agree again. I think we should leave STD alone for a little while
and solve the suspend STR issue first. I think that's where we tend to
disagree. About the need for drivers to block icoming "requests" (in a
large sense) and flush pending ones.

> It's a perfectly valid operation to create a snapshot AND CONTINUE =

> RUNNING! You can create a million snapshots, and only later decide that =

> you want to resume one of them after you've rebooted much later.

Yes. I can get that. There _is_ some state in drivers relative to
clients that need to be taken are of and resuming from a snapshot is
also a fairly differnet operation than resuming from a hard suspend
though (due to hardware being in a totally different state) but yes.

> The current code mixes the two operations up. I've said so from the =

> beginning. The current code seems to think that "suspend" should have =

> something to do with creating a snapshot, AND THE CURRENT CODE IS WRONG!

> Dammit, I'm right about this.

Please, re-read my above explanation :) The current code was done for
STR and it was just decided afterward that what it does could be "good
enough" for STD....

> (And btw, I've done device snapshotting that works like the above, and =

> taking snapshots every 5 minutes or so. It's damn useful - you can go =

> backwards in time when something goes wrong, and re-examine what went =

> wrong. Admittedly, that was done with simulator software - and hardware - =

> but the point is, snapshotting and continuing to run isn't even all that =

> strange, and it sure as hell isn't an invalid operation).
> =

> As long as you continue to confuse "suspend to disk" with "real suspend", =

> you're not going to see the point. Just FORGET about the fact that STD is =

> called "suspend". It has nothing to do with reality. STD has no suspend i=
n =

> it what-so-ever.

Yes, I do get that.

> In STD, you shut the damn machine off, there's not a whiff of real power =

> management anywhere, and device power management is totally unnecessary =

> and useless for it.

You don't necessarily... with some machines, you can acutally STD and
put the machine into some weird S4 state which isn't completely off as
it keeps the ability to do remote wakeup from the network for example,
but it's not a very relevant difference I agree.

So your approach to STD would be something like:

1- stop subsystems
2- driver freeze (in the sense to stop DMA's and other horrors for
snapshot, only some drivers care, most don't)
3-snapshot
4-driver thaw, subsystems stay frozen (that is VM, filesystems,
userland)
5-shutdown or driver suspend S4

The only little possible issue there is that the subsystems being still
stopped, some drivers may need to have a hard time doing 5 if they need
to send requests to their own hardware for things like hard disk
spindown, and they happen to use the block layer request queue for that
(pumping device specific requests into it). I'm not sure how SCSI
handles it's queuing between block requests and translated-to-scsi
requests, but one need to make sure that subsystem freeze will have
blocked the former from filsystem/vm/... and not the later so that the
driver can still talk scsi to the devivce for the actual
suspend/shutdown step (suspend and shutdown are very similar in a lot of
platforms, like handhelds... in fact, even desktops/laptops want
something similar in some cases, like properly flushing the disk which
is achewived by spinning it down before it loses power, etc...)

Ben.

 =
