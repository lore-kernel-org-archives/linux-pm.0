Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D3466B64
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034269; cv=pass; b=us7+pqp2mOI5IGP3j4+LLmWk1YpaAYNxJixyl2CnVZIG60psGreNu+3ZVcHhE2cLCvYjbfyeoly2tpa1Z9BQFgjOoNVorAToQOKhl3tw0B9vrDFgxISQDIAKTuaRPnTRBhas6sEXMWyXJQPV9/oOu+LuXmSRwgQbqUssEB1Ja08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034269; c=relaxed/simple;
	bh=/luk3Ez7jcbTKy8KcXNVXhgf0NBYtT6aBzAKJn4R7Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqiapFN6UypIJrXPAym4nxK5Y1wz0AyKipj0HTth+ASCINyUa8yUUFbyHIXvK3/TzDQXF3WhLhUMsjYoYgvEnHrVndwk8ISP1Q47T0QCGwKpeWmfGgPrFd3qGQXfzHifFHtPvBa7OvFgF1CUh/AI8R0v1rWHeirjAuBbQGTv2CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=beAKbhFJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FTc19aeS; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="beAKbhFJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FTc19aeS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ED3iQs720818
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzwHNQnrs5veaInk/Dsd5ZII47C1meWIcG3m36x+/ow=; b=beAKbhFJR6EXnpP3
	7yRIirxVRv+NhTKXlGHiMhq6/PSIDeJ8UhY7We4cwIkIEUIsf8Dd+kfA7xY07kwr
	iIjkSYwOFMABd3f9/hiDRfrkbMTIOfsYqnvKOWsN8IcU3uaNK1o9SkT5QS13q2bZ
	yHwhkclZPOxZVPWo+3SBxP2HpDEMMKMVCm+c0LGrl28HHLITow2JfkK5V9pa7EED
	dPTfZMZ8TRD30ix5iNoeWi21VpcdZc1qCxmZXi1GodPK7zfk5TeCXaGhV5q8e//u
	sfyqNoCKa//ZPhTJuqyTPovARmDRAb7RcHB54saxQUIi2m9x41uxZTaE5INQZPXB
	bUJwdQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnur03d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:04:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso79000131cf.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784034266; cv=none;
        d=google.com; s=arc-20260327;
        b=C7w+ZOCbF956pEI2Z9tdC+6HhkHYs+TKoQC9fb5z/vvFYdHHzVfDR2CZZA5FfytBX5
         kig2nBHP5X3e60FDtnKamP8exmcsKJGsPWh2P1jz5LWutGQ0pkREHVppvEC3MpW4PUmv
         xdUaa/xBcWAATrmCBvG7e+BeLSR+gCLKZnoaLKgMhUN26sjIP6Me9r+4KKb/Lf/TSAk6
         jozORcoKRYlAccGoksKHRlIiunFDSWKAMeVpteyqx4VJR1Zlay7d6dQQyauDk44tzLz5
         R7XiPxfKG8ukKZVIJddE9PBmSzEk2Ypmsyzw8Y/luuh1v+ascp9GsyBO5RCxPjV4Ts5J
         32gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SzwHNQnrs5veaInk/Dsd5ZII47C1meWIcG3m36x+/ow=;
        fh=Mr4KVvg+Z33wWRoqccLjCrb3UpjZlpnAZTN2gGFW4fI=;
        b=rSxfiBi/XpLKelImUoJOhUbUVT8V6XLZZbHBKvLn5x3KhvAAgFv0ZVwEi0Br+Zj+6A
         ySvj4Iezc5Q1Vo3UU/Png4FWE7VlURhhjIFzx+36wa59zxL5EEjTaN7YwiQrlxjSUqgH
         jXHg0NpWdR5G2MwLm0Sn8JRldHkyj1GbmKA/VkzUMTzaGoAN7z32qlhqVBOoxLJ5NoPN
         jbigYQuYog2DS8pRBX366hQomEKwTJH90HNM+Iy9uLSRqKXeIDSI4Jv3kb3b0gwRkwOT
         scrjaYdfvF1+76kXsLGnqYvabjumLSSwH7ipPJh5oR23+0VwwaNMT6ftcR6pgfXkFeH2
         zqWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784034266; x=1784639066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzwHNQnrs5veaInk/Dsd5ZII47C1meWIcG3m36x+/ow=;
        b=FTc19aeSqh+cwi+b0KxmwvAok2IxXuZ1NwYvHUmRUlAb1yKsrs2q3Xk55k8wrwwIOw
         WzTwpqJejpgPQ20E+eWvlS6/Por8Jh3UL2hzz75XBGXBOwa3dth2pZR5zYyrflXFma4L
         FZR8A+aDabNpPsJXGq38APg66kvychT4f4PsRlJjxgX8KNhu/PTN3tL8RTxVsowYfvis
         4Wc8ql76jpGrYVLsjeR9ZYp+JBHoO4gVaCN6hIn3nVxTVkd7jHpQEUs0YpHz2ElQoS51
         LJ399HqQtXl4f97OCpw0P1v16Ajbnth5WZRo9PI+194t7ih9aevwupByqfou3XUGqLVh
         CDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034266; x=1784639066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzwHNQnrs5veaInk/Dsd5ZII47C1meWIcG3m36x+/ow=;
        b=s5PtfopgUFNaLOA+qxf6CqolZLfER8qMJOOmbst5ZGhHAvDrLco/HGptVHlDyNVjA5
         HknJc4mVsw4xSVte1eweW9cOcnxN1FbBC7OXLWd5HfpPxKZ9lNAtHni8sT6k9sjzOmOD
         WOpsYPv38yEgF0ulB8VpeKafMtjemiavCH2v/gF5nSysfhU7jfkhyZZZ0xKg329bGZtk
         iijQ+1IVXH9RrkFqHoEAXSi7l1uOb6qVzcovzCReUhf9nHenhGSgf8W6fILBlubX4osd
         Ns7XYlb34CUEYAkNeOBWmR++PuADnEB7Sux+Otih0ubKBBzszxoQegM7THu/3b24RPui
         w68w==
