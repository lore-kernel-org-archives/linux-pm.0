Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392B3CBE96
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053891; cv=none; b=uz8CCCVqQoBGJZUSXryvtp3+U459ucl4LHoArhX4D7YiGYTQqPbQrZiA1GuNf5b2m6clSqOBqPtoDGc/Svd4jL4DTN/zH58WSYYOy2ehXdjXqVE8YJxfGv3C86yb/c6ejk4iqcmkV/zekPeOKYTwzBzDSvFh5xNQPMtBKE9+PZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053891; c=relaxed/simple;
	bh=v5z54Xk4bSmgyuk9NpYqxo4keii6dzEKvD9OmkaJbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeFpeBNls160pJ4F0cL4ifQUZQv3SzBu1Ue2m3CyD5kkdjDy4m3F27a4SYgXN6ibj1MJtvbm5oSFIu0juSVarRWnTIuVydc9lvtQ7LTHkN3KeZRQ4frjLIGcfKUutqvBCAjzjfoSnR9K/vrFqBeMcPgPw7fce1RA6R5jeENocQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7bdhRdR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQhSvMZz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7bdhRdR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQhSvMZz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T5KCGE1248033
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qloH8P1ospu9RxarNeTE+kqA
	33QizIUuoyflf0m4ulA=; b=A7bdhRdR6ZoVn/jgz4lBLNeY9QR2/Py1cCOeQ0Xu
	dYO0FIlhzWXYYkGYRGUcFDQJKNV+0MxeDY5QGM+ehW6BYk6whBR5S7XpfWFoEvWi
	GPZIDNIz0OvB2HGALPKTYFgOB3N2RNtL3ws3g9IrUGhyAGMfN6MmBkqzHFaHmVjG
	xUTljCrw2R6b9ZqisXOYtX1IphCbl9z5G5rWJbj34Fbue+oEGNv9OXTVL4/8jpri
	wi5Tplp3gSNX/P0g+l3ciuvomu3iqsRJe2PyrskcSpk+OAiINskm/0CD0NGdnnrf
	1pL7nwdF2R5Gz3FiUf1jWkfSwtitlAXd/AlMKF5/lWvG5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj1fpj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:24:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516ceea1984so152806431cf.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780053889; x=1780658689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qloH8P1ospu9RxarNeTE+kqA33QizIUuoyflf0m4ulA=;
        b=fQhSvMZztaudcMfEtnPpXfi83O83jKz7wL+kHSgSjdSTuDCZ59uI5qy2sH4S1H6A62
         FZDWc/Unui/UcIlZoSNa8QY+qLsS5h66ns4ttlD8BYcTYDUswl+NuiDN4Xfe9AJYxD/0
         XfBZx+K4n/gc2ryiO6dTooZE4w9Ugy0kZwG/AkwSa98jBeOFz33VBKfTdw1YP2AHQV/o
         3Ui//i+j3AxDBs1wUIVXw9T1lo5K8tovbGUVxPTxmVCK/Qq9LbWpo063d74RsNWe6VVJ
         xFDyWjYaRupaTjv208825CUaUlgaINcMvYtCP86qd1DPKty5xmQzrTXs1eroRyk/aKQX
         XyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053889; x=1780658689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qloH8P1ospu9RxarNeTE+kqA33QizIUuoyflf0m4ulA=;
        b=pOmzR/5jLaTldDPf0CthZXRf3QcMRh377kW+fc9m5y+joewHf443nmdf4xr+VnADfR
         FWI8MqqEEqUEzs50dYd6YXtUdtGXpplmTHslwFF9i8avTSTQwieFcqmbp25ds1yBnvXd
         qqjA4mst1k/Xu9bFH1xlQXqFIl5gvOJ0fl+K12I/falK0yK58ZlASmC5M7V/iunjeaFQ
         Og1eR9XzWjK05VbUUi73tudoCXJ2pBmcIS8b4JTJVr1fnjH+zBGrwapb9fFwhz0VbHwi
         ib2TcdjKwFgRIlgykQFp+FDluljG/BLDxfE66b84rxiATYXfRxRxsuiqkC/8sFIJhxVg
         4JYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Rh7dq+GMuJfr2DaDTDM237dm9dVE5HFUA27VO+/BAfZB66W3XU8OpEkQ0vBXLgWcJ3NzWR1oIWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vxPArbt99GMA7sEONsmO3mWNnDn7VcE1v20qFuo1k+YDdcMZ
	6RuCzHQTCwMuAsMnlvR0JA6D1cEwsRhTtebSthVU5b+qUrTmGK5eQwjUAhrPJKaBYA9n5WvekKd
	so26Y3omUO8Pgixe/oobyr2fKysBjgevEMylZvLHXx2LShOFFs4ZniTKQnWnfgA==
