From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 1/4] ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on
 Exynos3250
Date: Wed, 18 Mar 2015 15:16:45 +0100
Message-ID: <5511908.Xj1ZIW6HbI@amdc1032>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
 <3449559.PngGo6WKuq@amdc1032> <1426685545.23982.2.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55144 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385AbbCROQw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 10:16:52 -0400
In-reply-to: <1426685545.23982.2.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org

On Wednesday, March 18, 2015 02:32:25 PM Krzysztof Kozlowski wrote:
> On =C5=9Bro, 2015-03-18 at 14:23 +0100, Bartlomiej Zolnierkiewicz wro=
te:
> > Hi,
> >=20
> > On Wednesday, March 18, 2015 02:10:31 PM Krzysztof Kozlowski wrote:
> > > 2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierki=
e@samsung.com>:
> > > >
> > > > +       while (!pmu_raw_readl(S5P_PMU_SPARE2))
> > > > +               udelay(10);
> > > > +       udelay(10);
> > >=20
> > > We really need to start documenting this. Please add short descri=
ption
> > > why this SPARE2 check is here and who uses it. Without documentin=
g
> > > this behavior future generations won't be able to debug this stuf=
f.
> > > Imagine replacing sboot with uboot by someone...
> >=20
> > I've already planned to do this for this code and for coupled cpuid=
le
> > use of SPARE2 as well.  However I would really prefer to do it in
> > an incremental patch if there are no other issues with this patchse=
t.
>=20
> OK, please do so in incremental patch. Usage of various memory region=
s

OK.

> of sysram also should be documented. In patch 2 you add usage of 0x28=
 +
> 4*cpu. The various sysrams regions are spread over different files...

I completely agree that there should be some Documentation file with
the SYSRAM layout.  I'll do it later unless someone beats me to it (ple=
ase
also add this to our internal TODO list of open issues, thanks!).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

