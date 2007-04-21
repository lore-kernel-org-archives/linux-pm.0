From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 19:01:01 +0200
Message-ID: <1177174861.5941.26.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210841.18581.david-b@pacbell.net>
	<1177172194.5941.23.camel@johannes.berg>
	<200704210955.11351.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1573990815639572417=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704210955.11351.david-b@pacbell.net>
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


--===============1573990815639572417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1U33nWNBpdS8COEN1Wz0"


--=-1U33nWNBpdS8COEN1Wz0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 09:55 -0700, David Brownell wrote:

> Or maybe arch_suspend_disable_irqs() ... there are PM
> operations that don't involve system suspend states.

Yeah, probably better and I'm fine with that, but the crowd who screamed
when I noted that CONFIG_SOFTWARE_SUSPEND had nothing to do with suspend
states might be confused... It should be obvious that this isn't called
for suspend to disk.

johannes

--=-1U33nWNBpdS8COEN1Wz0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKkNN/ETPhpq3jKURAkvIAKCgSmDBfoJ6Tdi7imIs050J3/73UACfQsbE
3KAAZ7TjM9x2MCn7d70mtEM=
=iSlf
-----END PGP SIGNATURE-----

--=-1U33nWNBpdS8COEN1Wz0--


--===============1573990815639572417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1573990815639572417==--
