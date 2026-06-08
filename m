Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA73AA510
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906963; cv=pass; b=K0PEUNVfcJnbTLJlnFUKzw25YGhii8CsL2TwuNiqjVhcxw4hIDH2JEUHu8LOgQ8HQINg5gEnRn3M+F0/2ZSAK13IpbaGHnGbGfo/g49anIoaD4RqHhJs7tLUAG8Ruuy3czV6pUUd+KmJiDIotSMPzjDvmguCuMOYFTPqimKPqkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906963; c=relaxed/simple;
	bh=vtWNS3npdkcAslK/SBBMO1SRfQSABiKbV8HThujbXD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF1rjI2f8O7qrnGHJ7g20JuBsoeoCNPyy2TpsiGui5ZqhjXl3Ap7nBv8/30ndzjV9iE182gy5nRfisEzyTUe4D1OM9dHV+mCKWyPIVTgahLzu7HnLo5Rd0MqEyDsv8MlUVvfE5M5C0khnvs3zOx8sAnfStiYDFI0i/XZZKxss2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6lLaA8q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcIp1Ups; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6lLaA8q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcIp1Ups"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrGr2274541
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=; b=E6lLaA8qN09yGM+s
	c+LUGNc/oB5k0DXe8dZ6ZZsQPGDMTMob4DRZoWJLiZdUObBzjZgJJgQeoL/XVOgm
	OSH6M5XIugSvBr16h3HG6vCUKQGG8DY6Trjf0knwsA+CN8DIxSrVu1eEplln7Mj+
	C56Fu2DvVxiV0A9U5GcQsroffiLpMkXjmY1xD/zAveUgBW+fVu5KX+0OgaAab8gw
	8SR6n69zkCoWI+E3ZZ6IV88maTxranZUJUvTDn0AWSoY4Wi5lLu85j/ijRJWCJKg
	RsIm4M7+yLDQxv/+4fy6Hbm+XPBQPN0WVWKXr6RnVqfOHFrtGaWKrz+8DwpE/zQ3
	/XNh2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgxfuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 08:22:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915b6b63056so490266985a.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 01:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780906958; cv=none;
        d=google.com; s=arc-20240605;
        b=axAp0qH21SOJTvnwYzKGDkK0Zo9IA1Us+eGf7Iq5q7BvNOcIX6easWnWqkIq/4bi4o
         I1NmvrpkikOKjJ9AI9vCq6eSbRWDeQzpPYp3xKNem56oxUuRrANKtX9PbcAvZCFZ6c1x
         mZMBUER8ufkNmL4IQlrs2YNQ5DlE3Hm3dvn2OaPVKiQyH+tXANLJhgME39NmZEAHUIqm
         JZj7IJpoOD8s3KFWu0aL9afKKzclsD+rFWLzjE+fdrKG2DxzlWsCPbxuQcPnzW2xCpkh
         cNfXYQgfcBR/ycO8Y2ZcWIXLx4Q3JDrbsVArfDONIa8+8DTyLFiKjl7vBgU/MI/hKWwQ
         M7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        fh=ldU2Q1GV5ILNsn2RABX0xdgWXfeJFGtu6oN7fSLIS68=;
        b=aY7nC/oQwoNlO8/ikLWxfjN3VwHr3cQGGVbXL5jsTY2NghVoquOVzzj7iY4UpTuO6j
         fQlO3uK/Aj2Tk8aIcYINTCBqUnTf8obuW8fWZAczcU+qsw0bxLM0jnWgv9bWOxJyqR75
         O7mTcnv/NXnZBE8pYv9dwzY6SresgLP6kL1P8b9SrFY99CTww/KiJUf5QGBGgJAKbsUB
         Srv+AYbxHjLQY9ohiMIBfJaTXkmVjtM0V1C4/L62Bxq8sjJIcg0Tj4x5+MAa4aDsJLRn
         Dswt4La4W2GxV9Hi7YmAcu14WYETmjA8MUSeZwrvW42OTNVd4DKwxk9nHNs0gLeudIJO
         VBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780906958; x=1781511758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        b=dcIp1UpsVcwo2HBMwV6XcwuN1/QDxFNzp+kZq8LIS1YNTAAWIiMA/NoM3sfzCJyYXG
         cJOOJumMMHX5nEsY03btyD23HgeYl3tbN7YomVCkwnzeeYi1Pv8fzH6fAdxoUQzs/aVL
         oEfyHj1WfPR7LZVf4QklFzPoiOZ97YwXxQJDl77n4WIuvOyWCQbGlyCwroDTaspfLTQN
         sURLhgNrffLs21I/v1/DnRZhKvhvz4yhJ6VIhwfIZloONlv+Fl1srQB2O8giNjPjHGmM
         muE75yhkfvim/VOWZXMF7OHoNaiux5eBOofswmlXJiinYUZBJZBG6GtY+jKoju71sass
         GT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906958; x=1781511758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        b=Ln9J124HeoS6Qt9kGjFcyiZf80Bu6DCXVcsYiQiiM5osJNcoa+YYkwg7bdGuHXrd/G
         77MzNWLE074CNz2Ej1+n3icwzb4ie8jtqxOxnG/ul1cnNmYB33FeW2G7KCiZ/A/Pv2YD
         UBXcjqX959VAhUCId6ivTz/UEQqvp7LLwP/0QMgZmR4kX5PyBgd/wDamARPFLCSUDmFj
         1WkCjACGyLQ1UD8HlGWCvyDtVcGxyd9x2CboeaeHTCrmAkHlfUMWtdAR+Ly1BB74+WQi
         7474uBBdQkNxnGz179tKqSSHavfq/CbNaTaH4McfVc8u0XLFrUlPgSuR+UZCzycxPGVy
         M6ow==
