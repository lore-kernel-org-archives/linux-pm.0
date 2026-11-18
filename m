Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984906;
	b=TP9B+4ZxO8ek1rBlyfrWgNImuo/yYe/FmGY4sQuekCCclvqNMWHBYvhIcJhQAwDlJ9Be
	 G2aqJBNURoFF4kj6/NxMIK0I7x7jigUbhlXFG3LdzCpdsACIjSoNej28zYpNzNoqYmmEc
	 jkqtOMkfvRPtf6Gf8Iq4r3h0jtzRlzKuGJCweF+7KFCU+j42SJ88he5JUOpU8G3Ez9Y/o
	 ZiVAu7NYSaLSnbi/ZZwtmcWWHcOrgcFhJnIgDj8fc15sXaBl8q/CyP5/YC2fbJhJuNrEx
	 2mzJiqEzC5Ay7MhmpVnJtpTL+DDcFbIci91K6Ki0f41L2T9NmF0mBxn9pdrhR88yqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xHO46V2+jhWyowoFT898RU1DleDEPsfgWYvhjeEUgxw=;
	b=FXYhiLZ+xPVkYxZkFyPtjgRaQLFSsGl85vx7GCfiASoaNaG7p+fQqLJdBrZ27RNuyOd6
	 KUqJ6QZ8Fmw9dRkJMudWGJ8UaVbKaV5o3OK2AJyvrKoarrPUBz7z0kAFtLyh5pRN3P13/
	 EgXD2ZsnPgzcis32on2/03WjcOYqdNmM5VQx0EFJsMpTOYinURljyhDJibM33bnGHcRBz
	 wWcpTn1RjNZv1aDQocQEXozP+BzBpHsPVFrXlmtUzRTRpKMWiTD3gzGohliq/5leY2VAJ
	 X2kvAJ2vQAjK7udAsZjBo1y/obAM0BFcjiJ2S0ZhhzwvrqdBGBcD9Yp6UewFPEdV21Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gdl0lK+0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwEAbva9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B50606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B50606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gdl0lK+0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwEAbva9
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2V4Aw3121916
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xHO46V2+jhWyowoFT898RU1DleDEPsfgWYvhjeEUgxw=; b=gdl0lK+0OfTs+42S
	UvtSCwuKorlm3XTsB9rG+rN3qkThx14hornSh54QdUG5USLAWoxsN1K/OcczxAXf
	lrB5wfsW4MLi7ia7qAaioVSm7p0qDUqapPJ1Qks98pXRBouhkx52ANQiyxYHpNfl
	0X5kuWVXIDEhrPVWF14oY4/gzemqIx9KHDzY2hHayLgnqbAtUJ4kqI3hihF0YPl0
	ccx1IzKAO3pJPjmSCMqxeRbIukzCeaIloM8OqPj71BGWY1SMkhWTsEOXNOIvnUhv
	jvQJSyMp6QjvOoMv2Gdpj6L0v9qtq8JfpfYnZkRW9N8pFB8oZvRgzvIZkZnLvGO7
	5XAzVA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9hn5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:55:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2efda3bfec1so3690245ad.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794984903; x=1795589703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHO46V2+jhWyowoFT898RU1DleDEPsfgWYvhjeEUgxw=;
        b=iwEAbva9v26ntmEuN/RqNhSnSL8b8aLDN9wFRLnwqflnNeXAbGvV5pd1aFod4xD5DM
         Ffa2tu9yUspeBya96BnnxnkcXtV0lY8HmLWAuhjNeuhMlNz0Yc4iYjEjqNwTzqd5yxIm
         9tBauX+Rwo0XEAhHTFOPugYzdeYpzsSgkmatm9h0q8wjrwJbWKVu4ZjKo0ejwW2HO74a
         UqMnBpeVzxjl85fOnggT1XnIg9cIim0+QIGLz8gtxKGn8+S0y54z9xpSh62LBcFexld9
         7SnefNNZhuNqxNUaB39O2ggDCyNgc6MZKATB98zkhOX0Sfo6fyh1gTgIeyZfdPayL9Pd
         RGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984903; x=1795589703;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHO46V2+jhWyowoFT898RU1DleDEPsfgWYvhjeEUgxw=;
        b=FP7zFCpyiKKSYWDMj3uDDJQOFs1MUDan8LuLLavC3ds5qqF55fqWOLpIHi7CKQFOJb
         CQCCu0fyY/f1tuiRfeNxW47S0id1rdT7BmOs/oexrCkQKJ7tPTFsEacnKWa14lPVVHQp
         TKhpcdvbBRUwPBEJpVDVIJmxTxZCUJf8uRWi5K9xCce0mSNIqSo6ovb6QeUheRK4GM3I
         deKQaHOcUDoHBBO5goZjZB4rU78EC/FS+dpq6K2CorcqMh59T3O9jtJzTivZl9lSqzRj
         dAvSsr2dGp9tm04u7R7qN2A9XoxKrs66qRf5T2Ne5W63u9O4oyrdjbybnox104r1jgmu
         GLqw==
X-Gm-Message-State: APuU4Z+x9bgDgSPH6NhK8TNFSyBMvDXGAfdGoOPFIY1kB/elH+9P/blt
	dZZ/4otzauJD8zMlHxkivXfOtIuUmngt4LK7GawkGPxOoCg/nK7+TlTo8Ew+sCGxHCn0p0DYq9a
	+Rt1aBCAakBdTToD8u34TuP+IHZKyzREisqpw93seTkm0Gk8Ts4aKsv2+XXyOsA==
