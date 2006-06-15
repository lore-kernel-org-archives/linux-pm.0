From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 18:59:09 +0200
Message-ID: <20060615165909.GE23859@elf.ucw.cz>
References: <Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > But I've said that before, and nobody cared last time either. For som=
e =

> > > reason, people continue to think that suspend should be a single phas=
e, =

> > > with us sending down "suspend" to each device.
> > =

> > Actually we already have
> > =

> > 	device_suspend()
> > 	device_power_down()
> > =

> > calls (badly missnamed, some people believe), so it is two phase for
> > now for s2ram. s2disk is more complex...
> =

> No we don't.
> =

> We have the above _calls_, but it doesn't matter one whit, since that's =

> not actually what the calls _do_.
> =

> There's no driver infrastructure to call down to the driver to say "save =

> your state, but don't suspend". None. Zero. Nada. Zip.
> =

> In order for this to actually _work_, you need to have
> =

> 	device_save_state();
> 		.. calls down to each device, saving their      ..
> 		.. state BUT NOT SUSPENDING THEM!               ..
> 		.. This phase can return an error, and can do   ..
> 		.. things like memory allocations.              ..
> =

> 		.. If an error happens here, we just return. We ..
> 		.. do NOT "restore" any state, because there IS ..
> 		.. NO STATE TO RESTORE - we've not actually     ..
> 		.. _changed_ anything ..
> =

> 		.. In other words, for a regular PCI device     ..
> 		.. this function does "pci_save_state()". Not   ..
> 		.. _anything_ else!                             ..
> =

> 	save_image_to_disk();
> 		.. NONE OF THE DEVICES ARE SUSPENDED! So all the  ..
> 		.. idiotic crap about trying to keep the "suspend ..
> 		.. device" alive would be the obvious crap it is! ..

This does not work, sorry, stop right here.

To save image to disk, you need to have an _image_. To have an image,
you need atomic copy, so that it is consistent. To achieve atomic
copy, you need other CPUs stopped, and you need DMAs stopped.

To have DMAs stopped, you need to "freeze" the devices.

> See? WE DO NOT DO THIS. I told people we needed to do this _years_ ago. I =

> tried to push through the two-phase suspend. I tried to explain why. I =

> clearly failed, because we do _nothing_of_the_sort_ right now.

I believe your solution does not work, sorry.

> PS. I'll also argue that we'd probably be better off with two separate =

> phases on resume too, partly to just be consistent, but partly because we =

> want to do some things with interrupts disabled, and some things with =

> interrupts enabled. Again, we have this INSANE situation where we call th=
e =

> same "resume" function for _different_ devices first with interrupts =

> disabled, and then with interrupts enabled. Gaah! Idiotic, and hard as =

> hell to even understand!

Yes, this part is misdesigned.
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
