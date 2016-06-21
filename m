From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger framework
Date: Tue, 21 Jun 2016 10:45:48 +0300
Message-ID: <874m8nouhf.fsf@linux.intel.com>
References: <cover.1465807514.git.baolin.wang@linaro.org> <710550bd6c860d7dbdd3e7225ef51b59ae9c39fb.1465807514.git.baolin.wang@linaro.org> <AM4PR04MB21308ECE74B23A44E51C42B689530@AM4PR04MB2130.eurprd04.prod.outlook.com> <CAMz4ku+1HxXLhFJp6mK+hRqKxHZ+ELC3CmJhupLgDcO7SJXy5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+1HxXLhFJp6mK+hRqKxHZ+ELC3CmJhupLgDcO7SJXy5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Jun Li <jun.li@nxp.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.o>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Baolin,

Baolin Wang <baolin.wang@linaro.org> writes:
>>> -----Original Message-----
>>> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
>>> owner@vger.kernel.org] On Behalf Of Baolin Wang
>>> Sent: Monday, June 13, 2016 4:47 PM
>>> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
>>> dbaryshkov@gmail.com; dwmw2@infradead.org
>>> Cc: robh@kernel.org; m.szyprowski@samsung.com; ruslan.bilovol@gmail.com;
>>> peter.chen@freescale.com; stern@rowland.harvard.edu; r.baldyga@samsung.=
com;
>>> yoshihiro.shimoda.uh@renesas.com; lee.jones@linaro.org; broonie@kernel.=
org;
>>> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.co=
m;
>>> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
>>> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger
>>> framework
>>>
>>> This patch introduces the usb charger driver based on usb gadget that
>>> makes an enhancement to a power driver. It works well in practice but t=
hat
>>> requires a system with suitable hardware.
>>>
>>> The basic conception of the usb charger is that, when one usb charger is
>>> added or removed by reporting from the usb gadget state change or the
>>> extcon device state change, the usb charger will report to power user to
>>> set the current limitation.
>>>
>>> The usb charger will register notifiees on the usb gadget or the extcon
>>> device to get notified the usb charger state. It also supplies the
>>> notification mechanism to userspace When the usb charger state is chang=
ed.
>>>
>>> Power user will register a notifiee on the usb charger to get notified =
by
>>> status changes from the usb charger. It will report to power user to set
>>> the current limitation when detecting the usb charger is added or remov=
ed
>>> from extcon device state or usb gadget state.
>>>
>>> This patch doesn't yet integrate with the gadget code, so some functions
>>> which rely on the 'gadget' are not completed, that will be implemented =
in
>>> the following patches.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> Reviewed-by: Li Jun <jun.li@nxp.com>
>> Tested-by: Li Jun <jun.li@nxp.com>
>
> Do you have any comments about this patchset, if not I will resend it
> with testing by Li Jun (thanks for Jun reviewing and testing). Thanks.

please resend. I don't have the series in my queue anymore, sorry.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaPCsAAoJEIaOsuA1yqREDY4P/2AmtaIDyJFC4wqvIKK9nMfe
DkjdOiIA5yjd5iMkw3wqGUEisBYBFF6Ue7BDr2t8RyiDAsxXy8GcQAfmKpRq32zN
sVZXSlql23ojQs90yHWyCTSPG4DFZKVx2RyF2Jsu6QqWmyigavlJZ7rMQXmlViVV
fJifEsdXWjZ3ZmamZqTN0ZpMJubyWIt/SYMKjIl0tBmQR5jWnaiFFo/5X7e+YwdT
VVS6td32+rRdzyacGwpdrm0TVGndVxh787AK30KBryKDLbkGSg87AtKPaKRHeKS4
8DM8n7ucKXHRqBAGh04RtGj/yPzAIto3Bs8+kOTSQxykPJ1fIIc8XnV3Vk1LBvgm
jWMZSyPXqvsFBNLUDrQntIzY5nWDMMFuAXuKNxn94f77hhKNILbIqpp9YZ1j3FC0
SQ1NIc2J57iS12g4bJhzblHEWwSUKpm6ju5GE0hvEko43ClZxa5pkCtHlbHd9qAj
CdMBfAj456Pct6ZHpYsIQwE1Xac1uX6wN0/WGCN+gz8v79E5nHPEcWVH0z32bCwY
M3G5getZy5IUfvh0Q+x5mH3WQ3n9ZH6JMmBmCBX9/S9pbiev4XHjx/O7tsHJgI6S
oFbK907ljalTFFECTc/B+nCfJEdKCK6ZOJccLg3XLp1i/6A0mJ5E1R4Xa/BTKz+v
9A7MRCylFNnK0ADYzmhx
=Pdzx
-----END PGP SIGNATURE-----
--=-=-=--
