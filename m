From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Wed, 11 Apr 2007 18:39:13 +0200
Message-ID: <1176309554.3826.4.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0704111006060.3305-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0512702363=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704111006060.3305-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0512702363==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FBK+r6nMybdd5O7Zeu30"


--=-FBK+r6nMybdd5O7Zeu30
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-11 at 10:07 -0400, Alan Stern wrote:

> Have you guys considered using a notifier chain for this?  The platform=20
> code could register itself on the chain at boot time.  When suspending yo=
u=20
> send out notifications just before and just after disabling interrupts,=20
> and inversely on resume.

Not really, but I don't see the point. There shouldn't be anything but
the platform using it so why have a chain? And we'd have to register two
things since it's not exactly in the inverse order here.

johannes

--=-FBK+r6nMybdd5O7Zeu30
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHQ8x/ETPhpq3jKURAkMIAKC4IgSIsgPKaaT/HQxVPS9iyxuwcgCfRiy0
H7cl08xqiPs92FusUQV2J9U=
=bHS2
-----END PGP SIGNATURE-----

--=-FBK+r6nMybdd5O7Zeu30--


--===============0512702363==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0512702363==--
