Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733943E48A
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228649; cv=none; b=t5ELUs1hu+m4VI8+UlYsq4g66f/gMzMRsVA0k6pfOOk5lLzxFwHpkbdvlEvFxBI3zIl5s8SIT4NYw1+Fb0FcmUoZk3BOP/uuQQ8lTdjbNIbWZOvk89UnY4EMLx+ZhoPPHJJE7z0lF0kfQ1Ph66kbNFgiL32gXgrQ0ELah27AdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228649; c=relaxed/simple;
	bh=Ui/hP+QL6ancseNG+Kxx4ozLzkd475S3Hpqx/mBIMOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOJSgIWtA+og7BT7kkqGnxQSRPKNr65WqiV+l+doo677M/yaxkjGyHnOVRL0B8lLtWurmaoWpA1EcvJs+TTgg7JaYsKn7fPCr1WiOs/Az3xN0FTYsjr4gsyNVEEDPwO7zS7Iv62wp94iyzyqr8JUcLC1CmYh/d4W5KqYpUCuBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IxEFfG+H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbV1c7Or; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IxEFfG+H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbV1c7Or"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8jlQW2529721
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrlmU7VL41FHOTbD5cdWiU9bgIS+YIxBeShNI/+hVa8=; b=IxEFfG+HvpqHgjUT
	8T+BKA4fVOxl4OpBOyg1Lxel3uyzrNtTzCbUjRgVqlswqf1tfMPVcnr9eKJTZimJ
	HSjHsaMOeTimK4Qqg0YlgU69rhk9CqAdL8Og7zJQkutG1PsUYxzcWN+H2yOQd284
	03DPREM6YVDrBDOsv+l83l1YQkhtb9e4XvsVtnZyw8ZnAZfNZgIoCF0NI3ug/5MD
	9RkJXR1Z5+UQu+zbqYEE3yYoBGRtjbM20yK+EU6R2F5D6+jetX7+Yhm+xb3bFuQR
	vO+Gz8i/zhwbd+Au+1HmzbRR1IIH1j57ho9kpMS/N+PKgCNfb2q04G982vTeyWvP
	Uh3JzA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8svk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:24:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1174792b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787228645; x=1787833445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrlmU7VL41FHOTbD5cdWiU9bgIS+YIxBeShNI/+hVa8=;
        b=LbV1c7OrRv6E2M4pViwbC8HGwXPowcUiCJIK8x0oz/yIXxY5D2PObocPTkA0t9ZvIA
         mLVXF72BWgf07xSM+jQBHwD2WkcCfGs9IxdLaCm7zs67gumkWeGvzKR6YmrO5uFoJTTE
         sah5O+BrJ1MVu6aiL+4PToHNRbl3/rHUzq3aPirlzmn9dmBwiW6EiOqrgxm6SmF/mGFH
         kvNLV0kxr6wqm36aJfOO9BoqFEXoLrLzyset5zFBFcarJlTr7kg03Q6NpS0smJodOil0
         dOg00UlC0t2j0gqhiHhnPIYzyIpwuQQdhhpGRg9Pl13r76mMJQdvwB99A+mnOtuktPY+
         Im2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228645; x=1787833445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrlmU7VL41FHOTbD5cdWiU9bgIS+YIxBeShNI/+hVa8=;
        b=cRKNBznMhakGNWE7DDWQs06ShEbq46XJwM7imFzAsBpSXJND8P+6PP+OOgtpSKL9VJ
         NPBiQ0qil0Vc+sw3mpMC/bnqiNeaoYtKrF5g6MNjNAfKK7Aue/8nGx2s+K7KvOJfp/ki
         Hl445XTjxJaNFD5ncceYp+sBI/iLwn3OGzF9RSbW0km5FHkFKEiF1ork7BDgYpn3JAO3
         0yvmHOAJXT9j2MrzXp3AHzuf/OJm3/i2ZeDCHbIZd9jooBIhqcryMGu0TNkikO3XsAwP
         6DhyCgf0odiw4M5Xvccb0ftH+iPFmdT/RJT/ZxGpA6dgFUkzhOwP42eJ55hN8vPPiPbR
         qCEg==
X-Forwarded-Encrypted: i=1; AHgh+RrSH6B5yVJcugV9S5ZWLOWgEFmLwh96hUVjCU6qRYUjQPfMWgpV5RABEPtgbFmOKOPKTajYp6oikg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybYguAdpWbxovSj/14trZLSuEaw3PTBTdTM1J84xregBfnpgjn
	RrRjmPguU202sRfTSEF6T+YdotR5hZdPsDlGtOezpNH/f5GeSp8h66p9RDFZ3/h+RTJtxbf0bSw
	WSuhXr7jQB5yhi5awKf2Js8cB//QCFFQ+HL++sL1n5NMmWmh4XDING1NRkUWSLQlZAzSAG//z
X-Gm-Gg: AR+sD11M7CTpnAnMGswLJ8JOS1A4INsEFjuRrOr/tys53HsO4MRg3GBUyDW98Rd+MKS
	mzqqSacAhBN/EFnzYM7HgYCU1uaXGj6N0ZzC67Tb95t7HM0PDn8zlDlkCaCwQhovfm/azEySqeG
	mVYsYS2E7KmLL12fBi3vrMIEFCyTCTRIyNqHRN1E1ZFCJciqR3lerlXqjmPwi2Apa7obKBDwvt4
	O1o1s+97SPWjZGZYCvFDPxehTzgUNMYF45bmJz4RHo13CMF7oWNx33OKFHlLtUJmSr3t7dd9xhT
	ZMBDc5MdmNn2AyWCcjjX9RYcLihj11ahNrs34Gfw/4PJO38ClN+29aEuhKI7v+xfytGfw9sDjwo
	6CnHKUL5fzSExUki7FGImf0CXfT+eflodrBY/6yDlLLRGbN5DIJyywq1/t6tKzN+ZmGLdnXyZ
