From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 15:01:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151446350.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<20060615211031.GA2255@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615211031.GA2255@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> Okay, so you are saving state, then changing it. Now.. you are right
> that for most devices it is possible to separate state that does not
> change from state that changes; that is okay but lot of work.

It's ok _by_definition_ for all work, since any changes we do are done by =

ourselves, so it's "not important".

I think that a lot of problems that people look at aren't actually =

"device" problems at all, but "memory management" problems. =


The fact is, suspend-to-disk is really nasty from a memory management =

standpoint, since the image you save to disk is not the "final" image in =

the same sense that the STR image is (or the APM suspend image is).

That means, for example, that if you save-and-restore temporary pointers =

in your device status, you need to do something about the =

_memory_management_ problems, but that has really nothing to do with =

saving and restoring the hardware device state.

(And yes, I agree that memory management problems are hard, I'm just =

saying that they are an independent issue. They aren't hardware state per =

se, they are "driver state", and, like all the other VM issues, it's nasty =

to try to restore memory allocations that can change).

But if you realize that memory management problems are _separate_ from =

device state issues, you already get a much better handle on the problem. =

For example, you immediately realize that _that_ is the biggest difference =

between "suspend-to-RAM" and "suspend-to-disk", and that realization means =

that you understand that there are several possible solutions:

 - some drivers might choose to not support suspend-to-disk as well as =

   they support suspend-to-ram. They might, for example, decide that if it =

   was a disk suspend, they will simply throw away all the allocations =

   that could have been temporary allocations, and jst re-allocate all =

   temporary storage. This obviously means that you leak some memory at =

   resume time, but it's an alternative to saying "I won't do any STD at =

   all!"

 - another approach that a driver might choose to do is to free all its =

   temporary queues when doing a "save" event, and start using a separate =

   memory pool afterwards - and then on resume, just clear the whole =

   memory pool, since it's not "trustworthy" any more (ie it was saved =

   with some random state that you thus can't actually trust any more)

 - a final approach is actually push some of this into the VM layer, and =

   have the "suspend pool" be something that the VM knows about, and that =

   a resume will simple clear. Every single allocation after the suspend =

   was started would be from this "suspend pool", and that, together with =

   a simplified #2 above (no per-driver pool, the driver just clears all =

   its temporary pointers at "save" time, and knows that any subsequent =

   allocations will be throw-away at resume time) would also probably =

   work.

But notice how this is about _memory_, not about the actual hardware =

device state?

> Okay, so .. in your model you can simply save state *during driver
> init*, right at boot.

Basically.

Except in practice user actions/setups can change it, and in practice you =

really do want to save it later, because you may not need to save it at =

all. =


But yes, the basic idea is that there's two classes of hardware state: =

there's the part you have to save, because you can't re-generate it (and =

that, by definition, is _not_ something that changes as part of normal =

operations, since if it was, the driver _could_ just re-generate it at =

resume), and then there's the stuff that can be regenerated.

You obviously shouldn't save the stuff that you can re-generate. You =

shouldn't save it for two reasons:
 - it's unnecessary
 - it's wrong (because it may change due to IO happening).

See? =


		Linus
