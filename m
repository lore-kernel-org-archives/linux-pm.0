From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 09:03:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606210844460.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211130350.6700-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606211130350.6700-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jun 2006, Alan Stern wrote:
> =

> There is one small point they do have in common.  For those systems where =

> power doesn't get turned off completely during STD, you will want to =

> enable remote wakeup (just as in STR).

So, let me re-iterate my view of how things really _should_ work.

 - we should have _suspend_ support. This is the "real suspend" thing, ie =

   support for putting the machine to sleep, and it is totally independent =

   of any snapshotting capability what-so-ever.

   The operations for suspend support is literally:

	- save_state (or, as Ben prefers, "prepare_to_suspend", but that's =

	  a naming issue, and having listened to his arguments, I think he =

	  prefers that name because he's confused)

	- suspend()

	- resume() (and, to clarify my position, let's call it just =

	  "restore_state()" here, although I don't actually think renaming =

	  it is worth-while, but _mentally_ you should think of the =

	  "resume()" function as a state _restore_, not a "resume", =

	  exactly because it's not actually paired with the suspend, but =

	  with the "save_state()" function)

 - we should have a logically and physically totally independent =

   "snapshot" support in the device layer, with two operations:

	- freeze. Which would normally be a no-op, or a DMA engine =

	  (or "receive path") shutdown

	- unfreeze. Which would normally be a nop-op, or just resuming the =

	  DMA engine or receive path.

And the thing is, all these operations are really very different =

operations, and the most important part to realize is that they are fairly =

INDEPENDENT.

But being independent very much means that you can combine them. So, a =

normal _real_ suspend would literally be basically this sequence:

	for_each_dev()
		save_state()
	for_each_dev()
		suspend();
	system suspend()
	for_each_dev()
		restore_state()

note how the normal suspend wouldn't do any freezing at all (at least in =

theory - in practice it may well want to quiesce the machine, and =

obviously the driver "suspend()" part will result in it stopping handlign =

any _requests_). But at least from a conceptual standpoint, there are =

_zero_ VM games, no frozen processes, no nothing. =


(Also, _conceptually_ the X handling is all perfectly regular, and is part =

of the "save_state()" and "restore_state()" loop, but then from a pure =

implementation standpoint you might make it a separate save/restore around =

the whole thing).

Ok, so what happens in a suspend-to-disk? The basic loop is

	for_each_dev()
		save_state()

	freeze upper layers (shrink VM, user crud, filesystem read-only, =

		yadda yadda)
	for_each_dev()
		freeze()
	snapshot
	for_each_dev()
		unfreeze()
	unfreeze at least enough to be able to write
	write snapshot to disk

	.. shutdown ..
	.. reboot ..
	restore snapshot from disk
	for_each_dev()
		restore_state()


See? The "..shutdown .." part is whatever you make of it, you _can_, if =

you want to, just make it

	for_each_dev()
		supend()
	shutdown();

but on other hardware/circumstances it might be a more normal "turn power =

off" kind of shutdown. All up to you, and TOTALLY INDEPENDENT of the basic =

operations.

Also, notice how the only thing hat is _really_ common between the two is =

not the suspend at all, but the "save_state()" and "restore_state()" =

loops. THOSE are fundamentally shared, but neither of them actually has =

really anything at all to do with the suspend itself, with WOL, or =

anything else.

(This also clarifies why "save_state()" and "suspend()" are really =

different operations, and why "prepare_to_suspend()" is actually not a =

great name - it may not be paired with a suspend at all, if you just shut =

down the machine: it would be paired with a "shutdown()").

			Linus
