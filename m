Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A023E5A38
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701648; cv=none; b=EIqoUazf4zbx2r+73iriHb15QtCAlcRZ6wLeWLh1uRRuX6sjee/kyM9l8aHXBQRy6wVLJXUT9LqB+TO6gnu9+VpC3INcDSBZKfYw7XwWgy1AIEIiFioYet8ELXeqrj+30EEz65rT1S04+loDycaiz6z3AkvV4LcN238oR/L2PKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701648; c=relaxed/simple;
	bh=XjaiCpeCYWyNVEErorwgmD4dKb39eRk0O83gVF2YfVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXbyae/v5GyY3Fc163io80m0721gSnKKySfSWTTuC02tob0IDHfb0RgwyUNBOw4lZqemKdeiJOLro3Sq7/s4ukIFQc3JEYHbDaajIyvDBDbzS5KzNGHcN3Eb0kC8ApEKlLi3OFN4EmTFz6eBVOxJFxzMY0NIKCuzFnZeDGGntiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8bmYpAb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRbOlsnv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8bmYpAb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRbOlsnv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P4odlH3282561
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FbNMQjBTSJaq94GvKwR19KG/
	gst5Dr26hUgZXOVVrh0=; b=T8bmYpAbIcntCDeLhgj8YsFoBnr5SMk+nbZpLmAR
	Pn3/VsbCihzuzOTQXVPgNqcJT5FUz9VXaSLcnouyPKZjYyAhz9PPkAB97rx5qp16
	vhH1p9FXAM8TTc7AO8Ytcyk53aNdyClqi/2FBUc/hc9tnsLjKYfBSG9RC7b44evu
	sM73KEeEWO9YofOejpU6Vt9EI3qJOoxlJ1315wTJ/552MFYnH9w2ql4wkt8WGr8X
	bRNMqhaTUy5aybtYzivoxND9axeLpHOD5s2RWrGDMQvJsnQylAdUozvFbh9GRRor
	BGWjVr6FQpKXZblIrCwbyPWiIJW3NrRUDqHpCnMhZ28mIg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3e0nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:34:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cde13e8cso81577741cf.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701645; x=1780306445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbNMQjBTSJaq94GvKwR19KG/gst5Dr26hUgZXOVVrh0=;
        b=cRbOlsnv3jM+mNN6KCKzVjwGSyAbta8wwYkeTqsZU+O+KmysA6R5mY+FGikw4cdEMi
         7mcvcAjIFcfLlqGqkV9sjJEzalexeAtmKXHlJQrnIhv1O9onl7xEcJA9+lN5LixXp9U+
         vmaVqHKt753qtqBGG8X+/5o8YF/obpJK5jWKptpy8lYPLE4eCAOydfU0sn8GXZS9LJuN
         pYvfYnW8FnlXl4m19HE65VOVRjF8eTml+N5uXd5ZC41kMZ2/5Axg0tOJJkuyFmuGs8uE
         iKN1oV+i9kQcLhrqQOwcMVfFj/klUQ1WJYqv91l9L8latS/zE1ZYnG6PmsijmlXQM4FL
         FwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701645; x=1780306445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbNMQjBTSJaq94GvKwR19KG/gst5Dr26hUgZXOVVrh0=;
        b=S/Ulmg0zzXxm0OzUInjjum/Fdg2cOcvc+JQNsM6tzDL/KpQhrZKvwNL9ltGCLSGKUA
         l5EVq2M34DUGPRcU2SwzGSl8Vj/fqqlYxOhjQrI+IBtTTmgqXlk4eHnzvogWEtpXxFxH
         NDPaj9VqBZ+whKeZbCW1mBzX5uJ60VSCdpnDTbmy0XCAnZ7GRlKelxw/LuCfOUwVY4tl
         Z0MpjFp/TmP4QG6Oz031x37uARgdu5/yPLs3SASQ82uVcuBfRC7xDBIJjeAePj0v/L5U
         9S7Afe+TtNuQFX3WA0RsoJ4M0l9pLG6/+x4fbSadQhCfh+7hEqs2cx0uvxz0sO1SMxVe
         KYaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FKwHJb+DuX2y9DP0ev5LEhBafTZX9d3yRPgcAMKIk29osEZZjgZjOjwfO0v77vz0ADLu0FlRM7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIx5r5SFCYdAGGifIdwrsxSfeDlQ/ZyYblZoY6htmuW4iDF8Eb
	hM9PeJTSGbQo3Z0dkyAxZdIC1dGyKtVWzXnWhbjHHcghpbUJMtYLw9Vu7zPYtfX0hklMcjX1wGW
	6dTrmr/iUswWG0Wybx5ojwDpx7Z91YEz2AuCp9MaTI900NxczDQ8V+8Mztj1UiQ==
