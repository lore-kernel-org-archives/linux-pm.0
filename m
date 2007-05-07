From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Mon, 07 May 2007 10:51:38 +0200
Message-ID: <1178527898.7261.0.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705051132310.1976-100000@netrider.rowland.org>
	<200705052049.58353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8590939171209398933=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705052049.58353.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============8590939171209398933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2lRYVXUZkf3QEEKC3LfC"


--=-2lRYVXUZkf3QEEKC3LfC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-05-05 at 20:49 +0200, Rafael J. Wysocki wrote:

> I think we may need yet another callback, executed before pre_snapshot()
> and before we shrink memory during the hibernation, to be used by drivers
> that need a lot of additional memory in pre_snapshot().

I'm not sure we really need a callback here for that, your suspend
memory allocation chain seemed good enough since most drivers won't
actually be using it and it's not a hard requirement. Not that I care
much.

johannes

--=-2lRYVXUZkf3QEEKC3LfC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGPuiZ/ETPhpq3jKURApg4AKC5w/gfrnBFyn9iptbnb4++4tXeSwCeLvq4
G7mAHmB0fz4lndNCFdmenww=
=MIys
-----END PGP SIGNATURE-----

--=-2lRYVXUZkf3QEEKC3LfC--


--===============8590939171209398933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8590939171209398933==--
