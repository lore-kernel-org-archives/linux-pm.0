From: Marcus Better <marcus@better.se>
Subject: fw-ohci breaks suspend-to-RAM
Date: Fri, 18 May 2007 12:07:40 +0200
Message-ID: <200705181207.45868.marcus@better.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0857166752963032343=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>
Cc: akpm@osdl.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0857166752963032343==
Content-Type: multipart/signed; boundary="nextPart1248606.kMK78POzdl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1248606.kMK78POzdl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

the fw-ohci driver breaks suspend to RAM on my Thinkpad R60, Intel Core 2 D=
uo,=20
kernel 2.6.22-rc1 (x86_64, SMP). It does suspend but hangs on resume if the=
=20
fw-ohci module is loaded. (See also the original report [1]).

Best regards,

Marcus

[1] http://permalink.gmane.org/gmane.linux.power-management.general/5819

--nextPart1248606.kMK78POzdl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGTXrxXjXn6TzcAQkRAv87AKCiWGhBZfJyhYm8xHabcVJtffJSZACgtdTF
zVtUgNzTsNO2WO52R5h3qto=
=9cW0
-----END PGP SIGNATURE-----

--nextPart1248606.kMK78POzdl--

--===============0857166752963032343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0857166752963032343==--
