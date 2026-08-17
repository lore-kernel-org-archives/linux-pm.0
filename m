Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DC417D80
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970761; cv=none; b=kQr0/t2FUs2d6nuVZBcNFaZiS8IhuLAqlHZhe7dZHZWO1yABsVydgwZr1L7b6TWTFlbK9HTMxY+S4OfS9qvGVCdcs8JJR5lPfpvh9W+GWW7AItjp0MWZsN90g+eGc9bssENPA74E/ECoDth1DCBAO+XFnxltXu3vtAWt2BLSE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970761; c=relaxed/simple;
	bh=akLUhO+MsKf1233ngisGv9yxbFsLF+SiGkybxWkTLwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=PH9M0u/mPAkUMik4Bkc/mAZf8uesYqey+SowDvmXlsjdvVH8wueJLXrGIxHB7Hs6h+2cwug4diaclkVVtnBXvkPkLN+8RZEkS2qViHG+qS+dMXGh11EznTAmQiU4YfeYelZkUQagHdMB6Zn5UEuOE+5y8Fqs735OiQ3K4Amb+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+3q7ZiH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9Wbl+yb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+3q7ZiH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9Wbl+yb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCAhbi2206627
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zlvXqbuhFI5WDJM1M3oD6suqM7DRXo9zn3DG6aOMOPE=; b=A+3q7ZiHosJjKhvZ
	vKhDAerUR5c6g1WpyKgp5B8kWIvcf++F0gyniaXnkhm7yqNMmYQ+Kbgj7HSFg7g7
	/CAiTQWNS89z9NzmeshKkqJPQNwAFidkx3yuGVfD2J5NfyiiZ0Mfdmzt/PnQ55nZ
	TTZJFORIJJ7YbUt2WmmegZc1fT0fTIQPQPljK8CTQ70wnUEoxognldJvzCEC5W0B
	al3S09aIzBvQdIc8PtfeHcVCkjDkaC9qYIsFgM+q6lmQmEa04uzPEXcKKrc4sfFR
	sRJflBycd1kOqGUBUnFCkOxIOH1uET/XX/5yLCykHNzp4Oja9LyRRwzlohvY2dyH
	WTSgVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vghsn5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:45:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so53259155ad.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786970757; x=1787575557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zlvXqbuhFI5WDJM1M3oD6suqM7DRXo9zn3DG6aOMOPE=;
        b=D9Wbl+yb5j0mek1fW97rMsAWCSlsOV8j3RVQ/bZnb5QWvzOqgMa6GHVN5D81VvV6Ut
         Zl1MlN8nfXpVqIX6/W0W5LJSTLGr4VYy1jQQ1QvcBn7z3Nde2riru1ml7iYYJ8gjVXOf
         +GYV0B4I6jkAKymtI0w51twrzqabrZM7GXr6m4ABF/vHaUI58fM0L1Jr9IpmOpThQFFE
         AJ0yRV+Rvz+gtjPst0GUkOs11wZBnbSMYPMcVCaJbY7YSFKkMN6Du/zmBl4TBuFMyLIY
         qMFtqZOoGn9v9+ZtaLiO2/4L4V8emYPWA6t9twp6WWDvxbujr0+1mlyf4vt6n+ge+5DZ
         XqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970757; x=1787575557;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlvXqbuhFI5WDJM1M3oD6suqM7DRXo9zn3DG6aOMOPE=;
        b=MwfKnsdf+ZCvpzqWZNrjmUFkHSBS3vQ9C6hddAdygljMB8X3evaaMi9Sgm9tscSwp3
         aN5uW36MkxrHGHUWwx0ijF1OaztIjKgFvhZYgYWKH/kFw6xmJQlzvPZsH2LCdHaU2b48
         FP7PGOwWsWemiqSHs7pnywrg4wd+4FxyaHQEXSAnYldUTBnJ+I2TlGSEWZe5Dxeh6n4B
         lmFsp0cnVCnv+FSx9YcESb4pS7Hv2MsCIGn/XOYrwLutu+Dphz2Qxe8rxGMW5IyUtznF
         W0iCNbE7hyytwlSK/jVLraa1ci21gJXB3BNYq/ESIH8UV11ToFlsauakw9iBSHenTgjy
         MUAg==
X-Forwarded-Encrypted: i=1; AHgh+RrNbrd5rdzRjk9HpwH7jKLyPtQDZ4PJt0D8Holo1PfSPSveltpUfmrGmLWucoqsTadPsREwgODG8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb70vIS4LBnKJ7WpoXI9RQMYnQnpnfy94LQFiQk+A1JknP/XYa
	F/OUqyNRtjnZgkj6JSmx5zeVAVhm3dkZCMSY6/EhIf829uBrzHPNPM+4DLn9j+p3IQmk/pnpOUb
	XAV7uACDilDy82WKbfRe6i8pCwIblXKa4dlOUT4ne3ljdDHL5NuFGQbV/ta5WUg==
