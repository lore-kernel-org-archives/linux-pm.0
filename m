Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262184334D6
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225708; cv=none; b=sT5mDf9N6t1lm/oyWBtoODg2V+i8OpLkbXT6YV4quyoPoAzJkslRqDVsozfxwpRnsY5tMjltZ6EtSw3s0YgETi/PRWm+hI9vltW5f0z3NTSzJLt0q6HQuWPbfYOzx8pTt8fCdUftygn/4UIdHKXVe/ysz989CVUQ38ym2iqDtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225708; c=relaxed/simple;
	bh=w/oe/n1XYNtDc0P/sdP49l4CFCqy7eqL6XVrY+vYFP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSzd9A03VM1l4d53i4r3T8w1Qf2asJuXTbbwt0FNVLf7ROwxMfyHCIKkjkjcNJKwEGImD5qgJdWmU+0g23oyMsfaa0pXOysz90oAoYVf0+/5/Wv0t9R1oKaYXMjNCJrAYkWrMZfjVF0uuu4fCmOs98nLfhvxGWgCxZtCSiT01TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INnkzwFD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKkr7LRx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INnkzwFD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XKkr7LRx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PCZr2465359
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 11:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=; b=INnkzwFDr3Mt1N52
	g+XzLhNJuP+bvMZ1xMcVQcUw5aLDHKyA8EVsfD9vtdhiDG/VqOAKHKPfbYiL5Ky0
	4UfyOzpOTJgAS+VXDxyt6nu+I9LNrqrIrNUdqg0dgy/0fdYHvsofX89QYMvG3o3A
	WBJHYkd5w0pWXPGrq8ZZec33IxE6/yDkOTTs43JL0SAzWTRA4C9iRFe+i8JcV46n
	hbJDHDyU1D/pB9kGyG2DSDUcAq6dF6hpAYfUjbjJJkTzBEwgFJXJrqVTBcipwv2q
	9bbd5+x/7UOk9WrPY//PscDf+SUWRq6XThmZ1eDWmLHyggSsg0oRT3qyVrZc8+MB
	GrA4aw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gqya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 11:35:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e024d2129so3349964b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787225706; x=1787830506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=;
        b=XKkr7LRxigTaRpngUwoEH+85Io/fGbTKBtNtlAJ7Mxw8UIPJ8Y0DOM5Mcg3ceKDRFG
         r5gslpRIVb0SchRWb9SaEjNIonAXBo5pFMHEXAk1Y0wJ5VISUk555udyxGVAv71Ovkbc
         VeiJB3q15Y0ekfBAqqDuY4661fFrLBXk/hmL8XCWjTOkyYOHHNYRzAmqOkn+k5m6/1yN
         VsG9BM0dKSHpKyV0UOk57kaNyigc3e2ik7+1134OJ3x4bdA7CHqQvdQKz8o0LpiQx5CC
         P1vn515izPt5mL2wle1R33iwoXin3pBgoxeV4PYDxAM9BU0gGILlU9AkS9HO5i4bRk1i
         n3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787225706; x=1787830506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=;
        b=TFyX8/vGX7Kxu3sO/nBM5r9ggQ2xt9V3W2Oj48aDcWzefJE+YpmYYinQu8GH69lMOz
         qrzu+ItDaF5Z2M881RMJZKVLKiuVEaiHlM/B+IC25XIH+Q1k8edkeMjA3VzpuxGbS7m3
         uUyDtoWq81YQl3jAZJOUbCT65ZgKXS/9RoWzQIwGm5ZUR6Niw8yXgVmImEmpF6DP4g2e
         nuAKrSXf66WZjhLDgX3XEd49aoddtZjoNOa6zuVEyD2JKmfV+6G6ZqBe0tXeX209qOeR
         ZshBaVdN9oTwSNoZqI7tLKkDTnukb11G9ciFiyqbwx2DMdCowoBk4maV7YmtdNGADqoX
         Rqew==
X-Forwarded-Encrypted: i=1; AHgh+RrpD0xs5vf5uXnfKja5wrYA2W+DZn6475a1CzhCsrCPwqzTITzcWJsdgvpAAL5RDopvgkEhUdnKPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeP2gzNTgI/5/GByFdhNwLqSuFeLIJ5NgfY2kVHVKqK6FbDUZ
	fPI0USomtPwkoIYvf4j4rIDvQY510fVj28TZNAssZuNwsSRFwieZk8wydCfkygZ6RQNm59ZfNiL
	KKiKO5EFUcXFX+TBaFKhOD62jzYTAaa9brxhIxasUxzCAdObio2CBvO0/eS+paQ==