X-Received: by 2002:a05:6a00:4007:b0:84b:e69f:1b3f with SMTP id d2e1a72fcca58-851dfa00aa2mr6762128b3a.8.1787228645249;
        Thu, 20 Aug 2026 05:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4007:b0:84b:e69f:1b3f with SMTP id d2e1a72fcca58-851dfa00aa2mr6762048b3a.8.1787228644731;
        Thu, 20 Aug 2026 05:24:04 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d36185c8sm1601613b3a.38.2026.08.20.05.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 05:24:04 -0700 (PDT)
Message-ID: <fed97fbc-7d78-4509-86c2-cb302d3957db@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:23:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cpufreq: loongson3: Use global physical CPU ID in
 get/target callbacks
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        Hongliang Wang <wanghongliang@loongson.cn>,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-5-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-5-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86f1e6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=civxVzKdHa92ALpkkEcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5MiBTYWx0ZWRfX4ayVleBtYmh6
 VttmzRymVvXwDmIp9vOjxlgheLF/HVVUslFuGiGtXGo9lz/tFzvjTpht+HJ98P+AQmHABGh0hxm
 bS8wermwHC7qihL4aWKmDystrdKr1UTsKpwiuVbM4PUyo6WOoqZh+sk2/keCtaGiY0SPvlUH5CL
 h7Oa5MxqLn8rT7v6ip/dnNQd5z+tINoT9391dLT/yTxweNJq/SzBwKnjaRU7BHLD9TRwCzL8Car
 s0cuZwjlrIZ4MBDYqsd9G6T417EXWpi+sEPpJN1c0JWuzb1as8e6Bd3pWyf+RMKTifnIchdt6o3
 G8wr0dxAF4hHWO9kv/2nsy/daOB447Xr3C/NSVi/VOGtHHTTaG9QdLWA1IHGpwk110h1NamYy5t
 CB9bbQZmRuDM1kVNIcwjY/3wRf5964NyOsbFWgDkEiBCeekl3MGLwixzpjKIXOUiN630o8d/zts
 RHTHB4Gf/Ljwl720fhw==
X-Proofpoint-GUID: KSNtsNLqv5lf8Gtp4f_bdOruD0OzY3Lh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5MiBTYWx0ZWRfX3wSXGD36ZEQL
 tHK/SC+mSFa67ZMSL8I8rjHNW2fghHI0ImWRpdSh21BOIal0of64iGJtBGJyGAT8ep8CwpcDHWg
 CBpMfTNb9+NT4LLm4RKbGBFARHW9D6A=
X-Proofpoint-ORIG-GUID: KSNtsNLqv5lf8Gtp4f_bdOruD0OzY3Lh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200092

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> Our server productions (e.g. Loongson-3D6000/3E6000) can have discrete
> global physical CPU IDs while the core ID inside the packages are always
> continuous. In these cases we should use global physical CPU IDs to get
> and set frequencies.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index e3cd78a5ab18..c75c0e30e881 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -219,38 +219,40 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   
>   static unsigned int loongson3_cpufreq_get(unsigned int cpu)
>   {
> -	int ret;
> +	int ret, core = cpu_logical_map(cpu);
>   
> -	ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
> +	ret = do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);

As patch 5/5 changelog:

"However, IOCSR read/write can only perform on the current node, while
sometimes we want to perform on other nodes"

However, patch 4/5 starts passing the global CPU number without updating
do_service_request(), which is only changed in patch 5/5. Doesn't that
mean patch 4/5 is broken on its own?

>   
>   	return ret * KILO;
>   }
>   

A separate issue， do_service_request() can return errno such as -EPERM,
it will cause .get() func return a large unsigned integer value.


>   static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
>   {
> -	int ret;
> +	int ret, core = cpu_logical_map(policy->cpu);
>   
> -	ret = do_service_request(cpu_data[policy->cpu].core,
> -				 FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
> +	ret = do_service_request(core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO,
> +				 index, 0);
>   
>   	return (ret >= 0) ? 0 : ret;
>   }
>   
>   static int configure_freq_table(int cpu)
>   {
> -	int i, ret, boost_level, max_level, freq_level;
> +	int i, ret, core, boost_level, max_level, freq_level;
>   	struct platform_device *pdev = cpufreq_get_driver_data();
>   	struct loongson3_freq_data *data;
>   
>   	if (per_cpu(freq_data, cpu))
>   		return 0;
>   
> -	ret = do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
> +	core = cpu_logical_map(cpu);
> +
> +	ret = do_service_request(core, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
>   	if (ret < 0)
>   		return ret;
>   	max_level = ret;
>   
> -	ret = do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
> +	ret = do_service_request(core, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
>   	if (ret < 0)
>   		return ret;
>   	boost_level = ret;
> @@ -263,7 +265,7 @@ static int configure_freq_table(int cpu)
>   	data->def_freq_level = boost_level - 1;
>   
>   	for (i = 0; i < freq_level; i++) {
> -		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
> +		ret = do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
>   		if (ret < 0) {
>   			devm_kfree(&pdev->dev, data);
>   			return ret;


-- 
Thx and BRs,
Zhongqiu Han
