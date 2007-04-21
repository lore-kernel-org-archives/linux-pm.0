From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 19:49:23 +0200
Message-ID: <1177177763.5941.28.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210955.11351.david-b@pacbell.net>
	<1177174861.5941.26.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4883233354976025281=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704211006.58857.david-b@pacbell.net>
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


--===============4883233354976025281==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6vCdqgsf9saZ+A8pHeWB"


--=-6vCdqgsf9saZ+A8pHeWB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 10:06 -0700, David Brownell wrote:

> And even userspace makes
> that distinction clear, calling it "Hibernate" not "Suspend".

But that was quite a fight, at least in the gnome camp ;)

> I feel a Kconfig patch coming on ... ;)

Not from me. But you'll get an updated one for this :)

johannes

--=-6vCdqgsf9saZ+A8pHeWB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKk6j/ETPhpq3jKURApxfAJwMsgJKgEG3x/Cy67kdL3bTLxhVEQCfYWf5
NFUW3kcGgI1qDHTXIN+sEF0=
=bRem
-----END PGP SIGNATURE-----

--=-6vCdqgsf9saZ+A8pHeWB--


--===============4883233354976025281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4883233354976025281==--
