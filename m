Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405328;
	b=iU8QyBeg+sntHnP9GUzJF7mFz/IHNYQnHyWkLBgRiVOsJrKvHvGcs9TPX/wY1ngBLzSJ
	 srtLSzSueIkb5KxdA7o38BKw8THe8suiT2KHqBJmTQeO03hhLZDEthmPNnr/C8rzR9pxO
	 aFUX1Eq6C3EFJrIF+m0XK/yTrWyNBcTW/8k6cRuMaX4RiYBQZ8ath33QsNyygUtrR0RS6
	 tBAmpGw8AjHfnRTHy2xxyQ8RNHPZYhyowR/CinU98B0k4NKPZc8GLrZXjmZBKY2Y5pAGQ
	 bxtCP8sdXTKMZPYxTQz8WAq+Eizkool97UjwNZsqDcMhMoHf1pNcdB/5UG4JU/xaceA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tOMQjZfNZl0Skc/H8u9J1Nf60tDa0Xn86zNJMbt3J1c=;
	b=N/VtMy1wc98M9G3UDANjfyexLW3AUSM6egD5r2YVETyHf3W+vvenb9+BAeOQ3zhVIXuy
	 Z0v2Uxq+M1uvL9hBmVE9Cb7pgMBBhbcTAzI8gvY02KitPbXymUnldavbC+5/ULJrboUhJ
	 /7kFpxkNLXmZsOY7nk+PBmndOxsbz+ly2+m3mrSBINXz2N1IneCmBoxiDkd+jqmVSSbHq
	 u+aElCseffzSAaPzc/6ZwjFOetYvX8s0s3rf4HQNYOJD26raeFbUMgALYcayc4HKAWUwu
	 zbYMOQGa06gkEqp5nCNo/GnKXf3X6O2uMl7wNeavkZIpxc1D8GmBsRYQ5nFEtG/TUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oTzJt6qn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E51JgrRa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AA606A31A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oTzJt6qn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E51JgrRa
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMNr5Be3901943
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tOMQjZfNZl0Skc/H8u9J1Nf60tDa0Xn86zNJMbt3J1c=; b=oTzJt6qnLd0hstbd
	xT5GdQxklui3K8aOlQ3KlmrNk7szOErxUT/OHKDYv5tl0eR8noJQLb1H9ygwURRk
	Le99huTrH6aQVqzpwCbzYnht6MoWDr6GmvIkNp1itUcEBysCMcY2GjpjS9pM/OBr
	VeVoQSVgla3FrtKpWN6PvXNnLaUARUR3LpN4oZGZ2QSvDWORGQiWbB8fH09xaiUc
	w38ZoJlfqabPhdUPIOY2IzZ4JrSdbzBdGJqynRii0FaA7Ur6vJ2PbR3IOza+DfuS
	HJ4aB34bbOWMEdHAzTldUKyuFJearU9F+ODz0wxHp5kceA/FsFW5N5VCfcEE++7p
	Cqt1DQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka4v0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:42:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so2865516b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 19:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795405327; x=1796010127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOMQjZfNZl0Skc/H8u9J1Nf60tDa0Xn86zNJMbt3J1c=;
        b=E51JgrRahuktshLrc9ZZf1jhRwLZW1xq/lhLpJOrvB7gropeym4YCRRhBxHp41YdcG
         rs4AvLKxmtsnujbTZcq5dQTqEq0EL2hAIqeH5MI6S0PjeBxdWqFV+PWn68c/kUUR5AUT
         PzZYRSeVqRKbkpBmNiexhsNFw91nYaEy4+Gr4kX43pUsiWBEGR5L/Bj9UsVuhgouJv0O
         hFgAGUYS7zjZLsiJpXFQlXuhJm0GVk3rJ9XWx33S/+Y354yN7A2FdX/tJAw/64sGZinT
         lwoQE6ontmjyCMxpJU/VjRZ6lweK5dHSY748QK8CATvGQjoLTjEfRd5rZ6oRMwFcvGxq
         fwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795405327; x=1796010127;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOMQjZfNZl0Skc/H8u9J1Nf60tDa0Xn86zNJMbt3J1c=;
        b=L6vjCR6DQ5Z9CELPT96bK1d8vkz7/1F+Bd7EJ3/Bu7pVIAECt5bUvfI7dyvFjDQ+jl
         czJ5QzvQgyU+D1OXLGU8/HWzBubPi/iU0sM12YP7uX8+EmCf1BFOKWuLvvFoRJCqLOJ0
         pblxrgTEoztH2kO+zCenBKvTShrTD9nhmp7Dkd/ce7EuQoO6NouVmITPhVtCo0l5/SUd
         yAUsJBy+3IF1wnbSm5PwhUUNc6ogKDAbCjb94FjGaUefJ1I3xEYJMGeHoTrdufx+8vA5
         Kd6nFkDSEMkZjNRV/krc9rvpq/5sNwWgZEMb9QOcTQbKekL9nb2owl5dnTQM9im7sJV6
         hf7A==
