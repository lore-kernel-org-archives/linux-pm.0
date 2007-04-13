From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:06:08 +0200
Message-ID: <1176498368.7052.117.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>  <20070413205837.GG28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0189533640=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413205837.GG28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0189533640==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ourh00ucCW3CinxKQrYp"


--=-ourh00ucCW3CinxKQrYp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 22:58 +0200, Pavel Machek wrote:

> That it is same old hack it used to be. There's nothing magic about
> decrementer, and I do not think it is _neccessary_ to touch it just
> before cli. Just disable it from sysdev handler or something.

No, you cannot disable it from sysdev handler because you have to be
able to take interrupts. Can we *please* move on to some more productive
discussion?

> > > --- wireless-dev.orig/include/linux/pm.h	2007-04-13 10:09:17.83535688=
0 +0200
> > > +++ wireless-dev/include/linux/pm.h	2007-04-13 14:57:01.525356880 +02=
00
> > > @@ -135,9 +135,19 @@ typedef int __bitwise suspend_disk_metho
> > >   * @prepare: Prepare the platform for the given suspend state. Can r=
eturn a
> > >   *	negative error code if necessary.
> > >   *
> > > + * @quiesce: This callback is called after devices are suspended but=
 before
> > > + *	they are powered down. If assigned, this callback must at least t=
urn
> > > + *	off local IRQs. If left unassigned, a default callback that does
> > > + *	nothing but turn off local IRQs is assigned during pm_set_ops().
>=20
> Is it called for s2ram? swsusp? uswsusp?

Whoops, I had that in an earlier version, it's not supposed to be called
for (u)swsusp because pm_ops involvement there is a hack anyway. I'll
fix the description.

johannes

--=-ourh00ucCW3CinxKQrYp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH/C//ETPhpq3jKURArbjAKCjDgEFhEbXz0TU/mfLoY+a6hEXvwCfQCnJ
0F5cVrsjJlSZWfmG5M6DCLQ=
=6hMH
-----END PGP SIGNATURE-----

--=-ourh00ucCW3CinxKQrYp--


--===============0189533640==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0189533640==--
