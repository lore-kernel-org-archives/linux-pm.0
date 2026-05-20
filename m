Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095A3DD535
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280890; cv=none; b=pGWM2vbf+Gr08bh9+jD4LuFKuRX+dCB6mDVuWd52qp12vVy/g9Me0q3u8rYCXsKXdcFLrLu8axtOxo4L2lqAQo7zpWtuY5ym02SasGRrwqrCJpXCeMga0FtOANVTuXeI//8vdzgymIT3Nu9CJUKnKmeQlrIr983Yz9ca34Vdnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280890; c=relaxed/simple;
	bh=zCCict06pIOXxb1IpBlXdDfgZuXsApbE11u2/vLcW+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okQqqIAgmAf9FpXm/v0afS/litBQ3WlYSYUekRBxlvt9aXMD96UaDqj+DPVbpmwKscjLXldofYGvgm2c3ghsN1KgApaQdpUBLslNxdk3rGzD0sR3EYfvcsK9sIzxoGRSsMYOKlbbYMX+DdOR+Pu4zcSd0RceOcN7JmEbWzMkrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbtzF/Bi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YoGy0lNQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbtzF/Bi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YoGy0lNQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9lsi5267212
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zdpYM21M8Q0ktREpxiFdF0gP
	EhGDLYOGCqnBfOEn0DA=; b=SbtzF/BiR32o/geG0QtteC1Uzq1i6C4LZ/51oSut
	bHXz7+2Egv/9Pu81p1GHLwbUU6v6Iu2wkwkbrjlUntnzg+ifidGgt9VM9epsvb02
	QJyuQAO2GH9W5QLXYdDsdDj8i5rCGkLaknLoWC2t5++LNKC/aHKdYOEADVxIckmc
	f5GcHBZj4JhyR/wx1UFYQYewID+vCYTW6SgXAFjxHCuxyIIRDoo1vaOVzd46N/c9
	oANqQ91DOpmmtiWl1mA9rF5SY1bbVf3H9Gnu+DzHQOlUOByBkULTYojDOK+1WXZO
	Ew9E4FgIEl9tzdx/xPQevSKR3wevc2ve6dKWrZQnqaI8mQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxrkm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:41:26 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95fd51d5c22so9751620241.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280886; x=1779885686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdpYM21M8Q0ktREpxiFdF0gPEhGDLYOGCqnBfOEn0DA=;
        b=YoGy0lNQYTvBpiYWw0CEo4XfRrUgO2CkZI3LF+l3QW5AecRG/T9SEmYJi/HsKNqqoQ
         sceOaG37Q6vJKWZ8nU4TcpbF/wQ5RhYspCZ2WIXLX5FWyach8BRxRk07b2D7wLBkL8ca
         rUcFiLEDgOQArkCE6TJhvkUJZWxYKwI1nDg2wN6E0+PoVnPcVls8Xho4g2YN70ryyiJr
         juMNJBM2Icp6pVZnXWOW8KdC8lL5VHhVU4VxfTihq0eGzarCXPUoEWnRgSulf7rvcHQ1
         HaUmbhAOCAofVIFd4tqFqIDUsrpIVrUWyca0dfSmky84yYnGN2E0+Q4zwlHi7oD8esH+
         MDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280886; x=1779885686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdpYM21M8Q0ktREpxiFdF0gPEhGDLYOGCqnBfOEn0DA=;
        b=rpzkGVMldQvX0K1mdwqkV5kH+YAqo8Q7J69uFb2pMpuAgUr8YR+Wr2PZdPG6rT06h2
         WRe7ZRFckAE+961fCaT+3x8ZjgjrNWOrkfauYKAMThiO0sFAGIGo3v985MO6qsW5d7xR
         Zmee9GKtoFiSPVzXX5yRACz8toJlZWszaE//wYd5eU14INo1PXkwyi9UKBqrDSP5VXtQ
         qo85ngWlTBRkt1ueCMaaWYgTqlBX97bKAMfTTWW5U8ikDiqjQGLWs1aeJWuhYjKAVZxM
         62KLbYaPuPWW2gJTZ7jrz1Yg23qFQOujPxpnio6wVur74of1oU1aBRTwA8ebOPoYhTWZ
         ZkzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zl8C7ooVTCH9vSUech+vVPu3b++/66qFjak7tF0arCDBrrR3eC7OBdPPywlR7P5yz8Y9oHw8k+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdYeh+Lb/RPZGGlZb3Jibgp1hVjPP1riEHnnyHwhUu4vZJXZA
	zJrURBOwCwqzrXw1nsXLb5c1NHycN4OVwTVgGkAYKZhimk0hbnK05oACrNdmEhgLDvK9mYaATPA
	PmZpi5VQOPvyVgBgYyoevwIMpNrS1vbveRhVMLJ36Nt0JlbQKsCpDhlwQVTiMoQ==
