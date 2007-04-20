From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 17:34:25 +0200
Message-ID: <1177083265.5902.6.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070419145508.4a6d2055.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5299878062972027816=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070419145508.4a6d2055.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============5299878062972027816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pxUrzUUQe8gM+FW/t8Lc"


--=-pxUrzUUQe8gM+FW/t8Lc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-19 at 14:55 -0700, Andrew Morton wrote:

> what on earth is a decrementer?

BenH explained it here:
http://thread.gmane.org/gmane.linux.power-management.general/5088/focus=3D5=
230

> It might be nice to identify which arch header is supposed to define
> arch_s2ram_disable_irqs, perhaps via an explicit inclusion of that header=
.

It's supposed to go into asm/suspend.h which is included from
linux/suspend.h. I thought about doing it explicitly but opted against
it in the end. But if I change it to be a weak symbol (somebody tell me
how to please) then that will be moot.

johannes

--=-pxUrzUUQe8gM+FW/t8Lc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKN2B/ETPhpq3jKURAvNDAJ97fUiwVZIO1RXD/mvnhMVbByiJywCcC5zy
SkUL9BzNuA+7vT5bYuTQmd8=
=iynn
-----END PGP SIGNATURE-----

--=-pxUrzUUQe8gM+FW/t8Lc--


--===============5299878062972027816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5299878062972027816==--
