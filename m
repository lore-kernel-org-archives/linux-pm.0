From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Mon, 30 Apr 2007 14:34:06 +0200
Message-ID: <200704301434.10008.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6104885740295515833=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704291832.15959.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============6104885740295515833==
Content-Type: multipart/signed; boundary="nextPart4401058.gzPOACNtTk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4401058.gzPOACNtTk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Can you please apply the appended patch and see if that helps?

A second attempt also succeeded, so I think it's an improvement at least.

Marcus

--nextPart4401058.gzPOACNtTk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNeJBXjXn6TzcAQkRAjHlAJsEqaiCe1b7t0eBY/EGzFypHuYwCgCfYM+c
kYGxPW24OtqQBh3IixuLhG0=
=HT+l
-----END PGP SIGNATURE-----

--nextPart4401058.gzPOACNtTk--



--===============6104885740295515833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6104885740295515833==--
