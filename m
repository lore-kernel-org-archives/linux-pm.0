From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] PM / devfreq: remove checks for CONFIG_EXYNOS_ASV
Date: Sun, 15 Mar 2015 00:10:41 -0400
Message-ID: <878ueyaoji.fsf@gmail.com>
References: <7638065.14871400820762911.JavaMail.weblogic@epml08> <CAJ0PZbS_Xcu=OJuiy=xs7k_A1=ajp34KEdi4KGC3e-y8t3EUGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33261 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbCOEK4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2015 00:10:56 -0400
In-Reply-To: <CAJ0PZbS_Xcu=OJuiy=xs7k_A1=ajp34KEdi4KGC3e-y8t3EUGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com, Paul Bolle <pebolle@tiscali.nl>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?utf-8?B?6rmA6rWt?= =?utf-8?B?7KeE?= <kgene.kim@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--=-=-=
Content-Type: text/plain

MyungJoo Ham <myungjoo.ham@samsung.com> writes:

> On Fri, May 23, 2014 at 1:52 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> On Thu, May 22, 2014 at 5:37 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>>> Checks for CONFIG_EXYNOS_ASV were added in v3.3. But the related Kconfig
>>> symbol has never been added to the tree. Remove these checks, as they
>>> always evaluate to false.
>>>
>>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>>
>> Thanks for pointing this out.
>>
>> ASV was supposed to be merged, but it appears it failed or never attempted.
>>
>> I will merge with the next batch (this week).
>>
>>
>> Cheers,
>> MyungJoo.
>
> Uh.. ASV itself affects the power efficiency; thus, I'd like to keep
> it alive, but not as the current form.
>
What is the current status of ASV? I've not seen any patches since this
was sent.

Cheers,

- Ben


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVBQZBAAoJEHPt6ejPuu8BTQsIAKI4APrIB1L/lXslJ/OIqrNj
R2SfucM3HB1H/PFshgoTfgZ57TC72K+zvBfv6zcuUQ8jgUzelIuLTwBosORVpB0b
P6vxqLpdLqFg3VC5RH4FB6wBOXJiuNIfxF3zZrCH2Et67MTkcUrtf3ricdGT23xs
cM+xX5Dd6b8EvFU0HqBIDIGhLEY/N4+4wj8/sgR3ED+ZPHDx8zsscsVGvR1+tOpC
VmGovJMHWOMaAc9TYHcKVA8Mi2lVfqbOP/nOhKMVr8zVetFyyeYjfoRsNB+jIWYY
Ur5l+Wtm49EfSd/0wPrrLhkUTkQvPsKUd+WtcHbmUgjNDhdAmK1sp62t+0ru3XU=
=U3D4
-----END PGP SIGNATURE-----
--=-=-=--
