Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F93E51F6
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701035; cv=none; b=geL7z6FBcwFeFDRDfC15pMlYteeZQ9B3gOrXXpVM9ZwCgLd4Rhn1RU1ozL75ysDC2y9cfqqTBtq1VQn4tdtoktRe3AT4vo8J9H6t1Z++EBY8yN8QAyn744qaxA/+XkEmT4zoOTKyRBgqtyBwMYfZtU/iJZ7gIgKpI+S4Ob8ikI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701035; c=relaxed/simple;
	bh=yMesBNc83KFeDSyEVsHsqZR1yAWMj5zw8lrvjBNS3N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IujXT+nLJM5sM8RIhosE0I6ab/7hmA3I0YWYwyWTYRmjoRwmNy5EMOHAH6ReGfig1Isz/fsEpjd+nMRnVqgAAP3UBhMX5uGxMtiIylMlYgbZDMeGnZjPIZlYWbkByyyxKUkzDYv4n9czH+PHzvlOeqAhwW7ZyCSQtz7r4LmiIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMtLprGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMbOop1d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMtLprGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMbOop1d"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7SuGp961954
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZgEROvWEv1cb9w2QdV5vokQY
	l9MdDAQ1ReIXJgtHI+8=; b=TMtLprGbDMI/hnPqqiYx+U/blMZFw0vbp82uc7bV
	ooCXpTVMNnGMYmPP2wGeLXGZlLmClFHi9qjstlIAnKAWK7GAD990gatTG2frv2eR
	XQ/r6guqNDn+yeFlbFGFzW5sqEGxbRi5fA2m16RCeHrnjG44WiQbG+ExlTu2qV2B
	X/WKO+uYWXz8plEefKKasBbG4JxRg7RNHAKyjoG0RnStdGTvD7BrnP9TmEJR71G8
	rbyum6Nq4U1csA97iDrFXzcMgPLjXkJih+JdfychF2q5NwPN9Ihp2x9BTHSNxbUi
	UKopP6vYMNA6s+ku9VTahM+Wkx3YaaCGIlEgQ17FBrZGUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3dy3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:23:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d19f68acso72966131cf.2
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701031; x=1780305831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgEROvWEv1cb9w2QdV5vokQYl9MdDAQ1ReIXJgtHI+8=;
        b=jMbOop1dqPsfu+VeBFOFpXpPwXOcY3gYx56YjvAl+Qj0H0X0bUgdQ4+fb/Bd5bMNbd
         XlYra/zQIUa0/0EtWoMIaPhP/3I4LvL0jCY0roH+MyEIPGTTJqJxpVkomgjX41dRukZT
         S2nfbXoM5XCc1pbp2nF9h2nMwfvBTvWtC7n25PInDTMSR5zt/Jp3+f4S5gu+xXMw82uh
         zOAUK/Ecrkgg14E4ItMpxOt961ji4IdjRPnK9VrYPOwNZeU33PqLXhGwvxiryOPmEK7G
         5XpXLQNdcYPhmSUKn57BWeITMbemzod4smY5L2EOe6G7HqZZq9YaV1rJaNQ9YGjvaMgp
         jYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701031; x=1780305831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgEROvWEv1cb9w2QdV5vokQYl9MdDAQ1ReIXJgtHI+8=;
        b=k80npceNN1W+xOxAkl42GVYtq/jvZrPuwmapMlcRFk8PK1uYrnqphAXhPkYdCmpHhN
         xe3g0QA1QSeZDKf/378FJEa3IMBFWsH3rjodK3z6PhNpEFsdWROrAfRx7otimuImfjjM
         9Fe5HHKpD/VwKqGgnrTklcVbIGokndEb0knLHJHrqRF0AC+YyKVGpZlmSQzPpqTr+bLN
         +H9TP25lb/Af2GnT90L9lWIu12ruPECPZ8LEStjKqGG6a5S2kbxRu4Fkdk/akv1Zf5aj
         +F6WA45dhPdkmTU5rc/EdFRhGnMeqM0WCnDLAqcAggL4oDGnXqwiX8jc9WYJjMM25BW7
         dZ4g==
