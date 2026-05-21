Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBE1E5207
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368394; cv=none; b=CGKLuEdDwobF+Ok9y8EW8d1gGDjGIFoFsTXvIlSeWYYiOHA85Wv4w5lwMEysvfcgrJOhzXr1i9UqYHCUJrR4TEisRKlddjhd0vBzU7o7omFE5bOTdXuDYwekcK7Y2x4ZmCWh50HTBdgZwznqCFXEk2ge0hlHJxGmaa7/rFzYF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368394; c=relaxed/simple;
	bh=zLzgeOAn5um6ZKmQXfkK7i8pRIuKnoWZr7x3tYIRIJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQOYST0ZCQWt6aPy2GUmNGZl0Y37ZOef1FN+JXs9YZTrp57RiEN+8OJlpgs78iCjH4yNDSRUlQWARX8vQq58bmt3JnHXOZ9Schb4Mpypnl1c69vgTSadAfhHuII9sqNTtBIqR2dITrYYCQn5k2IlJuqVMwg6bh8bJBQT1nywti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0AnmhzF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ea2h6+aU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0AnmhzF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ea2h6+aU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99tbv517929
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 12:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HkXvMRxNG3BeSXrWPn53qbObcfOeiHhsQzNE6x1CwF0=; b=a0AnmhzF95DSG7Yl
	WeztPkuW+5xDbxYz3x1l9JWYmGv8CYbsVOXu+B2VVRr4cwZlTTWLxNWKZY89WUcP
	WcLSiyPQ0eIs70X1cS8pykMbLNMKHEXw6Ankn7gWkPushFLxvta4GWFQbQf9SgcE
	M7C1FfIB2XPznxIK/ppYjVSdtJNnHw6k4bSLGRM4crGiNTTWPRB7cssYGAcwS/dg
	VU5XGZZ+n8SLLf8TS2PtOXNNTEdEPhKJxSJFPiDwKTEAAp+vzRn0Xc2cgG2Hgs37
	9UrTD30yAzZXCTD0pA1k+ulvjjjGq2RCWpIdkRpQw7o8nZr92MvGOHo4iBSkO2OK
	IbXqqg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa2a9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 12:59:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso12702841a91.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368392; x=1779973192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkXvMRxNG3BeSXrWPn53qbObcfOeiHhsQzNE6x1CwF0=;
        b=ea2h6+aU/wbWJhsLeJwj7oSyEhTrDw2qqTFMIYmH/1rLuvR8RpMHofQQkNGK6AsVui
         bkq86YeXMsRsbF4zeEE4WXdInV5UpkTlRrMOTEqeVoTUiNocTyc7Z37vL8qJ7sTDydjX
         PXOcL6xpTzNR6XxLr1UGBrMXAT32X9GrrTQ7Ea7hOWZv2eFzkF36UHWELQohAT/HMRwS
         ZkAOfzLnDVTSjNnL+U+ZxIwqLYRp1i3UgDehlgLLA5uJCpWMdhLq2W2GnIgeF/o86QJa
         kTYEBEENl7CSEV+vh6t2z5o06B9fgh/vHGUndpymHLleomPWuOgDPZjrnBGdTUs+r5+o
         kiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368392; x=1779973192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkXvMRxNG3BeSXrWPn53qbObcfOeiHhsQzNE6x1CwF0=;
        b=EbhtL1XyV2KTC+AxZLJ0iaDvBGmk7Hj7gXAYLWmqzvVses6qB8zMDk98AU+BdjkDrv
         KfROY+Zxmf/hru4VKWxmFNXiIVvmouxS04WyM+cItNmxb6nizbkfjH4m0xN2cDvbosI/
         /y5lWFspxVkCyx9DdWw4guHjUt4t6IBxJHJfhrJC317WgIdaJ05D8d1Up8YqqD/OaQ1O
         ttLkCVDdamiZc8KNgRzje2uc4I/sBPHvNLWt6ZCy7YHZEzmh6B31XHPzuzQz8Rq9uiTr
         bVBjq4vZBfa09JnS1B3YiZBfITnKlIzfNz6K5N74LdIG5c7ZJRsrWZPDppwQUwV0Cb2r
         QjfQ==
