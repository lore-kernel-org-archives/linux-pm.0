From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: intel-vbtn: match power button on press rather than release
Date: Sat, 16 Sep 2017 15:45:38 +0200
Message-ID: <201709161545.39058@pali>
References: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2168745.4ung4HuQjD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario Limonciello <mario.limonciello@dell.com>, dvhart@infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: AceLan Kao <acelan.kao@canonical.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

--nextPart2168745.4ung4HuQjD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 04 August 2017 19:00:06 Mario Limonciello wrote:
> This fixes a problem where the system gets stuck in a loop
> unable to wakeup via power button in s2idle.
>=20
> The problem happens because:
>  - press power button:
>    - system emits 0xc0 (power press), event ignored
>    - system emits 0xc1 (power release), event processed,
>      emited as KEY_POWER
>    - set wakeup_mode to true
>    - system goes to s2idle
>  - press power button
>    - system emits 0xc0 (power press), wakeup_mode is true,
>      system wakes
>    - system emits 0xc1 (power release), event processed,
>      emited as KEY_POWER
>    - system goes to s2idle again
>=20
> To avoid this situation, process the presses (which matches what
> intel-hid does too).
>=20
> Verified on an Dell XPS 9365
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/intel-vbtn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel-vbtn.c
> b/drivers/platform/x86/intel-vbtn.c index 61f1063..4809267 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -36,8 +36,8 @@ static const struct acpi_device_id intel_vbtn_ids[]
> =3D {
>=20
>  /* In theory, these are HID usages. */
>  static const struct key_entry intel_vbtn_keymap[] =3D {
> -	{ KE_IGNORE, 0xC0, { KEY_POWER } },	/* power key press */
> -	{ KE_KEY, 0xC1, { KEY_POWER } },	/* power key release */
> +	{ KE_KEY, 0xC0, { KEY_POWER } },	/* power key press */
> +	{ KE_IGNORE, 0xC1, { KEY_POWER } },	/* power key release */
>  	{ KE_KEY, 0xC4, { KEY_VOLUMEUP } },		/* volume-up key press */
>  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release=20
*/
>  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */

Hello, maybe a stupid question, but why to not report both events "key=20
pressed" and "key released" to userspace? IIRC kernel input layer can=20
distinguish between these two type of events. But in intel-vbtn.c source=20
code I see that all "release" ACPI events are ignored and just "press"=20
are processed.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2168745.4ung4HuQjD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlm9KwMACgkQi/DJPQPkQ1I/ywCgsSDL6U10qql0ZQnOSk+sI8HQ
SUcAn3ZBMMD5LtR8GPIuqhavWwG36SyV
=0spM
-----END PGP SIGNATURE-----

--nextPart2168745.4ung4HuQjD--