X-Forwarded-Encrypted: i=1; AL+hErHxJ9AvAEUYEZK+wTdTGlmyHV89ZnkvKkTIgoyRmvVmQWyhX9bTmUiFDhF2FAdxC6N47S8NHVBHUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/poXtcvSFVygHHSl5nwYNjgmyCX722XT9Kc8jd3+WmvnSIMwr8
	g3edSbHNAjj6xILz46aLTWAA4RtMzrI6e7AWCBo6QMUP2+wZapPb7GoWy8fes2c1SHo1BiJVWQk
	jHyCFPl7+GxB5w4gIxFTk9Uulcrb17X1vO9zQFVwUc/Qw1JdPFVlcMJE8tQItc9T97nOzOQ==
X-Gm-Gg: AZFdTZfPqYMpPjBw2/39nWqIdoEh/9CjgIJ736ZbJdamTBkF0RyukX/N0LMa7qU2aCH
	BXQjKwn8t/lqFzeODujCnCAIyFl8TSkrrU5R8rGCQUCBngPRO61NQlvTKAkuPUkujajYACTdAPx
	fdKZPjggrHaFeK/swvFOI5h/JiRmm7ysqViMPLZFm3mKn3SgQgOWbFGyLbLjxR0W7/glVE63747
	lXGbs7BJrW8Y4WRZ7njV7Yzl/HW9xlOrWt6Q1B1dCOZ27kgOzFne/DHKeX/Ds8WyyG0AizutlE4
	ziTw/Wb7Ofs0KvFwBekO04LiRD5zkLwSh8ZwLYCNBvfUIfyp/uZz1tZi2eNhY/JixD/SewUJf5n
	chftEN5aDRwDq9LCqJ7oNoRStp2KXo0C6S/BsLimjNmeyNn/UaQa6JWvzuHBejH+Mwc5GUM0Wk5
	78h3jqfNAfpvK2gJ55te0UpGTh5b9PylBeUsxZvKz57pzyGA==
X-Received: by 2002:a05:6a20:7486:b0:3fa:53f1:abf1 with SMTP id adf61e73a8af0-4014e74bf27mr10216916637.66.1795405326624;
        Sun, 22 Nov 2026 19:42:06 -0800 (PST)
X-Received: by 2002:a05:6a20:7486:b0:3fa:53f1:abf1 with SMTP id adf61e73a8af0-4014e74bf27mr10216896637.66.1795405326163;
        Sun, 22 Nov 2026 19:42:06 -0800 (PST)
Received: from [10.133.33.103] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm4362204a12.13.2026.11.22.19.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:42:05 -0800 (PST)
Message-ID: <f74a9623-4522-4a30-8d50-bcc148f2b9bc@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:42:01 +0800
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
Subject: Re: [PATCH 2/3] cpufreq: kirkwood: Put clocks on error and in remove
To: shyckless@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        krzk@kernel.org, peter.griffin@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, alim.akhtar@samsung.com,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
 <20261122-cpufreq-leaks-v1-2-96fc17ff7339@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261122-cpufreq-leaks-v1-2-96fc17ff7339@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxNCBTYWx0ZWRfXwiA1caF5/8Qd
 5aQ5vRUuNd1tG7tCpoJIfui5solbWQDFtqMFXmaUqNKbdXEJkYIMqIko+8Xuci0O9l6WEzriUnE
 htl+hctSm/p11An7lil7YnmEOeuCsWPHh7EgtE/NVik8b2iCYfj/HvbkkoWemX6vEPwG9zfgB+F
 mkgBjqSEe5ucSeP4XiIAQ+iJTp5lemuf+xqq+RxNQhm1NbsnjF1N+WDAGBlPjs7wH9JfqHkaz+q
 6TqEEClnE+kPUtzBciwemhg+qXuyh9pNqlMDeq/eUYohpealSN9WSNiLOZnQOg66Vwntef52aQx
 Yb9CclP3rWbh28xVxM74QmEtvKvNvjkReJlSIGhmPMMJNuG4+ohq+H8WnO7B0Krcc0TeUK/bzVq
 d1EDDISPbPXpjNa0+iF/feLPPu1AQZJ6qG0hieU7sxhL87XWwuL5nBWVBLB+jBoWo1CrX4aJMVX
 V84MQxtUmsMlJG3UH+w==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b03b60f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9A-NSSyiqZj1DCQBHqoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: xqYcCI5yUNZrDkXA4geFWYPhQFZEFvBl
