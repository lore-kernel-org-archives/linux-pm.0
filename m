From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 22:23:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
	<200606152135.49527.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606152135.49527.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, David Brownell wrote:
> =

> The main reason a network driver would be interesting from the PM
> perspective is that it might be able to issue wake-on-LAN events.

I think we do that separately as a totally user-land "prepare to suspend" =

functionality, long before we even get to suspend, right now?

Maybe I'm confused. I've never used it, but from my understanding of =

drivers, I thought that was one of the things you would do with ethtool.

(ie this particular facility very much has that "prepare" phase already ;)

> > All the rest of the state is stuff that the driver knows to do, and it'=
s =

> > about _driver_ state, not hardware state.
> =

> USB does however rely on hardware state during true sleep states.
> For example, that hardware state is what makes remote wakeup work.

But that's state that we already know, no? =


> > Are we also in agreement that it's entirely possible that the main syst=
em =

> > disk is behind USB, and that it might be a good idea to support suspend=
 to =

> > disk off such a thing?
> =

> No.  Last time this was discussed, the conclusion was that it was not
> currently supportable.    The issues are shared with all removable media
> volumes:  MMC/SD, Firewire disks, IDE cartridges, external SATA, and more;
> not just USB.
> =

> One of the basic issues is that _resume_ from such media is problematic.

I agree that it probably won't work now, and that it's certainly one of =

the worst cases. It's obviously why I chose it.

You may call it "best" from a PM standpoint, and I'll agree with you from =

a "discuss the issues" standpoint, but I think I'll still just call it =

"worst" from a purely complexity standpoint ;^/

That said, I think it's not unreasonable to want to be able to resume from =

a USB disk at least in theory. Even if the rules very much would be that =

you'd better not move that disk to any other machine, or do other strange =

things. I think those rules would be _very_ understandable to your average =

user, who wouldn't really even expect it to work.

(Evil thought: It _would_ be pretty cool if you could take your work with =

you home by moving the resume disk to an identical machine at home ;)

> >    There's two things to notice: there's no _information_ in the comman=
d =

> >    lists.
> =

> ... except from buggy device drivers which didn't abort all their pending
> commands when they got told to suspend.  (OK, that's the current model,
> not quite what you're talking about here, but this is a real-world case
> that currently gets handled that way.

Yeah. I also suspect that in practice it would actually work, because the =

devices would have been quiet, so the fact that we didn't suspend then =

didn't actually matter.

(That's the same thing we now do for the suspend disk: whether we just =

avoid suspending it, _or_ we re-animate it before writing the suspend =

image to it, it obviously ends up beign active while the write happens. =

Nobody really _cares_, because it doesn't really affect any end result in =

practice for something simple like IDE).

> Going that "re-write" route implies the driver init and re-init logic
> gets handled much more cleanly than it ever has been.  It's a fine notion,
> but currently not as practical as the save/restore config space approach.

I do believe that for a lot of drivers, there really is no difference.

You see all the complexities of USB, and that really _is_ not just the =

worst case, it's generally a million times worse than just about any other =

driver. =


			Linus
