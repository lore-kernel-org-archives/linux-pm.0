From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Wed, 29 Jun 2016 15:30:20 +0300
Message-ID: <87r3bggotf.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com> <87eg7giexn.fsf@linux.intel.com> <CAMz4kuK30ZGdqgyHNj=xnVLSpceCFD4R8-LvqMS3EOUTUhcHtA@mail.gmail.com> <87bn2kieb6.fsf@linux.intel.com> <CAMz4kuL9pJzNsn7xXXCp4s9Rczm5vWhuWfF7VjkuxsMUzNZXZQ@mail.gmail.com> <87twgcgpwp.fsf@linux.intel.com> <CAMz4kuJ2duayzdBL07+pMh5YA6QRXozX+CNpc8M8VQi=KicFbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23413 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbcF2MbH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 08:31:07 -0400
In-Reply-To: <CAMz4kuJ2duayzdBL07+pMh5YA6QRXozX+CNpc8M8VQi=KicFbA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>>>> For supporting the usb charger, it adds the usb_charger_init() and
>>>>>>>>> usb_charger_exit() functions for usb charger initialization and e=
xit.
>>>>>>>>>
>>>>>>>>> It will report to the usb charger when the gadget state is change=
d,
>>>>>>>>> then the usb charger can do the power things.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>>>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>>>>>>>> Tested-by: Li Jun <jun.li@nxp.com>
>>>>>>>>
>>>>>>>> Before anything, I must say that I really liked this patch. It's
>>>>>>>> minimaly invasive to udc core and does all the necessary changes. =
If it
>>>>>>>> wasn't for the extra charger class, this would've been perfect.
>>>>>>>>
>>>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>>>> completely?
>>>>>>>>
>>>>>>>>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget=
, unsigned mA)
>>>>>>>>>  {
>>>>>>>>> +     if (gadget->charger)
>>>>>>>>
>>>>>>>> I guess you could do this check inside
>>>>>>>> usb_gadget_set_cur_limit_by_type() itself.
>>>>>>>
>>>>>>> We will access the 'gadget->charger->type' member when issuing
>>>>>>> usb_gadget_set_cur_limit_by_type(), so I think I should leave the
>>>>>>> check here in next new version.
>>>>>>
>>>>>> Here's what I mean:
>>>>>>
>>>>>> int usb_charger_set_cur_limit(struct usb_gadget *gadget, unsigned in=
t mA)
>>>>>> {
>>>>>>         struct usb_charger *charger;
>>>>>>         enum usb_charger_type type;
>>>>>>
>>>>>>         if (!gadget->charger)
>>>>>>                 return 0;
>>>>>>
>>>>>>         charger =3D gadget->charger;
>>>>>>         type =3D charger->type;
>>>>>>
>>>>>>         return __usb_charger_set_cur_limit(charger, type, mA);
>>>>>> }
>>>>>
>>>>> But that means we need to export  both 'usb_charger_set_cur_limit()'
>>>>> function and '__usb_charger_set_cur_limit()' function in charger.c
>>>>> file. Cause some user may want to set the current limitation by one
>>>>> charger type parameter (may be not from charger->type), like by
>>>>> issuing '__usb_charger_set_cur_limit(charger, SDP_TYPE, mA)'. How do
>>>>> you think about this situation? Thanks.
>>>>
>>>> if we have that requirement, that's totally fine. Just rename
>>>> __usb_charger_set_cur_limit() back to
>>>> _usb_charger_set_cur_limit_by_type() and expose both. But
>>>> set_cur_limit_by_type can assume its arguments are valid at all times.
>>>
>>> Make sense. I'll fix this issue in v14 version. Thanks.
>>
>> there's one thing bothering me though:
>>
>> gadget->charger is supposed to be "current detected charger" right? If
>> we have a single port tied to a single charger, in which case would we
>> *ever* need to change current limit of any charger type other than
>> "current charger" ?
>
> What I mean is user can set the current limit by charger type as what
> they want at initial stage. As we know the default current of SDP (not
> super speed) is 500 mA, but user can set the current limit of SDP as
> 450 mA if there are some special on their own platform by issuing
> '__usb_charger_set_cur_limit(charger, SDP_TYPE, 450)'.

Oh I see. Odd, but okay

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc79cAAoJEIaOsuA1yqREitEP+wfLt4OWLQ8vSmMEZUO4toS0
yr0h41MGfOqsdU8Q7F7UYiansUXiK9H7Xj8N6D4ofFXNA2Os+GXaZS8UJmGYbaz1
ton7HqN1u/V6NhGi1k8WYzN3tPTQu9ma/rBGkCTL7t365sVfWQhMdeAviWaFJqlE
lcYYwwbaGY9xu8ksMMauDG/BI7dkh6OJISMcGYZJz4D0jmQ+9SjDevFYXLixZerK
s33xPXuLDO4vSCrh6LnIn8uDaecQ64AEzqjaC1LVs/a+2xNp70/edhpLpz5EG7hr
BKzf4n61vl7YTKB09YkDk5Bq+VENbN5bS1VVmc4wcDjaxgsKrq045jJiDTADwPDv
psZVtxzGTVM4AVYXt6FixwCXIT4MOMzsLejcga5n4VegCBFd2it31gLPnR/KWmNg
bfDWc08MMiLY4ShxUAvA9D4fzs7LLrvpPGnHoORyR7m8HKqzg8cd+RxLaQOoFlTg
InscGyuYqIg/HBjGKkloTPfIarqzMSQDGbzk3f22Tshje8z67pHUiYp8he/dcWBC
8AkQ1sCLEq+0Kx9cXZLgYRUV5AgBVT0eV9obYnSegxhQkOkTIJFcZ4nM2tO0m3jM
12tDauO4RHrEiN3HkKu5VXxdF4xAFI86awTWXLuTY/TNsS7agtPO0OXq0Wl9rFEF
BzJ7wi33MCYWIKy3LTCI
=Zm7Q
-----END PGP SIGNATURE-----
--=-=-=--
