Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890905;
	b=4qQMznLdQKoAtHKF/02PFpUJQF+JW+oHmar/HPzFHhzb7UUGUd0/vrgoYqgYWO4VMMNk
	 FinOihBVqNuPK/18F4x6Y6z4XPqekcQ+rzerHDRH9y1+Re55lAZtClvMgsAaI0KM/mDOc
	 b5NlsHxK96ju0Qn2E7aj34RwaciFGDmsXo2HhQRqPJBUI4Oju+qOLihB0cqUmG3MVkseE
	 iTwjI70Gp4hiuax0AbyB9HcFKCdCIhi8nCo5KguaCFaOz3DKpTEnXm87bDbGG5szgYa/G
	 qwM0CJKBhz/5wUp9hzDRm3sn0vtlTwhR2Wj7wuKtpP2qaqeas8PaRWWjcema2bIMsSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mMwNgiFqS/fjPiXuqloRBJtiMm6ycT8nN8GDDLAnBo4=;
	b=Q80p4c+pTm8hInKRExY9KKY5KdQlo+d44Q2UZA9sxJsdEUh6d6DhrlWe6LoopMgkLC0c
	 KJ0beWiVlZtp7PDucS3f+coJ8rBKbdeLmFdbQGDBUMtjBGRLmaWfmp5MbIyUj5VVbgtPp
	 NoijiNSkJMR8wnmyjlrWI4kzkY+Sel397bW6F1p3Svb9xWX3eSzAWf+jsfAhnNxngXwDc
	 aqFe7ErgpasD2L5XOVNZKKzs+W+UL9gOFDM99BEfqNukw/hNetgbqezEDSH++r/UQ3h+8
	 luaLgcyTrhPQ1Bxj3PymjMzprQDXSZaRILAqIovTs+jn+y1JJQwVpoRpCNt75pQe0jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nrsmPyc3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hYgr3pgN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2B606D805
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F2B606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nrsmPyc3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hYgr3pgN
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQJBb1631100
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mMwNgiFqS/fjPiXuqloRBJtiMm6ycT8nN8GDDLAnBo4=; b=nrsmPyc3ojS7h+Nj
	2SkD8Y9QyeBJquijpVunHjntEzl4PE/3EkuPYx6C0KHzndFm20YcPdRPu7mhfv5Q
	hDRHtyXQaRQ5EetJ4qJbHdZGbHE4tZ/SBe/tFMt2fXxhScjpDr1+PoxBfl5+j40u
	Itu5zoVs5vxWuDfVZAk74ij3TIuKz1qjT8ld+5mJHqXwprvztdnAIIFT/IQ9qsFj
	jcAB7qimdnkny36ksZsb+RAmQII4loxan0Vql0ziDTvu0zerC8UY6FAH+Syoqqtw
	gLNlxsoWmX9oTUucpQnw1O3uRhX5q+AHxxGl8p/oDC4V6QfoiNeGurctuBrZwDJz
	d4p+Iw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaqadcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:01:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so2960546a91.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793890903; x=1794495703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMwNgiFqS/fjPiXuqloRBJtiMm6ycT8nN8GDDLAnBo4=;
        b=hYgr3pgN4qVYIBRMB2dksoEgK1qOH7qf8liLvpcYEvJhVt3FiiE64KXuBRBJUy85vs
         hH5SikSZosKG9DXWsjyEd3mAhKidDreUJigC/TBvb5GjYKLHgu/YuZTGCp0sF46YGNSU
         BEwkSv+ckMJVKkPwTSEyMoQ4pArcCBZBnfqmT5CCIJvku/HZ6jolK9h9ANKihmFdx1It
         ULZbDVNy4Q0zzD6GrwE6qw6YXrcYNSWq5ha4+tzlV6PAxN/iuvWZSBHJzLIrPJNHIi45
         D3I58o0kJDKQYXKv1DMhXCObEQ2RD34nIaYYK1zkVLk62I4FFRT4xC5XeFvpstYvg09p
         iRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890903; x=1794495703;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMwNgiFqS/fjPiXuqloRBJtiMm6ycT8nN8GDDLAnBo4=;
        b=CoEc1iSLtG1CXmPMnlG0q1b7TQ+s7dbml6Dl2+qch+BDjlWVa0HlzeUa6le0ip9sPA
         3F9c6gUXyVoRE5yMA4NWQwUH2FBkqPiGp1oVtsCv0P7PcwCo/f15DonWDr1FjXHyEXIk
         ZTdgj+jy3jqqMehPpJUDx/Ta7zES7KzK8DP1t3y4xo0q80DCQGIUCgFEsqp44vc0Ji7k
         K14VpRWC8VnKIVCnXY3/dZol7Qj5BY39osXtq28H+9liqr6VF6oPJP9jB+XeVyFg96S/
         aHxGV57/bY64RWcvNhQApb2qHNWSlDjAzVBWHtOUrq/qmserIaOD0k+v29dCD0qic1KO
         jkzg==
