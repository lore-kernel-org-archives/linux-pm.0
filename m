From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v5 0/7] PM / devfreq: Use OPP interface to handle
 the frequency
Date: Thu, 09 Nov 2017 23:56:54 +0000
Message-ID: <20171109235654epcms1p29b8d05dce899f1b11919823ed66cbd1c@epcms1p2>
References: <CAOCOHw5+TtrCrnDUVj1QjBYb5tivsgTFL_8MgDGocAp0uWoEUw@mail.gmail.com>
        <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171023013213epcas1p165faa416f69659b60ec4c3f18ea251d8@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27247 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdKIX45 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 18:56:57 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171109235655epoutp0312b43f13cfc18abaf3ed6e13227772b2~1kDbwA_Yb2792427924epoutp03b
        for <linux-pm@vger.kernel.org>; Thu,  9 Nov 2017 23:56:55 +0000 (GMT)
In-Reply-To: <CAOCOHw5+TtrCrnDUVj1QjBYb5tivsgTFL_8MgDGocAp0uWoEUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vinayak Holikatti <vinholikatti@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>

> On Sun, Oct 22, 2017 at 6:32 PM, Chanwoo Choi <cw00.choi=40samsung.com> w=
rote:
> > These patches makes the devfreq to use the OPP interface and clean-up c=
odes.
> >
>
> Hi Chanwoo,
>
> This patch series breaks UFS support on modern Qualcomm platforms
> (e.g. MSM8996).

Could you please show us the code location of it?=C2=A0=0D=0A=0D=0ACheers,=
=0D=0AMyungJoo=C2=A0=0D=0A=C2=A0=0D=0A--=0D=0AMyungJoo=20Ham=20(=ED=95=A8=
=EB=AA=85=EC=A3=BC),=20Ph.D.=0D=0AAI-3-Lab,=20AI=20Team,=C2=A0Samsung=20Res=
earch.=0D=0ASamsung=20Electronics=0D=0ACell:=20+82-10-6714-2858
