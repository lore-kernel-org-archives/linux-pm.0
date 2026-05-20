Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8283D8130
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288093; cv=pass; b=HQxgsNbBV3bTbnBeNKzbXXppTPRaRJ5Uwfa46e/DdjBSl30O0W5boarypIzAVfkJ36NOkbRyPVdWdAaVCY8Kmc3XhUC1VqTc63h6JYuCDlx4GaF0hESUfyvIu7xUrlo9teo2TI+NdbQNwGMwmmAM6QHexuOF5kl9tPuezLawMEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288093; c=relaxed/simple;
	bh=xbUg8Tez49Qym/fFbF+EEOQeWpWM0YvZSTU0Ng9IgYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuB0x4R90933Hr0atm27YwQckYd+9HXwaJMW45b3Syv67+idJLB5ObQmJ8Q/0XisbMhNheJkAGNedfzfA1VMM9FDgTtXEiH/7y6YkIwl/XI8buOFgSngHhKTNkJzj86rmB4BboZZoF0GsldH/QH6Qo0a/HH4juTxbyyqE+SAS+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx9EpT+x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+upmF5H; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx9EpT+x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+upmF5H"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDiOBW1725603
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=; b=Gx9EpT+xa8pxdOq0
	XNYzY8kOQM/Hr7PLVClI3TM+OYCo0nTMERSQDLo1l0XIQ5UtfJCa9gm5SY8Y/toD
	GJf01zTFg7pUDWODu/rb3SNSx94qWl4lvo6jSUNerqpbaunNf/SZaPd+nDYOcS1X
	GEXzuRAith+p5H1MSibwmmth5SpzYTLEEjrlfrEU7DdncBJ7wyM8L2Lic0+MZq6E
	CLMVnqOsRNHgkveL8IzMTePUzoFN5jt+izlZdzmb3RNJV1+swrowgRodrpcq1Vmu
	nMyAxF2xMLnQCG5Du+CNzVR90Xcc3Is3KADZK1SOH2BznSu2S6oOHJVvboRkd+is
	XoPjZQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qn74g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:41:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-43a356e0119so14055038fac.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 07:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288091; cv=none;
        d=google.com; s=arc-20240605;
        b=emj1TK58b3rY9VYNcYq6Zl2GRIpTUNWZjpxS5bG0KM45djAELM8V+EkiSnrOmeHvs6
         PoCOfOTLncP1Yc5wYVU8nKX+0/04eCcE7oA+d4I/nPgpTH2Em6q50nHg/eGCQchJCKaA
         LhimLeJcoxMiRIO//nHem6Q8QkU6IQD8Bvs0/AWG2sfXRFPzgDo3BPNDJ6Kaz3ZRKwx6
         RhBVi9hBGhVVL2RDxqSB0RKgtZBeamHtF/Da2dQTvtkQgXhGwgmgdjJuq1uKELq8V57C
         rNhTTexmxoETHOuEwRrzszGM95CjhP6YhKAptNZTUGHrFLwmgyQSCpNimXGGQRHs8E3u
         8noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        fh=+sEgvPz4KzKrwKRmp/pUhbSabxjy/AhO3ZnLcBDj3jA=;
        b=cA+ZpqT4mxQlUtHv6bxA2tR3QnEevWKOnAtrZk833F5+XfljF59EPKasrg72ZDzff2
         0PTES+uUPNyssjdCVlXeSJ1+Z3LQMxtduxFcK9QnNLuSpGe6HX0/yPNXWjsuu8BgXN3d
         dgLpFWwZgX8L4eJ7cICO+yLDjmTgPU2DALQlXDK6dRZ3d0ldSUdr69X7aAsRwwL6oWHN
         7mBXHVX20qNWavu/NojnAU0ZVdyznrZQ5yajLq8BD+5p9QJ/oQa4O3yjQE5Sz0cWqGuA
         j8OlzJyQK2gK7wQPt+7BhumRcuYJwas2252H6Jc1i5XkBDHWpJZASClcrvTWIdmGhv4r
         MaRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779288091; x=1779892891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=C+upmF5HsRq0cE+0KO8ZioGMSW4S9IVDtTUGzIAf4rCG20ipjBP+gjvObtW5VLZ3US
         RBf4UmQ2MnFgCZDQJRJO7OP1aTaEHO8PbpOFTC6fkW2m3EgD/AYG0H+c2/J2H5MJTkOy
         uT9Mn2mao2yyae5E7e5J8O+yqumrVBpzckZ5j+vHPALrdnStgyNeeJlApKMdUmW2NqIl
         /5s49xjgaIuTaNNym0QoN9Zu7wjKiJDvpI4NLfBupSqiTAUc2U7Lqw+7fHF8OTBb9OuC
         Qw9mbGoM527Ry6lecomVoErt7LMN74vNaUdrISWXEbYYWae/TLDsTVAiBfI70mZCnYlM
         iIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288091; x=1779892891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=IrrAoBqN1odGl4baSkAolVxCLFVA4JFUgf8/FD09NLtqjukr2yo1+LiYL3OisyG5zI
         DnOkFeq9lAzfFi26NgwAeRtozraNeUTt9SdRrVVP3JZBy1MP2Qi58VF5qjW9gziuGo6D
         okB+JWn48XdRj/pJwpWn8M3VC7FmDNHDGJEqaSChWmaqPCFmuFFUAd4efIlGdOUjdQaD
         N6htmSxOTMS9ZN7Lftw5Ado1hv4RVA444Qa5V9gvJPi6D4prXKZZyKveBx4LBs0fc+fB
         b4mMb7DAfceteEI7GOjAVImB4jtYX0+V5uPWOlk/PsaZt21leFrwlNJE1dJqBjv1pfFz
         527w==