X-Forwarded-Encrypted: i=1; AFNElJ+QpfxVllZHz4mfUnvCr6dsMHQOXvhHiNWI1Rut6WDgou4uIE5aICH62cL/t9mY7QPG+DknPBInmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhiANOnILLniRzN0u2OKM2IIEmc3hfYqkunuX+owon/zkEnqL
	5CHJvHYpJixrd7YjRGb2PsyP7zPtV12B9TgBp4lUF4DFloNeuOFcMYQGc0a3ozZh9fVFCah+8n2
	RW7Kq4/3jhqa4M9XYITelvYPRZHxltObQyEtvnyQj5FoYjIAvb9ROCE/GgduMJ8LTMofDj9wg2T
	RR3dsWYsNRQ3JK7/taWO/285TCA+ALTD9XeQpQ
X-Gm-Gg: Acq92OFCPTs6GUSRDiyASATcZhuUvxzNlS6WXlJTxEXU8WkLuMZuwlwqDzz6EiSxi/1
	JWw1g1+Z1pVJt6EjVRgAKVIAE7bL4VdwKyvSbrXt2Xx7HWOHpg5UCkHxz9REiWl5SfaW1HffZFk
	ulGFIpbfWOSnAV5wFv3Ok8PF7OLJV+NkhGogREGV01ZjRJ5QgZRWGAwkTgPB3CQ0uu1L5xwtqKl
	InCzohzkCKpdpjBPxyA3zNne3XNZ/ZiRbCYUPvUJy+uDX0sJZEAKnqw/JdGPNgCnDxoAtfYpuhA
	Lhwvz4IWxFwG0hzVD0jPBPX7bpK7z/7s5T5Lw4qRTLdnbXp56ndjOUYm4QTV
X-Received: by 2002:a05:620a:f0d:b0:915:931e:5e8c with SMTP id af79cd13be357-915a9c7584dmr2385827785a.7.1780906958040;
        Mon, 08 Jun 2026 01:22:38 -0700 (PDT)
X-Received: by 2002:a05:620a:f0d:b0:915:931e:5e8c with SMTP id
 af79cd13be357-915a9c7584dmr2385823485a.7.1780906957558; Mon, 08 Jun 2026
 01:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com> <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
In-Reply-To: <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:22:25 +0200
X-Gm-Features: AVVi8CfaqXeEW7_fGzZ87WHqiQ-n3gAVt2qJ12GlDUzulGzVwqZJCRnMLkCi62M
Message-ID: <CAFEp6-0xpsNHn-Dg9LKLvMbnPD6DBo6fi5iEo6DWR8uosVxQfw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a267bcf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=gccCA3bCN5zK5WmTdcQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: jyIXAQwTroOl4GkM2VvHJnvbtL_DJDJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NiBTYWx0ZWRfXyiyAkNhbf0L7
 1d1dEqpZCC4g3cFzBGY6+7dExu3Nl8IMxTEQO82blkrdyZcACR1MCq130JYqIx0GyViyoLS7Ase
 WZl41jYV62+mN+PsbdMJJ9+yO3X8yRlbI1JBMhvLrQP7PwzQeeKmmIvMnxcYXkhK5m+F1oH+Z3D
 kRZ08k9t/1McmQ0HwpohoDCN7kTfr0iZcCX/U2F0bIKvxNuOs1oECM6raJVwq4sJkhJATosI/G7
 X5zUkUHOFE5JSNx3K67DuXdldLeceF9L/FPAaulBmb3+IJIsUaMypYhs2WOfeSVLWyWLDeevzeR
 gnNrpkjb5nRtgNgghH0vtaySGUS0JiZcFKGh+zsUZvMN4ueC1i5dn9VQb7bCwy1ub5utBJRmt6F
 M744qEYzNlPc/NltrVLhH3ViWfqJhsnMAfpNEj87Hpczl5x/duOIcmWIhkrQLAMkhjN3sz7rgRx
 asDybwOwZ0kS7rvp67g==
