Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D402D1913
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863035; cv=none; b=DYJCK1z4mWVXQ76DD57HC+Em3TS8BDmsPjLtjKGwcZzXM0ItFoz2pfgZyw04ktELu3KzlaopdL4rNWB2WMNNhnX6bu4Z7qn68Zinmz5wCvk5jIgcxnawZ3uqHtEZ3py+PV/vWFk0qFWco5wiBqjjom2CcTxPYP0VRxNn9qGBACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863035; c=relaxed/simple;
	bh=lb/BAo8nt/synyDfbm+lEnhjYWT3KhROXJZc8197IhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNjCXvoUmEDsuWhcOHQ7u7xCVAbpNSTfNzJldaBO3fKzGuYIQMjIX/ta6bTbIj3iKHRxp8egsH8JeNrKiw/ahrX9sM/BIzLXdjkRZFVAPcNPiCm20OYgAukoJWNRyfo6iiTPjl/veXbABLW7CPkWszUk+ifu9Ekxsh6nP3KMQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yk71QcsP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFnzSenR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yk71QcsP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFnzSenR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAcBdq2332033
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 13:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4uHhiyPDur1M8sX3vop9wkmPBwPJCdrUdMn078zxrjg=; b=Yk71QcsPfmUAcpUC
	ri8yyNK/LBXK3z7oCGi56+sC8lkTtaoIbICpaSXoI6gyN52T0Ah9a+Y3vh9+DB+H
	AKU3gmMiNqaxgQcqxC7bz9297hdJ3MzuDncRBqOGu5FFQqLv89JGYRKKd+LE1DSH
	cxz5HfyxEnp1ONorkGHNEDYXanVEMFSflDFybOJXwrSmaojBImpLTm9yN32JTySW
	nXvavCffINO6Z/BriIejal/N1nNssPwjmJTrI6Hb9dExke9UUg+/x8RnowOrFiYs
	h0uy45MkVBKf6vK2KApCfVq3dpquMXuhYtLFCNWhoxy+rGCaMdLa8zgDbsnFW+Z0
	41THug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamtv81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 13:30:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce870a060so45592925ad.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783863025; x=1784467825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uHhiyPDur1M8sX3vop9wkmPBwPJCdrUdMn078zxrjg=;
        b=KFnzSenRKG75KSFm37V4OJvAdEGjwr87WC9v/zM52Vx/KHxxbapalBe+/UL+ww3Cc3
         J2sfJy2vMhy2ZXn5yb87JoPYMneY5tF0vBxUjKCrx87tRFZAw9YtWzyrAmwQCE/9ByRc
         lGzBXTqH2lBoQgc31gUxH4re7x+sNT+VqQcU3jc7m+aMnc0oW4IumpWpVtdHb/j4JtCx
         qBhoxDbvlzLLzJXluRk0LzhwTLpLgqHvbHzsgaY3ZjP20lOgqcvG40pHsW3NW8WheuPn
         qm7PCxcG0W9ARH/4Xb5IPtqtdVAS4jiB4xgQFOUB2suWYlh9C6K2Qsde7VtKaaYPPR/0
         cXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783863025; x=1784467825;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4uHhiyPDur1M8sX3vop9wkmPBwPJCdrUdMn078zxrjg=;
        b=O7lgx79W4eKG80z5KSQQflN2hBuN1kGfquKCN4JyrZCf0xdnxdjV82rr1LU2Hq+W1B
         YPosFSCWTGeeQOoQM4g5CgiLh/QMoySqomp/kydpt1eQFPF3XPQ3edN6g0TUu6/3aLQW
         lHdqGm+ycRpJlTpyZiDk1N882vu9hCk92DkkJmck5K6ze/8GWtHBvoOBjaZwY7uHhwBE
         XCKuIb6bczKo6B7P3OAt131jzAa1W1Bm0zqNMGOWGheaTcfX7vIh4+sG1Q+XjVVS3tyk
         637Asz3igAtUis0nPSLoayMCIvOIQWTs0Gkwa2EDQsrzItbI+SMmoN1XoHy8O5gUoQyK
         jj+w==
X-Forwarded-Encrypted: i=1; AHgh+RpvsTaxSi4BNvEbSFi7DxEGIvMMAcQm3FLbBzDze2HDxU9g+0x+FTlQg5oZpgkgrgERawgEaVyJLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEPIYY5Rr2CNbATRgpgYJ2VMNxRWTU7z+yjAmZtzq8kJZbXm6
	z8alrBnotsLMMZ+cVSZzmmxPogS8BWcq0x6pKSegY9vOcs2wYQ5FblGH/ex7OrmKk9k7eE/ZUTF
	HKs5ogGaAfXrApVpnjcsZLEQlrd6KWQVNnuEWEt14wc3okywqfAUPluZo9Q19tQ==
