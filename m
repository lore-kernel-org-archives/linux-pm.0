From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Mon, 30 Apr 2007 10:11:01 +0200
Message-ID: <200704301011.07646.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8222790938913992722=="
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

--===============8222790938913992722==
Content-Type: multipart/signed; boundary="nextPart1213896.a1gXtPpP1N";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1213896.a1gXtPpP1N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Can you please apply the appended patch and see if that helps?

I just had a successful suspend and resume with this patch.

Marcus

--nextPart1213896.a1gXtPpP1N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNaSbXjXn6TzcAQkRAhmgAJ9EltvqtMai8djQj0l7ijtX5WvszACfTd9O
4+QBX4OPPG90gAzkBlpRRi4=
=/3Uo
-----END PGP SIGNATURE-----

--nextPart1213896.a1gXtPpP1N--



--===============8222790938913992722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8222790938913992722==--
