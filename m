From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 15:27:19 +0300
Message-ID: <87inx2n2vs.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com> <87twgmn4m7.fsf@linux.intel.com> <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>> completely?
>>>
>>> Yeah, I also hope so. But we really want something to manage the
>>> charger devices, do you have any good suggestion to avoid the 'class'
>>> but also can manage the charger devices?
>>
>> manage in what way? It seems to me that they don't need to be real
>> devices, just a handle as part of struct usb_gadget, no?
>
> Although charger device is not one real hardware device, we also use
> one 'struct device' to describe it in charger.c file. So we should
> manage the 'struct device' with one proper way.

that's fine, but why do you think they need a struct device to start with?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaTKnAAoJEIaOsuA1yqREu3IP/RTeVAjccVXE0sy8ytkYe34T
96oS0L/JtgY7QA6bt76k5ElkvYNd4GJ5GFhfOSJi3l7wWUBUZsEf55fQGofvpi+0
3yOHivEYBW62h4NSG4WCliwOhneSbAop+ILV7SIVuNeyhPXV7WTHbL3qEGwDGpnz
nJT5DBtVYMk5ALOCJsY7LKBNzpxeHRTyDUYzEEkIPCWV2aF7vjmHqB3/dS7It9Wl
0wGXr1qZF0rTUuUXiAS+99G8nlGtBE+JAowA8pKQRg53oodbXPjZwLBEAYY0u4Ux
lzXyPfBjbbnd2L797gE8aBYF1+ukX5deroDJIg+SD6o+R+rw2vwxMHGBCIkcMP8Z
FuyLaZyMjeJKU/daK8thsLiUym5ODws3jPK9GZT0wT4nMMyR2qxUepRhajDA76mi
UMoQ6cgIt/dTCCaFznFD0EdnivJP6EYvHczsGD818I5uqtG4p3ZoDh+b6uoYL238
HDEZ0gZphBIX94FJefyrYDzW71ivpHWiHN5X939IHC/pDUr8zQDSyUIlk+nsUc7T
8bjsm9IiL39RPMIpCT6hw7bYiORs/NXa4HuuXQmY2fK77+pNMtGgGpRv9H+MTFG1
75FKCO3NA3upoRIaYvFmdR6jMFX9g8qqc1Ky6JP40HQZGKbb9Yelv8KnmVL589RV
gFOOJ/cl+awzU1zEkChN
=LLYZ
-----END PGP SIGNATURE-----
--=-=-=--