X-Gm-Gg: AR+sD11GV5Umr4pxBY459Ih66ef5ZvrR8peO4PcSawkStZmEZ+AQPYFHC7D16ODcIyx
	/rZNw7pe4g+Tp5MK1DGHHdqUXlc2cbS0Gb1ScUk5Gjl0DA1xUM/2acKY8qIv3zC8VtEWFj3oJz7
	S/he5SXxMNc4CSwkGpAB7/q55Hvfl3nC2C0w9Ex1+gf3y8WEOsDczTYWDomFs6Pc+IfTr6oiSE0
	CncuIHDGLHYoLtLbsoNMVc0McQAkghrsggDeusgJKt79G4AQSW6UACDC/4AAcee8rF66sS+4qgr
	aqH3r+l0EIiGI+Zv4f+VOS25S4+kG9YJoETykJ1550Ws/JK5vpPG7BHz9j6+eR1mCLgHoSYWtOn
	r5Q3Q3pF6nXpMaztBzxI4EvTGN5DybbWRkdBU3klWerlGKnH3SvFA36YYzQmZEM6KnugeQdI=
X-Received: by 2002:a05:6a20:6a21:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3cc71d1e1c7mr25995245637.28.1786970757370;
        Mon, 17 Aug 2026 05:45:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3cc71d1e1c7mr25995178637.28.1786970756756;
        Mon, 17 Aug 2026 05:45:56 -0700 (PDT)
Received: from [10.133.33.95] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13bf235fcsm684836a12.9.2026.08.17.05.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:45:56 -0700 (PDT)
Message-ID: <8327e7fe-7acb-4fff-8347-b6d5fb4de427@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 20:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in freq lookups
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813090145.2450-1-lirongqing@baidu.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: zhongqiu.han@oss.qualcomm.com
In-Reply-To: <20260813090145.2450-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a830286 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=zuLzuavZAAAA:8 a=m2pJCCGmavP_bDTzO2wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5NyBTYWx0ZWRfX7UObJ8ORKgOC
 TC4MCTA658VVxoYrk+7wtGjce2z2EwAXA98iQovY9Y1/DWhAgZ4/Du3D7ymobPbispV4C0XTX6O
 539P4QXTS6HY4/9yauUON3uTHOaf4J0=
X-Proofpoint-ORIG-GUID: GxC89ryOr1ABxQKQ8sBXKOCvoTOiX68W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5NyBTYWx0ZWRfX/obn4YT+s/At
 T+9LiPXhGEHJQ9k/TTBFOfkaxfyomMrhinwmbtDOpzIVmrxPbq7W2ODE/X/TUQ9jwkjYzYJ5xLA
 0ITmvuIGWgIFB878/1hhD4TC1XVSnZTwi9059HFIjaovZdixapWVIQbNlMB7s/9+s2Y9NhbiGIp
 R0fZu5SVc9BaGZc/sQqOzWdjTx8YwNH9Qo+75eGtWW+OyMNyzk9PsB49wbHJkl5EcpHDXCz5rMO
 ULIayT4ocJocVnpmV8L4qDrVMJK5YlhtO0tOLVVyz9PwzWGfbsogu2ldE4yHRqA6vdsqjX6HOM6
 PTR1hCFkC+7p7HFWJRITX570oOvsBWPJ2vw6ZIxR3Na9kBogTwnwrXy+d7HpazgIqU2pHJJJ+LY
 T8qZNtFKo+muhVty50o76Bcx0nWs8N0ixsIzjwuGjJa6kda1N5+qAUcaZM1invfcIX8V7PtPyM9
 g6ZsSDEzI4OOaugG4FQ==
X-Proofpoint-GUID: GxC89ryOr1ABxQKQ8sBXKOCvoTOiX68W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170097

On 8/13/2026 5:01 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> policy->freq_table is built with duplicate _PSS frequencies dropped, so it
> no longer lines up positionally with perf->states[]; the original P-state
> index is kept in freq_table[].driver_data. extract_io() and
> get_cur_freq_on_cpu() indexed freq_table[] with a perf->states[] index
> anyway, which can return the frequency of a wrong P-state.
> 
> Changes since v1:
> - Reword patch 1: v1 described it as an out-of-bounds read, which is wrong;
>    it is an index-mismatch / wrong-result bug, not a memory-safety issue.
> - Add patch 2 for get_cur_freq_on_cpu().
> - Add Fixes: tags (not exact, but reasonable backport targets).

Hi RongQing,

The Fixes tag should point to the commit that introduced the bug.

> 
> Li RongQing (2):
>    cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
>    cpufreq: acpi-cpufreq: fix P-state index mismatch in
>      get_cur_freq_on_cpu()
> 
>   drivers/cpufreq/acpi-cpufreq.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 


-- 
Thx and BRs,
Zhongqiu Han
