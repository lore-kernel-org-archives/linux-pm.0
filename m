From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: do not use pm_ops (was: Re: suspend2
	merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Mon, 30 Apr 2007 10:29:18 +0200
Message-ID: <1177921759.5102.24.camel@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <20070426113005.GU17387@elf.ucw.cz>
	<1177605074.6814.93.camel@johannes.berg>
	<200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5996473357219496731=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
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
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============5996473357219496731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yC2+z8WXZnPcfwvD7h7D"


--=-yC2+z8WXZnPcfwvD7h7D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-04-29 at 14:48 +0200, R. J. Wysocki wrote:

> +	status =3D acpi_enter_sleep_state(ACPI_STATE_S4);
> +	local_irq_restore(flags);
> +
> +	/*
> +	 * Restore processor state
> +	 * We should only be here if we're coming back from hibernation and
> +	 * the memory image should have already been loaded from disk.

That comment doesn't seem right. This is in ->enter so afaict the image
hasn't been loaded yet at this point. I don't know if you just moved
code but if you did then I don't think it was correct before.

> +	 */
> +	acpi_restore_state_mem();

Maybe that needs to be in ->finish then? Or somewhere in the deeper arch
code?

Other than that it looks good to me on a cursory look. I'll give it a
try on my G5 on Wednesday or Thursday.

johannes

--=-yC2+z8WXZnPcfwvD7h7D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNaje/ETPhpq3jKURAmxSAJsE10viaGm6KckKTBgX9v8jspwU1ACgtVtX
2wOOecLW261eaLSbTZ/TIlU=
=dyfY
-----END PGP SIGNATURE-----

--=-yC2+z8WXZnPcfwvD7h7D--


--===============5996473357219496731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5996473357219496731==--
