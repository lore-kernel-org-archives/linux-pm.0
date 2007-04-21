From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 18:16:34 +0200
Message-ID: <1177172194.5941.23.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<1177163853.5941.21.camel@johannes.berg>
	<200704210841.18581.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0285689059235235606=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704210841.18581.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0285689059235235606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HCBnLwkMQBU7X/nFKovW"


--=-HCBnLwkMQBU7X/nFKovW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 08:41 -0700, David Brownell wrote:

> Sorry for not highlighting this before, but these are badly misnamed.
> They apply for every system suspend state except PM_SUSPEND_DISK ...
> NOT just suspend-to-ram, as specified by the function name.

Good point. arch_pm_disable_irqs?

johannes

--=-HCBnLwkMQBU7X/nFKovW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKjjh/ETPhpq3jKURAo5HAJ9ROyOxlxoUp/GTWgQTO7EZj+GdFwCcDFNN
2kuBZ8TO9HWhQsj3CmTDmYI=
=iJUH
-----END PGP SIGNATURE-----

--=-HCBnLwkMQBU7X/nFKovW--


--===============0285689059235235606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0285689059235235606==--