X-Gm-Gg: Acq92OEIkUVtSXVW8odaQ2DBC2SK5hKGk75Y/AWr0d8alPjdGRZ9USxpnGnU+avSWa9
	nI2nLZovSuUJcNS6hKBHXXfp7fXDEfnnYk5sVTuq8tCmUpXtH2gfsEad11q9Gh/aqQHZwC5Vamb
	yh8bjfVCFcdOYzWS8Tiebxo7UuauOAfV3FvM6+ymZGSTPjA4UUtEP6F6YZ8UfjfyZi7PF13D/oB
	wxYMJXuZ3Xi0ZqdOF60dvcGR7pHIeSk1TV364tmkIHU6j1dic0zX3QzHVd1ciNfXSContiUyRK9
	NId0yT0VtGg1zTcZmHrnamiiyeQcdLLWyx8rswOFqUle7WTXD9A3iniXMbiNyBNPgoNgaZLCuW7
	o89VbR6IoO1Cu21THl0AzW8jbXuLTgJci8AWz5rK6FzYPXRQ+PS+tjy2o1oVLuIPvudWsEmMUeG
	bbw/Lwgsq/0ctTSiC/KHkcPm9+5dFNmBrN69EXqUQl2ssy7A==
X-Received: by 2002:ac8:5fc5:0:b0:516:a471:dfc1 with SMTP id d75a77b69052e-5172dd3e10bmr29951041cf.49.1780053889123;
        Fri, 29 May 2026 04:24:49 -0700 (PDT)
X-Received: by 2002:ac8:5fc5:0:b0:516:a471:dfc1 with SMTP id d75a77b69052e-5172dd3e10bmr29950541cf.49.1780053888618;
        Fri, 29 May 2026 04:24:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b068abdsm221819e87.12.2026.05.29.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:24:47 -0700 (PDT)
Date: Fri, 29 May 2026 14:24:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/16] arm64: dts: qcom: shikra: enable WiFi on EVK boards
Message-ID: <teatmsgijdgdfwwqy4nrcvcfkhpqybje52gkjzniqt23si2rms@bksrb5npq6ji>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
 <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
 <57f8c593-11b7-47bc-8e11-7ec1b97210f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f8c593-11b7-47bc-8e11-7ec1b97210f6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExMyBTYWx0ZWRfX1OzR01WOUpCH
 43mLBxjo69cIRtxsrLiFkdtLIxenefOgY/1Fy2lVFdmmmZH5luzrWDXXAu5OEY8PH64xeP4FKEP
 V5HvUoj6omVBGV2hGXi8ehBmZw673yWW2YQVLq9G9WKlN+9MdGj0lhfVLLbcYLoIPEW9Yxhn2FD
 0jktGkt98UIoOsgoKEgoED1z5vVOikFasUK9IeQ2uFrAbn8PLdj+L+heoDtdTZ9mGixQha7K+VO
 M5u1w3rLDvVtcGpkDkPEdDZegtJxVqA+ebbKD3KfPcATf0DjUHGpuDWGEH/ydPWibv3UhTNkL/+
 6nw9fUZx8SQ3Uo6d/ZSTLwJ8qL2ncmXb42HmRQL9hk/4h3tTw3RoagihFJ956JYSjfZIwJxjHVN
 xb6uP/4gZrnX+p7XfZlo06kp3xKopBKpSgiZx4H6C7AVXDFU9xvYwfn3YEJyu8o6ZUohyjJGTH8
 Fxm4YWHT6nc3Rjy2ILQ==
X-Proofpoint-ORIG-GUID: w9nbcBCV49gteAXHSgevpHbX_ZBh5yCM
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a197781 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PDj5yD4EQWKW1X4F5PQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: w9nbcBCV49gteAXHSgevpHbX_ZBh5yCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290113

On Fri, May 29, 2026 at 01:49:03PM +0800, Miaoqing Pan wrote:
> 
> 
> On 5/25/2026 5:34 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 01:19:20AM +0530, Komal Bajaj wrote:
> > > From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> > > 
> > > Enable WiFi support on Shikra CQS, CQM and IQS EVK variants.
> > > 
> > > Provide board-specific WiFi configuration, including power supply
> > > connections and calibration variant selection. The WiFi node is
> > > enabled on each EVK according to the corresponding PMIC and board
> > > design.
> > > 
> > > Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> > > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 11 +++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 11 +++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
> > It makes me wonder... You've added DSPs in three patches, one per board,
> > but BT and WiFi go together. Where is the logiic?
> > 
> > >   3 files changed, 41 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > index 259032bd20af..15208e1abff6 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > @@ -69,3 +69,14 @@ bluetooth {
> > >   		vddch0-supply = <&pm4125_l22>;
> > >   	};
> > >   };
> > > +
> > > +&wifi {
> > > +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> > > +	vdd-1.8-xo-supply = <&pm4125_l13>;
> > > +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> > > +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> > Squash with the BT changes. Use the PMU-based bindings. Don't forget the
> > swctrl GPIO.
> WCN3990 does not rely on the PMU module; it is managed directly by ath10k,
> so the swctrl GPIO is not needed. The details are described in
> qcom,ath10k.yaml.

See https://lore.kernel.org/all/177432372677.35532.960283784585134331.b4-ty@kernel.org/

> > > +	qcom,calibration-variant = "Shikra_EVK";
> > Was this submitted to ath10k-firmware?
> Not yet.

Please do.

> > > +
> > > +	vreg_wlan_3p3_dummy: regulator-wlan-3p3-dummy {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "wlan_3p3_dummy";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-always-on;
> > Why is it dummy? Is there no regulator on the board?
> 
> WCN3950_3P3_CHAIN0 :is powered by on Board 3rd Party Buck which is always ON, VREG_SYS is always on once the device is powered up.

Then it's not a dummy. Please add a proper regulator describing the
node.

-- 
With best wishes
Dmitry
