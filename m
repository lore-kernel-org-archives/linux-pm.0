From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 13:49:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606211345150.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
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

> Isn't it true the only a small minority of drivers need to do anything
> special during the save_state() callback?  In most cases all the necessary
> state is already stored in the driver.  So instead of making this a
> callback in struct device, how about creating a pre_suspend notifier chain
> for drivers to register on?

No. That would be horrible. Yet another notifier to register on, rather =

than just adding a function pointer to the structure that you need to =

initialize _anyway_.

> And ditto for freeze()/unfreeze() -- almost no drivers need to handle =

> them.

So leave the function pointers as NULL. Problem solved.

> Hmm.  Be careful here.  The power level really isn't part of the "state"  =

> that gets saved by save_state(), is it?

Why wouldn't it be?

That said, I think most drivers can just assume that their normal device =

state is always D0 and they'll work, so in that sense they don't need to =

"save" it.

> So drivers will have to be very careful, because when restore_state() =

> starts the device could be in any of several possible states.

That's nothing new. It's no different from what we have now, in fact (for =

exactly the same reasons).

It's also no different from what we have now at driver initialization =

state.

> There's an unforunate asymmetry in the design.

I don't know why people harp on symmetry so much.

The fact is, saving and restoring driver state is fundamentally =

assymmetric. In one case, the device works in a known state before and =

after. In the other, it doesn't. =


Big deal. But as it is, I actually would suggest just keeping the current =

"resume()" naming, there's no huge reason to change it (and, in fact, =

semantics won't even change). It's the _suspend_ part I want split up.

		Linus
