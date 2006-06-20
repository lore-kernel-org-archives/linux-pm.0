From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 15:06:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606201453160.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<200606182054.36975.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606182054.36975.david-b@pacbell.net>
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



On Sun, 18 Jun 2006, David Brownell wrote:
> =

> Do you see the case of consoles staying usable as being like no-spindown?
> Or something different?  (Some of what you've said implied to me switching
> to a different model than freezing driver stacks...)

I don't think it's necessarily so much about consoles per se. I suspect =

99% of all console-devices wouldn't even have a freeze/unfreeze action, =

since they generally don't do DMA anyway (but I think it would be best to =

call "console_suspend()/console_resume()" around the actual disk writing =

anyway).

I think the spindown example isn't even special. A lot of devices would do =

suspend by just shutting off, and a lot of devices take several =

milliseconds to power up and discover, even in the absense of any moving =

media. =


The fact is, "shut down" and "freeze for a moment" are just fundamentally =

different ops. Not just to disks. =


Think just about any USB device. suspend might try to keep power active =

(hey, if you want the keyboard to wake thigns up, it had better), but if =

you have a USB camera, a "freeze" is potentially totally different from a =

"suspend". A "freeze" would do absolutely nothing (it's a USB host =

controller issue), while a suspend might actually shut the dang thing =

down.

Yeah, for suspend-to-disk and a camera, maybe you don't care. But my point =

is, that disks are NOT special. The only thing that makes them special =

at all in your world-view has nothing to do with the device itself, or the =

action itself, but simply that you realize that "suspend-to-disk" will =

need to wake it up afterwards.

But for all you know, the suspend-to-disk will need the random USB device =

too - security signatures from USB keycard readers etc to enable disk =

access aren't actually all that sci-fi (and some day it may even be the =

camera that validates you).

So once you get over that hump, you realize that the "freeze" thing =

actually _is_ different from "shut down". =


> > And the special cases may not even be hard. For example, take the disk =

> > case above. Disks are generally _trivial_ to suspend. You just basicall=
yt =

> > tell them to. You're done.
> =

> Most pieces of hardware are pretty easy to stick into low power states.
> What's hard is getting everything quiesced, and ready to be suspended.
> (Which is the guts of what a freeze does.)

That's not even true. A lot of hardware needs _lots_ of care to come back =

from a real low-power event. Like reloading firmware etc.

			Linus