X-Proofpoint-ORIG-GUID: jyIXAQwTroOl4GkM2VvHJnvbtL_DJDJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080076

On Mon, Jun 8, 2026 at 4:26=E2=80=AFAM Miaoqing Pan
<miaoqing.pan@oss.qualcomm.com> wrote:
>
>
>
> On 6/6/2026 8:57 PM, Loic Poulain wrote:
> > On Mon, Jun 1, 2026 at 2:57=E2=80=AFPM Komal Bajaj <komal.bajaj@oss.qua=
lcomm.com> wrote:
> >> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> >> EVK boards using the WCN3988 combo chip.
> >>
> >> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> >> board-specific regulator supplies across CQM, CQS and IQS Shikra
> >> EVK boards.
> >>
> >> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> >> with register space, interrupts, IOMMU configuration and reserved
> >> memory. The node is kept disabled by default and enabled per-board
> >> with the appropriate PMIC supply connections and calibration variant
> >> selection.
> >>
> >> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> >> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> >> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> >> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> >> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++=
++++++
> >>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++=
++++++
> >>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
> >>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++=
++++++++++
> >>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
> >>   5 files changed, 223 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-cqm-evk.dts
> >> index b112b21b1d79..c2ed0396533a 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> >> @@ -16,11 +16,48 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm4125_l7>;
> >> +               vddxo-supply =3D <&pm4125_l13>;
> >> +               vddrf-supply =3D <&pm4125_l10>;
> >> +               vddch0-supply =3D <&pm4125_l22>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +94,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> >> +
> >> +       status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-cqs-evk.dts
> >> index e62ba5aef71f..3bfd0050064f 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> >> @@ -16,11 +16,48 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm4125_l7>;
> >> +               vddxo-supply =3D <&pm4125_l13>;
> >> +               vddrf-supply =3D <&pm4125_l10>;
> >> +               vddch0-supply =3D <&pm4125_l22>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +94,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> >> +
> >> +       status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boo=
t/dts/qcom/shikra-evk.dtsi
> >> index 8b03d4eafa6d..a79f44aff968 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> >> @@ -8,7 +8,22 @@ &qupv3_0 {
> >>          status =3D "okay";
> >>   };
> >>
> >> +&tlmm {
> >> +       sw_ctrl_default: sw-ctrl-default-state {
> >> +               pins =3D "gpio88";
> >> +               function =3D "gpio";
> >> +               bias-pull-down;
> >> +       };
> >> +};
> >> +
> >>   &uart0 {
> >>          status =3D "okay";
> >>   };
> >>
> >> +&uart8 {
> >> +       bluetooth {
> >> +               compatible =3D "qcom,wcn3988-bt";
> >> +               max-speed =3D <3200000>;
> >> +       };
> >> +};
> >> +
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-iqs-evk.dts
> >> index 727809430fd1..95bd797d009d 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> >> @@ -16,11 +16,56 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       vreg_wcn_3p3: regulator-wcn-3p3 {
> >> +               compatible =3D "regulator-fixed";
> >> +               regulator-name =3D "wcn_3p3";
> >> +               regulator-min-microvolt =3D <3300000>;
> >> +               regulator-max-microvolt =3D <3300000>;
> >> +               regulator-always-on;
> >> +       };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm8150_s4>;
> >> +               vddxo-supply =3D <&pm8150_l12>;
> >> +               vddrf-supply =3D <&pm8150_l8>;
> >> +               vddch0-supply =3D <&vreg_wcn_3p3>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +102,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm8150_s4>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> > Does the firmware differ from the one used on Agatti (QCM2290)?
> Yes, WCN3950 vs WCN3980.

It's not exactly my question, Agatti also supports both (e.g. WCN3988
is integrated to UNO-Q).

Regards,
Loic
