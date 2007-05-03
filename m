From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 03 May 2007 14:12:12 +0200
Message-ID: <1178194332.13233.98.camel__20753.5303234637$1178194325$gmane$org@johannes.berg>
References: <200705022213.35831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5442522388535726071=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705022213.35831.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============5442522388535726071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xNWvY0Rmtu1mJf+pSfS9"


--=-xNWvY0Rmtu1mJf+pSfS9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:

>  extern void swsusp_unset_page_free(struct page *);
>  extern unsigned long get_safe_page(gfp_t gfp_mask);

> +void hibernation_set_ops(struct hibernation_ops *ops);

> +extern int hibernate(void);

You could add an extern to hibernation_set_ops for consistency :) Not
that I really care.

johannes

--=-xNWvY0Rmtu1mJf+pSfS9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOdGc/ETPhpq3jKURAs6IAKC5za+QocxbzSNbP85nYJoGk/CYfACgr9FH
oFX4+MhLw95lj4OSTy2ba2k=
=ScPR
-----END PGP SIGNATURE-----

--=-xNWvY0Rmtu1mJf+pSfS9--


--===============5442522388535726071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5442522388535726071==--
