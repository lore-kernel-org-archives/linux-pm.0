From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Mon, 24 Oct 2016 15:09:26 +0200
Message-ID: <3F9199B6-233E-4260-9362-498FB1AA3FB7@goldelico.com>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com> <20160212085157.GA16326@amd> <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com> <20160215115304.GA5014@amd> <20160221200653.GD15242@earth> <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com> <20160221211257.GA26418@amd> <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com> <20160222172009.GA7393@earth> <20161024123404.GA24185@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_46A23FF6-0D2B-4BBB-AF74-DEC83EE4164E"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024123404.GA24185@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--Apple-Mail=_46A23FF6-0D2B-4BBB-AF74-DEC83EE4164E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 24.10.2016 um 14:34 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> Hi!
>=20
>> On Mon, Feb 22, 2016 at 06:58:13AM +0100, H. Nikolaus Schaller wrote:
>>>>> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
>>>>> ...
>>>>> }
>>>=20
>>> To which header file should this go?
>>=20
>> I think it should get its own header file in include/linux/power/.
>> Maybe something like "generic-fuel-gauge.h". I'm open to other
>> solutions, though.
>=20
> I'd like to use use this formula in my own code. Is it somewhere in
> the kernel already?

Not that I am aware of. Marek is still working on the =
generic-adc-battery
driver augmented by DT + iio-ADC + formula before publication.

Here is the latest draft so you can cherry-pick it into your work:

	=
http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dpatch;h=3D22ab047ae296e=
998379c1aa29fe1210043cfa040

But beware: I think it is quite wrong using the sqrt() function above =
19.66%
and doing linear interpolation below.

By using the sqrt() function it has a steepness that goes to infinity =
when reaching
19.66% from above. This makes a quite non-realistic curve with a sharp =
bend at 19.66%
(which is equivalent to 3.756 V).

No real battery I have seen and measured with a coulomb counter has such =
a strange
bend at 3.756 V...

IMHO it would be a better approximation to adjust the factors so that =
e.g. a realistic
voltage for "empty" (e.g. 3.3 V) is taken as the 0% point where =
steepness goes through
the roof.

It should then be something like:

	SOC =3D sqrt((Volt - 3.3 V) / (4.2 V - 3.3 V))

This goes more smoothly between 100% and 0%.

Or we could even use an exponential function with an exponent different =
from 1/2
(1 being linear interpolation):

	SOC =3D pow((Volt - 3.3 V) / (4.2 V - 3.3 V), factor)

But this would probably need floating point arithmetic in the kernel or =
some numeric
approximation algorithm.

BR,
Nikolaus


--Apple-Mail=_46A23FF6-0D2B-4BBB-AF74-DEC83EE4164E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYDggHAAoJEIl79TGLgAm6qowQAI91+wjKUNiOKuu0dcnOKlhG
pdKewxYsjP9VT3WtlgEq32lJZBmcEesdPYzJFIbdifr5u7mSL47a7SrHz4qFd/s0
908a4l6ybDiTvp90uyW5R8epf9Lq+PyWI2nHyCgcfEHS6E8QfJtkWsrvnDGX4DVu
AtTAXrIdg5C66owCJNsnfz5B3UyBoZVxVDWy3tG6pJxCQnzC06c7xJRs+mVOVrS4
816fu2jp1oRy3Uh80oq4zxJI/aJriZRyliHuc8URxmp+qAEwdC9r+q459BOzqI8P
jLR/nylTj5ERxi2op86H9wviRgbHPSeN5i4nQXByShzEKjCiUDStgWtm3RtyKL53
/Us7rTVXziiOjIzIdenmMFdupTgTUGVpXy3Jdo7TN4Ru4zQTl9I7CH7N9DL+DRR1
cnedTS/XdHtywgM5vzx+rQgWSN2cdtfQTsABrRV+DNrVBdGvwaaNlb7YJY2dmCoW
rLKS5SQGva8kZbGN0SHhom0dOR1T98CNL0eJ350+H0syD+wtTac1NrsXEKOV5PQT
KbwMy41HcAu7krKBLeipZ/ZKJrv5JRaGSYMx/ijM/234TSPt8fizll6IPGGm/aU4
BZZgQwFG2tpQ3+awOe5HkN1jxLjEY16gawosFgZHHOFNFSC1SL8ZpYzwJlGzuXSe
QWtS8+Qp66bIG2Hi7p77
=OvKW
-----END PGP SIGNATURE-----

--Apple-Mail=_46A23FF6-0D2B-4BBB-AF74-DEC83EE4164E--
