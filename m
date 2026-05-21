Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DC367299
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342953; cv=none; b=SXfA1uTCiBPYVHCau3dM+PHe7/lwj5DWNgtj4BzdlG+m4fB4fnIT5C9WKjAKZ8S8RDJo9mKIM4ds84636gAoGACI3EM2raBUWXou2keqlp+chN4cctkhF7SIHaE6Y1vs1MufFU/ZPF3f3+hvFU1WkpFrSniQDVkoUvHccu8MdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342953; c=relaxed/simple;
	bh=F7VqFNmZGbADQDE8OiZtq4IHfudgK7KwtlqE4HaJ6zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIQuDZBKFL8DH0TLI9GXdxwSlK+oBfllFJboqksm7FtyryNWq1n63Oc00E/eZTBXqehP8mWdgRn3il0/iQqRF+Hd/d9ONEyikG8q5g9XTBPlmIeCNAYezQ7AWVRWtYnEUpIRBR5lr2/X/hY8n8XtHd50vN5gfi19fChauT8FBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckzqee7/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZEpjkxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckzqee7/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZEpjkxt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KLkrCB1798322
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bB29QB4y1Hf+TL1lvG+ncW8LElTa5mItRg7WxbcXeLY=; b=ckzqee7/9qSCrBMj
	keOMfh7G7p2KguQL7LMcbKM3GSnqP1uRbmfzSNQIkTvOv1xjgYrpNq84XSPkrYW9
	JXf17cN1ReHWSiGED8opxx6oStfDaNU/JnB47odu8D2buBV2H/lYD30cE/eVz8wP
	VOP68A/7doxJxIGlACVv26Wll9iF881Tnc1o6+cLNpJRKHicmWblC8cwsiusMTy2
	wKldKMBkjE64LLf2MdEqpz9hCKPcMKZ1+S8TtAj54NE+z5GLiKbCf5bjapA/fyAS
	/9ljXFyxIFH2q/3FuWtxMvWErqrETwAbU1LKvFqWiMSyY0lwTdj7ck20NdQgT4q4
	gvdBHw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu3ch6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:55:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b9fe2d6793so135074015ad.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 22:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779342951; x=1779947751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bB29QB4y1Hf+TL1lvG+ncW8LElTa5mItRg7WxbcXeLY=;
        b=aZEpjkxtW3VJlmiu2mlaKxXycoU6OfLpNCjqfqpRM2JznktNzUC0wbKUI32OMgm//H
         zWU7A741K2pINgNNT9NmvYkTEM4R7EjQji8McKPq7sWTQqhZEah73bKFZBPtyH8D2ooc
         JmBsDHKr6hMACpPAx5RgayebwNEGQ10kMaTkIpnDJY9ql1CdaYGSEbo1Qan1HcVHWkRT
         WJXjfJarT7alyDuuRODeCRenAivgKJ8EtzgOE5/2YsB1866CTRZdbi8uwifD77RAxjzv
         JHaMY4FhDItNG+X5NHDzb151tUuCAPnXZSgjjEpoGssoMWJ7CT8eEjxIoUoNN2gobrIK
         lLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779342951; x=1779947751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bB29QB4y1Hf+TL1lvG+ncW8LElTa5mItRg7WxbcXeLY=;
        b=DTyXeBDAx63CCmnvdGTpU5gf/6CxlYCxq/UfwBW0la2HGEMmcbWw+cxiLjZulIlTNx
         cYSGuHYrPU1ENJzoiHHU18YYnlxjcqF0htVFhQeDbUjyL1UHZPBdfA88jvPSgC9kKWfn
         HjeemIf5x+cKtjMBbsYqdicmBiiA1XdX5OI3smEGVEztJciIIjZ48nDoMiFRVKSedxZH
         sp4XVHIiva/Kw9eyu4FIVzcXG8/q20jAABgqtGGtLdenZIYi7jeSo2G9wzjXXEXJIxSt
         hfHoqOjyQkQlgHS53x65rbiPZ0HA0XYnZ2VBgPeUNlQzIpkFA6QUS3dL+l/yTMlamwDf
         xFlg==
X-Forwarded-Encrypted: i=1; AFNElJ90DlqrK9RHg9t7snZLWxJejZ+WQz57iAzVcD3wfMQxFXDrmaZBZ2s8CfMRwJlSdOM9F1lhc6qXVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSwNOE7DYs47ogsLh+bVKaCQb2zE8xQJNR4O8SYaTdLd+Upwj
	p23FHxMohQ2e01pRFpIqTC/P4gRZ4Wb/4SEq92JzrQhJAPKKNbS7kmgmboloTM17HmbLCwrHRKa
	WIKwDlLYxRMVxiSwlu+eOM05U72J2tqfy13LSor+4OOdhq2EAbou3lWzbeeCeRw==
