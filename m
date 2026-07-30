Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90536829D
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429691; cv=none; b=O6+J+YU5e+QcZm3MGmGfSaCRbSyMvProZxeYhjZaF5ETm0pzXaYsDZ6aiOfCEmBnVyTo6cL6wUCrgpyph0XJRvgk8Jyn1O1bSQOObdosqiglqwO0XzQx0DAGkkDoZnvNCjSekEyRRQUrVRLGCmM2TYECsy5Hp96ZsFFQRpAyoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429691; c=relaxed/simple;
	bh=W1qHPOfiLKP9reR3QhYi9YeVhYLovQs0sDLJcbc29/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4UzCdyTo6m9VQcXhjbLodrFNHQ53tVc1G/REcxqefbdoABMiSpOlHtLHGvdBvRpplpsfIsl+xoUtJf5NuOPy5QyE5qTWvOvvEunNZde6EzcjUocnnmw7lEpeJ3wKaBbjANflK8fBkBV1e+cfSh2Fb/4VRb0fISaitFyctIU0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P0dTlVDc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hNPFOvHN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P0dTlVDc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hNPFOvHN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWXZx1379016
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=; b=P0dTlVDc8DfrJ4wI
	pytp3nTccA75LMtWp+hPPaH2FIDyucvJc7kaK5q8mDhNrGle7ySsOMYKUqPib6Ul
	n5BUUdH2o9OU6mc07tT2CVHB+KYKyl6YA3TeYBaHKxsXDhjDB/fK1LmSlom44ubz
	dJuxLCFcbzcQqer/yZgurp/AxMGPYU3fBu5eyPGylsomifbrpHShWeBY/+RwUSPB
	4UxFKqH1ynlD1DmpEiExcjSSP/0AVE75LqRlRRwG2uOGvS9p608BhwPmzvtP4ZRl
	MFzGDEfbPiLoJxjtdzWx3A2V1ipYpx6ycV4dmSEXgjY5XBxy45AgwG0ZOZqquiAj
	mV1tFQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0pba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:41:28 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6688d64bf53so4565292d50.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429688; x=1786034488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=;
        b=hNPFOvHNfPB7M7/sL1hU0w+URzSY3c/KCWd/YiPqaYrGBi3P3gjWnXCCcy1lN0Xtua
         lvNM0+9k/+ZrrdJ5mYGYZ7mqMRR8eTUzlv6U24VkF+zQ02fP1vTqmkFQ41Ws2byK89uz
         EogKm+x8QIkCsHLJTchWPfsWHqpXarR7IQptLYmc7wyFjXmmaU6rzGKm97JqaOz/brBF
         4kULrl3Jav2e7b3hOD1gt8FSx3kYZW3E1EVCoIsBPgOWr4HEnLyvsqEF7vtWj45XTSUq
         v9wU7H1L8RmZRkVfaCHzldBLXyYsGo3PqN47uvj1uvedxo75V3QJWTep4zrMhONssK5k
         WgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429688; x=1786034488;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=;
        b=Vs3k9VW25fGXuQ+H57F6HhFwL/owBFThG4I6dr9mAZd8DaG2QmWe/stfLVo4WulhVT
         m11OsqS6OCbbygYgjexD7A2OqfVRKd+0u6pcF8cnAcRO/EkECMxyrIroo/dsDZJl2HI2
         Yd6IZtAapMAJ+hMIJeg5EtckrG+z6FTTvOU0cggRalNujDSmDlv4mpsl9oF9Da2xjHYX
         bIsMJCXTabfqHGDDRlAdpJ+iXkPy4WERXKy5Eycdp7eYy393O3bd7DkavAbTVS1eF49h
         3kAjaGdKZLhfrcGVxjtuV2FYUCswUePHUxpQK/zPi2LdOcmNtLZpHwsnBDPF9FwObFd8
         RF7g==