X-Gm-Gg: AfdE7clwA+w8AOvfWvcD56Zyt4KCxOBaKhxKl+v5lZ/pCLVWF5OhACdVZIUPMu0xJLi
	dA81MYNER36QbLTf3Sr1VhYzPykC+3ZttBYbW03JXkNRweQTT9bL/u7DaVSohaN99lZDv/EOhdB
	H6SHs9bBWHH6Iixr4kMiGQJs0g//hqry7Uvb0s8Vh3zVVJvIkR0IMj0NoncJ24jL8fdVJK2XuhR
	uaYW7xbA1N/OpAqh08bgdWWjyCEEhCt6sVclGPoTs+wbl2b0EIzCXxAJ0rn252/lwixEsQiScaw
	SNF+mYS9UoYU3BadlXw9t5NxFohVKnqJQASTPTvGD5DkfXJ92iLt9YC+16RRYtV199RX6RBe/XL
	VSttNLcw6uLXYjP8NzUib/Osnf7tfRSvM5u5vMvNhQguev4X8VKAU6iQ/uI55s++5aljaNjC1aD
	94C/JjzQ0=
X-Received: by 2002:a17:902:f68c:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2ce9eab4f48mr68185515ad.13.1783863025150;
        Sun, 12 Jul 2026 06:30:25 -0700 (PDT)
X-Received: by 2002:a17:902:f68c:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2ce9eab4f48mr68185185ad.13.1783863024679;
        Sun, 12 Jul 2026 06:30:24 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm85304465ad.31.2026.07.12.06.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 06:30:24 -0700 (PDT)
Message-ID: <c0800c49-3435-4e89-87b2-21dfa20ae58b@oss.qualcomm.com>
Date: Sun, 12 Jul 2026 21:30:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
To: Dan Carpenter <error27@gmail.com>, Deepak Sikri <deepak.sikri@st.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <alFJNUllC3JOKv6z@stanley.mountain>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <alFJNUllC3JOKv6z@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE0MiBTYWx0ZWRfXwRPS74fU/Yf4
 7BeOnk+t4iZ6A0UkJLzGkjSe+Ov0Pv6uvS1KmbOoSdE2x9UuJcTGBeAQebY7ckPwOsKTcfZ/d5S
 3rJnPZhy4yyYHFfKc1W25TNRshQcd5o=
X-Proofpoint-GUID: 7Sy17WJiWCBoaFXuRf8fJ8ng-43xTr15
X-Proofpoint-ORIG-GUID: 7Sy17WJiWCBoaFXuRf8fJ8ng-43xTr15
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a5396f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=N0crexS4lfU0QNQj-gkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE0MiBTYWx0ZWRfX4TkQiV5AiEiY
 GlHj8EK9FR//vzxSOMZoDbKUAIi2LRraMdlZO6lurMdGe5hw4VaieQuOtYtvvcSS8Zk+zlFF6vK
 cJ3RA+xIuXYMCIOKRmTDX53k8u452AtghqyJkvWvkCI9jUJZRGIGVn/lxNuXSefvuRhMpC3X4jI
 tGo2nQFtJN36uWlYDmvf7aRungUsjF6JgdUibXJAhc3oNkLzIGsQ04pjjM/KrWgCRPol3jy6/bs
 zGx33qQmfBc8JWVO8qMG+jBkdkqd4nLAF9fSlTcRWV2k/yuzFSkZDARC3OjM3AEAlPd+R8gAfIe
 7pHacmBFFi9xta7h9CVZJjpBj9oqMCctmOY8qzecmxfBebMASnXwQ8OlESm2MDSu/f0SInQHEut
 DLE89xBH8QIn8TZF2tSQZNnPX08c1j+lrbQqkeFOydT/EKv4t6vQ+bYFa/tTZuX0udIgjF81nEd
 xCj2zpxjHjCYVYI3P+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120142

On 7/11/2026 3:34 AM, Dan Carpenter wrote:
> The clk_get_parent() function doesn't return error pointers, it returns
> NULL on error.  Update the error checking to match.
> 
> Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Nice catch, thanks for the fix.

Nit: the subject is too generic and can be misread as a cpufreq core
fix. It is better to scope it to the driver, e.g. "cpufreq: spear: ...".

With that:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/spear-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 81a0780b2ebf..ffe5eda82f0b 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -79,9 +79,9 @@ static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
>   	int ret = 0;
>   
>   	sys_clk = clk_get_parent(spear_cpufreq.clk);
> -	if (IS_ERR(sys_clk)) {
> +	if (!sys_clk) {
>   		pr_err("failed to get cpu's parent (sys) clock\n");
> -		return PTR_ERR(sys_clk);
> +		return -EINVAL;
>   	}
>   
>   	/* Set the rate of the source clock before changing the parent */


-- 
Thx and BRs,
Zhongqiu Han
