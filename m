From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 17:27:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606151720350.10244-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
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

On Thu, 15 Jun 2006, Linus Torvalds wrote:

> On Thu, 15 Jun 2006, Alan Stern wrote:
> > =

> > If this happens you're already in trouble.  It doesn't matter that the =

> > unrelated devices aren't suspended; the fact that they have already sav=
ed =

> > their state and will no longer respond to outside stimuli means they ca=
n't =

> > be used.  Not to mention that their I/O queues won't be running.
> =

> THEIR IO QUEUES ARE RUNNING!
> =

> Why are people being dense and stupid? I told you in the very first =

> explanation that the IO state isn't suspended by "save_state()".
> =

> "save_state()" would not disable the device. It would not disable the =

> queues. The device would remain usable, and 100% functional.

Here's what you actually did say:

-----------------------------------------------------------------------
> To have DMAs stopped, you need to "freeze" the devices.

No you don't. =


You need to stop the high-level _queues_, but that's something totally =

different from actually stopping the _devices_.

So, for example, you want to make sure that nobody is writing to the disk =

cache, or reading from the disk, or writing to it (apart from the thing =

that writes the image, of course) any more.

But that's fundamental: and it has absolutely zero to do with device =

suspend (although you do want to tell the device about it - a number of =

devices that do polling even in the absense of user input should probably =

take the hint from "save your state").

The fact that you equate "suspend the devices" with "stop doing IO" shows =

how you think at the wrong level.

The "stop doing IO" is at a much higher level.
-----------------------------------------------------------------------

So your recipe for suspending should really look more like this:

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

	device_stop_DMA_and_IO_queues();
		.. This is what we have been calling FREEZE	..
		.. It can be implemented as SUSPEND if the	..
		.. driver wants to				..

	prepare_memory_snapshot();

	device_restart_DMA_and_IO_queues();
		.. This is a form of RESUME			..

	save_image_to_disk();
		.. NONE OF THE DEVICES ARE SUSPENDED! So all the  ..
		.. idiotic crap about trying to keep the "suspend ..
		.. device" alive would be the obvious crap it is! ..

It's not terribly different from what we do now.

Alan Stern
