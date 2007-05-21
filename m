From: Marcus Better <marcus@better.se>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Mon, 21 May 2007 07:25:51 +0200
Message-ID: <200705210725.55299.marcus__14062.9976209768$1179725275$gmane$org@better.se>
References: <200705181207.45868.marcus@better.se>
	<464DDB85.7080203@s5r6.in-berlin.de>
	<tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1265423628412775042=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
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

--===============1265423628412775042==
Content-Type: multipart/signed; boundary="nextPart3455224.L6gWW4UYf0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3455224.L6gWW4UYf0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stefan Richter wrote:
> Could you test the following patch?

Now it hangs on the second suspend to RAM (at suspend, not resume).

Marcus

--nextPart3455224.L6gWW4UYf0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGUS1jXjXn6TzcAQkRAiTMAKCPaUrjFKkFSsSTLxJkdDVVm3DCWQCgmExf
1nEbstCiBOuZusn3k05W1fs=
=fkyL
-----END PGP SIGNATURE-----

--nextPart3455224.L6gWW4UYf0--

--===============1265423628412775042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1265423628412775042==--