X-Gm-Gg: Acq92OHnmaf400drV2Sll3qYXLLZQ4/3OfpL2kpX5ygTOJruBk69BXao93KcKtzfmiv
	oCgQ8YXPHk0Yrn4uhI3xA2WIYRB1G8LKnXCRTa1SPyrhq17zSl+qPQ1XFfJgPatLqY8Ags4FdeM
	GagEtj4u4TvUsVISsPP52wY32uaWY6lHouaemij82X1lcLn5ADvy7FTEx98hS535RjVv1DoI9S7
	waKM09FHkuFL4QyNUY8jBhCehMXs64DSx8eivtSNU0zQ+pPyzHW/CtaJ8BOyJJIeqQL5kBSxNVT
	HuATxj6d585lmdyfXbtEA8de5Ix5gtRjJutUkiDfx26U4/hjg1h+mF9CTbqAcJ0WOlYeO63tRiS
	dhBAj8PZKEd+2voaIsbny7r+zjb8CYh1UGuu1U1QiEipAZMmwCW5jZMRmtVmBRPpxUXkJlSa6Op
	v8usO3zNaf4AR/Or3q6kTcQgSdp83W0J4tnJI=
X-Received: by 2002:a05:6102:304d:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-63a3d42ebbamr13508321137.11.1779280885896;
        Wed, 20 May 2026 05:41:25 -0700 (PDT)
X-Received: by 2002:a05:6102:304d:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-63a3d42ebbamr13508310137.11.1779280885368;
        Wed, 20 May 2026 05:41:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11e828sm4975736e87.35.2026.05.20.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:41:24 -0700 (PDT)
Date: Wed, 20 May 2026 15:41:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
Message-ID: <fmqsbwm6is5qzflvyt53ax3ls5vnxabb2fbl4bttbcxjnhnwwu@x2jso7rr743y>
References: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
 <20260519-shikra-cpufreq-scaling-v2-2-2b09f0e1c9d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-shikra-cpufreq-scaling-v2-2-2b09f0e1c9d8@oss.qualcomm.com>
X-Proofpoint-GUID: -d6GzpenH-eQurNLYLD3xsGLHs7h7_VL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfX8sPNr2ADDlRq
 PDqwagxh35AquimN8boXkLBuCxsE9Erf7jvT1Dw593P2ZgwQoBj3Thxx0uyhVxUddBYqG9ACFFH
 hY/sfUkbARIo1i2Cq3BlZOvZI+Q+Arrm+v64aoVSJlaiQa6RUg34DMXhLs4l58BbZEYG2l6bxxy
 xPbxMpse/+3GIendcgBEwLzbBd8DIUMd2CEQAata567NUpXRcy2Q9rgfo6HA4kAEiwawkw4e6Zd
 ZMxrmIcHq7fgxQGImO0btI0BT3BFH89vASPS+4vrUrNDX6QNNWsiIEuCpBLMH71qm/hyUZcxbyP
 apelqJSsZNSbVnydCfa0XRpB374+iTVSYdEe4e3lYMxkYbRM7x1EgjKpP3ikqSofgX8EDkiZfgK
 JGsSbFNMcK806JmnQomCCbPCBAIj6XbGloP5tX55EXPePTftEbMFbabjrSUbk/LcFkGk1SbBMAA
 RxjoKLwogAbp+OKP9Fw==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0dabf6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4ielwApaMtWjWprE9YYA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: -d6GzpenH-eQurNLYLD3xsGLHs7h7_VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200122

On Tue, May 19, 2026 at 10:58:04PM +0530, Imran Shaik wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
> but supports only up to 12 frequency lookup table (LUT) entries. Hence,
> add shikra_epss_soc_data that reuses EPSS configuration with appropriate
> LUT entries limit.

What is the drawback of not using the exact limit for the LUT table?

> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

-- 
With best wishes
Dmitry
