Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410489;
	b=3m3FojpjAoEG/H9bvDrNxKk7iLLTAjRFRdSStp0o0eXV3huGzyxF/EdY4Sxlw4NnrTyk
	 7HNPqeGN339Ana5UznPKFMznojCjY97j+Ftq83XzgeBJVULWjfE/zBKnX10UWcwf7QNyB
	 2/mVHuUecSvDJLC7xjRVFgvf47ocje5cu6GzEPc5LYq2wZjgmB7ymlRoMUI2ccOfjAGvw
	 YJbz/Yooxv81Y7dNfpSMMGHlIZMFaSdTUK8JKQzmI5q5PYlapeZk5oKg5SXbyhBdLJeqc
	 h0LPB+r13LA683SRdJ+3dEJnV4GZK2hjFvm7fHkoRcWCCjHaSz2mP6BhigiS+m49OWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ixxmwj4X1glsH2rmr44JTvp/U38L97CIj3oyLiQlPOE=;
	b=ARz7i3MPvWQMXdFcXsKPiNbLV1hOMUsmZs8auAdAQ8AHoHP6qR7Y+d8AKxu0X13UrzSo
	 8TCR3MP9+FQzYpRv7I/DGevFcBnu8WpU93dQzVlwOHoRqQvUbU0Eu0G1SZYHYGAb0QTOG
	 Y8tIntZctZqoLGhREMe4fmhcXB2SUjgJ2JPLa4koKfEeq6qrCnT0nTcIBA6n1XcY68U1X
	 M5TA3uT2/WLvBOaa+XlmZQP/fPdMFOjyU5Pgf+pv636rOQLsx1AfssF0a7nPLgxFaEcMC
	 O5syyttq1iWLupsiqiGerDterOFdgNMJMVKSDNtT8WC9UK26H/r5yW8DLQ2CWErdM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LalogYks;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3AtzLxc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEA606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54AEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LalogYks;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3AtzLxc
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN50xhp1960992
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ixxmwj4X1glsH2rmr44JTvp/U38L97CIj3oyLiQlPOE=; b=LalogYksQ4y4FDaD
	ChLAP3A6hNMZm7KWjRVyHXxGKfK1Q4LE04SOcUCQXd0FTEoFSqZEZz7I9RE+tFZn
	DLAl3cUqAdj8A8gGEoisBxWdZOggJWXlUMBhdIhwnaumMsamaqFK+70R3SH3lroj
	krYhAhLuM1PAfePicSPQ0KLsul7h2pyebmHHt3Z5GmoxS91JaOGNUEJUPwYW4TAs
	YWKg+M9IDp4h+WNSJ/ssy8LTAW61wgOThCI8bnK+jyVHnfZMti1MQWvXAN+jVezr
	W1KE4c1IvP1wSlKVaVWX7yjoGYCWFty3R+2CcJeovdhZZdGsMgItkTk/5ZLrsDrb
	1BhPBQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6natn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:08:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so3599094a91.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 21:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795410486; x=1796015286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixxmwj4X1glsH2rmr44JTvp/U38L97CIj3oyLiQlPOE=;
        b=j3AtzLxcb3Yol6NFRZqR42vMS7eE3ccWa8QavF5jchEYE3Q+J4NrPrYd+U3Hg7sVol
         +0KXtixKPrI3AEo/HvIcagYWjvLNMfY/smisd7HbYeAcuJQXlvI/6Ww8NZua4CkMOr07
         UDTIpOZxo/gDONTKL+GqNGRSWB1B7v82yVDYUGWVjfMWu6M+wAAi3HZHdiwVHoTg7niy
         aeHIUQsGBWkJp32wk2k2fvsbnt9TtvxISFOu5nFOtMdtIUHSkAVObYSBzOGGXm0QZvql
         AVavIvkExt/vRkdAot56DrXrEUYS9aVRI40SzBxOtNBtfiMwOmpS9txq0nKxzRyhunIy
         /Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410486; x=1796015286;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ixxmwj4X1glsH2rmr44JTvp/U38L97CIj3oyLiQlPOE=;
        b=Vck1u4flR0rXMV+3nwPmCHgXhwt9Ld0dVCotu4PU0BAL7ioCyHGkAWLqerd9XJC+aQ
         l9+wSsnMXefueLqHBkoj4+TCJzUw0ptYrm5SgG8RyrmE1HLKK3y7hp0MTQaH4oMz2yJA
         DQ8Wxb7R5hCaprB3QxNo23rWx1qEbq5u3oabl2wN48ApDyURslM4UUqHvcvwRdfhCpI9
         KbRUpjD0Mq4G3HsuSuXsTyKCleWyN38TItc1VL44rQ+w7Ikfp9cygM8kQFHLGbI5GDQV
         BzFUjoiNem2jfIoh6S9Iatd5Atoc55KWLZ920Z094JUM5tWRMvEcF1lLfreb/xu1aMr+
         mOxg==
