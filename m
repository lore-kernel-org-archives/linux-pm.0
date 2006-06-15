From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 09:53:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615161721.GB23859@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> > =

> > But I've said that before, and nobody cared last time either. For some =

> > reason, people continue to think that suspend should be a single phase, =

> > with us sending down "suspend" to each device.
> =

> Actually we already have
> =

> 	device_suspend()
> 	device_power_down()
> =

> calls (badly missnamed, some people believe), so it is two phase for
> now for s2ram. s2disk is more complex...

No we don't.

We have the above _calls_, but it doesn't matter one whit, since that's =

not actually what the calls _do_.

There's no driver infrastructure to call down to the driver to say "save =

your state, but don't suspend". None. Zero. Nada. Zip.

In order for this to actually _work_, you need to have

	device_save_state();
		.. calls down to each device, saving their      ..
		.. state BUT NOT SUSPENDING THEM!               ..
		.. This phase can return an error, and can do   ..
		.. things like memory allocations.              ..

		.. If an error happens here, we just return. We ..
		.. do NOT "restore" any state, because there IS ..
		.. NO STATE TO RESTORE - we've not actually     ..
		.. _changed_ anything ..

		.. In other words, for a regular PCI device     ..
		.. this function does "pci_save_state()". Not   ..
		.. _anything_ else!                             ..

	save_image_to_disk();
		.. NONE OF THE DEVICES ARE SUSPENDED! So all the  ..
		.. idiotic crap about trying to keep the "suspend ..
		.. device" alive would be the obvious crap it is! ..

	suspend_console();
		.. Again! None of the devices have actually been ..
		.. physically SUSPENDED, so they're all working, ..
		.. so we could have done "printk()"s etc all the ..
		.. time until the next call:                     ..

	shut down CPU's, and disable interrupts HERE!

	suspend/shutdown_devices();
		.. This is the stage where devices are literally ..
		.. actyally SUSPENDED. Not before. Not after.    ..
		.. Before this, they're not frozen, they're not  ..
		.. disabled, they're not suspended. They still   ..
		.. work perfectly fine, and were used for both   ..
		.. console output and disk saving. The "save the ..
		.. state" callback did just that: it SAVED THE   ..
		.. STATE. It didn't change it.                   ..
		.. This phase cannot return an error ..

See? WE DO NOT DO THIS. I told people we needed to do this _years_ ago. I =

tried to push through the two-phase suspend. I tried to explain why. I =

clearly failed, because we do _nothing_of_the_sort_ right now.

Instead, the "please suspend" thing to the devices is a single-phase "put =

yourself into D3", with no support for a separate "please save your state" =

call. Crap.

The include files talk about PM_FREEZE, but that's a load of crap. The =

whole point is to _not_ freeze things, so that you can still access the =

device and save your disk image or your printk messages to it. It also =

seems designed to _either_ "freeze" the machine or "suspend" the machine, =

but not both.

In other words, it's misdesigned. And I've talked about this before. Ijust =

googled for it, and I saw myself ranting about this very same issue a year =

ago (and back then, I also said "as I've said before").

			Linus

PS. I'll also argue that we'd probably be better off with two separate =

phases on resume too, partly to just be consistent, but partly because we =

want to do some things with interrupts disabled, and some things with =

interrupts enabled. Again, we have this INSANE situation where we call the =

same "resume" function for _different_ devices first with interrupts =

disabled, and then with interrupts enabled. Gaah! Idiotic, and hard as =

hell to even understand!

But I think that's actually the lesser of two evils.
