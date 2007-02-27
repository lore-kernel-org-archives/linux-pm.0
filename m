From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 27 Feb 2007 14:50:17 +0200
Message-ID: <200702271450.19080.caglar@pardus.org.tr>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1529654856=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070226220152.GA29575@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Tejun Heo <htejun@gmail.com>, Arkadiusz Miskiewicz <arekm@maven.pl>, "Antonino A. Daplas" <adaplas@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-ide@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Jean-Luc Coulon <jean.luc.coulon@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>, linux-usb-devel@lists.sourceforge.net, Andrew Nelless <andrew@nelless.net>, jgarzik@pobox.com, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Fabio Comolli <fabio.comolli@gmail.com>, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.o>
List-Id: linux-pm@vger.kernel.org

--===============1529654856==
Content-Type: multipart/signed; boundary="nextPart4118373.3YUhFlvKGP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4118373.3YUhFlvKGP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

27 =C5=9Eub 2007 Sal tarihinde, Adrian Bunk =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> This email lists some known regressions in 2.6.21-rc1 compared to 2.6.20
> that are not yet fixed in Linus' tree.
>
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
=2E..
> Subject    : ACPI update breaks kpowersave
> References : http://lkml.org/lkml/2007/2/10/7
> Submitter  : Ismail D=C3=B6nmez <ismail@pardus.org.tr>
>              Fabio Comolli <fabio.comolli@gmail.com>
> Status     : unknown

That regression fixed by c2b6705b75d9c7aff98a4602a32230639e10891c according=
 to=20
=C4=B0smail [1]=20

[1] http://lkml.org/lkml/2007/2/13/105
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart4118373.3YUhFlvKGP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBF5CkLy7E6i0LKo6YRAs+fAJ90PHusL1+EmgYOM2ISXNsnO4F3xACeJyKD
SHBwKmGELVMCEsNvQftWQOM=
=zYRw
-----END PGP SIGNATURE-----

--nextPart4118373.3YUhFlvKGP--

--===============1529654856==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1529654856==--