X-Forwarded-Encrypted: i=1; AFNElJ+MrnshRq4Bju87TJd3nlTmWck7myQIS/e82PXEQsAlzR3GJ4cQ1NWuT7N+jDslxUDnP2vtzg8jHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBwbtDhz/I+9KwNY+SGcERUh0N2MTltyuY0fxKE2b5kaINnWX
	NC6MnEjZhE6U83P1i95e8hehCsCReNZBSEXi+6/97Zk8kMS0XQIpP90Ll07Zk9IYsVzTtkBG3qh
	Dm3n1J3auslD6FkHdWe1UYuoMYJemvqzqPMPmsU4pci//cgz/+0FqPPKEdJ4K0cT3+MxgKPl7SF
	eEePQk1qqCSfzMrDk5hIny22HfyniifydEYbHD
X-Gm-Gg: Acq92OHRpyDeW3baJoz4wX0klb/oqjcNmsE0Dzx89PKqZiioNwP5wIkwqob6aoqzinc
	tg6shyl/0SX2K8BMRI1RcgTGJczk9DJMem2wNPNjcypzdKFW8JmdlUMn8bqmQcTd9UWZqBpAsBj
	IReJQ+INuJudyhot1IcPVlKrB6arV6xIYn5aLTjFXQtwxjdGAjt/zQxJFec1uGG3Bfw8vDY3amx
	PcTuG55aiBAi2sq4cUxYWdvSEpTYO6JgaZLSII=
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id 006d021491bc7-69b884ac83amr13326877eaf.33.1779288090703;
        Wed, 20 May 2026 07:41:30 -0700 (PDT)
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69b884ac83amr13326862eaf.33.1779288090260; Wed, 20 May 2026
 07:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com> <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
In-Reply-To: <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:41:18 +0200
X-Gm-Features: AVHnY4KjiuGhKKWHmCXQOioTVfBJ-iXDUnzJmiSH1aWxruwXcP1EGQFS7-tjBSA
Message-ID: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MyBTYWx0ZWRfX4alfhXmS9Erl
 cjYEMd1lHk5UYw+cqXqDJre1Mhs8M1hbJEYp0bhaZiLBOqjFxSGC+yFwhC6Odq6gSmmhWgcG2KR
 NlW3y12fA8dYr0loFK+i7cusAWc8evOp+SdZvIZIw86DxVvWvzCpO0XfUtmopgWwOofb5JWE0gO
 1kW8W5TCsturpSH/+Or9o6aBPwXkcuQ37X1J0GSsF+YQOZRTaP4k4KFGVBBqOHhnHGAb8Q6ZqSZ
 2C6DhkAY+vU1oaKvIIqICuCGYtSRKtUdnT2Y2GrStarH5PbRHG0AqvgFVDUrEBvgU7usrqpYPIG
 2pixWr47XRMtBQEPCZ4TMrl1C42090BrOsEQapjEhl/prIyi9UZIK+i6DEa+akydbikcG0CpE0D
 jKTJ1yoaqJcW9UXbpWPEFTFSXYbXK4tOxUCDaPxgTBAAG01piZ9C0JOHYJuB0lpI6SSEMRxydGV
 Cf22zXHVD/6c/BAFLaw==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0dc81b cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=QwjQxBKOi-_Ocnt6GWoA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-GUID: msLra81XniKstKzMbwt1jecVkiZWl6AY
X-Proofpoint-ORIG-GUID: msLra81XniKstKzMbwt1jecVkiZWl6AY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200143

On Wed, May 20, 2026 at 4:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
> > On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > > > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > > > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > > > compatible with the M.2 Key E.
> > > >
> > > > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > > > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > > > the Bluetooth interface.
> > > >
> > > > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > > > the pci-pwrctrl driver can acquire the power sequencer and enable
> > > > the M.2 slot before PCIe enumeration.
> > > >
> > > > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > > > (gpio56/gpio55) used by the power sequencer.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++=
++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/ar=
ch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb=
6f07244d185abfb1976d9 100644
> > > > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> > > >               enable-active-high;
> > > >               startup-delay-us =3D <20000>;
> > > >       };
> > > > +
> > > > +     wireless-lga-connector {
> > > > +             compatible =3D "pcie-m2-e-connector";
> > >
> > > I think it was discussed that LGA can't be an actual M.2 E-key
> > > connector.
> >
> > I am not sure I followed this discussion. Do you mean that I should
> > introduce a dedicated LGA/vendor-compatible string in the compatible
> > list of the pcie-m2-e-connector binding, or that LGA-based designs
> > should not be described using the pcie-m2-e-connector binding (graph
> > representation)?
>
> I think, it should be a separate, vendor-specific compat (maybe using
> m2-e as a fallback).

ok, understood.

>
> >
> >
> > >
> > > > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > > > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > > > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > > > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > > > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > > > +             pinctrl-names =3D "default";
> > > > +
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry
