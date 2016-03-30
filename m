From: Felipe Balbi <balbi@kernel.org>
Subject: RE: [PATCH v8 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 30 Mar 2016 14:24:41 +0300
Message-ID: <878u10jjie.fsf@intel.com>
References: <cover.1458822334.git.baolin.wang@linaro.org> <20160325070937.GA22398@peterchendt> <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com> <AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com> <AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com> <AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLY8vO5qnkuY+kv91zKpdxBBSDeLZXFvD1LjnS3R3UccA@mail.gmail.com> <AM4PR04MB1665E85D823D5AB59B54B56D89980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20999 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbcC3L0j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 07:26:39 -0400
In-Reply-To: <AM4PR04MB1665E85D823D5AB59B54B56D89980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Jun Li <jun.li@nxp.com> writes:
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang@linaro.org]
>> Sent: Wednesday, March 30, 2016 5:31 PM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: Peter Chen <hzpeterchen@gmail.com>; Felipe Balbi <balbi@kernel.org>;
>> Greg KH <gregkh@linuxfoundation.org>; Sebastian Reichel <sre@kernel.org>;
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>; David Woodhouse
>> <dwmw2@infradead.org>; Peter Chen <peter.chen@freescale.com>; Alan Stern
>> <stern@rowland.harvard.edu>; r.baldyga@samsung.com; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com>; Lee Jones <lee.jones@linaro.org>; Ma=
rk
>> Brown <broonie@kernel.org>; Charles Keepax
>> <ckeepax@opensource.wolfsonmicro.com>; patches@opensource.wolfsonmicro.c=
om;
>> Linux PM list <linux-pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org=
>;
>> device-mainlining@lists.linuxfoundation.org; LKML <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with
>> the usb gadget power negotation
>>=20
>> On 30 March 2016 at 16:07, Jun Li <jun.li@nxp.com> wrote:
>> > Hi
>>=20
>> >> On 30 March 2016 at 10:54, Jun Li <jun.li@nxp.com> wrote:
>> >> >> >> It is not for udc driver but for power users who want to
>> >> >> >> negotiate with USB subsystem.
>> >> >> >>
>> >> >> >
>> >> >> > Seems you don't want to guarantee charger type detection is done
>> >> >> > before gadget connection(pullup DP), right?
>> >> >> > I see you call usb_charger_detect_type() in each gadget usb
>> >> >> > state
>> >> >> changes.
>> >> >>
>> >> >> I am not sure I get your point correctly, please correct me if I
>> >> >> misunderstand you.
>> >> >> We need to check the charger type at every event comes from the
>> >> >> usb gadget state changes or the extcon device state changes, which
>> >> >> means a new charger plugin or pullup.
>> >> >>
>> >> >
>> >> > According to usb charger spec, my understanding is you can't do
>> >> > real charger detection procedure *after* gadget _connection_(pullup
>> >> > DP), also I don't
>> >>
>> >> Why can not? Charger detection is usually from PMIC.
>> >
>> > Charger detection process will impact DP/DM line state, see usb
>> > charger spec v1.2 for detail detection process, section 4.6.3 says:
>> >
>> > "A PD is allowed to *disconnect* and repeat the charger detection
>> > process multiple times while attached. The PD is required to wait for
>> > a time of at least TCP_VDM_EN max between disconnecting and restarting
>> > the charger detection process."
>> >
>> > As Peter mentioned, the charger detection should happen between VBUS
>> > detection and gadget pull up DP for first plug in case. So when&after
>> > gadget connect (pullup DP), you should already know the charger type.
>>=20
>> Make sense. In our company's solution, charger detection can be done by
>> hardware from PMIC at first, then it will not affect the DP/DM line when
>> gadget starts to enumeration.=20
>
> I see, charger type detection is done automatically by PMIC when VBUS
> is detected in your case, you just assume the process is complete

assuming this finishes before gadget starts is a bad idea. It would've
been much more robust to delay usb_gadget_connect() until we KNOW
charger detection has completed.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+7d6AAoJEIaOsuA1yqRE4YwQAKNouReSBJUPTj9JgT/txBp/
nOrxdmFupekc9dkDa9jc0gj4a/0zahM/5U6r8UQtRDJFzpcgP13Vdnjk0/Ha9vre
5nTotkVTmu6nSJlTDDgbxFwOApxPipNxAoQ1NZF5oAJ2LSY5/hn8T5CnY/YxfQc3
bQj8CdEXlFNekn0nmw9X+Wm+8Igz0tEbDFNP+/rGshZVB+So4EvOpzgHOC9kUj6H
RYu8YWU56X4fiRdP1vPKiYGEgRrG4iHwRZgMD2iGHNkq/XDmgYUtldMKkPbDkfPZ
Y/COwGykTvlag2NM1li94+Y+iwsWid7OMEeXy1kQocVfLVUGGUT6GJO4OYc3p7nd
saAOEaCG/mtr4fwS9X+zdtdOZVLmeRo8c7EvUTHw8bR9FZEDZ3xJW3BGSnRPTBkT
NNr0epBU2bfn2rNG10JVl8SMmgP5iZAaBvOTX1vDWHpK0vHjU40qyTpPg+zB2oTV
6siWFOJq/SXADJfeCZWdzVj7tyoOYN/RWk6EtlFXx4X/6UG+EKZp4BYxEUIpS6wo
RvaposzuAASTwhIdnQsSuiyV1qUvvQ4rS4gUrUe7yltroP3/zMdKUes77/ff6Add
2FzjE0d4spUKR92RvG0A4r6KEqIiG+sFEWhQzaNwGbfJ9TNtOuYw8sVcCKBeyj+Q
j5Uxa30BpjBWmL3AQGQu
=ArvR
-----END PGP SIGNATURE-----
--=-=-=--