X-Gm-Gg: Acq92OFObqMGTmYEOH5kgMnPnSXvcGETwDm81STSX2xEWqv80aypE0IAI5vOsIHIKLc
	1dGLPAHBD4Cmx+7RgvPgQjWAzA89DNJUpoGDzh3Ih9WgtDIroDNkwBoRlkpL2uxEF2ZhHZX00PN
	RWbxxXrog2SScXRl8Dq95lAnPMYAd//vPwGm4/bA/xetPWJYwIU6ECZqqzRpZKo6GxCSOyhdrs/
	52c3akCAvW8MXcX1WItXJf/yYDH7VEMv4lRjIy9BgquXRqZA2khNdXeLLSlMKlMZh6Wc3SK9B5q
	TfNvCdcEPBfv9Qyyw5FL9OpE2ELVXcylR65AdFMMk9WPsXExTuhUp5viSQ7TVU2w+hS/26SH6Sq
	5wsW/PZorbjL4ESv8gaIgo9M5FV2VVxGSWJY37g6SmcgQpSn5+eQIktQxmc3FPPlGD80MUsanBI
	f//VUU+rFbWtBx6sbvuiDQsGyfzTHLHWaYj4A=
X-Received: by 2002:a05:622a:18a4:b0:50d:db76:55cd with SMTP id d75a77b69052e-516d43d9c7cmr188562711cf.52.1779701644987;
        Mon, 25 May 2026 02:34:04 -0700 (PDT)
X-Received: by 2002:a05:622a:18a4:b0:50d:db76:55cd with SMTP id d75a77b69052e-516d43d9c7cmr188562301cf.52.1779701644479;
        Mon, 25 May 2026 02:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2d61fsm21227531fa.33.2026.05.25.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:34:03 -0700 (PDT)
Date: Mon, 25 May 2026 12:34:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 16/16] arm64: dts: qcom: shikra: enable WiFi on EVK boards
Message-ID: <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: zPxBrnmKnufpH9PxKsyose31N7u6yBQE
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a14178e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=FEDGRNkftAy9gYbYj1YA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NyBTYWx0ZWRfX9/Ec+BRKYMmC
 rFqHPa1LfzR0GhtsJS+Nkvn+L4Pc5B31/225ufb/70kbY/4Hg1l2fLVC6K4XjI4vACeoHGvn+Ru
 dUSx9y17WwrAySlkPVbGlHS+XmvbC1mYD4mEn7j1OVHb6amv+Toln2TZ4YTBgO1f1VdkJrmjL3E
 BDTpPki7+AVAe5uzjWBCw9e0OmXeRK1zfZl11RyJRvb5VAZGamAOj67tkWwdCUX0y+GrSvvohMI
 9UVw/jmCrKBbs3vupA2YGUiqQaomQcvOlN1C5KhvRhnxi3+AvkjI6JJnT+xHtWWCWonfaZtSMgv
 xBnnbhoEmwAiWfzX1lM4YLhhWR0DmdRtIWQBA84ZWMiHmLnXAviLFtrbMuxOp6JeIIlpXw/LoQv
 7IyFwsFGECEo3MIV+zmCS1Sj+qAkIxJW7RXckdL8v8QDbl7m9VR+rFPNjp1mmru/4AIC3YWL5st
 gXLCzlJVo3i3WfBdPAA==
X-Proofpoint-GUID: zPxBrnmKnufpH9PxKsyose31N7u6yBQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250097

On Mon, May 25, 2026 at 01:19:20AM +0530, Komal Bajaj wrote:
> From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> 
> Enable WiFi support on Shikra CQS, CQM and IQS EVK variants.
> 
> Provide board-specific WiFi configuration, including power supply
> connections and calibration variant selection. The WiFi node is
> enabled on each EVK according to the corresponding PMIC and board
> design.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++

It makes me wonder... You've added DSPs in three patches, one per board,
but BT and WiFi go together. Where is the logiic?

>  3 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 259032bd20af..15208e1abff6 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -69,3 +69,14 @@ bluetooth {
>  		vddch0-supply = <&pm4125_l22>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&pm4125_l13>;
> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> +	vdd-3.3-ch0-supply = <&pm4125_l22>;

Squash with the BT changes. Use the PMU-based bindings. Don't forget the
swctrl GPIO.

> +	qcom,calibration-variant = "Shikra_EVK";

Was this submitted to ath10k-firmware?

> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> index 142cc8da53ce..51267c1a86b3 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> @@ -69,3 +69,14 @@ bluetooth {
>  		vddch0-supply = <&pm4125_l22>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&pm4125_l13>;
> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> index 9bf52030bcc5..f4e93cfb77e3 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> @@ -30,6 +30,14 @@ vreg_bt_3p3_dummy: regulator-bt-3p3-dummy {
>  		regulator-max-microvolt = <3300000>;
>  		regulator-always-on;
>  	};
> +
> +	vreg_wlan_3p3_dummy: regulator-wlan-3p3-dummy {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan_3p3_dummy";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;

Why is it dummy? Is there no regulator on the board?

> +	};
>  };
>  
>  &remoteproc_cdsp {
> @@ -77,3 +85,14 @@ bluetooth {
>  		vddch0-supply = <&vreg_bt_3p3_dummy>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
> +	vdd-1.8-xo-supply = <&pm8150_l12>;
> +	vdd-1.3-rfa-supply = <&pm8150_l8>;
> +	vdd-3.3-ch0-supply = <&vreg_wlan_3p3_dummy>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
