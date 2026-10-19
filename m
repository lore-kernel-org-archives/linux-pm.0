Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161D401A3B
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381041; cv=none; b=J1MyFvMIlToYpHycsfFHWYxytWjp7XA2KSR0BlF/pTtsoYQc5rD6+XA/eTgIQMiJ9qnuMVR5JyU0OJyZHjvpg683WUyJ+L+1KeTo6kjk143Rv+QRwkwXMswVXNEO/Ya/heZToHkQIXDO1DqFPs9PCz8pv/sYFnWP7pvNR8zitHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381041; c=relaxed/simple;
	bh=j906orCti2ITeVgDnuaXfjvITkH7zdowOZGNTpAwBog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAIIRUgptruJsGODyF6J0UYfT32i60/n/AZDvND7jb+T58mmPqoRhD4PFMEqGKqbWYQyUxJf2eM6DYsLKWz3AvjBHr03DwfrzZFSD8kX2b3djaHwAPIyZPhnk9Y2Glog/j1X/z8JLgQrEMrwOkAfhoUpsLSgtDQ3qPYpAilJmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mu4J2g6D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MgcELVLK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mu4J2g6D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MgcELVLK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1G5AL3995065
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 03:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E3x1ccoSWKvaDczPqyBJn7CYWbLOpigDoCXjx7UHQBQ=; b=Mu4J2g6D7npX8EcZ
	wleVgQrY8JGlwLg4Lj9D80LXBFZ2ppU7zDk95LLEIo2jDc+QBHurYOIPqdoITKZg
	jNfjseYwYZpw6+lO/Cy5ohNeh4ISl7G7s3Fxu752TGaaONMbmVJcpy4hLbtWoQlA
	Emu1RSsoo0/d5ane2uTp1ym5Pur0a999NNLMDfIMZwBY8DlORgfjcJH6iBugXjR4
	BF3jIETeM8In3zI5VdjkwLCx3hd6RnsU2s+uO9KvX4WwJzMsNmcBrdfehXy6QB9O
	bNHoX5+gOQzylQ7IyGF//FG7naw7vWXRsU2otdH1EOQn/L88uIIvPWpoOr9l9lF+
	d+X/Ew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k4hmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 03:37:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0589ff620so550176b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 20:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792381039; x=1792985839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3x1ccoSWKvaDczPqyBJn7CYWbLOpigDoCXjx7UHQBQ=;
        b=MgcELVLKIDBrjAAAkmGixVPnj+v0GtbvXajLSWVMozhbcyS+kFRtqOHP0B1QPNiNdg
         5XBhrUU/9PZkf10jtVRdNEWtZYynl9a57AD3TIHOT7St3ef0ZaH7ShoZQnoOWru2OzgB
         UWfcRwAF7gdYkCvzqMlrdBpnyGWch2jfG/uskOWljf2SEZHOSswcdh5S26aByT1XtzYe
         ZB4edIrizLZYSC+vgs+UcZZdhzVUR4eXQHy+0RN6tZxt4UtRw1qI3sIyr7HcmMf645Po
         2hphBhPoU2aAKjHvihpSYIh9IGyNoiN/Je+U7p67xAIrhOu4+6360XmQzmybBnc500Y/
         TS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792381039; x=1792985839;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3x1ccoSWKvaDczPqyBJn7CYWbLOpigDoCXjx7UHQBQ=;
        b=bvnjVfVKLrLV6aMcxJjAtB9FvLtsMZMcBnj3DfuPmRz+K7DTWz6aiRmE3JWWrt5Uej
         8PohS5qfSfz8szlTCM+eFK7K2/Ia00gQDIhGHxbmLyzIRJYSGjcAKnNK5tk2gzmQIzku
         zRKTr2BnizPmO5jiwHyeHzNCOQhaYFUCCYAfJZv8dKNfbDEbgrNocHS8cbHUJjXQCjR7
         Y/F7ork7y3tSqSb0YGWdztSCOCucuVGqqLKElKM1poaG+DjKnDejM/bgPPQX2wbjMxww
         /M3ufE4GxZ12PM/GUEWXfx2EhcOUNCBH7RChRBvf9bWylnwr8WZLVVCV2yinh2UHysql
         TE1Q==
X-Gm-Message-State: AFq9FYJUS7uRFgrslQsz/EkbYsq/lBPe/jCnNb+7RjGvhjjMPcbdMv1G
	l8y1m3nM2HnCHNpIc6fZJeiZtKotX4QYB/Vpzaa2FfwpfUzBaSMc20FPuaL/nCDzOR5EzBs7tKR
	xILuusEVbp8TCH56ic0wOnM9mk3Ex2f1/9pmUBMN1CouXWfCIZe3sayk/o65jng==
