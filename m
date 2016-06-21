From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 15:54:12 +0300
Message-ID: <877fdin1mz.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com> <87twgmn4m7.fsf@linux.intel.com> <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com> <87inx2n2vs.fsf@linux.intel.com> <CAMz4kuKnzjPOqEr9kJY6SCnq2rszsc55X5=7mWb+ZcbL6G_8DQ@mail.gmail.com> <87d1nan2ft.fsf@linux.intel.com> <CAMz4kuLnKH3to_gYdZC3+eos8a4i9nyqXQZyjui+eryv5i+_EQ@mail.gmail.com> <87a8ien1o0.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16405 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcFUNQM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 09:16:12 -0400
In-Reply-To: <87a8ien1o0.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <balbi@kernel.org> writes:
>>>>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>>>>> completely?
>>>>>>>>
>>>>>>>> Yeah, I also hope so. But we really want something to manage the
>>>>>>>> charger devices, do you have any good suggestion to avoid the 'cla=
ss'
>>>>>>>> but also can manage the charger devices?
>>>>>>>
>>>>>>> manage in what way? It seems to me that they don't need to be real
>>>>>>> devices, just a handle as part of struct usb_gadget, no?
>>>>>>
>>>>>> Although charger device is not one real hardware device, we also use
>>>>>> one 'struct device' to describe it in charger.c file. So we should
>>>>>> manage the 'struct device' with one proper way.
>>>>>
>>>>> that's fine, but why do you think they need a struct device to start =
with?
>>>>
>>>> We can get/put usb charger and mange usb charger attributes with the
>>>> device model if we use a struct device.
>>>
>>> We already have that as part of struct usb_udc. Why don't you just
>>> create a subdirectory called charger which will hold all your
>>> charger-related attributes. That directory will only be created if a
>>> valid ->charger pointer exists.
>>
>> That means we can remove all the device and class things in charger.c
>> file, right? OK, I try to do that. Thanks.
>
> right. Keep your charger.c file, because to conditionally compile and
                                          ^
                                       we want=20=20=20

> link that to udc-core.ko, but remove all the class initialization and
> all of that extra code.
>
> --=20
> balbi

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaTj0AAoJEIaOsuA1yqRE1KAP/A+PcKPkW7iWMIeo91hrrebR
ZNpp/EOGLAU5n6xqWtrOWZbYjZyVVb/hf/t59V7hKdqhNMAgbc6iVOp8+soRSwte
MpZzXH0UlL25igBy3FrflHqweSHrv0j8XqRjOrs9rDFKfo6hc0Rj1qXIAITsXnZb
MJVZNwMTPys2jHiK/JbE0fmJZw3n7ypu7hxnM+YhmzxoFyQDLKDPg9y0qphzV2zh
5kp6jEhDyKHwtXtFu2uSf2VbnfLE9LUo1kpvUlCCYGn4rVY5M1UtcXwvtAb94RuW
9U6gOXWp9wWaLJKsLqiioyHJbB9aRH7xwRm/LUeoFpmDJ0sNUDr0Y4TQG8uexxSA
KaUMiRWgHvTTZP2p0LvFZneYtHBPVl6i/f8LQOdxTKxJ1KgZmcC6Za5oCQ0mGt1x
ETsZWN0KP8aZjQlb1IMdaVvuSqPzAdooEFe+2NVNu5EIiAPnNQOBngHR5Y8paNSP
dJ5kZxCJbCKBa2btDtBu+M3ME0EXcp9nvj9pnrTAEv9SWziBul706rJp4N8wEb8t
qhF/4YuzXW7PLNWt4wMFsbv1HOYc3RDpjmMxj143Yq/jmg9d6vXDaG0vKDCD0jnM
dKtrOwW1ZBTJZ07idAre2flAruTeR3jUEAKgpyTOLRDuKwaVAojmHAi7yyk92u/J
ffylAc8LfWwnf9A+vMp0
=wANB
-----END PGP SIGNATURE-----
--=-=-=--
