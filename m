From: Daniel Borkmann <danborkmann@googlemail.com>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Mon, 04 Jan 2010 13:46:16 +0100
Message-ID: <4B41E318.4050809__2356.9353660152$1262619355$gmane$org@gmail.com>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001040030.01256.rjw@sisk.pl>
	<54ac764e.502c1a33.4b4129c3.9dc1b@o2.pl>
	<201001040045.39517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6787042852405135384=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001040045.39517.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: awalls@radix.net, linux-kernel@vger.kernel.org, =?UTF-8?B?QmFydMWCb21pZWogWmltb8WE?= <uzi18@o2.pl>, linux-pm@lists.linux-foundation.org, danborkmann@googlemail.com
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6787042852405135384==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig617ACEB1397EFE08C9EE3CDF"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig617ACEB1397EFE08C9EE3CDF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki wrote:
> On Monday 04 January 2010, Bart=C5=82omiej Zimo=C5=84 wrote:
>> And what do You think about sending extra signals to processes?
>=20
> I don't see a problem with this in principle, although I don't think si=
gnals
> are very suitable for this particular purpose, because you need two-way=

> communication between the power manager and the processes it's going to=

> notify (because it has to wait for the processes to finish their prepar=
ations
> and to tell it that they are ready).

Again, just to abandon some thoughts... do you really need that "two-way
communication"? I mean if the kernel delivers that specific signal to
the process/task_struct [do_signal():handle_signal()] it has to save the
original execution context that will later on be restored after the
non-default signal handling function returns. This is our ACK /
notification for the successful return of the programs "suspend
handler". The kernel module (if such exists) could be notified about
that for instance by a simple notifier hook within kernelspace. I mean
if I see this right, the "two-way" is just for the ACK isn't it?

Best regards,
Daniel


--------------enig617ACEB1397EFE08C9EE3CDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktB4xgACgkQ5AxJm1m3CC9vxQCfWdKkD2G/vFXqz3D3R3U0nsgD
PasAn2JqmawTG+k8NBjbddSFCxOggi+B
=8/RW
-----END PGP SIGNATURE-----

--------------enig617ACEB1397EFE08C9EE3CDF--

--===============6787042852405135384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6787042852405135384==--
