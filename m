From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv5 20/20] MAINTAINERS: add maintainer entry for thermal
 bindings
Date: Wed, 13 Nov 2013 10:46:25 -0400
Message-ID: <528390C1.2060902@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-21-git-send-email-eduardo.valentin@ti.com> <CAOesGMiCh-nGPqJQd4NPz9st7mBT0JkZ9nEK1gfyF2RmnrXZog@mail.gmail.com> <52828C31.2050604@ti.com> <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="slmGsk2f3aKAX9TOXKTg41uE9VJimV0Lc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45451 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757299Ab3KMOru (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Nov 2013 09:47:50 -0500
In-Reply-To: <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "wni@nvidia.com" <wni@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--slmGsk2f3aKAX9TOXKTg41uE9VJimV0Lc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-11-2013 05:42, Mark Rutland wrote:
> Hi,
>=20
> On Tue, Nov 12, 2013 at 08:14:41PM +0000, Eduardo Valentin wrote:
>> On 12-11-2013 15:59, Olof Johansson wrote:
>>> On Tue, Nov 12, 2013 at 11:46 AM, Eduardo Valentin
>>> <eduardo.valentin@ti.com> wrote:
>>>> After discussion and agreement of thermal device tree bindings,
>>>> it is desirable to properly maintain thermal bindings for
>>>> existing and upcoming devices.
>>>>
>>>> As original author of thermal device tree bindings, I am
>>>> volunteering to maintain them.
>>>>
>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3438384..94bfc46 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -6178,6 +6178,7 @@ M:        Pawel Moll <pawel.moll@arm.com>
>>>>  M:     Mark Rutland <mark.rutland@arm.com>
>>>>  M:     Stephen Warren <swarren@wwwdotorg.org>
>>>>  M:     Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>> +M:     Eduardo Valentin <eduardo.valentin@ti.com>
>>>>  L:     devicetree@vger.kernel.org
>>>>  S:     Maintained
>>>>  F:     Documentation/devicetree/
>>>
>>> The number of device-tree maintainers is getting to be somewhat silly=
=2E
>>> You don't have to be a maintainer to be a reviewer, and the number is=

>>> getting large enough that it might get hard for one maintainer to kno=
w
>>> what another is doing.
>>>
>>> So, soft nack, but it's really up to the DT guys.
>>
>> Hello Olof,
>>
>> No issues on my side. As I stated in the patch description, I am
>> volunteering. The motivation comes from the fact that it's been hard t=
o
>> get DT maintainers attention, so I am assuming they are not having
>> enough bandwidth to pay attention to an extra class of bindings.
>>
>> I agree with you, this is up to the DT folks.
>=20
> When we discussed this in #devicetree, I was under the impression you
> meant adding a line like:
>=20
> F:      Documentation/devicetree/bindings/thermal/

This would work for me too. How about adding this to thermal subsys
entry in MAINTAINERS file?

>=20
> To your MAINTAINERS entry, rather than adding yourself to the general
> devicetree bindings MAINTAINERS entry. Sorry for the confusion regardin=
g
> this.
>=20
> Given we have enough difficulty organising ourselves at present, I agre=
e
> with Olof that it doesn't make much sense to throw more people into the=

> general devicetree bindings maintainer pile.
>=20
> However, we would certainly appreciate any review you'd be willing to
> provide.
>=20
> Thanks,
> Mark.
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--slmGsk2f3aKAX9TOXKTg41uE9VJimV0Lc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKDkMEACgkQCXcVR3XQvP1MgQEA4A3me8OJdzA42F/3En97fxl8
+BMg42OFMOItYPRaNTABAJPGu4RiWaQFdYyCqzH50zMuushR8yN/BSnBnE6gu3d0
=VWEh
-----END PGP SIGNATURE-----

--slmGsk2f3aKAX9TOXKTg41uE9VJimV0Lc--
