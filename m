Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB24391E66
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750647; cv=pass; b=SsGEAr3TnmjMTzeznsXyfVTdUQJ23ddgJ9cmq7L8ARIZpDo+kID5hfx89WueELEFdCnJVYHksJMdNFUpZAj6Z2DlwoBnjr7MlfGy+NcytQ4O5uCIdd1zKwU8knGv3FDabIAqh9zXv3WaxUSOfhSXCQJ3jLoby/oCjMQ4I50hYJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750647; c=relaxed/simple;
	bh=N2ev8NttSPp3sm8JN17mx+8UplfZQ9K6+B3+i211/Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5p9XyqhpATnwbeH6Zc0Etv2AeFU2eLqu3lOOdl2USDhz2Ouqv5RtkdlcaSzRfFqSkGbfN1jw9BmGdDuaKge51y83pdILrS7AxKhukbhFxNv6uxZyZwAm3saeMDaevUwBHNuZomShqUTyU3+5fXK9pnl2BqwZNQfTV3DNh//gmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Snec7G3w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTFw6F8C; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Snec7G3w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTFw6F8C"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BGh5I1291148
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 12:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5tekgFbaGaE0XEy2TBAKDaP0xadvG7zEM2y38MY8Bc=; b=Snec7G3w/7iD/SSO
	GVTQvnZ2gjF2VwjWoNnYCmMa/hIIGIxBdya0Y4Xk/FRjHec47aDV7VlDpQTnfgJJ
	1yUJvXglwD4+J15UtrB6o6332VomC5gGsNjr3nFKHK8SN11dR9RpuIaGHXgRheIS
	S2gBSDtR3tPa9B76L80rmcc0dAZFd2mTLqsaLCEUM6CDQfG8Vbags2571yJD35pE
	Jke0AgNfr2vTcwCI1fJXus8nC357e9VIKeeU3l+Q5x6MDJ07prQ6w8ntljC3QUnX
	ro4gWiBST1vXaEXfLtaYUvh/odlLt6q6Z8AOG1VugemDGV9zk8gwAMHvRPZl6wc1
	1JX8jA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmr93tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 12:57:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157929bf8fso152233385a.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 05:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780750644; cv=none;
        d=google.com; s=arc-20240605;
        b=C3Ol6hnb1CNlykMpMi6CPr7nCFl0okr0r0x9GERWalg/naBWlsZZ9OSEH51ao1fm6e
         P9QWEHoVvWbEn2uJJeZnbmn7oS7ps1Afh/5z8uFgoal59zd8SmBP0vgB22mngDXhspob
         bSK4QDLgoV3P+0mkd27L6RUexhRAYjdYPI/gkncywtoPIY3PK3zxG5funTVQ/BLH1Yqh
         NYohkWV7ZVE9ju0SitvsZp+1lMgQY/PbvM7pfY97vKFcaTA2qYp9G3OjUhT5C8T/+IdR
         wjn+uXpnD44CXt2s+SXTyrJ1/CHP04N9sYptxIES0wLgJfKB5XWYafE8fgL5DTub3/AZ
         t6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5tekgFbaGaE0XEy2TBAKDaP0xadvG7zEM2y38MY8Bc=;
        fh=EfOfvimd4KHUQq/POjXoNZL43HSpgZCeLDNbDIiRfaw=;
        b=Mt1vu8unwBc9n0ChiqSJ53b8Wts8hYVN7jP7wkjmoX6EyK11nNCNPPiFGVSdhTvVJ+
         mgBxnOtbuEBiSOr81bRT3a87byM0x9y1y0hAgWVlUGQ0ZZ17rnJl69Wf1dF5j3w6jE4l
         BZW3EVjcjwZga9XibUS01U/rd8te+mrMSqTiYLYDyXZIKwXRpUu9NsKa+jlMRRMjUTiJ
         0nYInvOQj3UrNHvlw4CfLIrpEK5C7n5HyqTTuEVQncPy86mtcYArxZTU+Un0f+62odzp
         Bd26DFy/Bcv+YTvZcPGebWqiFvVPouccSuv3irsquybMQrQqrsnZJzWFSpPPAd7kR+AQ
         4Qow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780750644; x=1781355444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5tekgFbaGaE0XEy2TBAKDaP0xadvG7zEM2y38MY8Bc=;
        b=NTFw6F8C/++n6YZIUh3hdvBs3FccDMLq549ldHckophfzy51CbFzLkPWq36byKXb+M
         JlW1tmWnTeNjKqqH1VQUzE2taZcJ4EzAIadeTtPcCTBziC1QyDVRqfmDeezabjWF6ghe
         CI2YZkABCsCVvwthnOaF9Ezmi6YGZgL/Pwftl546qfYU/AtjwM9h7ZYd0LuhD10EJeMQ
         qEeudyKQ/YDv6tVA142fzwk5JuSEyx34Udmsi3Ok6SzCyUyPQ0FlOyZmLZVNxwRNtSVU
         2bcKnRSB11oiGQKeGneUPYdZ2AC7QrleOlN73FtSwW/GlfMVxz64S664WWTx+JuJvWSW
         cY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780750644; x=1781355444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5tekgFbaGaE0XEy2TBAKDaP0xadvG7zEM2y38MY8Bc=;
        b=RmfdoNbWEP+/vlUZpyuAJFAGvVyL3wk3XMXP6OL9/nfqAXZacT0CCuHlOpXnK9E516
         0stXBwB/Tdrw8XXo85wkz/4F22QxxDIecpkWfnAyEcW7FXERcVEtA2bbe2iTJTnhXUqu
         IFEIsuOMC2usYOFm1WlIfT6nNsw6QeYeX8+lYZbjxSVdvhA0ghYKlwCDl/Jf6iYa7WiB
         s3GnqYBzBtWl1QZGFAJ17KOLbVjpW45lX1RLKjFsDqGrByBiA0OetUrQTk3OJ/e4a/KW
         sEl2mPjsAL4ghC//MeROmZxJKE6sLXWqXOxBZWdoryEdO2NYGsG4/wNS0S9ulR5uerrI
         dsvA==
