From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Tue, 29 Nov 2016 14:12:46 -0800
Message-ID: <87lgw2lyu9.fsf@eliezer.anholt.net>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
 <87twarz6s1.fsf@eliezer.anholt.net>
 <20161129013436.GA3080@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8674237064608735609=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161129013436.GA3080@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Martin Sperl <kernel@martin.sperl.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============8674237064608735609==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eduardo Valentin <edubezval@gmail.com> writes:

> Hello Eric, Martin,
>
> On Mon, Nov 28, 2016 at 12:30:38PM -0800, Eric Anholt wrote:
>> Either the device was initialized by the firmware before handing off to
>> ARM (today's firmware) or it never will be (potential future firmware).
>
> And do you have a way to check if the firmware has the initialization
> code or not? By firmware version, for example. Or even, chip version,
> maybe?

We would know if it's not present because the register would be in its
power-on reset state, which is what the code is checking for.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlg9/V4ACgkQtdYpNtH8
nuiB0RAAinlrEOEz0n7DGGsG2RmiOQhfeMedvz/lEmi1LvdvINWjFXDyRTBzmo/0
MV0Ij3KjptaGpdE4+NUI9VvyuVFcWCPo33Er3ee8to8cswhE+e40+yLhz8O/imQ/
r3wConMmGrg0tw1po1mvTjHCP3zx9/ZQBiB06Istqyb32o+dipCbiwJ1ZPGyFbi7
CZ/C3JHpmCHVTBKJYoTVobt2bQ092wjoKTyLXGGw8Fq9jy0Be644Kjqk7BNZM+Aq
nLakx14D9Qr8pdQEXe/HUuXyPuH5X/p1Qsm3BbUznzk9HjbbqYQn+pilL02ALTYI
AUQf4pDAZstk1yFpZUZnb7Jsj1kUapm3iMPyL0ybmlWC3q7QpiYEVTiVELxvXEjs
ll978O9hV9cq7Q0ZvlxqZNCJvMPtHES+dpTLXu3phd5dz1gBFpR8i9yWBOhzLQti
cCbEK4VXg38++RP7zyaa3xePVjuDCtR9I39ix6KoM6MKzUoNjf1Q4VL920xfL0JW
/TQu1q/y2fRy69/rMkDudo/igGMFEEYsbhMP/Lf5z/nJKfcGmPdWxq9z+qgENCU1
5oSLL41Y2Knespl3gA+Y3M+KYRMPmC8wydZLSgoztKFbaLQriY94mhiGzb7tuYTQ
n+txxNXzk5etfsqIXChXms6YcN7pXjG7xaIfKepk1NhBI0/z6YY=
=jrZn
-----END PGP SIGNATURE-----
--=-=-=--


--===============8674237064608735609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8674237064608735609==--
