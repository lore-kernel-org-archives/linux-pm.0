From: Marcus Better <marcus@better.se>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Thu, 7 Jun 2007 13:26:57 +0200
Message-ID: <200706071327.00327.marcus__8601.91299948401$1181215711$gmane$org@better.se>
References: <200705181207.45868.marcus@better.se>
	<59ad55d30706061314s45c86e7eja587244a6ed37812@mail.gmail.com>
	<466723C7.3090305@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450980662090192024=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466723C7.3090305@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============0450980662090192024==
Content-Type: multipart/signed; boundary="nextPart7529643.Us1zySveoa";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7529643.Us1zySveoa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stefan Richter wrote:
> Marcus could take the time to check whether his machine keeps happily
> resuming with the new patch applied, that would be good.

Yes it works, but I didn't check firewire functionality after resume.

Marcus

--nextPart7529643.Us1zySveoa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZ+uEXjXn6TzcAQkRAoTsAKCXh6UScPbA06P5i7cUxLR7jC5+qACgmLQm
wHvY38GOYtnab5a3sSNsm6g=
=CU4/
-----END PGP SIGNATURE-----

--nextPart7529643.Us1zySveoa--

--===============0450980662090192024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0450980662090192024==--
