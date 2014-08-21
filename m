From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Re: [PATCHv3] thermal: exynos: Add support for TRIM_RELOAD feature
 at Exynos3250
Date: Thu, 21 Aug 2014 12:32:47 +0200
Message-ID: <53F5CACF.4050600@suse.de>
References: <1408450078-6296-1-git-send-email-cw00.choi@samsung.com> <1408492364-8012-1-git-send-email-cw00.choi@samsung.com> <CAC-25o9LjKwjBwwxcOvV75bXEHGdUh2vU=ae1STsXxD6q4YsiA@mail.gmail.com> <53F54D86.9070601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35972 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820AbaHUKcw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Aug 2014 06:32:52 -0400
In-Reply-To: <53F54D86.9070601@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, Amit Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, l.majewski@samsung.com, naveen krishna <ch.naveen@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello,

Am 21.08.2014 03:38, schrieb Chanwoo Choi:
> On 08/20/2014 10:38 PM, edubezval@gmail.com wrote:
>> On Tue, Aug 19, 2014 at 7:52 PM, Chanwoo Choi <cw00.choi@samsung.com=
> wrote:
>>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/th=
ermal/samsung/exynos_tmu_data.c
>>> index aa8e0de..8cd609c 100644
>>> --- a/drivers/thermal/samsung/exynos_tmu_data.c
>>> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
>>> @@ -95,6 +95,8 @@ static const struct exynos_tmu_registers exynos32=
50_tmu_registers =3D {
>>>         .triminfo_data =3D EXYNOS_TMU_REG_TRIMINFO,
>>>         .triminfo_25_shift =3D EXYNOS_TRIMINFO_25_SHIFT,
>>>         .triminfo_85_shift =3D EXYNOS_TRIMINFO_85_SHIFT,
>>> +       .triminfo_ctrl[0] =3D EXYNOS_TMU_TRIMINFO_CON1,
>>> +       .triminfo_ctrl[1] =3D EXYNOS_TMU_TRIMINFO_CON2,
>>>         .tmu_ctrl =3D EXYNOS_TMU_REG_CONTROL,
>>>         .test_mux_addr_shift =3D EXYNOS4412_MUX_ADDR_SHIFT,
>>>         .buf_vref_sel_shift =3D EXYNOS_TMU_REF_VOLTAGE_SHIFT,
>>> @@ -160,8 +162,11 @@ static const struct exynos_tmu_registers exyno=
s3250_tmu_registers =3D {
>>>                 .temp_level =3D 95, \
>>>         }, \
>>>         .freq_tab_count =3D 2, \
>>> +       .triminfo_reload[0] =3D 0x1, \
>>> +       .triminfo_reload[1] =3D 0x11, \
>>
>> What does 0x1 mean? How about 0x11?
>=20
> The bit of 'RELOAD' field in TRIMINFO_CONTROL register is [0].
> and The bit of 'AC Time' field in TRIMINFO_CONTROL register is [5:4].
>=20
> 0x1 means that set RELOAD field.
> 0x11 means that set RELOAD field and ACTIME field.

Might be a good idea to use #defines for 0x1 and 0x10 then?

Regards,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=C3=
=BCrnberg