X-Forwarded-Encrypted: i=1; AL+hErEm2VL3sJWrXanfPcCeEgqfsw+qy+vm2UEx9zxhNuPcwqOfiAwSPFZ1X1tH2hiEsuB/wwjnFGEwSQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z98UqBrWdo6qfaNSX6p1lU6FV6h8lB7SQnTV0vXutuBzMa3WDpV
	H21qMdDD8Voy0EQ1aPaZgzwAUfwBXszeyeJzWqA+FoApqS78JtH2OsLb6weaolhrx4KSKZBAKNG
	xDEQpZQ48Dzvvh5HiOGHl+VUZNlIKHMm6VKmwibrpSEZ+9kY7PGYclz3BRFuc9w==
X-Gm-Gg: AZFdTZdC7TQkbPwWh6ZUJvASpEu4dF7Add599WATclpp/TCzi3Xqppz3jyNdsOI8TFz
	uEUS47cL7PpKV3OqxmGTICgsn3vFjc5AizrvyFF36yTea5NmIkhs/t9gWGc7jNw3VNH9+CET+EB
	LtsPwonnWBl1YChMlXbfKX7j7dQf+urK+93tDOuefALeCc/L479zSyjOxR0/PZsln4C6WwXySX6
	TPFFOC4pZ0+oL8mI86kA9cpXTxoU7g+r15ooJf6m9nco8QEInqgfzsFVG7YsjWAGvV1kL6uHFMc
	rPiyUFkGwde9iwh0iMNiFaU1YUPVXOIcMOvKCAJyvp2PEFw/0ffKtjkUoKBzy3n1/imy8ULUcym
	tY4ugn7l7iqQnOD1pzyyawwHktU8KXIRmd8pKZcfB70z35kE7SzO1m13EjxkjlQ5ZCXrQH+Lc0n
	tkZ7GypFjYk3UDBd7sqVBG/0c1wZeJBGTzAUTEJ88eXf9YEQ==
X-Received: by 2002:a17:90b:442c:b0:3ac:b145:8f4 with SMTP id 98e67ed59e1d1-3b41c9325a6mr9841167a91.41.1795410485961;
        Sun, 22 Nov 2026 21:08:05 -0800 (PST)
X-Received: by 2002:a17:90b:442c:b0:3ac:b145:8f4 with SMTP id 98e67ed59e1d1-3b41c9325a6mr9841143a91.41.1795410485442;
        Sun, 22 Nov 2026 21:08:05 -0800 (PST)
Received: from [10.133.33.103] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm16407965a91.12.2026.11.22.21.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 21:08:05 -0800 (PST)
Message-ID: <12d70da7-72fe-49be-803d-9b2824f99d86@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:07:59 +0800
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
Subject: Re: [PATCH 3/3] cpufreq: s5pv210: Fix resource leaks on probe error
 paths
To: shyckless@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        krzk@kernel.org, peter.griffin@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, alim.akhtar@samsung.com,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
 <20261122-cpufreq-leaks-v1-3-96fc17ff7339@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261122-cpufreq-leaks-v1-3-96fc17ff7339@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ovzQpBSeN_4ybSSXmpp2ZD_Iov7mKhxZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyMCBTYWx0ZWRfXz8CZTBgk799i
 HDG4jVoUNcK/TTonu0YPgBVTWe/Oaljnyd5cl2lKPcuLx94lphXpXAZWqq3fEDibsxRTZRAjZZf
 dvcdUIfHlqtxmR35CLrZMHz16D8u+7o=