X-Gm-Gg: AR+sD13ikTSRiCZGOqdxH0x2+sx4qI1PTF64tRog9RXGCG3IuqAAS6e3sXqCBUsi9kL
	II/yNjRHMgiN+h9vqbcM/NDoI11CuSHXAo/+ygLOuP5q0EDx0KY69gXz3bBlvy44vjaqBCrmXZG
	QQsYivdcz5NH5KM9LOZTn1UKvpECxHOSJhDsJnOrzixWexBq9QoVyeiv8oAbR2h06n/VTxTh5D2
	PtMMuHhU08+odSL1IgxvUG6sto9npt0EinKPe+ppglSWYK1Pi8D2oSadwsh7+7Q6c8YTljfgwSa
	oBIzK7wRPtqYQfHcPs44ZabAkei7LESizLRjBSOt5ioy62e1DtJZ/CrDql9z02nl+3GBkq14urC
	PPpp78Uq69hkrZkay/TIhZdy64iILJQ==
X-Received: by 2002:a05:6a00:808f:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-851d383149amr20467246b3a.4.1787225705576;
        Thu, 20 Aug 2026 04:35:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:808f:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-851d383149amr20467124b3a.4.1787225704987;
        Thu, 20 Aug 2026 04:35:04 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3617efdsm1528743b3a.39.2026.08.20.04.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:35:04 -0700 (PDT)
Message-ID: <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 19:34:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with
 per-node
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
 <20260818123921.3600606-4-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3kJ3ppOr9UqecZNjshfyjfQNICK5jwqi
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86e66a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=aB35LMdZ1wvYvMI90LkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfX3iqH8Duws84i
 IETJtWJHXZgshi34kOKGgOtUC9cIrBLBc9kQatv5eevRPnCMWeBoqPfRPKGuSBAuVvgYkHZfxZ+
 UytxSR0WoWI0XCd3AIGPVbn7GzUZy28qoiv8ROteniNUPt2qu5y+mIvnafz6s33vMkWnqW9clyw
 NfNZ+2LUYZPM5JUDEm862LwE/ZZNI0CXmI+hyBPHKN+tajmaq+FVl/6bKUAhz1cvkkjb8bsplpA
 LWcnISBmUge+ssKgIGuX9vn0mvWyrzxhayqZzdWXcmecnJxHpF614mS3X3S1UOTunsUnvzC8Lhc
 pd6xF8Mr8mV79G6qr/5L+7jQNYPoS4pqZi8Mdh0jsKRgnsF/ILIIbsHnBhKa+y6w2UG6VQfdN3c
 oQW2Y9JjiDZUL3tuGf9HvnMgCVKAYEdl4dqFDpr2PIbzp9Alv6CMgcaH5bzIJE6QjEkKKsj4jpP
 Ot2Cdqp9iWnqH8msCKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfXx9x1rMwJns/J
 Nzlq6KXEbK3ANBT2CjZkTdDUdkfhNXdWnj2Xg8PAXL/HLxwF2ypw96o+XlSbnHrl56S/eGp8h1H
 vC08EezeVZFqjfGtP367C9/4dok0bBc=
X-Proofpoint-GUID: 3kJ3ppOr9UqecZNjshfyjfQNICK5jwqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200085

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> nodes in one package and SMC mailboxes are also per-node. So replace the
> per-package mutex with per-node one.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index 630f679aa739..e3cd78a5ab18 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -169,7 +169,7 @@ struct loongson3_freq_data {
>   	struct cpufreq_frequency_table table[];
>   };
>   
> -static struct mutex cpufreq_mutex[MAX_PACKAGES];
> +static struct mutex cpufreq_mutex[MAX_NUMNODES];
>   static struct cpufreq_driver loongson3_cpufreq_driver;
>   static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>   
> @@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   {
>   	int retries;
>   	unsigned int cpu = raw_smp_processor_id();
> -	unsigned int package = cpu_data[cpu].package;
> +	unsigned int nid = cpu_to_node(cpu);
>   	union smc_message msg, last;
>   
> -	mutex_lock(&cpufreq_mutex[package]);
> +	mutex_lock(&cpufreq_mutex[nid]);
>   
>   	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
>   	if (!last.complete) {
> -		mutex_unlock(&cpufreq_mutex[package]);
> +		mutex_unlock(&cpufreq_mutex[nid]);
>   		return -EPERM;
>   	}
>   
> @@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   	}
>   
>   	if (!msg.complete || msg.cmd != CMD_OK) {
> -		mutex_unlock(&cpufreq_mutex[package]);
> +		mutex_unlock(&cpufreq_mutex[nid]);
>   		return -EPERM;
>   	}
>   
> -	mutex_unlock(&cpufreq_mutex[package]);
> +	mutex_unlock(&cpufreq_mutex[nid]);

An optimization independent of this patch: considering to use
guard(mutex)(xxx.lock)

>   
>   	return msg.val;
>   }
> @@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
>   {
>   	int i, ret;
>   
> -	for (i = 0; i < MAX_PACKAGES; i++) {
> +	for (i = 0; i < MAX_NUMNODES; i++) {
>   		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>   		if (ret)
>   			return ret;


-- 
Thx and BRs,
Zhongqiu Han
