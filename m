From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Sat, 28 Apr 2007 09:05:34 +1000
Message-ID: <1177715134.4737.194.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427145212.GO22250@elf.ucw.cz>
	<1177709523.4737.157.camel@nigel.suspend2.net>
	<20070427221234.GE2994@elf.ucw.cz>
	<1177712296.4737.182.camel@nigel.suspend2.net>
	<20070427222543.GF2994@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8399943789427783038=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427222543.GF2994@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============8399943789427783038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FHD+r37QJg9AcCztK2vX"


--=-FHD+r37QJg9AcCztK2vX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 00:25 +0200, Pavel Machek wrote:
> Hi!
>=20
> > > > > NAK. This slows down regular operation, at it is 30 lines for wha=
t
> > > > > should have been one (or five).
> > > >=20
> > > > Count them. It is one line (an if statement) plus seven lines of
> > > > comment.
> > >=20
> > > You count them. Hint... you'll need to read original patch.
> >=20
> > Ah. You're assuming this is the only use of freezer_is_on().
>=20
> Yes. You need quite good reason for hack like freezer_is_on(), and
> this is not it.
>=20
> > > > > Just place avenrun[0] =3D avenrun[1] =3D avenrun[2] =3D 0 at stra=
tegic place
> > > > > if you feel strongly about this. Additional points for using Rafa=
el's
> > > > > "suspend done" notifier so that you don't have to modify suspend =
core.
> > > >=20
> > > > =3D0 might not be right. If you did have a high load average prior =
to
> > > > suspending, not delivering email would be the right thing to do.
> > >=20
> > > Ok, so =3D0 is not right, but it is better than adding 30lines of jun=
k
> > > to the kernel.
> > >=20
> > > NAK on this patch. Original behaviour is acceptable.
> >=20
> > to someone who IIRC correctly recently said he doesn't even use the
> > code.
>=20
> If you want to work with me, learn how to write kernel code, learn
> english, and learn how to behave.

Pavel, I would love to work well with you, but I just find you arrogant
and unhelpful. I don't think it's just me. In the past, I've seen you
tell users to fix problems themselves. I've seen you dismiss real
problems (like this) as acceptable. That's not acceptable. If we want
Linux to be the best and most useful operating system out there, we have
to be willing to support things that we personally don't find useful,
and help people with problems that we personally don't care about that
much.

I haven't spent something like seven years working on hibernation
support because I find it fun or because I have nothing better to do.
I've worked on it because you're happy with a solution that just doesn't
cut the mustard for me and thousands of other people.

If I could find a way that we could work together and get those features
that others find useful and helpful in, I'd jump at it. But that just
doesn't seem to be possible.

I therefore have to ask: Please. Go away. Hand the maintainership of
hibernation over to Rafael. Work on things you do care about and where
you do want to see a fully functional implementation. But stop being a
hindrance to us making Linux hibernation support everything that it
ought to be.

Nigel

--=-FHD+r37QJg9AcCztK2vX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMoG+N0y+n1M3mo0RApryAJ9zDAk2pA9I4Navn+8ZiqAArVHQ3wCfbwaU
+Uvd6JtH2NzzJOnJMjVjAI8=
=p/Z2
-----END PGP SIGNATURE-----

--=-FHD+r37QJg9AcCztK2vX--


--===============8399943789427783038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8399943789427783038==--
