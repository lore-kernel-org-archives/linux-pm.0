Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE73443A8E
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675542; cv=none; b=JUFTzTXhmWj0zDUtAAUFa0DKO1KhbHta9zTRD/Nq8jQ8iSClzn2YNRwGtekd/WtV9MQUolCL3e3wMKm7cfAVGjRIGGO7LJiVbEZtv817Th67imQgiZ1dBBHfxJ+dnqNnmHnWD4tAQbmGb9dYt1svKF1dsbtyO57g2ysVpSF0IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675542; c=relaxed/simple;
	bh=Vl8rdLXA/zWODT5DG80RoiJoKnYzEvwuaitp4xFqIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nugHgTAYd+hvQGUfaQCB/R8PfX2vQ8+wYrhQ432TKfVNZdbDdqf4vL0733QFglsXU6kh0cYkoIN993dc6sPHS1wztxYmjaOdxDtcpzZIl16pXEa+7BFNS5iisTQEbwbzlq8SKeQpB6raGyCHULb+SlEXyIv8rCdlsv65yjBj/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCfZDsuy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZYGPZdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCfZDsuy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZYGPZdT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZPUa3311587
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=; b=gCfZDsuyx8wMiPx6
	EjB1L9/DUuBEJcexYw9PgKGiBCWx0LhrRNZDnTEtr4oZxr9P3ly25ZHfHVEKxSJY
	9kK1ufSBa7LZRQmbFZwOZxxyRQvZhnQc7Q5eu+4KB5syWvGe04yqCfHBI1ObuGLA
	e9xx0GnN0cFqNfj8dPDgD45Z/lINTd9Yow4xiY1mJqireeQIxlrPKa4Gmp5J2+A9
	u//EPfo6OEc8dpgB4cNiH4U0FYq41I8WqdOzJLrtTYx12R1SLGGzos9k/52QVrVX
	iixs/rsoNEs083G2eSwF0XCNiCZAxab6sYzdfhkmEETNKBIPu0yyZ/gRwIr1hc/q
	5Phr6w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3kbpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1eb52e1fso122217281cf.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675538; x=1785280338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=;
        b=eZYGPZdTZeUyLiFgHtkxVwwsHrQCJNQS0MfA8po9h9YZHmhI8dMwN8iWAH4nI1LCUf
         0crx3eAqsciFZtI28rdIlPCuwPQMeVI+6zbALE2QHZJySm2K4FV2TJezmKRYlrRARVwr
         1V+ZqnDllpCMKIEoJDF7EO5ZbBVKgqS9ucu9D5Puj8dM6LUraoYevqOaS2Plgji80HKc
         koCeIIAlJJIP7TVaLVEOPzofaMlWS2BOoQtRo+0s2fKCXYHZ6yYivn0i8Pz1PWk0U5Yd
         z9DNz97SN217iAI6dLD08FLbjALb2uuHKbPhWKLW8ErfaVuAgq7zULwlHzEmK5toQks+
         6MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675538; x=1785280338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=;
        b=X220GnUYCWXN3mopwmKpvD4KqjlaLDpVzNI9JYz6XjZmagEgRkF/oJPM9DJhL5SvVq
         9U2GsT+PklREIB2k/Za01JNa3WYHdC7fERCumqmBwBszGZ4i4Vl0nTSwfsw1vtQUBvhx
         sD7l/dXs5QIezzipPkJslvIjbr8YTkPaoogh3SMdWEIVRx0PLbOYytCoaJQqAxikSqj3
         PjGNBNlMFCUwkLt4u2khTdYIWaM1S3PnrQHaQZ0NAn7CKB/WYDuXIxnAtDEbIgxguC1n
         QfzJkQlGDT8q26PeYSyzfypwtwRaFfFRZ0T24+lbLrZXA9g5fnBXxj/q97ULmjvwBmrq
         12RQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/SAcj33p2sCGB8xPLT5eI7ro1RSrzoFwws+CDV02i+KZnniSZJ0KX7TglU2Xav/PC0lzgTYGHVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWjT25DS1BP+M2fg7R9bR6Mk5eSDfCoiErwYCo4Kuucl/KpEC
	wrmTJkmSxn3fk7BL6UhFmuCxNjWOf7ED+Co7z06oyVz3ZS0xvAOYXmDVfYIQCcwL5QaTTPPKE1k
	Okn21kT1TpbEuaTXlup6LhHf7otw+1p5YhZtctxCnGxl5i2J62EpVaFFlVnbsZg==