X-Forwarded-Encrypted: i=1; AHgh+RpszH2EAhAa3jGcmexRDejXH9pC2UljtXbtUdUp66fUCOeMkyoktzBGcZ301H3BSXZPSIqHievHIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJukkIAbmG9JT73b3F+4Zl7pq4CgOdi6PvAUsQ/AqEqiY6Noe
	5Sm0bsPESxGi3CYvhp2NlUGNtXpuZBoqtSeIF5qm8m76KuVsacyRLZsmsn4lh1oK7Gaz7lg1sG+
	nW6A+bPkMiNgRSPUMf8itVtbzFyp9llus0uTehI2mJ9eVP1beOOf3bAUtTWBGNXDQrqxbw2d8D8
	0/sQpHh0PPXRV4f7orGvMSXQnzesOd3rePvS+K
X-Gm-Gg: AfdE7ckjKVSi0rn+yQ8LWkGuobg++gXI6UyUyCxVD1sl9QjQTKP8matmw4KJItzjnsy
	bO2VdDV1n1DbfqktRZH9j7wi847qnJvtshMGTVtfE8Ph2PrMv5vOKU5B56N9MsKaJX8rorELOTe
	jG/bcM1bUaEUHVUNnjN+mczSQg/D7+2QIPfy+2RAqtfiUjCan1kohR19Vr153kg9XbvKAn
X-Received: by 2002:ac8:7dc1:0:b0:51d:deb9:b0a3 with SMTP id d75a77b69052e-51e3c39c40fmr32445091cf.84.1784034266017;
        Tue, 14 Jul 2026 06:04:26 -0700 (PDT)
X-Received: by 2002:ac8:7dc1:0:b0:51d:deb9:b0a3 with SMTP id
 d75a77b69052e-51e3c39c40fmr32444371cf.84.1784034265302; Tue, 14 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org> <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
