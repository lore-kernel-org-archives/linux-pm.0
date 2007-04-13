From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 08:54:54 +0200
Message-ID: <1176447294.7052.74.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
	<1176377017.5764.15.camel@localhost.localdomain>
	<461E6E07.5020408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1991975657=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <461E6E07.5020408@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1991975657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-q0KNRn9hfM44uJvneK2A"


--=-q0KNRn9hfM44uJvneK2A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 21:36 +0400, Dmitry Krivoschekov wrote:

> It'd be nice adding some examples to patch header, and accurate
> explanation what is possible to do at this new level, this would
> sign to other people that they don't have to invent theirs own hacks
> anymore.

That's pretty hard to do generically since it'll most likely differ for
all platforms. I can paste some powermac specific code but that's
unlikely to help anybody.

> For example, I'd like to enter back to suspend mode
> right from "activate" stage, because I've woken up just
> to update some data and I do not want to resume all devices
> for that, is it ok for "activate"?

I'd think that better be done within ->enter itself, no? Like putting a
loop into ->enter:

do {
  go to sleep;
while (should sleep);

johannes

--=-q0KNRn9hfM44uJvneK2A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHyk+/ETPhpq3jKURAueIAJ4pWatPU2+1dr0EaSMFBMRHxK1ftQCfecMR
HyvJzGIOVzejfvKvpAR+sdI=
=BoMh
-----END PGP SIGNATURE-----

--=-q0KNRn9hfM44uJvneK2A--


--===============1991975657==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1991975657==--
