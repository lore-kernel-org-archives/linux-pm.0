From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 08:54:53 +1000
Message-ID: <1150930493.16303.21.camel@localhost.localdomain>
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
	<1150866244.12507.141.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606210809380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210809380.5498@g5.osdl.org>
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

On Wed, 2006-06-21 at 08:15 -0700, Linus Torvalds wrote:
> =

> On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > Not stopping queues but not servicing them instead ... hrm ... not that
> > much difference if you ask me :)
> =

> A _huge_ difference.
> =

> You still don't seem to see it:
> =

> > In fact, there is very little difference in practice as far as the
> > driver implementation is concerned. I don't care either way as long as
> > the driver is hardened against incoming things (requests, ioctl,
> > whatever) happening after it's been suspended...
> =

> The difference is _exactly_ on the driver level.
> =

> If you stop the queues, most drivers don't have to care any more. They ar=
e =

> quiescent _without_ any driver impact what-so-ever. =


(Note that I'm talking about STR here ...)

As long as there is a notion of "queues" separate from the driver itself
that can be stopped by some global thing... might be true for the block
layer, might even be true for the network layer (but in that case, it's
really easy for the driver to do with a single call), is not true with
everything going through ioctl's (unless you have frozen userland and no
internal kernel daemon is hitting driver ioctl's), and other direct
callbacks that don't go through a "queue"... =


In many cases, it's actually fairly easy to harden the driver tho :)

Ben.
