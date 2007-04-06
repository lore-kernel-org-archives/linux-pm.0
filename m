From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 12:00:57 +0200
Message-ID: <1175853657.3489.69.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<200704061202.42069.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0692277234=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704061202.42069.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0692277234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AlOhI7MyVeV/heIAsxMn"


--=-AlOhI7MyVeV/heIAsxMn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 12:02 +0200, Rafael J. Wysocki wrote:

> That's why I said "it feels". :-)

:)

> Still, we can, for example, define default_quiesce() and default_activate=
()
> that will only call local_irq_save/restore() to be used by the architectu=
res
> that don't need anything more etc.

Like I did with pm_ops_only_mem or whatever it was...

I don't feel strongly either way. But the last big discussion when I
changed all pm_ops users sort of discouraged me ;)

johannes

--=-AlOhI7MyVeV/heIAsxMn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFhpZ/ETPhpq3jKURAocjAJ9DKkXlNTiE9p1juL+TpCKo7yq56QCfQz2i
00dS0wK35S104x0jIz13Gq4=
=6EMW
-----END PGP SIGNATURE-----

--=-AlOhI7MyVeV/heIAsxMn--


--===============0692277234==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0692277234==--