X-Proofpoint-ORIG-GUID: ovzQpBSeN_4ybSSXmpp2ZD_Iov7mKhxZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyMCBTYWx0ZWRfX0sWzQOtRZ8e3
 EP+6uvBJl+E1EOZn6MdXbLRFaTynusceDk3V66Xn6+0brkaVJpyGYudYVml+SHX+lNF4/6vxWj/
 8Y+IWqmYTxONn+1+9WzmwL8WxvymQTnTGpVVJQmZbEfUJv7x5NPwl5gWcU9Zu/V7k8hUSmzLPqG
 bebAZuPkVsLXuWuA/tKawaCEJ7RD0z6Dn31WqoQFPE5P8lwI4t4ixorv/orhoYbh9+4Ma90UVfI
 /xlq3FJD14NLFhk6mhBuJjq3QB4v+CjoVZYT80aXVWYlducoHUlx4Ejsb3t5vT/T+3CwkpG+h4J
 MPkMOc8xoNLjcSk1Ipb3BAL0HpVNispO7VCSjSVAnpn/kR19KcVO2TtW2DyXblFbgMUjTlsvYvk
 Nl55m+6a5sa+/wLkk4F65pZCz5+WDsaVGYjxOvCUWLOIRj1NQxgCx5fm/yCasKQUKGksKgMMO3R
 e4FTQQkWaJpFh6UIZJA==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03ca37 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=_Cgvf9wQB5e8zHb46_kA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230020

On 11/22/2026 7:55 PM, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> s5pv210_cpufreq_probe() returns the result of cpufreq_register_driver()
> directly:
> 
> 	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
> 
> 	return cpufreq_register_driver(&s5pv210_driver);
> 
> If the registration fails, for example because s5pv210_cpu_init()
> fails, the resources taken by the probe itself are leaked: the two
> regulators and the clock and DMC register mappings. The reboot notifier
> also stays registered. (s5pv210_cpu_init() releases its own clocks on
> its error paths, and the cpufreq core tears down its own state.)
> 
> Also, when a DMC node has a bad alias, the code jumps to err_clk_base
> and skips unmapping DMC registers that were already mapped for an
> earlier node.
> 
> Unregister the reboot notifier and go through the existing unwind code
> when cpufreq_register_driver() fails, and jump to err_dmc on the alias
> error. The err_clk_base label has no users after this, so drop it.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 6d4ed0f46af6 ("cpufreq: s5pv210: Make the driver multiplatform aware")
> Fixes: e0e5b2b4f427 ("cpufreq: s5pv210: Defer probe if getting regulators fail")

e0e5b2b4f427 didn't introduce either leak; the alias path already
leaked via "return id;" before it.

AFAIK, e8b4c1986efb added the two regulator_get() calls before the
unchecked "return cpufreq_register_driver()", and fe7f1bcbff91 added the
reboot notifier there, so those two leaks predate 6d4ed0f46af6, which
only added the register mappings.

So the tags should be:

Fixes: e8b4c1986efb ("[CPUFREQ] S5PV210: Add arm/int voltage control 
support")
Fixes: fe7f1bcbff91 ("[CPUFREQ] S5PV210: Add reboot notifier to prevent 
system hang")
Fixes: 6d4ed0f46af6 ("cpufreq: s5pv210: Make the driver multiplatform 
aware")

Could you please check and update the tags accordingly?


> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
>   drivers/cpufreq/s5pv210-cpufreq.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index e64e84e1ee79..29b1c5d71a8b 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -634,7 +634,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>   		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
>   			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", dmc);
>   			result = id;
> -			goto err_clk_base;
> +			goto err_dmc;
>   		}
>   
>   		dmc_base[id] = of_iomap(dmc, 0);
> @@ -655,7 +655,14 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>   
>   	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
>   
> -	return cpufreq_register_driver(&s5pv210_driver);
> +	result = cpufreq_register_driver(&s5pv210_driver);
> +	if (result)
> +		goto err_reboot_notifier;
> +
> +	return 0;
> +
> +err_reboot_notifier:
> +	unregister_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
>   
>   err_dmc:
>   	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
> @@ -664,7 +671,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>   			dmc_base[id] = NULL;
>   		}
>   
> -err_clk_base:
>   	iounmap(clk_base);
>   
>   err_clock:
> 


-- 
Thx and BRs,
Zhongqiu Han