X-Forwarded-Encrypted: i=1; AHgh+Rqi7YmR26Jhhm5T7Q5vLW+6rYWUxm/1X9kASDZxcqhvyM2Yjai1VeU4fJNj/729WYunITMx+aZTKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqlPJqDbcsFYh7MIHfWAwugKynCYuUqvYyYbOsDvquvUVT0s7m
	ieSVv8FYZNTwlJnLOyJZQyHDb1Qp/T+YtAy2jo2DFMXKtTTtPWouJPl/XYNmQgGD2ZYn7Alhpu6
	jvbzEQIDvq6/WGTzJwsGb1v027Qlmd/sBWQJ7e3oqYuIUvCLycRGSxk5sarq2UA==
X-Gm-Gg: AR+sD10m1jLP1l0vrIVdAPJaB6LtVU4JpwwHZjRxKceqHC+kOQa199VsCGIS7fiSPWK
	gzkbRd7ARA9P0NviHOtx5h2J0E0JNh6HA4OEYnxc8oNbvnSzs4CdQDfQPq7NVTtawrUd0baI6d3
	wbanx75M7foqd+6ewln0zfZyr+CjEs0WkP5ex00pJPjc1xiyzUdiIM4p5r4qbRZpBvY+BeIbehu
	N+P8Bco9ckioXRccvElNTpz7SRxIIn52rqZyt0S4V6ixnOFHwJe3MujrjmAc0PpArPfPVDIAJCI
	BM4gFy2CL7sHAShxcRSuA5xNmLQIGlE2QmoQ8jNCeXMoFSkHLm3ObXiwtbBRuz+N5MlEgUK/q2C
	OJUn5b1kXzmATN7KBxbDI12HgBTz157sMeHc0I/c++cBQ2SvGZQK28hgk0VIiolArfQ==
X-Received: by 2002:a53:aecf:0:b0:667:b5d4:98a3 with SMTP id 956f58d0204a3-6693a62cff9mr530853d50.96.1785429688496;
        Thu, 30 Jul 2026 09:41:28 -0700 (PDT)
X-Received: by 2002:a53:aecf:0:b0:667:b5d4:98a3 with SMTP id 956f58d0204a3-6693a62cff9mr530830d50.96.1785429688008;
        Thu, 30 Jul 2026 09:41:28 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c95ca34sm1627738d50.17.2026.07.30.09.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:41:27 -0700 (PDT)
Message-ID: <ac813518-1fc2-4262-a166-dc54545bff9b@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:41:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-6-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-6-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNSBTYWx0ZWRfX1Uu0EUR+Qswl
 WOXCq1kVflijIS9RO7U/hym1c9z1RoQIw6pvN86epx61ZEnAx2U29h5ZOBwTlyaRkFN07ULz/7y
 yLXGKACCP8xASVCFZfMuBpnInNU01+4=
X-Proofpoint-GUID: 4RLdd5VSTcF95xbmSpgW-WdMMYxxFBiL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNSBTYWx0ZWRfXzuoZfifmp58G
 YvKFRy8IsVSWZdZ9yRjUWPTc+hsXoeKtFGoD8G/pw0uo2IEjxWov0XiHXNm2uTdiruybdI/T/Y0
 OSl9ufX9NUia2WJPL4Wr8dsrDRrCd9ZYOkWBekMtnGktJRVpz+nDbr61ke+cyVvywzveuRSD+/1
 hCfUPWVV6CPb0uzTg45Gy501hZn4zHmY+YfVPfLEzZTGYCPncW3OD48RmjKgzymVE1aYL0mRYiN
 Y0kXhwgHxwywwxDTKZrAyU4Kn68g9r043sC9spz4gWIf1K7KQbfynU4UxS98iXF/2Qqtcywa4mv
 BWtqZglSBAew28jvE8tepr7XjeHzsab8phMUUSOoSt7quSx6f3V+dEqwHvR/bsoBMq85+kswajG
 QsxrF/5cYUVkgE2mpiatsp3sGC5Y4U072nYYJrptXDx/71tnEHU8HMLmEXvppIp5cBe8nSTRdKN
 EouDAmOTX/EneRqIA0Q==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b7eb8 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Oo7k-GI02y8c9wmTVmcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-ORIG-GUID: 4RLdd5VSTcF95xbmSpgW-WdMMYxxFBiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300125

On 7/27/26 16:22, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in lemans.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 105°C.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

A side note, not related to these changes. The passive polling intervals 
look very short (10ms) on this platform, may be worth to double check 
these values in the future
