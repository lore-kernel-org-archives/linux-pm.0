From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [mm-patch]Documentation:reference notifiers.txt in
	freezing-of-tasks.txt
Date: Tue, 10 Jul 2007 12:48:27 +1000
Message-ID: <200707101248.27761.nigel@nigel.suspend2.net>
References: <200707091026.20463.oliver@neukum.org>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7586028413737054931=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707091026.20463.oliver@neukum.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============7586028413737054931==
Content-Type: multipart/signed; boundary="nextPart6926592.AGqNk8pWco";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6926592.AGqNk8pWco
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 09 July 2007 18:26:19 Oliver Neukum wrote:
> Hi,
>=20
> freezing-of-tasks.txt mentions firmware issues without mentioning the use
> of the new notifier API to overcome them. Here's an update.
>=20
> 	Regards
> 		Oliver
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ----
>=20
> --- a/Documentation/power/freezing-of-tasks.txt	2007-07-09=20
10:06:51.000000000 +0200
> +++ b/Documentation/power/freezing-of-tasks.txt	2007-07-09=20
10:24:05.000000000 +0200
> @@ -155,6 +155,8 @@ Suppose, however, that the firmware file
>  only through another device that hasn't been resumed yet.  In that case,
>  request_firmware() will fail regardless of whether or not the freezing o=
f=20
tasks
>  is used.  Consequently, the problem is not really related to the freezin=
g=20
of
> -tasks, since it generally exists anyway.  [The solution to this particul=
ar
> -problem is to keep the firmware in memory after it's loaded for the firs=
t=20
time
> -and upload if from memory to the device whenever necessary.]
> +tasks, since it generally exists anyway.
> +
> +A driver must have all firmwares it may need in RAM before suspend() is=
=20
called.

s/firmwares/firmware

> +If keeping them is not practical, for example due to their size, they mu=
st=20
be
> +requested early enough using the suspend notifier API described in=20
notifiers.txt.

Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart6926592.AGqNk8pWco
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGkvN7N0y+n1M3mo0RApJoAJoCvQpG24TEnHgOwutOgwAonPdmRwCffEeI
wyoyRlstrV/mVbSzk4AMvcE=
=jmPc
-----END PGP SIGNATURE-----

--nextPart6926592.AGqNk8pWco--

--===============7586028413737054931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7586028413737054931==--
