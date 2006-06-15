From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 14:04:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
	<20060615204317.GC1849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615204317.GC1849@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> > > Why? We are saving state to memory, we should not need any other
> > > devices to do that.
> > =

> > Hell no, we're not.
> =

> ?

We're clearly saving state to _user_ space etc in some cases. That's not =

"memory", that is "pageable data and processes that can - and do - depend =

on other devices in ways that the kernel is not necessarily even aware =

of".

Just as the most obvious example, it's entirely possible that when you ask =

the graphics system to save its state, it might actually tell clients =

across a network that their window got occluded or something.

The same is true of various virtual devices that the kernel may not even =

know about. Network devices done as tunnels in user space etc. They may =

_look_ like system devices at the root of the device tree to the kernel, =

but that's just because the kernel has not a f*cking clue about what they =

are actually connected to.

So we're _not_ just saving data to memory. We're allocating memory (which =

means that we want to access every single device that may do write-back), =

and we're calling out to user space (which means that we _really_ don't =

know what a device may need).

> Okay, but graphical console means X these days, and -- being userspace
> -- needs special casing, anyway.

No it does not.

The point is, what I descibe - with a separate "save state but don't =

disable" - doesn't need any special casing at all, exactly because it =

doesn't do anythign STUPID.

> For fbcon, etc, no, we do not any other devices, so it actually works
> okay.

Yeah, Linux suspend is generally felt to "work ok".

Not.

> > In fact, done right, if you know the machine powers off, the final susp=
end =

> > should literally not be needed. "Remove power globally" is actually a v=
ery =

> > good suspend/shutdown mechanism that doesn't even need any driver suppo=
rt ;)
> =

> Actually, that's bad idea; some machines are unable to power down with
> devices still running.

Can you read my sentence again? "If you know the machine powers off"?

Trust me, if you remove power from the devices, that machine _will_ power =

down. It's that simple. It's not "maybe", or "if" or "unable to". It's =

basic physics.

Just removing power can often be the most efficient way to shut down. It's =

a perfectly fine algorithm, if the user asks you to do that.

That doesn't mean that it's always the right thing to do. It's just that =

it's an option: "save state to disk, then power down, and screw any PCI =

devices that don't think they know how to do it".

			Linus