X-Gm-Message-State: APuU4Z/2dBBjUq8uCyYTKrz+X0iz5qiqLxCZHL7iR35126fLtOjKvNgV
	IKGlQEaPsmmSRUoxgKQLTlspxOpfdJD/BWD4kMRMf3QTGqhM81i3pUGy047HMrfpr4jHiAiTYGz
	gyn85hbJXDaCdVfLBOLHY84RqzsBwsuZ9j+kmz735NieMkUcWJII6h47C1HREbg==
X-Gm-Gg: AYBFou2BlwVcfXWRum6Lxf1c9pWr/ufExl55RrWaFkyC318Cusz2ltQEVLsnR86CwVo
	IUTDBogFGXJsGr5SGWovjJ5vUndaXqOedqwvdRq6PLIScOWA33YAmCelPgSTXKJ9f5jU1YDcg6o
	KAEpHbsDtoq0ls57FrGJo8QFccPet3/j7ktNc7fl4Bjbbd+EYBjTtZKBEzzLZHSOZI5OafAhzSu
	GtwyiJup5IaBs4Zn/oRwXn6oOOstVNpX2k6HP7YhxDlwuEPAI49/5UdlAwaVcC9H13TdX1Ys/pm
	RCLqTP1yTsLWsjLfebGUUNkaW9CQ9uif/ScuErfeEido3DkZvAw+cZZ9YCb/CncwfBE25THauTD
	VKvgoHg17fxmL80F6wMn5bUswQcLhi9AM1ADYtp2q8H/zhIH9GNorMGiSWJ/i8zmSsAPpnFr7Cc
	LjTYqtCu2udUxcHwkzf3m6auOPLPADCd0l/TNUgVzqW0mA
X-Received: by 2002:a17:90b:5808:b0:3ac:aa8d:19de with SMTP id 98e67ed59e1d1-3ae895743ebmr16831859a91.3.1793890902818;
        Thu, 05 Nov 2026 07:01:42 -0800 (PST)
X-Received: by 2002:a17:90b:5808:b0:3ac:aa8d:19de with SMTP id 98e67ed59e1d1-3ae895743ebmr16831799a91.3.1793890902227;
        Thu, 05 Nov 2026 07:01:42 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969b35c7sm4179157a91.3.2026.11.05.07.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:01:41 -0800 (PST)
Message-ID: <663e799b-9cb9-4e31-a6a4-5488d30ad14f@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 23:01:38 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Serialize global boost updates
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sumitg@nvidia.com,
        zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-3-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261105090311.1026648-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PWAAJ7IxEWugpQD3yR45UTWbUTc_Dk0E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OSBTYWx0ZWRfX37Ka+W5jtha4
 /DnmP151Evcwlpv8LGzKbjgl4RssmncfN6pcBT213lv/s9YuuAZK//MPC1Zg1JA76eWHawQF3cp
 F/kObE32Zdsu0EavFlhpWBG5a19Kyio=
X-Proofpoint-ORIG-GUID: PWAAJ7IxEWugpQD3yR45UTWbUTc_Dk0E
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec9a57 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=lRSh-j1tXNIazO6Y0zgA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OSBTYWx0ZWRfX9qRXJRn+kWX0
 f0bZcWvBDZJafPUbKpcJGxGxvEIKfMupm5N92X16EZ+bSQTAVx4sjvOmh6pDGrFF9CMMIirj7Qf
 CNyqCmHRX/B1alMEktFCpDpvHgrI7M0pBFnNsC/CdFuF4TVKg84a/05gT24+3M7bv67qO9Qc52v
 qvvKw3Af86/J01HlIocAIbVDO+FN3JIBqus6XxCHudd2VFyT7FC7rUszk99+2pudhY0Q7BDKGq3
 OOamz6XtnocYim136CX1MVKBn7pCnJn08e0+/qDsUik5KrGp8uEpBD8JYd843cIcs/JlwaZvmFq
 CtRcyPhYNc0VNEPCAfJBK17lSMlYPiahsORYxEBZOsBAZNKoX+1S2bElHzYRcvOSgeZTo1CfIDV
 eTdWl/khZJ7bCYxgfNdaYS2YA9284elL/PcmDzOeAFjgJp3mv6N6e7nTHcvBJ62e3rGd08nGWEz
 U5XvHnVudLn4++WoGxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050059

On 11/5/2026 5:03 PM, Christian Loehle wrote:
> Serialize concurrent global boost sysfs writes with a mutex.
> 
> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>

The change looks good to me. It might be worth expanding the commit
message a little to describe the race between concurrent global boost
sysfs writes and why serialization is needed.

With that minor comment:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/cpufreq.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 23a77f5524df..d95c849f79c5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>   
> +static DEFINE_MUTEX(cpufreq_boost_mutex);
> +
>   static int cpufreq_boost_trigger_state(int state)
>   {
>   	struct cpufreq_policy *policy;
> @@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
>   	bool boost_enabled;
>   	int ret = -EOPNOTSUPP;
>   
> +	guard(mutex)(&cpufreq_boost_mutex);
> +
>   	/*
>   	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
>   	 * make sure all policies are in sync with global boost flag.


-- 
Thx and BRs,
Zhongqiu Han
