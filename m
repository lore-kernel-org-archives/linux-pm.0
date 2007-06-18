From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Prevent frozen user mode
	helpers from failing the freezing of tasks
Date: Tue, 19 Jun 2007 08:15:13 +1000
Message-ID: <200706190815.18292.nigel__46406.0389706448$1182204994$gmane$org@nigel.suspend2.net>
References: <200706182329.58917.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2887913195291817479=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706182329.58917.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============2887913195291817479==
Content-Type: multipart/signed; boundary="nextPart1281076.UZUROANAlK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1281076.UZUROANAlK
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 19 June 2007 07:29:58 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> At present, if a user mode helper is running while=20
usermodehelper_pm_callback()
> is executed, the helper may be frozen and the completion in
> call_usermodehelper_exec() won't be completed until user space processes =
are
> thawed.  As a result, the freezing of kernel threads may fail, which is n=
ot
> desirable.
>=20
> Prevent this from happening by introducing a counter of running user mode
> helpers and allowing usermodehelper_pm_callback() to succeed for
> action =3D PM_HIBERNATION_PREPARE or action =3D PM_SUSPEND_PREPARE only i=
f there
> are no helpers running.  [Namely, usermodehelper_pm_callback() waits for =
at=20
most
> RUNNING_HELPERS_TIMEOUT for the number of running helpers to become zero =
and
> fails if that doesn't happen.]
>=20
> Special thanks to Uli Luckas <u.luckas@road.de> for reviewing the previous
> versions of this patch and for very useful comments.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>

Regards,

Nigel

--nextPart1281076.UZUROANAlK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGdwP2N0y+n1M3mo0RArmbAKDepNuT82mHy+8n6DEGlEDn6xY1UQCgy8bX
wl+3pKR8e1Q9jrB16K/8bkk=
=/xR+
-----END PGP SIGNATURE-----

--nextPart1281076.UZUROANAlK--

--===============2887913195291817479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2887913195291817479==--
