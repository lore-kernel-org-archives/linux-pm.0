From: The Holy ettlz <theholyettlz@googlemail.com>
Subject: Re: High power consumption after suspend/resume cycle
Date: Sun, 04 Oct 2009 10:17:13 +0100
Message-ID: <1254647833.3845.3.camel@localhost.localdomain>
References: <cb0375e10910021044n182d696dy8fd566925e46b134@mail.gmail.com>
	<cb0375e10910021229x7924ec56o61627ec0f625a70c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2426446892881993185=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cb0375e10910021229x7924ec56o61627ec0f625a70c@mail.gmail.com>
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
To: Andrew Lutomirski <luto@mit.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============2426446892881993185==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tm9hUJjLwqFNzr1bH6Qz"


--=-tm9hUJjLwqFNzr1bH6Qz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

> > There's a catch, though: after a suspend/resume cycle, power
> > consumption goes up by over well over a watt.  (On a system that draws
> > about 7 watts before suspending, that's a big deal.)  I've tried
> > turning off X, suspending with 'echo mem > /sys/power/state' to avoid
> > any distro scripts running, and manually restoring SATA power saving
> > settings, but it still happens.  I even tried unbinding e1000e and
> > both USB drivers, unloading the i2400 (wimax) driver, iwlagn, and
> > iwlcore, and it still happens.  This is 100% reproducible, and I'd be
> > happy to test things.

Just out of curiosity: does it make any difference whether tickless mode
is enabled or not, and do you see an excess of wakeups with no apparent
origin, a la http://bugzilla.kernel.org/show_bug.cgi?id=3D12788 ?

Thanks,
James.

--=20
The Holy ettlz                              TheHolyettlz@googlemail.com
PGP key ID: 03F94B5D
-----------------------------------------------------------------------


--=-tm9hUJjLwqFNzr1bH6Qz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrIaBcACgkQL/Is9AP5S10vUACeKYrLazVLr7XSaA68H2xh5E41
7NAAoIgskYfkaJuOkCnfbJk01RqtcSvy
=qrlP
-----END PGP SIGNATURE-----

--=-tm9hUJjLwqFNzr1bH6Qz--


--===============2426446892881993185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2426446892881993185==--
