From: Marcus Better <marcus@better.se>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Thu, 31 May 2007 14:41:07 +0200
Message-ID: <200705311441.14021.marcus__12238.8196447448$1180615341$gmane$org@better.se>
References: <200705181207.45868.marcus@better.se>
	<tkrat.5b4ba1068f8b64ee@s5r6.in-berlin.de>
	<tkrat.07833adfb2306655@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3686825519977634935=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.07833adfb2306655@s5r6.in-berlin.de>
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
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============3686825519977634935==
Content-Type: multipart/signed; boundary="nextPart3428986.7kMoPCyAeX";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3428986.7kMoPCyAeX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stefan Richter wrote

> From: Kristian Hoegsberg <krh@redhat.com>
> Subject: [PATCH] Implement suspend/resume PCI driver hooks.

Yes, it seems to work.

Thanks,

Marcus

--nextPart3428986.7kMoPCyAeX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGXsJpXjXn6TzcAQkRAnx1AKDU+WzRN7Imyg3uBs01hugbEV5yFgCg6sXp
w4CiQ6sjFGwNXbSL0d83HlI=
=2sKR
-----END PGP SIGNATURE-----

--nextPart3428986.7kMoPCyAeX--

--===============3686825519977634935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3686825519977634935==--