X-Gm-Gg: AfdE7clbs9t959mrEHK+vPUg2ZGfpstAdyqcs0AKu4AQxJ8p7bJinGGr5dIPW0hL6as
	EY7tOEaE2kc1YtkVmgsqEFD5UQAFc42wNvLWU7uFD+Wfych1X4doDSMBuSBciHbIGDUwW8s+21h
	i2efHD/9DMhQIuitFh49EJyVr0/TFZRLq82Npw61t84CnTmINLfi64/+iZLMlajVMShU9DTzFhu
	MCr50V3PcNgId3S5Wm4yWmdgijNdpgLD23+IFxO6iFcasGBzCzdHmevCvIyzbtpMfuEXeujDgUv
	/XvOAizZb0fm4SgmGIK4xN0ABRL4L+kBxwDZ3ax5cOTDrp6wg8k3m2COWdalkya8L9zVZQTYJdD
	fo66ac4mZj0ZOEo3p0Ton222/ZxXRMO82t2Kv7GgdGknpK02N+DkCM/PXXMqjb8Ehlrwi0zdYZB
	EetNizs/jybwgW5g==
X-Received: by 2002:ac8:7dd4:0:b0:519:f884:b587 with SMTP id d75a77b69052e-5213ab6d3a9mr195185221cf.27.1784675537746;
        Tue, 21 Jul 2026 16:12:17 -0700 (PDT)
X-Received: by 2002:ac8:7dd4:0:b0:519:f884:b587 with SMTP id d75a77b69052e-5213ab6d3a9mr195184921cf.27.1784675537347;
        Tue, 21 Jul 2026 16:12:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef68b7425sm1387111fa.11.2026.07.21.16.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:12:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
Message-ID: <mi4irfwanrjjv56p62nn352yinzzxuig56amv3xkpkscwlrywl@pst3udv3kpth>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-6-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-6-99620e07f505@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfXwJ3nFofAOo+/
 cKXG6uB0GNYUgWwXdSTa0tNc7A5FrC5UHE5yrP7F/3x7GEr5bOeB1Qlz8M0FxGETfBz8ytp8CME
 /WbIqfVQW/fUd8jaYOQ72D4TjwU5lZZ56pSnzNowL0gfvl5Z3y2g59xQveDK2fj+SkjHLKLR6Io
 bqAaqB8KA3ziwqOpiO5WgA0ExIISW1KmB0tEi7EEzDq2sFg+bcnS9x5pVEtUS0Ym406gHuKoG5r
 2HQ0oJoHmFCjVNdY91L/2y9rEEaarSHe3Htei6nM/q4xYuY4VF7mOvZcxjoDot7hXzlWf3bYXpc
 TwYhDPlf4CNS1E2abBUYyeaK43eElpcQtMJlhOB7DdLIkH4XMm9rke+w+4EPTEohfxWXurvG3OW
 rjThOkNd9XWWIGMyMuBoU6CF5MAFYX1mN2GP2ADbfopC5Dg+UF+2YJmUxmhgXqZjLs7M1tfJiAf
 TWc06e0Q1Mvj8/Lr6EQ==
X-Proofpoint-ORIG-GUID: ob1hMPYIhsfjor8lIMrjnC_D_DgELiD1
X-Proofpoint-GUID: ob1hMPYIhsfjor8lIMrjnC_D_DgELiD1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX/Ab6HKkc6bRm
 rVJrFGIAgbyk4DyK19351Hs5i/Uswag5IaKgCde+j42Lijx5YAuMVRI5iuWPi9sgDYCT32nsXyh
 Z/NL4CSxypvOCsdLXAD22VATdUtqHLk=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5ffcd2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ysZNT-AePBnC6ZdsTwIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:03AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in lemans.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 125 +++++++++++++++++++++++++++++++----
>  1 file changed, 113 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
