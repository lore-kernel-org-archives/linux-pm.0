From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 10:15:57 +1000
Message-ID: <1150935357.16303.51.camel@localhost.localdomain>
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


How do you handle things like partial tree suspend, runtime suspend of a
given device and it's subtree etc.... ? the needs for power management
go beyond just sytem suspend and drivers need to be capable of handling
it. There won't always be an allmighty god to stop "subsystems" above
the driver to send requests to it if the driver itself doesn't ask for
that to happen....

(Oh and again, I'm strictly speaking about STR here). What annoys me the
most is that you seem to be doing some kind of special casing of system
suspend saying that drivers don't have to care about proper blocking of
their "request queues" (again, this is a very generic term that ecompass
not servicing a block device queue, telling the network stack to not
call xmit, blocking or refusing on ioctl calls, etc etc....) because
"something" above them will have prevented it from happening.

That's what I don't agree with basically. Drivers need to do this little
bit of work to make sure they can be safely suspending in a fully alive
environment. It's not very hard to do (and those "subsystems" above
drivers, when they exist at all, can well provide a help the driver can
call to say "heh, I'm sleeping, don't bother me"... heh, they can even
provide a callback to the driver to wake it up in the context of runtime
suspend when activity happens) and it makes me sleep better :)

Now, the case of system wide suspend has one special aspect to it, which
is the notion that we are bringing down the swap device(s) etc..., and
thus we need to have this prepare/finish phase we talked about to give a
chance to drivers to secure in memory everything they'll need to
succesfully suspend and resume. Additionally, as I explained earlier, it
will make everybody's life MUCH easier (especially USB) if we define
that between prepare() and finish(), no hotplug activity takes place
(the bus drivers just basically ignore devices being plugged in during
that phase, or if they can't completely ignore them, at least just leave
a bit somewhere "need to come back on resume look what's going on
here").

Ben.


 =

 =

Ben.