X-Forwarded-Encrypted: i=1; AFNElJ/OXCO0hY26jT3w9hAfJDxe5XDg2mAB9BHAC2BBd8jJI/1BLxJASh/W/orAWbnyk90bRVSFX/TTpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfHYsJLgehN0tWW1/2VcSb8xIckqMFGd8yjkxaF56yFsRQ/AT
	2mGG6BzI4fnh9eBOvWoxAYUfKDjcANohMVKVI+7zTZ1brw55Hlh4AY7a5QfzE4M3bIvU821QtzB
	Z+8YRKUCytvm0CbovtOtDk1N1wZ65zA85zge7T6GhwFSnzvz3TpgryOSo7bBFwhz2ve/S+1nuZZ
	eT7OwvxG+e1tFPOMWv5WP1yBLRw8X6371FX4+J
X-Gm-Gg: Acq92OEeQyrIpJHcsg21NpDxPr/jbwaFMNZQSPH7Iw0Ppy8Fy5VcoCQoUQ6JOyoDSJk
	BShvVryfMgJNbf+JCoF/ccP22UMODqGAzE0Rpx7Z8F5aI3d+TOqGi5zEQZP2DnWQoaxDjwxp2BN
	VB3F3T9E055IAjbdD81QiloxAo2sXOWcJDaSrHzGW5t8rfaMs3sqGmbKe5nu7r/qA8xCjy/XOt3
	tqym2FRK9E5EyfPkLedlX5JZ21z4/Z0wZAY4hCSk42o5yZy4EPwJPUzk5P5nBQyHW/Ho1/2jQxK
	W2Jt2WSa+M479+z0LZLk244WvlodF5yKkPsBveK1Q+kOmjj0rbpOqcddEP5r
X-Received: by 2002:a05:620a:4590:b0:915:a6ca:f121 with SMTP id af79cd13be357-915a9dedaaemr1367557685a.54.1780750644085;
        Sat, 06 Jun 2026 05:57:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4590:b0:915:a6ca:f121 with SMTP id
 af79cd13be357-915a9dedaaemr1367552785a.54.1780750643596; Sat, 06 Jun 2026
 05:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com> <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 6 Jun 2026 14:57:11 +0200
X-Gm-Features: AVVi8CeAR11CszzTeykil9zbLE-OpnwBQ68EzyKpPXntRU4a3bCccDFMCJWuwUk
Message-ID: <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyOCBTYWx0ZWRfX69fIe0QYFg7d
 Oe4o/tVE8ttcIDKL5jPa++CiSav9YkkeBSm7tlq+teyuOZBIvetdp9r0o7sVHStS9x5FJV25+b4
 LwdC94+6Rp8CERL5NrtEyyQygdSUijpFdniHf+upstZpe+BNsa38fSyUivSV21396bZYVaMkHQq
 SdodbvDOz7eBCI7NEJ+/RYKf05HlRO6BAMSGTNYhM90w4FyO9w5ux8RrItgFgDqqKwEFLOyS0Sh
 1oZECO4L8X3gJUACRXxsMCQdsWtqDB7oaiYXLs2ZYHD3RFKUY1B3M9iQLIRzWQMntvNEHt8i9jU
 wLXvV8iNIga4zbqJKsVkCliiYx2YTwOYGlpq37sDPzyFloMKy/WLVAUgwQY+OI2mGkP8OIgYHiv
 bMbzfOA7RzhaIRuj5jit89HWhSOvfqEumv132LPTIqIIC33fc/WDDpkIEs4HmNWqYh4qkEepNyq
 df0U38nh8mtcHhU4pbQ==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a241934 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=BrMfsZBUJKb9yWDY1ooA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iuJtq6xo2CamKr72zCPfs06_xY01dD-X
