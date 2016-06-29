From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Wed, 29 Jun 2016 11:34:21 +0300
Message-ID: <87bn2kieb6.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com> <87eg7giexn.fsf@linux.intel.com> <CAMz4kuK30ZGdqgyHNj=xnVLSpceCFD4R8-LvqMS3EOUTUhcHtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51315 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcF2IfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 04:35:04 -0400
In-Reply-To: <CAMz4kuK30ZGdqgyHNj=xnVLSpceCFD4R8-LvqMS3EOUTUhcHtA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>>>>> For supporting the usb charger, it adds the usb_charger_init() and
>>>>> usb_charger_exit() functions for usb charger initialization and exit.
>>>>>
>>>>> It will report to the usb charger when the gadget state is changed,
>>>>> then the usb charger can do the power things.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>>>> Tested-by: Li Jun <jun.li@nxp.com>
>>>>
>>>> Before anything, I must say that I really liked this patch. It's
>>>> minimaly invasive to udc core and does all the necessary changes. If it
>>>> wasn't for the extra charger class, this would've been perfect.
>>>>
>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>> completely?
>>>>
>>>>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, un=
signed mA)
>>>>>  {
>>>>> +     if (gadget->charger)
>>>>
>>>> I guess you could do this check inside
>>>> usb_gadget_set_cur_limit_by_type() itself.
>>>
>>> We will access the 'gadget->charger->type' member when issuing
>>> usb_gadget_set_cur_limit_by_type(), so I think I should leave the
>>> check here in next new version.
>>
>> Here's what I mean:
>>
>> int usb_charger_set_cur_limit(struct usb_gadget *gadget, unsigned int mA)
>> {
>>         struct usb_charger *charger;
>>         enum usb_charger_type type;
>>
>>         if (!gadget->charger)
>>                 return 0;
>>
>>         charger =3D gadget->charger;
>>         type =3D charger->type;
>>
>>         return __usb_charger_set_cur_limit(charger, type, mA);
>> }
>
> But that means we need to export  both 'usb_charger_set_cur_limit()'
> function and '__usb_charger_set_cur_limit()' function in charger.c
> file. Cause some user may want to set the current limitation by one
> charger type parameter (may be not from charger->type), like by
> issuing '__usb_charger_set_cur_limit(charger, SDP_TYPE, mA)'. How do
> you think about this situation? Thanks.

if we have that requirement, that's totally fine. Just rename
__usb_charger_set_cur_limit() back to
_usb_charger_set_cur_limit_by_type() and expose both. But
set_cur_limit_by_type can assume its arguments are valid at all times.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc4gNAAoJEIaOsuA1yqREYnAP/1v68H2jDlpR3jC0u7IJmLyy
2VYPI+6UOTWqb6VuwApXbH2knTMQmD2Oi0QzQS0FNvtCzyuG+bhGs4ACgMFxEfAn
GXGDHJxLHv/1nbxPEYnB+Tqt/R29IzRombCis5cQbcjveCASVcvYz+EmFaSpJMCm
TucZIuMBe5i3cF+8H6xeTSng07vkvXwI5gJqRuTGoISWKBqE11hT/zxYV61pZbIO
dc+Q3vrOOol1pw75XGia8GL5DMKlHDdixTHtMWIjfKLn+JQ/bmpS2/lTncJ65Ct+
fYV+2AHI42N/kmXm8dZBbaqqDj+nqYLb1vARpZcKadMdNBE6tuDjbks4PNlnzT8g
Uiry1QpKdddWb0bQW/mPu7g+Mz+GOTCckfhAByHJkDVFkYYCCMnD2cMZMEU8xd9p
lFWKGhtparZX6poMqSPA0nqB1MR8B0zx0jeibOUct4XPOeCYTmCfcmFPdotfJRS2
XKC0pCA6BkFyidccmPPRQ9LM6bNGbXPy3fpWnrwc+WKJmL/doobQO1K8BVJ5Nh0p
tFgrDrAV6uzyp8oLMwsdv9ga+geIwl8veuHCsWytbrvcHrEZKcJWyuEx2AgIp7ez
CbQpcjy0Ua5mnJnHtdYecE2ozzj9W1plZ1YvtF3ijmtGFfumtMyZw63IgMJSPFx3
86PAB8//p8gWdMwiAj0M
=rg/M
-----END PGP SIGNATURE-----
--=-=-=--
