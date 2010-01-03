From: Daniel Borkmann <danborkmann@googlemail.com>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Sun, 03 Jan 2010 11:06:12 +0100
Message-ID: <4B406C14.2070907__10739.9430628449$1262619345$gmane$org@gmail.com>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001022201.04281.rjw@sisk.pl>
	<7cf4f51f.5fc2a5cd.4b3fc3ad.c849c@o2.pl>
	<201001030029.22449.rjw@sisk.pl>
	<65e5aef6.33251eb4.4b3fecf4.a2f99@o2.pl>
	<4B4063AB.7080401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7519019428848052507=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B4063AB.7080401@gmail.com>
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
To: =?UTF-8?B?QmFydMWCb21pZWogWmltb8WE?= <uzi18@o2.pl>
Cc: Andy Walls <awalls@radix.net>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7519019428848052507==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCE6E6D957E429ACE3AC98FD2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE6E6D957E429ACE3AC98FD2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> Bart=C5=82omiej Zimo=C5=84 wrote:
>> What about this discusion:
>> http://lists.freedesktop.org/archives/devkit-devel/2009-December/00061=
7.html
>>
>> I will perform some tests to know what amount of time is usualy needed=
 to disconnect
>> nicely client or something.
>=20
> Actually I think this is what signals are there for and bringing this
> information via signals would have least overhead, problem is that this=

> is not POSIX compliant, but may be you could have a try at this?!

I'm not quite sure how this is implemented within the kernel, but if you
have lots of processes doing their suspend routines, I think it is not
guaranteed that all of this finishes before doing the suspend, so you
will have some unknown states, processes could stuck at (and later [at
some unintended point of time] resume on).
Or, on the other hand you will have to block the kernel notification
chain until all the procs have signaled that they're done doing their
jobs. Regarding this, the kernel suspend would depend on the correctness
/ termination of userspace routines which is a _very_ bad thing.
You will have to introducte some timeouts... see where this is going? I
think a file interface might be too simple... just some thoughts about th=
is.

Regards,
Daniel


--------------enigCE6E6D957E429ACE3AC98FD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktAbBQACgkQ5AxJm1m3CC+N3ACfVohLlBmmZxuIoPj4Hj6Lq1F8
XNkAn0s7p2tLWTchN0h+6Cb6t/4OQB2a
=3BnN
-----END PGP SIGNATURE-----

--------------enigCE6E6D957E429ACE3AC98FD2--

--===============7519019428848052507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7519019428848052507==--
