From: Marcus Better <marcus@better.se>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Sun, 15 Apr 2007 18:26:33 +0200
Message-ID: <200704151826.33837.marcus@better.se>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414003808.GU5907@stusta.de> <1176515823.4807.7.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1522757379=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176515823.4807.7.camel@daplas>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============1522757379==
Content-Type: multipart/signed; boundary="nextPart4280644.u9WsuYudWA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4280644.u9WsuYudWA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Antonino A. Daplas wrote:
> A screen with blinking green blocks implies that your display is in text
> mode, not in graphics mode.

Yes, it happens when I suspend from text mode.

> If the above does not work, also try
>
> acpi_sleep=3Ds3_bios,s3_mode

Will try, but I'm using "s2ram -f -a3" which should mean precisely the abov=
e=20
IIUC.

Marcus

--nextPart4280644.u9WsuYudWA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGIlI5XjXn6TzcAQkRAh3rAJ0exGxenHskFcXGy7wlhwUMzpb+cgCeLCYF
Stq7eJu8dHjPGfYHLyqYWBo=
=Wofn
-----END PGP SIGNATURE-----

--nextPart4280644.u9WsuYudWA--



--===============1522757379==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1522757379==--
