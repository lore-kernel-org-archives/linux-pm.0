From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Fri, 07 Nov 2014 09:41:19 -0300
Message-ID: <545CBDEF.6050502@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com> <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com> <20141107032619.GD3698@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CDfTBk3FhrnL4FWXT4hc36VDMFcrvpKeK"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58203 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751694AbaKGMnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 07:43:24 -0500
In-Reply-To: <20141107032619.GD3698@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDfTBk3FhrnL4FWXT4hc36VDMFcrvpKeK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/07/2014 12:26 AM, Jason Cooper wrote:
> Ezequiel,
>=20
> On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
>> The Armada 375 Z1 SoC revision is no longer supported. This commit
>> removes the quirk needed for the thermal sensor.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
>>  drivers/thermal/armada_thermal.c                     | 20 -----------=
---------
>>  2 files changed, 28 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.=
txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> index 4cf0249..4698e0e 100644
>> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> @@ -5,17 +5,9 @@ Required properties:
>>  - compatible:	Should be set to one of the following:
>>  		marvell,armada370-thermal
>>  		marvell,armada375-thermal
>> -		marvell,armada375-z1-thermal
>>  		marvell,armada380-thermal
>>  		marvell,armadaxp-thermal
>> =20
>> -		Note: As the name suggests, "marvell,armada375-z1-thermal"
>> -		applies for the SoC Z1 stepping only. On such stepping
>> -		some quirks need to be done and the register offset differs
>> -		from the one in the A0 stepping.
>> -		The operating system may auto-detect the SoC stepping and
>> -		update the compatible and register offsets at runtime.
>> -
>>  - reg:		Device's register space.
>>  		Two entries are expected, see the examples below.
>>  		The first one is required for the sensor register;
>=20
> I've no problem with removing support for the z1 stepping from the
> kernel.  However, I don't think we should erase it from binding docs.
> I'm not sure what the DT maintainers think is the appropriate action
> here, but I'm thinking we could add a 'Deprecated' section at the end o=
f
> the doc and move these hunks there.  With a little rewording of course.=

>=20
> I'm primarily concerned about users with older dtbs looking to upgrade,=

> "Hey, wtf is marvell,armada375-z1-thermal?  I looked in the binding doc=
s
> and there's nothing there, do I replace it with marvell,armada375-therm=
al?"
>=20

We can do that if you think it's really useful. However, I think we've
designed this so *nobody* would actually have to put the z1 compatible
string. The mvebu quirk (tries) to auto-detect it from the revision
register and hot fix the compatible string.

Moreover, I'm not at all sure *anyone* would have a Z1 board except
early developers like us. Am I being too naive here?

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com


--CDfTBk3FhrnL4FWXT4hc36VDMFcrvpKeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUXL3zAAoJEIOKbhOEIHKiQ4QQAIhrmYyrEQ3/oAFGbnIGGeMN
XuwCblfudnFIf0x4F2ILoilcR66uNbDXGAYl8yDMk6+qiYpzY91PvdDgE1IrZR0q
sKt6xgriBXZ5DP5z3T+80ghyo3Jggk4Ot/QQpBneugOalb/If45bKHvL/Zur4syS
V6tlegdf7T0XAK/DaIunC4Sq2SUrUoCoObI/BDiYikxxGwp5NUmwJnqSUZc1l8dn
hW7muycwArCbwCTr6Oyp5WJ/ybafB/VWGGYPAyIhgTyyad/2StW+3rKMdr73tcEB
s85x+Q7/rWuuRQGHKXyedQKnxwy50fkEoU8XCyD74ao0SHTaxIiJKhOnyoEWankE
CH4DAfPk28eK/bFB79JlAbtYilc5iFhTMj57ywF8F2zczYlG61qg+T+IXDUknLoC
L6gxBopHAYL78MPuwVv9fYP3LmQk4vErr7t+XjoAstC5VepH1z6xInQ/ICgy4w/A
1EyLYWS+2z5MyBM2DMbZYy+CZIzCEBFenDqtx3z9lA/dzwLj9iD59BDrg3eeV8Aa
Z0Y2Kcj7fJBJgQ/T9xT5Iy5VI2ZMatR/+uLPlLYOUgghgHGDDxahQ/QKYBVepUvq
XquL4qihVb00IzmTvQkgWWwRUhClCEVQB5XJUEZ39QLAmuDEAS3Ymefou6IaBf9U
t8KD2VYfcMNwAO+4yDmI
=cUza
-----END PGP SIGNATURE-----

--CDfTBk3FhrnL4FWXT4hc36VDMFcrvpKeK--
