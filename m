From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Mon, 30 Apr 2007 08:58:07 +0200
Message-ID: <200704300858.11370.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4620987534978704626=="
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

--===============4620987534978704626==
Content-Type: multipart/signed; boundary="nextPart3172214.6CjZeyZSRj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3172214.6CjZeyZSRj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Can you please apply the appended patch and see if that helps?

Only tried once so far, but it powered off while writing out the image,=20
towards the end. When booting it of course didn't resume, and said the=20
partitions were not cleanly shut down.

I think I had similar behaviour once before, so it may not be related to th=
e=20
patch. I should probably try more to see if the patch had any effect.

Marcus

--nextPart3172214.6CjZeyZSRj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNZODXjXn6TzcAQkRAmseAJ4g3VlGBj2qFFZlMLJZZwEERna0IACffge2
y4cTjq8eVsGhElw8j2Aw7gI=
=XiNB
-----END PGP SIGNATURE-----

--nextPart3172214.6CjZeyZSRj--



--===============4620987534978704626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4620987534978704626==--