X-Proofpoint-ORIG-GUID: iuJtq6xo2CamKr72zCPfs06_xY01dD-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060128

On Mon, Jun 1, 2026 at 2:57=E2=80=AFPM Komal Bajaj <komal.bajaj@oss.qualcom=
m.com> wrote:
>
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
>
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
>
> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> with register space, interrupts, IOMMU configuration and reserved
> memory. The node is kept disabled by default and enabled per-board
> with the appropriate PMIC supply connections and calibration variant
> selection.
>
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++=
++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++=
++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
>  5 files changed, 223 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boo=
t/dts/qcom/shikra-cqm-evk.dts
> index b112b21b1d79..c2ed0396533a 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -16,11 +16,48 @@ / {
>         aliases {
>                 mmc0 =3D &sdhc_1;
>                 serial0 =3D &uart0;
> +               serial1 =3D &uart8;
>         };
>
>         chosen {
>                 stdout-path =3D "serial0:115200n8";
>         };
> +
> +       wcn3988-pmu {
> +               compatible =3D "qcom,wcn3988-pmu";
> +
> +               pinctrl-0 =3D <&sw_ctrl_default>;
> +               pinctrl-names =3D "default";
> +
> +               vddio-supply =3D <&pm4125_l7>;
> +               vddxo-supply =3D <&pm4125_l13>;
> +               vddrf-supply =3D <&pm4125_l10>;
> +               vddch0-supply =3D <&pm4125_l22>;
> +
> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +               regulators {
> +                       vreg_pmu_io: ldo0 {
> +                               regulator-name =3D "vreg_pmu_io";
> +                       };
> +
> +                       vreg_pmu_xo: ldo1 {
> +                               regulator-name =3D "vreg_pmu_xo";
> +                       };
> +
> +                       vreg_pmu_rf: ldo2 {
> +                               regulator-name =3D "vreg_pmu_rf";
> +                       };
> +
> +                       vreg_pmu_ch0: ldo3 {
> +                               regulator-name =3D "vreg_pmu_ch0";
> +                       };
> +
> +                       vreg_pmu_ch1: ldo4 {
> +                               regulator-name =3D "vreg_pmu_ch1";
> +                       };
> +               };
> +       };
>  };
>
>  &remoteproc_cdsp {
> @@ -57,3 +94,25 @@ &sdhc_1 {
>
>         status =3D "okay";
>  };
> +
> +&uart8 {
> +       status =3D "okay";
> +
> +       bluetooth {
> +               vddio-supply =3D <&vreg_pmu_io>;
> +               vddxo-supply =3D <&vreg_pmu_xo>;
> +               vddrf-supply =3D <&vreg_pmu_rf>;
> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> +       };
> +};
> +
> +&wifi {
> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> +       qcom,calibration-variant =3D "Shikra_EVK";
> +       firmware-name =3D "cq2390";
> +
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boo=
t/dts/qcom/shikra-cqs-evk.dts
> index e62ba5aef71f..3bfd0050064f 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> @@ -16,11 +16,48 @@ / {
>         aliases {
>                 mmc0 =3D &sdhc_1;
>                 serial0 =3D &uart0;
> +               serial1 =3D &uart8;
>         };
>
>         chosen {
>                 stdout-path =3D "serial0:115200n8";
>         };
> +
> +       wcn3988-pmu {
> +               compatible =3D "qcom,wcn3988-pmu";
> +
> +               pinctrl-0 =3D <&sw_ctrl_default>;
> +               pinctrl-names =3D "default";
> +
> +               vddio-supply =3D <&pm4125_l7>;
> +               vddxo-supply =3D <&pm4125_l13>;
> +               vddrf-supply =3D <&pm4125_l10>;
> +               vddch0-supply =3D <&pm4125_l22>;
> +
> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +               regulators {
> +                       vreg_pmu_io: ldo0 {
> +                               regulator-name =3D "vreg_pmu_io";
> +                       };
> +
> +                       vreg_pmu_xo: ldo1 {
> +                               regulator-name =3D "vreg_pmu_xo";
> +                       };
> +
> +                       vreg_pmu_rf: ldo2 {
> +                               regulator-name =3D "vreg_pmu_rf";
> +                       };
> +
> +                       vreg_pmu_ch0: ldo3 {
> +                               regulator-name =3D "vreg_pmu_ch0";
> +                       };
> +
> +                       vreg_pmu_ch1: ldo4 {
> +                               regulator-name =3D "vreg_pmu_ch1";
> +                       };
> +               };
> +       };
>  };
>
>  &remoteproc_cdsp {
> @@ -57,3 +94,25 @@ &sdhc_1 {
>
>         status =3D "okay";
>  };
> +
> +&uart8 {
> +       status =3D "okay";
> +
> +       bluetooth {
> +               vddio-supply =3D <&vreg_pmu_io>;
> +               vddxo-supply =3D <&vreg_pmu_xo>;
> +               vddrf-supply =3D <&vreg_pmu_rf>;
> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> +       };
> +};
> +
> +&wifi {
> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> +       qcom,calibration-variant =3D "Shikra_EVK";
> +       firmware-name =3D "cq2390";
> +
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/d=
ts/qcom/shikra-evk.dtsi
> index 8b03d4eafa6d..a79f44aff968 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> @@ -8,7 +8,22 @@ &qupv3_0 {
>         status =3D "okay";
>  };
>
> +&tlmm {
> +       sw_ctrl_default: sw-ctrl-default-state {
> +               pins =3D "gpio88";
> +               function =3D "gpio";
> +               bias-pull-down;
> +       };
> +};
> +
>  &uart0 {
>         status =3D "okay";
>  };
>
> +&uart8 {
> +       bluetooth {
> +               compatible =3D "qcom,wcn3988-bt";
> +               max-speed =3D <3200000>;
> +       };
> +};
> +
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boo=
t/dts/qcom/shikra-iqs-evk.dts
> index 727809430fd1..95bd797d009d 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> @@ -16,11 +16,56 @@ / {
>         aliases {
>                 mmc0 =3D &sdhc_1;
>                 serial0 =3D &uart0;
> +               serial1 =3D &uart8;
>         };
>
>         chosen {
>                 stdout-path =3D "serial0:115200n8";
>         };
> +
> +       vreg_wcn_3p3: regulator-wcn-3p3 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "wcn_3p3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       wcn3988-pmu {
> +               compatible =3D "qcom,wcn3988-pmu";
> +
> +               pinctrl-0 =3D <&sw_ctrl_default>;
> +               pinctrl-names =3D "default";
> +
> +               vddio-supply =3D <&pm8150_s4>;
> +               vddxo-supply =3D <&pm8150_l12>;
> +               vddrf-supply =3D <&pm8150_l8>;
> +               vddch0-supply =3D <&vreg_wcn_3p3>;
> +
> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +               regulators {
> +                       vreg_pmu_io: ldo0 {
> +                               regulator-name =3D "vreg_pmu_io";
> +                       };
> +
> +                       vreg_pmu_xo: ldo1 {
> +                               regulator-name =3D "vreg_pmu_xo";
> +                       };
> +
> +                       vreg_pmu_rf: ldo2 {
> +                               regulator-name =3D "vreg_pmu_rf";
> +                       };
> +
> +                       vreg_pmu_ch0: ldo3 {
> +                               regulator-name =3D "vreg_pmu_ch0";
> +                       };
> +
> +                       vreg_pmu_ch1: ldo4 {
> +                               regulator-name =3D "vreg_pmu_ch1";
> +                       };
> +               };
> +       };
>  };
>
>  &remoteproc_cdsp {
> @@ -57,3 +102,25 @@ &sdhc_1 {
>
>         status =3D "okay";
>  };
> +
> +&uart8 {
> +       status =3D "okay";
> +
> +       bluetooth {
> +               vddio-supply =3D <&vreg_pmu_io>;
> +               vddxo-supply =3D <&vreg_pmu_xo>;
> +               vddrf-supply =3D <&vreg_pmu_rf>;
> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> +       };
> +};
> +
> +&wifi {
> +       vdd-0.8-cx-mx-supply =3D <&pm8150_s4>;
> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> +       qcom,calibration-variant =3D "Shikra_EVK";
> +       firmware-name =3D "cq2390";

Does the firmware differ from the one used on Agatti (QCM2290)?


> +
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/q=
com/shikra.dtsi
> index c1f25ce89bb1..6bac6ebac8da 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -2064,6 +2064,29 @@ apps_smmu: iommu@c600000 {
>                                      <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
>                 };
>
> +               wifi: wifi@c800000 {
> +                       compatible =3D "qcom,wcn3990-wifi";
> +                       reg =3D <0x0 0x0c800000 0x0 0x800000>;
> +                       reg-names =3D "membase";
> +                       memory-region =3D <&wlan_mem>;
> +                       interrupts =3D <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0=
>,
> +                                    <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
> +                                    <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       iommus =3D <&apps_smmu 0x1a0 0x1>;
> +                       qcom,msa-fixed-perm;
> +
> +                       status =3D "disabled";
> +               };
> +
>                 intc: interrupt-controller@f200000 {
>                         compatible =3D "arm,gic-v3";
>                         reg =3D <0x0 0xf200000 0x0 0x10000>,
>
> --
> 2.34.1
>
>