X-Proofpoint-ORIG-GUID: xqYcCI5yUNZrDkXA4geFWYPhQFZEFvBl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxNCBTYWx0ZWRfX1Ini+zq3oIXh
 HfTiErWcUuHPKAIGkIBDYKnwwfidO0thTI/e1peEAmBhu6B+I15Zlh6DT/KgxrjVxZENd4jl7v9
 DM9MhdSREOjjv5Tegyh+Ei6g7Wk2DZU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230014

On 11/22/2026 7:55 PM, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> kirkwood_cpufreq_probe() gets three clocks with of_clk_get_by_name():
> cpu_clk, ddrclk and powersave. None of them is ever released with
> clk_put(). The error paths only disable and unprepare the clocks, and
> kirkwood_cpufreq_remove() does the same. So the clock references leak
> when probe fails (for example on -EPROBE_DEFER) and on every unbind.
> 
> Add the missing clk_put() calls to the error paths and to remove. The
> "Unable to prepare" paths now jump to new labels that only put the clock
> that failed to enable.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 2a4bd9f0db24 ("cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/kirkwood-cpufreq.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> index 24b285cbeb8d..e85658081c07 100644
> --- a/drivers/cpufreq/kirkwood-cpufreq.c
> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> @@ -125,7 +125,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>   	err = clk_prepare_enable(priv.cpu_clk);
>   	if (err) {
>   		dev_err(priv.dev, "Unable to prepare cpuclk\n");
> -		goto out_node;
> +		goto out_put_cpu;
>   	}
>   
>   	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> @@ -140,7 +140,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>   	err = clk_prepare_enable(priv.ddr_clk);
>   	if (err) {
>   		dev_err(priv.dev, "Unable to prepare ddrclk\n");
> -		goto out_cpu;
> +		goto out_put_ddr;
>   	}
>   	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
>   
> @@ -153,7 +153,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>   	err = clk_prepare_enable(priv.powersave_clk);
>   	if (err) {
>   		dev_err(priv.dev, "Unable to prepare powersave clk\n");
> -		goto out_ddr;
> +		goto out_put_powersave;
>   	}
>   
>   	err = cpufreq_register_driver(&kirkwood_cpufreq_driver);
> @@ -167,10 +167,16 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>   
>   out_powersave:
>   	clk_disable_unprepare(priv.powersave_clk);
> +out_put_powersave:
> +	clk_put(priv.powersave_clk);
>   out_ddr:
>   	clk_disable_unprepare(priv.ddr_clk);
> +out_put_ddr:
> +	clk_put(priv.ddr_clk);
>   out_cpu:
>   	clk_disable_unprepare(priv.cpu_clk);
> +out_put_cpu:
> +	clk_put(priv.cpu_clk);
>   out_node:
>   	of_node_put(np);
>   
> @@ -182,8 +188,11 @@ static void kirkwood_cpufreq_remove(struct platform_device *pdev)
>   	cpufreq_unregister_driver(&kirkwood_cpufreq_driver);
>   
>   	clk_disable_unprepare(priv.powersave_clk);
> +	clk_put(priv.powersave_clk);
>   	clk_disable_unprepare(priv.ddr_clk);
> +	clk_put(priv.ddr_clk);
>   	clk_disable_unprepare(priv.cpu_clk);
> +	clk_put(priv.cpu_clk);
>   }
>   
>   static struct platform_driver kirkwood_cpufreq_platform_driver = {
> 


-- 
Thx and BRs,
Zhongqiu Han