X-Forwarded-Encrypted: i=1; AFNElJ9/78yuIgwwBA/xp4QXv9qmlBchp3PaKu3vmd27sDeAZ1exYJDNW1ZLs+y4IhucHcudFWPwNRQBWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVsTEK9MDTku4kj15kz59Neh1XhyX988dJ4xerRcZnkKK4uCR
	Cb9BOQjQpnxl4Aev+eoqQSrJtdyOl0TmlPMvo21klZXChjEuYY2r2aOX+vkPNgpRd0AZbDX+21+
	LBb+LDkrhcNvYN1Cli4v8BfH6cehPBWh4FnZDS8vHJ6jRgxHhVrwddGgMn4LyDQ==
X-Gm-Gg: Acq92OFzqSer8O0899FaMGj9FyQcf7hAgXW5u6ygiTGGHg7mhd9VOM8aDncQKjM1pO7
	2DHQvWQmUqI/YAVzJAWfYVOh58kbTYCCN0dQfcRGRI9GNvnItVJdlE8+kKcybFVJTJnGOnOq4zr
	ksE+a8gcgYTOUsKjKC9+U+GwOJMt5f1z9g5YQyOj+nc9FgejHAcngfdczY6rYSkTne3/Q5fwKHs
	CcEyRYfmJ3dobYn2SHKzHnO6Eh9PICOhobYNiHCaRy0ERuDeFza1+QnHVy2z0B6GCbVOWYONJU4
	z03PoRYc5UYXy4+20PRQ8BIb5XZ9XI2O2EjL7AdmClZAMgNCcyeRZox1POSHNrtK6kwZ92rOIqJ
	n+LQu0usil2CZ1TunwIFsx7FUpfWRAvAo/XmpDm2kPqLdfJGkH0fhBj6ZOZ/mjv9hOCZw3sIYJr
	GPh90eJ7gK3lIvsoUUg5MchB6q4Mh/SUSimHw=
X-Received: by 2002:ac8:7e93:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-516d42bfb1amr206103441cf.16.1779701030682;
        Mon, 25 May 2026 02:23:50 -0700 (PDT)
X-Received: by 2002:ac8:7e93:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-516d42bfb1amr206103101cf.16.1779701030247;
        Mon, 25 May 2026 02:23:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc41ca0sm22447561fa.36.2026.05.25.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:23:49 -0700 (PDT)
Date: Mon, 25 May 2026 12:23:47 +0300
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Subject: Re: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
Message-ID: <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: upoUdRwmsGiwafm0H72Zp5Z0hqCyPIli
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a141527 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=djs_V13T0nIvbdZk5PcA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NSBTYWx0ZWRfX32CTh0NA2Y+e
 o7pKWjG6fj5tb2iLJ2sSWqXVe3YmeSjFeTn4fri7aeEaGXm67ipHvcQbWnRj5Q/apK0mjiSVWcE
 +CGHnZVdMce/kS5BVGZVJeOkXzT/ITv/UZcDlSOO81yvpJkKWNQHGJSnZimPRPaENX9NIHNIxd9
 Pu4SpDtWjIdhh9inSKBEUfmyUH7/l/ATOHl3/NvJFb1XVSOj2fe548h23GWb7vPH4kOlMbIFLHW
 /yq7swBsIaRbLtSzR7q2XAuGeYVT5PFn+scFkkHww/SxfwN9e93yApo9xCi6TRcw0pJQn5tB0GI
 IsEEehz0gem9VOLPtfZnle51lqcEvZfs14YU9nQGc1mhsMGadDI6ugMvj67N2UB1YQvnTysVhTw
 vitnTPy+JaTKitCyq/5Oqd8CeKjJx4wcfsI3L+VzeGxnnj+evLQRf2Wn/gPWmevlszSxrr72w6k
 F4AujpRpn18rZDb6bKw==
X-Proofpoint-GUID: upoUdRwmsGiwafm0H72Zp5Z0hqCyPIli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250095

On Mon, May 25, 2026 at 01:19:11AM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add OPP tables required to scale DDR and L3 per freq-domain on
> Shikra SoC.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

Does it really make sense to split cpufreq_hw, EPSS and OPP tables into
three separate patches?

> 
> @@ -144,6 +164,70 @@ memory@80000000 {
>  		/* We expect the bootloader to fill in the size */
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
> +	cpu0_opp_table: opp-table-cpu0 {

Missing empty line.

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp_768mhz: opp-768000000 {

Drop useless labels.

> +			opp-hz = /bits/ 64 <768000000>;
> +			opp-peak-kBps = <1200000 17817600>;
> +		};

-- 
With best wishes
Dmitry
