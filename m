From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
Date: Wed, 15 Feb 2017 13:51:31 +0200
Message-ID: <87mvdnoenw.fsf@linux.intel.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com> <1486776443-2280-7-git-send-email-peter.chen@nxp.com> <e532a212-cd15-ab42-6188-fc11a12633af@ti.com> <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com> <cb7182c6-0236-26f2-4f96-9bc001994728@ti.com> <CAK8P3a22f=sQXt+3-PeAuBFQN7_4iXDQhu41teExd6bxJXxDAQ@mail.gmail.com> <20170215013514.GA6579@b29397-desktop> <cb3ee971-6d97-fff1-64f7-1b527559b047@ti.com> <20170215085127.GA26227@b29397-desktop> <2a3d2d65-e531-aaca-d5a1-a71f818cec61@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a3d2d65-e531-aaca-d5a1-a71f818cec61@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, stephen.boyd@linaro.org, frank.li@nxp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gary.bisson@boundarydevices.com, Vivek Gautam <vivek.gautam@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Rob Herring <robh+dt@kernel.org>, Alexander
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>>>>> Why are we using sysdev to read DT property? We should be using the
>>>>>>>> XHCI device (&pdev->dev) here, no?
>>>>>>>
>>>>>>> If I remember correctly, this is one of the cases where pdev does n=
ot
>>>>>>> have a device node attached to it because it was created by the dri=
ver
>>>>>>> of the parent device on the fly in case of dwc3. When you have a pu=
re xhci
>>>>>>> device in DT, the two pointers are the same.
>>>>>>
>>>>>> From drivers/usb/dwc3/host.c
>>>>>>
>>>>>>>         if (dwc->usb3_lpm_capable) {
>>>>>>>                 props[0].name =3D "usb3-lpm-capable";
>>>>>>>                 ret =3D platform_device_add_properties(xhci, props);
>>>>>>>                 if (ret) {
>>>>>>>                         dev_err(dwc->dev, "failed to add properties=
 to xHCI\n");
>>>>>>>                         goto err1;
>>>>>>>                 }
>>>>>>>         }
>>>>>>
>>>>>> So it is setting the usb3-lpm-capable property into the xhci platfor=
m device
>>>>>> and we should be reading the property from there.
>>>>
>>>> Why dwc3 needs another "snps,usb3_lpm_capable"? Why not using
>>>> "usb3-lpm-capable" at firmware directly?
>>>
>>> dwc3 is not setting "snps,usb3_lpm_capable" but "usb3-lpm-capable" for =
the
>>> xhci platform device.
>>>
>>> What did you mean by firmware? Did you mean something like BIOS?
>>> At least TI platforms don't use any firmware like BIOS. So dwc3 driver
>>> needs to create a platform device for xhci on the fly and set the DT pr=
operties.
>>>
>>=20
>> By readying code, the dwc3 calls dwc3_get_properties to set
>> dwc->usb3_lpm_capable, and at dwc3/host.c, it sets property
>> "usb3-lpm-capable" according to this flag, why not let common
>> code xhci-plat.c to get this property from sysdev which is DT
>> nodes for dwc3?
>>=20
>
> Felipe, any comments?

Won't work. We have quirk flags which are based on DWC3's revision which
is not accessible by xhci-plat. Also, we can't call
device_add_property() because it's not really *adding*. It's *setting*,
meaning that we would loose all other properties.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlikQMMACgkQzL64meEa
mQZZhw/+PLmXD6TQO67lv7gOh1A0QrX48cqA0ZQr+XfOvreKsJIet6f8FY1XNeDo
yWfRqHZKmViE2B4MKySBMREV+AV4gALzGNfbZexwUYVdxWZAoBGVJv5WAKWUdLwe
3+VMyeGeibutjktxy3eQI4gWeVu8v5FGK0zW7uZU7gIyU0mVae8fkxCfUIiYlfft
xp8KPbN2zovhumgmq9z4Mpc8D/hIyTwRVswsx4BQ693CiAx685lb5VA4MXS28Q+B
zzIoMZ6b3t8RJPA0bG2DGa88ga88/JIjyXQnpp7ofQXJ3xjUs4D9k2/CFEHp/TZD
7oBf1tUZQ+jpejCTAwA2Z4gsd6YiE8gB8eRWUU20PeFRMBICJxwWuYyG9hs1+lec
SwoQfCInmygNBR3uqKmVOuJ+KgO7iHlmEz5xLnYYa9HBIvg9tttP/Nj8pR2tm93N
IKKL+uWeUsQuutmDTEP2PuVTX0iPTaMIElQQsP1hHvF4PjAcYT6gk1sIcEbxP1vi
4AuJVfISdc/TPfsNBwKCuncqhBa3qrgKZQirQrOEF1QasW3HPym2SppiPBTqTQeh
8d6zQzxfD1GsHHdn2gq/5EAq9sX0MvjJyl67CvuTa0jTjlOPBOLFTSTV5vI/0rIa
XsltXbtHfm1hkpCe9GS2DOFGbDHNdagsdysBT6+CfY95xMfWB2o=
=EbP5
-----END PGP SIGNATURE-----
--=-=-=--