X-Gm-Message-State: AOJu0Ywo0GBxe79coJK7oVMJsP6+7J18yu80nKEwcgOaF2OFHi2hOdJt
	74DfjRkH1V9iedZIxhxbEB2d/QcWPgsxQomdZ8aRjh1u6q0vY1cyZ+lwm144XyCb1VgNTfMFEX6
	dYlf7wFZyfoLM1CT+M/h+tJvR8bVcZ5nS3B50rdKofUD/nKv2T2+GWTrjmtzUpw==
X-Gm-Gg: Acq92OEpAw0l33uuKGDrY54Cbi023lCR8eXQhLu/ZMt8CfNvb7zZOT9VUbYNqkCy1sF
	MsUK8XWqqE55C4JSmgbeZpole+v7r4X9nykCwIt+Fdv5JW28fvqZ958YUaL6PwfBi9mpHgRfpOs
	4KS3pr9kMsH02+p/oGyoEXDW8mHqYkrZA7WFx4gc1DVu3E51mzHjAQVkzqawdYcmo/cCms/sd5D
	8Ne0sqdts+w+nuiCMThqeOF0LxZ7yEFxJyWdKAG+jYNf0raIJyCUEHcrGNEkD6/l4FfCQaukPIh
	NW0yBDM1rrWFRuN0QgDvL6eqTs6lyjylG371Ve7KGwKsfNT9rkvtVyQlf0I3ffW0cC5ULLboFDI
	6302rCcHLuwwlwko5kgQQsApr9bTkOByUPJPtMy9Vw/hYuoegn+YGYOl6Jfg8g7UMoWxbi9b4so
	0IvNBUoHS0YWF7Ktuy8g==
X-Received: by 2002:a17:90b:2f8d:b0:366:1172:597e with SMTP id 98e67ed59e1d1-36a4515e180mr2948402a91.9.1779368392068;
        Thu, 21 May 2026 05:59:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8d:b0:366:1172:597e with SMTP id 98e67ed59e1d1-36a4515e180mr2948355a91.9.1779368391553;
        Thu, 21 May 2026 05:59:51 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a5afe6868sm1107229a91.2.2026.05.21.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:59:51 -0700 (PDT)
Message-ID: <ece93532-6822-48ce-af84-c118cf4cc749@oss.qualcomm.com>
Date: Thu, 21 May 2026 20:59:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: Fix typo in comment
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMCBTYWx0ZWRfXzUkFqpSfv/Zt
 SbdIfj/o0E7H2obPzLMtMDH0YxjiI3XxNgA1kiUiGk5hWJvYJGMV0eD2zB5dGgq2oeNmALwksZz
 2/2yWaLdxH3fWQSFtN1ufS5VpY5Ct7UQPGsHpKedOIvnwk11JvHFxxJfDvN1tz++nrKGHvVNUy0
 0lIIQljbSMJu4C1a93ExJsX8UONAuNhqLuRgaSI3xb2G8M6ble7t5GEj+zrNuZulWzux89owWri
 My9UxxNPpbbjt3irvVQe5JLR/wtPF8VpQRDNPByuDe6kSVdNJQVMvINADRefvVjiQkAZrg88llA
 VMV2cWMDHkQvZSN7680yXHNtmL61nOpzP+3QRH0EHxpHS8J6tI6/5nYb5nODDg7Wx68gjdJP0Z/
 LtlFJ/lzGWZxrDMnP6T+MKxD/9+fVdoQBYfDp7KQ5PYe+enYufpPr7QQLeWlxcOimCgKzm2mysu
 ydEayJ9flPvHgdYLGpQ==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0f01c8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yDVtMUKNzat6eKGGHZwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 79j4Q0dINWkmycXcsffqrJIy5SVHhW8a
X-Proofpoint-GUID: 79j4Q0dINWkmycXcsffqrJIy5SVHhW8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210130

On 5/21/2026 7:39 PM, Viresh Kumar wrote:
> Replace "diver" with "driver" in the comment describing
> CPUFREQ_NEED_UPDATE_LIMITS.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   include/linux/cpufreq.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ab691828e48..4d4b4ed24b30 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -434,7 +434,7 @@ struct cpufreq_driver {
>   /*
>    * Set by drivers that need to update internal upper and lower boundaries along
>    * with the target frequency and so the core and governors should also invoke
> - * the diver if the target frequency does not change, but the policy min or max
> + * the driver if the target frequency does not change, but the policy min or max
>    * may have changed.
>    */
>   #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)


-- 
Thx and BRs,
Zhongqiu Han