In-Reply-To: <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:04:14 +0200
X-Gm-Features: AUfX_mxeevLMvSUnq3-LCE2rrh-wxPKfOm-OSszla6lQd2M8YC-0UB9URvbQZGo
Message-ID: <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Iy64Fg5yqvKKhVGi5i3nOgma6k9pggyy
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a5633db cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=hD80L64hAAAA:8 a=KKAkSRfTAAAA:8
 a=izklIh3Dp5d2CKdXTi0A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNiBTYWx0ZWRfX7IOIhHkjBHsp
 fVmvYz0a9RTkTLbLV2u3TQy789yuAQpv22t5muDaez7olBDquM1xjQIgYZStF2B1CXQcJo6kBCj
 W/48Ret5wdqKoW83D8bgLCD7v+MbmZOeGiRAhXvxtaTB7xpWIhD63O7tbm0LFwwp80Y0fssYUdI
 /iCMpzOJ+YwxQ+REA3UT7cZByYAIgs4i7lNEAWIRtpAtvhxaRg7iYmn5Kvb7RXEdZneG3XDuvwP
 5hnhyqC6tELvBrsIHAmI+9xgVbNtHoVpOjafvr1d5zIEQG4JnWSdbmzTQLkDUlzmJbhV6M27aBp
 0RTmeTlDKsudno+wVyRPlbhODzYcLv67/935FXRbDE+YCCehf8n65tayKUqKUPTgnMhZlhKqQ6l
 tQx7P2UP2IpZgwOTkGOT4C3s2+zFhDn9dXYpKNv8JIkzmm5Tx9BQvVj0bcFPTOdevILlCyu3oW9
 zDFxoL3nS24bQt64yiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNiBTYWx0ZWRfX/0N2KP/jGiLG
 aG6hiE74VK4A1T/MEatvjFA2Rqc16BnzA5yU7qoFLZxwr2lqnAwKiRaQjEHfh2KEmbCL7paafGq
 f9Jh8LXItFRVUHgmf6+4RdY3bTLwCIQ=
X-Proofpoint-GUID: Iy64Fg5yqvKKhVGi5i3nOgma6k9pggyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140136

On Thu, Jul 9, 2026 at 1:41=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 15.12.2023 01:01, Konrad Dybcio wrote:
> > Wire up MPM and the interrupts it provides.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 42 +++++++++++++++++++++++++++=
++------
> >  1 file changed, 35 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dt=
s/qcom/qcm2290.dtsi
> > index ce04d0acdede..0911fb08ed63 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> > @@ -199,6 +199,7 @@ CPU_PD3: power-domain-cpu3 {
> >
> >               CLUSTER_PD: power-domain-cpu-cluster {
> >                       #power-domain-cells =3D <0>;
> > +                     power-domains =3D <&mpm>;
> >                       domain-idle-states =3D <&CLUSTER_SLEEP>;
> >               };
> >       };
>
>
> This patch landed long time ago in mainline as commit e3f6a6994041
> ("arm64: dts: qcom: qcm2290: Hook up MPM").

Without detailed HW expertise (still learning about the UnoQ), it
looks to me that the HW may have been modelled upside down.

The power-domain-cpu-cluster should probably *not* be the consumer of
the mpm, but rather the opposite. This is how qcom,rpmh-rsc works, for
example.

>
> Recently I've added Arduino UnoQ board
> (arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts) to my test farm
> and found that this patch is responsible for the "Invalid wait context"
> warning [1] observed during boot of the recent kernels when
> CONFIG_PROVE_RAW_LOCK_NESTING is set (which is implicitly true when
> CONFIG_PROVE_LOCKING is set since commit d8fccd9ca5f90). This shows
> a real problem if one wants to run RT-enabled kernel.
>
> This is because the above chunk adds the "mpm" as a parent power domain
> to the "cluster_pd" (in current arch/arm64/boot/dts/qcom/agatti.dtsi).
> "cluster_pd" is initialized as "GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMA=
IN"
> (see psci_pd_init in drivers/cpuidle/cpuidle-psci-domain.c, which use
> raw_spinlock_t based locking), while the "mpm" power domain only as
> "GENPD_FLAG_IRQ_SAFE" (see qcom_mpm_probe in drivers/irqchip/irq-qcom-mpm=
.c,
> which use spinlock_t locking).
>
> I've check and there is no easy way to make the "mpm" power domain
> GENPD_FLAG_CPU_DOMAIN compatible. drivers/irqchip/irq-qcom-mpm.c driver
> uses mbox API, which internally uses spinlock_t based locking. Then
> there is a drivers/mailbox/qcom-apcs-ipc-mailbox.c driver and even
> more dependencies: mmio regmap, clocks and probably more (I've didn't
> check further).

Yep, this wont work.

>
> The question is how to solve this issue? Is this dependency really
> required? Would it work if the "mpm" power domain is set as always
> on and genpd framework extended to support such case without
> triggering lockdep warning (it already has support for irq-safe
> device in non-irq-safe power domain)?
>

I think the whole thing just "works" if we make the mpm a consumer of
the cluster-pd instead, which probably also is the right way to model
the HW.

For "last man activities" (before the cluster-pd turns off), the mpm
driver may register genpd on/off notifiers with
dev_pm_genpd_add_notifier(), similar to drivers/soc/qcom/rpmh-rsc.c.

[...]

Kind regards
Uffe