X-Gm-Gg: AZFdTZcqd8R2kwv60kk77dcFRcomgSGJV+lthP3eU9tQxxbPWuaF0jkAfLzB0qJXuqH
	Z5QLGA/z1u5G73WeqhRY8c5uoANeoDIT5mzitc9yRvII+u9+l1DuUt6VhnDX/4qb/Xs7Gucb2NW
	uIbzRAbme2RhAfU0eKnRdxGOUYNabzr+HRuI/5+05Rvz0qiJ6LIColuQdARp8xKqbnGgSNylBv1
	4RVicIObRt9mdZIsyVlJe5byWiObzNwO5b4VJ2tWlnMAsCOL4I8BeRV2JLfUM/a5AvOAPsth/9x
	IBQYwWrLDzIcOASq3XhoUq3uDiMVjriW/1gh9YgM2awGMEnd9U4OFSKh0JWieByFsR1z31M80Ep
	us0A2UC9bFW7KHHBUZ38NKb3JXOXtiE2A3gs4qfwEazxn++Beb9JiAbtJnGoGfTFSvJqqJYAiAp
	F9ZZ13WLOWwZ9bc/5PQjmCz6yMrHGQNzlxAKDOuu3QMreh
X-Received: by 2002:a17:902:e84c:b0:2e5:4604:c375 with SMTP id d9443c01a7336-2eff75368e5mr17564645ad.48.1794984902990;
        Tue, 17 Nov 2026 22:55:02 -0800 (PST)
X-Received: by 2002:a17:902:e84c:b0:2e5:4604:c375 with SMTP id d9443c01a7336-2eff75368e5mr17564425ad.48.1794984902511;
        Tue, 17 Nov 2026 22:55:02 -0800 (PST)
Received: from [10.133.33.105] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6215032sm7998485ad.45.2026.11.17.22.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:55:02 -0800 (PST)
Message-ID: <3af8a03e-137a-456f-b1de-626405852482@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 14:54:58 +0800
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
Subject: Re: [PATCH] cpufreq: spear: Fix clock reference leak in
 spear_cpufreq_target()
To: Haoxiang Li <haoxiang_li2024@163.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, deepak.sikri@st.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261118053229.2066011-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261118053229.2066011-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tNOJ1IMO5EuVzSqgpPO6eGNoNEhvGNtX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyNyBTYWx0ZWRfX+sgy1p0PmV7A
 ncNo6jMWZDu22zTbSzy8nlLIOg3+/X6fp8guC+fte+jRVscA+wIxCvPXfZ9bqUL/q1EAgWy0o+/
 QyKiZHY3hmjYRsd/cc7OyaXEkOEYb34=
X-Proofpoint-ORIG-GUID: tNOJ1IMO5EuVzSqgpPO6eGNoNEhvGNtX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyNyBTYWx0ZWRfX4rXX0ro3xSqU
 k76bH2Fmi1dQ5yRJp5gAO97VaLyaykq6ghDU4AzPutigFkhXhW9PyCcZK3KmNveaEyTmAvhEo5L
 4S6v8g/XCwx1vXAeM/rc6hsQjtA2RsE/2zz5r3kU13uFiynREjclrPGY5aFhtfe08lixAo2zg9K
 uqDUytUPKozYaqeGSwlVdarg2Lr9JxOb0qtrqhHFRRvKVRa3hOjxGLjjZYaGb9NC5yPJv1hyqWg
 dqgGgfpKITnLCTSjZOaDLm5p0f0boRNFCZv88uJ0gL56+H6Pz9C8RpLBgv/nMCvk7dZYuEAFWqd
 I8XOWyYZMgYJ/z/loY1nJcBKAVrEyBTbU2zUzXenUZ+FcCH+ZmLVXu7CoMD+3ckED0EHdSBsI6z
 xeWGiHMwwLzPb2VJ5xqfIlNHJME+7bGjont4cve275iC7ufVs87K9SpbwYvwuEouerHlSSms3KG
 oR+pRDumzSXoOVwAy0A==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afd4bc8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=_cko6zJwpGfbbsqUD2wA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180027

On 11/18/2026 1:32 PM, Haoxiang Li wrote:
> spear1340_cpu_get_possible_parent() acquires a clock reference with
> clk_get() for each frequency transition. However,spear_cpufreq_target()

Nit: missing space after the comma.

> never releases this reference, leaking a clock consumer object and its
> reference on both success and error paths. Add a common cleanup path to
> release the source clock reference.
> 
> Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com> (with a nit
inline)

> ---
>   drivers/cpufreq/spear-cpufreq.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index ffe5eda82f0b..7f3fd6eca854 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -136,7 +136,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
>   	newfreq = clk_round_rate(srcclk, newfreq * mult);
>   	if (newfreq <= 0) {
>   		pr_err("clk_round_rate failed for cpu src clock\n");
> -		return newfreq;
> +		ret = newfreq;
> +		goto err_put;
>   	}
>   
>   	if (mult == 2)
> @@ -147,6 +148,9 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
>   	if (ret)
>   		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
>   
> +err_put:

Nit: this label is also reached on the success path, so something like
"out_put_clk" would be a more accurate name than "err_put".

> +	if (mult == 2)
> +		clk_put(srcclk);
>   	return ret;
>   }
>   


-- 
Thx and BRs,
Zhongqiu Han
