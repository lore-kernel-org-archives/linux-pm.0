From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Wed, 2 May 2007 13:41:32 +0200
Message-ID: <200705021341.32454.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200704301434.10008.marcus@better.se>
	<200704301621.11826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7731037011696018839=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301621.11826.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============7731037011696018839==
Content-Type: multipart/signed; boundary="nextPart1472777.Ozqcn806z6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1472777.Ozqcn806z6
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rafael J. Wysocki wrote:
> OK, so please run with it applied for a while to make sure it helps.

I have tested some more, and it seems to work. There was only the one reboo=
t=20
during writing that happened on my first attempt, but it hasn't happened=20
since then.

Thanks,

Marcus

--nextPart1472777.Ozqcn806z6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOHjsXjXn6TzcAQkRAmurAKDSXCXSW2cqfyNmbKNriqTocgu7FACgmbow
g0IJwW++YYg2yCkHxrgUxRU=
=C4eb
-----END PGP SIGNATURE-----

--nextPart1472777.Ozqcn806z6--



--===============7731037011696018839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7731037011696018839==--