X-Gm-Gg: Acq92OHouNdO1JBE5/sxPrMqd17kE76z2sn7FO3QicNsjJ5qEU6OcW06ihqF7ThHCrv
	wXKLf08S9wucpYteaC6K5RMwMqQQ7Q0ItGuiFq5RuCQIrfy/pdodOYyUZqz0mP73kCHez1W+qpM
	XWfb821ClfumFk4RzAqwqAEHxuDfqm9CvqaM3nu/+Ylc8IYVBWCjKiBF3a7dP4ymtLmlrVlPRrR
	d6gJ8dqkoE+9qkZbVcnvwjF50DGGv7YQqcLN1tA4JfbXdLwyGwXZMD+Pk2Zyv6NAlFFVUWRm3HA
	qaB3IF/4U3myAh+PSajVUZRhc748sGcSDKYzf8hGBTasWqONiaHCHYctgIoxtVCLZB+APLTz1Wm
	fbwrOAdO954C9OxlMMACXMTzbcvrWnzOndOASlgw/XR70tkGHrmyXsY4QmvxT
X-Received: by 2002:a17:903:98c:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bea33315admr15185375ad.18.1779342950675;
        Wed, 20 May 2026 22:55:50 -0700 (PDT)
X-Received: by 2002:a17:903:98c:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bea33315admr15185015ad.18.1779342950241;
        Wed, 20 May 2026 22:55:50 -0700 (PDT)
Received: from [10.92.215.233] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm244847525ad.14.2026.05.20.22.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 22:55:49 -0700 (PDT)
Message-ID: <1de2e8a8-08ff-439a-a0a2-fc1387a7efd0@oss.qualcomm.com>
Date: Thu, 21 May 2026 11:25:37 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
 <20260519-shikra-cpufreq-scaling-v2-2-2b09f0e1c9d8@oss.qualcomm.com>
 <fmqsbwm6is5qzflvyt53ax3ls5vnxabb2fbl4bttbcxjnhnwwu@x2jso7rr743y>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <fmqsbwm6is5qzflvyt53ax3ls5vnxabb2fbl4bttbcxjnhnwwu@x2jso7rr743y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1NCBTYWx0ZWRfX96IjOs1bIz7r
 q5QF96yu/NMX9QHW/UFYEBj89+hq6gJpJIaoHE0g/UlTUFkI2EKCzw+XaulEu6CUDIQU8C9o2YB
 +S88bSsGRArJxyXB9qhCad5dgA2/I6D6ECsXtY6V8z47Ku/sBCgDtZ3mD2Qy6XUPv1y13dG2gNf
 JwhTVrGFuvLHMejMbeLQl+G8ic2IKOHX9mPqd1QQ2LJv3n1fJiHt2hcN2Vy4U9Uu/DG4LbKm5Xl
 S+zRCz79qdJEao6MIFcQatSOO9f3PXwUH/2HMRiGUTmJrTn5jecrfqT9otq+ncqpV3ww3uvyjCj
 4BfXaGQGUb3k09RMc9wSIZMWr+WxYB4fN8l0I9O7LZtiVdblAvXaQfZbgDivp2az4Ur2Q2EkpYJ
 HzA4FdtnQQE7pK7FDLoAR2ulkJ2Z/IAD77pD6SkRjdEFW2YVxlUcdTqEzSu8Ff2nDabVZwZADbk
 CPFl871IlE4eKsiZZhg==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0e9e67 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Flm-1UoPJwoPlLdpieMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 0qSYqeMbGrP7THN4E-RyEEC2UDMPAHwp
X-Proofpoint-ORIG-GUID: 0qSYqeMbGrP7THN4E-RyEEC2UDMPAHwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210054



On 20-05-2026 06:11 pm, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 10:58:04PM +0530, Imran Shaik wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
>> but supports only up to 12 frequency lookup table (LUT) entries. Hence,
>> add shikra_epss_soc_data that reuses EPSS configuration with appropriate
>> LUT entries limit.
> 
> What is the drawback of not using the exact limit for the LUT table?
> 

Without the exact limit check, when all 12 entries are populated, the 
existing repetitive-entry check may read beyond valid entries and expose 
incorrect frequencies.

I will update these details in the commit text in the next series.

Thanks,
Imran
