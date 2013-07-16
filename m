From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: config SOC_DRA7XX?
Date: Tue, 16 Jul 2013 17:02:22 -0400
Message-ID: <51E5B4DE.5040906@ti.com>
References: <1373813686.1370.55.camel@x61.thuisdomein>  <51E3DF09.4070109@ti.com> <1373889707.2591.31.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2EQGMAQVTSPNBKFNJOIBT"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33093 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933975Ab3GPVCd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Jul 2013 17:02:33 -0400
In-Reply-To: <1373889707.2591.31.camel@x61.thuisdomein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

------enig2EQGMAQVTSPNBKFNJOIBT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15-07-2013 08:01, Paul Bolle wrote:
> Hi Eduardo,
>=20
> On Mon, 2013-07-15 at 07:37 -0400, Eduardo Valentin wrote:
>> On 14-07-2013 10:54, Paul Bolle wrote:
>>> 2) Why is this dependency on SOC_DRA7XX needed? And what would
>>> SOC_DRA7XX actually be? Some searches on the web returned nothing tha=
t
>>> could show me what it is.
>>
>> That is the config which says the kernel has the support for the DRA7X=
X
>> soc family. The core support didnt make for 3.11. But I had already se=
nt
>> this code for review and merge by then. The core code can be seen here=
:
>> git://github.com/rrnayak/linux.git for-3.12/dra-core-data
>>
>> for instance.
>=20
> I'll stop worrying about this. And unless SOC_DRA7XX still pops up in m=
y
> list of invalid Kconfig symbols in, say, early 2014, I won't have to
> bother you again.

Thanks Paul for point me this missing part. But I believe it won't be
something to worry, yes, because Rajendra will be sending DRA7 base
support for 3.12.

>=20
> Thanks!
>=20
>=20
> Paul Bolle
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2EQGMAQVTSPNBKFNJOIBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHltN4ACgkQCXcVR3XQvP1flAEAxwxLQcjEJ7876GlFVQ6XMvo2
KPTXOAFSqgJrxvAX8rgA/jLAJrs0fhfi1C1Pl+4v1qX9qjB3G1iLqEsY0edvl6Ja
=KbMA
-----END PGP SIGNATURE-----

------enig2EQGMAQVTSPNBKFNJOIBT--
