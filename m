From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 15:04:04 +1000
Message-ID: <1150866244.12507.141.camel@localhost.localdomain>
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
	<Pine.LNX.4.64.0606202125460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202125460.5498@g5.osdl.org>
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


> For example, the _real_ suspend case (ie non-snapshotting case) has no =

> reason what-so-ever (apart from debuggability) to really stop any queues =

> etc. So if you want to do _real_ suspend, what you should do is exactly =

> what you propose: make it built up around the device model. Except you =

> don't actually need to empty or stop any queues, you just stop the device=
s =

> from handling them.

Not stopping queues but not servicing them instead ... hrm ... not that
much difference if you ask me :)

Especially with the network stack where if you really just stop
servicing, you'll trigger all sort of things in the higher levels that
you'd rather avoid (like transmit timeouts etc...), better tell it the
link is down and detach your queue to be left alone. (Or drop packets,
but in any case, it's easy, a matter of a call or 2 to tell the network
layer to not call your xmit anymore, and the network layer will do the
locking for you, so you don't need an addition spinlock to make sure
your xmit() was not just concurrently running with your suspend routine)

In fact, there is very little difference in practice as far as the
driver implementation is concerned. I don't care either way as long as
the driver is hardened against incoming things (requests, ioctl,
whatever) happening after it's been suspended...

In the case of block drivers, you really need to make sure that all
pending requests (tagged commands etc...) have completed and the easiest
way to do that in many cases (at least with IDE) is to have suspend
itself be a request in the queue that acts as a full barrier and causes
the driver to stop servicing the queue after the suspend request has
completed, a bit like if didnt't complete until resume in fact :) That's
how I did it and that fixed gazillion of problems back then.

In the case of fbdev, since you provice a memory mapped access to your
device memory to clients, you really need to tell them to stop mucking
around. We do that with the callback I added for fbcon, and for X, well,
that's what the console switch does (It's not perfect, as you rightfully
noticed, but it works fine will all sort of legacy crap including X
since forcing a switch to a console in KD_TEXT mode pretty much
guarantees the kernel gets back owership of the gfx hardware).

Then there are things we don't handle today and that we should handle:

Things like infiniband etc... who can map device memory in user space
will need additional mecanisms to sync with userspace to gets it's dirty
fingers off the hardware (unless you consider userspace freeze as an ok
solution). Same with sound.

Etc...

Ben.
