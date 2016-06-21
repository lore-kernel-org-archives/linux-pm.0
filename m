From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 15:53:35 +0300
Message-ID: <87a8ien1o0.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com> <87twgmn4m7.fsf@linux.intel.com> <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com> <87inx2n2vs.fsf@linux.intel.com> <CAMz4kuKnzjPOqEr9kJY6SCnq2rszsc55X5=7mWb+ZcbL6G_8DQ@mail.gmail.com> <87d1nan2ft.fsf@linux.intel.com> <CAMz4kuLnKH3to_gYdZC3+eos8a4i9nyqXQZyjui+eryv5i+_EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63680 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbcFUMyR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 08:54:17 -0400
In-Reply-To: <CAMz4kuLnKH3to_gYdZC3+eos8a4i9nyqXQZyjui+eryv5i+_EQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>>>> completely?
>>>>>>>
>>>>>>> Yeah, I also hope so. But we really want something to manage the
>>>>>>> charger devices, do you have any good suggestion to avoid the 'clas=
s'
>>>>>>> but also can manage the charger devices?
>>>>>>
>>>>>> manage in what way? It seems to me that they don't need to be real
>>>>>> devices, just a handle as part of struct usb_gadget, no?
>>>>>
>>>>> Although charger device is not one real hardware device, we also use
>>>>> one 'struct device' to describe it in charger.c file. So we should
>>>>> manage the 'struct device' with one proper way.
>>>>
>>>> that's fine, but why do you think they need a struct device to start w=
ith?
>>>
>>> We can get/put usb charger and mange usb charger attributes with the
>>> device model if we use a struct device.
>>
>> We already have that as part of struct usb_udc. Why don't you just
>> create a subdirectory called charger which will hold all your
>> charger-related attributes. That directory will only be created if a
>> valid ->charger pointer exists.
>
> That means we can remove all the device and class things in charger.c
> file, right? OK, I try to do that. Thanks.

right. Keep your charger.c file, because to conditionally compile and
link that to udc-core.ko, but remove all the class initialization and
all of that extra code.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaTjPAAoJEIaOsuA1yqREMLMQAKpOxTa27nUQ/3pnXWMQPx93
rD22m7cVvHvFt5Ke41ZJg/n/t0XspJMNitoMqqJzUKNUA7akKcNY5ZfOkvU7hi3Z
N/mG5ujf/J8Ev47QJTaDrRIicdTiIea+GHsm+g85ch6SaDlsiSuqbTJbcMymkLCs
/VzPJIKtTNb9rA117UpIhgDVqZcbK03HM7tefOspfC9SEWYieI2HT4gU0oWTIb6N
kcbt0zcve+EwR/6Ee4MYeHTpH944kUNnrQCqZvun9S38nK6felqg78b3Ut9rS5Dy
gg0HBTceBs0P12xTWRGf/JK2SSxOt4ScWbWx2fdyjXpoT9QxxZFcstLl1anKYv6n
FGTbGoaK0ddcISMr7TNOLCqTlZ2hscsEMhos+SnaXn5YjDiZQof5YeSOe3OsdKkD
LTpaEyu2Ie5FeVxhvlYVth19Fws5jejFNCHAoUX5Obd9cbMn3Ta6OIXUVauifgjP
jp8T8Fal1pjmV7HoakIPMCfi7+ejAPFKoST4cLuVmdOBkCsT2p7tOzndJ3TZDKj1
ONNbNclEiX35GlFS2pJpoN1fbaH8uAmVSYt1IsU/O6FsNAtmZIMebkFGXX1YL/h6
jE2zxdEDTF5sKu6TVLw1nEDfFx4tcTaRc+r4f0eLI19N4sLcXwkXEvvgc58Qr3rx
YUQxqD8lb2G0LKyvky4F
=tXIK
-----END PGP SIGNATURE-----
--=-=-=--