X-Gm-Gg: AYBFou0+1vCwUqCXfCdYbgpJNcCdpSluthS/eAAlExW/PT0WobiE7919n13PRrEXROn
	uG5OVmd7tHhFe7CIrV4x9NY90eXgq6pBVV0dBodEjF9ECuHK8AmMeH5ZFcqUr3qEPN8PYAqc7MD
	73eQ0nXRUqwKigFIMryyKe82Xk2Jnjfe9sgjTpZ0Ui1rGbzPtC6YlSYT4yEXydNsf4ioIVINnr1
	pp26Nh/pbXdq6yviVjDA+L2HPZ6p6I1OHxrP8eODi0wCi8oxtaJ69uPCDpBQE6BOzRk9XMtXowv
	LxyP/htmDzj/BywbmZJJhRXMuz2XnouvkrZz9+C2KbdzmnAAWPuru03rIW7GwhYEs0gVKfiUJ7Y
	hvjeDlA9mzOpZ7gK0W9Kb8nbTAThsWRokQfljWTCt0XylO5I5h6xK/BKds7ioFAL6VPeqwA==
X-Received: by 2002:a05:6a00:3cca:b0:880:ea3d:d70a with SMTP id d2e1a72fcca58-8a04ce354e6mr4846834b3a.38.1792381038867;
        Sun, 18 Oct 2026 20:37:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cca:b0:880:ea3d:d70a with SMTP id d2e1a72fcca58-8a04ce354e6mr4846805b3a.38.1792381038393;
        Sun, 18 Oct 2026 20:37:18 -0700 (PDT)
Received: from [10.133.33.85] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a040831d6csm2177560b3a.6.2026.10.18.20.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 20:37:18 -0700 (PDT)
Message-ID: <9c312de6-7c73-465f-93da-d7a75cf3be8c@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:37:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: longrun: fix typo in kernel-doc
To: Manuel Ebner <manuelebnerli@mailbox.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAxNCBTYWx0ZWRfX1Rb0sSudLJdR
 TF57JQoWnLaZPvUfrZ4y40oa4icjs6K64Ise2IPV3NWJlNr5czgu5KfJLI8ny39PBAwelRlYEVy
 FFxDkYW6yD7ZIqr8KuD9g1EpiMQMadsTwZUVn7Erd814owZLwcar+IWeS52Dtwi28As/td/eZo2
 WcFP+fVcyMh351bd7P1Y+OdRTPg5YOe4MHrX5PHbXUdeVTF5282bpqI4Hl/437Q8+g69PU6KHK0
 QmbyNXxX/H1N5Zm1qooyq81JqrgHRjp+zpkzy3wT/yhWPZ63kXteSqekjUdu1KB32nsO82cOI5m
 JLJ4zhXe26+tsnyWFU4bb8l84xRX+4eOL55XmMxyfDUce9/z3GfQO/zvHLI0RL8BcpE41TZKHl+
 D0hLc2Su0JorTSPZCL1iG3HyLDLaLAyoq9E1bT16ym8I0+qRMxMCccQpFRne7iiHVCyGVnx27/D
 ICC09jqpszxP+BQkeJQ==
X-Proofpoint-GUID: Yob_yifiQwd_WIGV3CTbJHAWWp_7YH4Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAxNCBTYWx0ZWRfXxjRmqLQHL5kO
 1gfuXSbUgWj74bmb3npKC1jMd+nlmL1/yJhTi31QwPKfufnXyaZWMzfP4pCJf6wL+i+d/mL37Pk
 nqjjTH+5i2hsOOhqgwU78jIvHsNj5Wk=
X-Proofpoint-ORIG-GUID: Yob_yifiQwd_WIGV3CTbJHAWWp_7YH4Z
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5906f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=b3CbU_ItAAAA:8 a=EUspDBNiAAAA:8 a=N8s1ZLDY4SbsyP3Umr0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190014

Hi Manuel,

Thanks for the patch.

On 10/17/2026 3:14 PM, Manuel Ebner wrote:
> Fix typo to fix:
> 
>    $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>    Warning: drivers/cpufreq/longrun.c:126 expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead

./scripts/checkpatch.pl reports a warning which should be acceptable to
keep unwrapped as it is tool output.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)
#9:
   Warning: drivers/cpufreq/longrun.c:126 expecting prototype for 
longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead

total: 0 errors, 1 warnings, 8 lines checked



Also, while reproducing this issue, I noticed another problem,

./scripts/kernel-doc -none drivers/cpufreq/longrun.c
Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**', 
but isn't a kernel-doc comment. Refer to 
Documentation/doc-guide/kernel-doc.rst
  * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz

It should use /* instead of /** and may be worth a separate patch. But
since this patch is only intended to fix the typo, the patch itself
looks fine to me.




> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Small nit: please consider to add the Fixes tag:
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/longrun.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
> index 82a7bb69c..7d4146d6c 100644
> --- a/drivers/cpufreq/longrun.c
> +++ b/drivers/cpufreq/longrun.c
> @@ -117,7 +117,7 @@ static int longrun_set_policy(struct cpufreq_policy *policy)
>   
>   
>   /**
> - * longrun_verify_poliy - verifies a new CPUFreq policy
> + * longrun_verify_policy - verifies a new CPUFreq policy
>    * @policy: the policy to verify
>    *
>    * Validates a new CPUFreq policy. This function has to be called with


-- 
Thx and BRs,
Zhongqiu Han
