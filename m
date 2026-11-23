Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795404085;
	b=aGKm/1HLjlmFBGRawOkICNUCmzx9PPmWpp+N3e1jWR3RXE9xZF8e1m6mqHDjwiOHyuK4
	 B+33faWY9tCEL/SKRD4nfIYHjmE09AWyOmPIX7FjMPbisBCzE/dhb8IS1/whiRttBQrT0
	 XSZVkBSa907GM7a9h0LYrt0mEWE9A253rZ6TKzMvR+KB0S1/Oz2oFENE4cDxfXdpIMM/B
	 0WBSiLwI5nLLR6UYDE7h/LZbB0JVGNhzykrz+Wb8Uc27Lxg5Hv7tSgTiCBzvYbOkprAOL
	 N6fKekmmYgDIwMqJMZDBADmRwmYUFLtTaAJBRuAm/uWzp/UbCm2AjenM1ltMFYBG8Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795404085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VXedBlLbPwD6MOhiJ1M+V/ws5Iohq5O/bPIG7VrD/2Y=;
	b=jsHzQN79jUrAF5Km9gbHjGk/iX/fVpsWKNSZs0cXwGGHSSOEUXqajyRW1vJeaMSCYsRN
	 Qn1fl5bDEbVKV+2YSSAUp8SkqdBhXtR0CIo+go/OWDOxvv9rciR6f0qr5hhiAK0Ekxa3s
	 tGzv9F01TAG701levqveM3HSbvsxtVapjzbY9yCnwEYOX0tLh/QCqyX+GQhj8l2sfMCut
	 JvRm743rUIEs4kvRCmWLGOIRYtfWlNQPZAx/RgJC93tN2ddwFuH6lyTLvgbxnLW4GsqI9
	 Eo30WOkaGqtP6veWbq0IsmW31KQaBm9XnSqSEdwFUNhbQG1GowB7Dbe8f4bEvJFN9VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoraXHFR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Zo3/uIj1";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160A606A320
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D160A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoraXHFR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zo3/uIj1
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMNrFci2880088
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VXedBlLbPwD6MOhiJ1M+V/ws5Iohq5O/bPIG7VrD/2Y=; b=QoraXHFRbb9UnELq
	GPO9l0JpOcU6VcmdtSJDDANpnm/s8tsML/fOenKlPD0WCAVWVv/LTJ+jtaD919Ft
	8e6C4XensAVOHJZo4vqvy4/LXxnTkHpXH5fVHruBWo6oOx+AI5c2oD9cNQt0mPRB
	J3J+7AgmHgcPY+iY9T+wSyigCKKvbwMwvHWYC0OqZJSZa/mtK5/WBOtOfNQp7dga
	egnjjrhuj5AvhXHQ5aB6lNCgj6tkRUhuVFFyDljY+NCkfKOIQgfk+37WqbagzLF2
	D4au9eJ6BI7d1cCX/zL7K7rdvCMtJ9KpSI22d/ARSobgQOtTvWMGX2QPdAeWsWDQ
	wGnoKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j30nnwb1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:21:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b41b099809so2468436a91.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795404083; x=1796008883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXedBlLbPwD6MOhiJ1M+V/ws5Iohq5O/bPIG7VrD/2Y=;
        b=Zo3/uIj1Ox691nFw7TymmsPrWz1wnLyJehzkhMZvYfkeE/ZkeQVP9DnKpzd9ld0rQl
         L9nHrhzxfZLOyXhoKY7fmk9uENDf0pxnWYhNGaxh3zlK0tTOC/kwvAKK1h9WkJxMZljr
         rtkoBdReEulAAgfcqAjouqubGcGSCjJwprnqhq23+A5egg85Luw9jTpFH3r9p+YvOhaR
         AWpiGuPZd9GnMZo7HNKu/Vul383AnJ25CdpKPhJ64wDOf23hB/7uR6u1VRubv7bsazrT
         te0MbvKLxSgEhW87DPzqi3tBNFI5TNF+adB7klKqx2i/3PavyvYcJ15sPCPoJ5cRlnBz
         5u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795404083; x=1796008883;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXedBlLbPwD6MOhiJ1M+V/ws5Iohq5O/bPIG7VrD/2Y=;
        b=Qt65LF2jL5oa8Bv0Q7Dv1TK5ZiR08yukD4Dc0jzFGOVf0gr2tHeXfHV9Pidy1WLreF
         6DpBbUJVl44MmApQAx+WFVOokZDls3S5dJHFjPNI2zwcsTHeQCQOqVRq3+82OQuMn/dM
         eY/mK6frjHrxgRuH3He7CUSLJ0yi0iCKE4dZOe40fGemxnm+5DnazALZ+IyQJkeum4iY
         mido0GWIoEqZUAZ5dUyXwwVWYw0JsH1EEg4oRNIgzljeyD2ACb0OC0rj1GQ/xHEJWNcf
         30EUhY1RJQu0FXOA3XoXO39oJ88EMnNhhxtYVEniAg/Y8YwKMG583q7eASZxM2GAgzRh
         1B8w==
X-Forwarded-Encrypted: i=1; AL+hErHgCvEAyyOv/V05KMaWcOalQ3BOm29HFr5oQbPwFo5ky21pSh7icNJRCAGbiEGGqAde0fnASYLAow==@vger.kernel.org
X-Gm-Message-State: APuU4Z+u6yb0dhwmceyb7pndnT336ayU0x3Mgwf63VOq7ZklUhEWRm0w
	SWCJouOJptxyUCExIqMwKLnIWQdXN/9RkCVMuofx6H4INaLSc+ljbUiWHEikTnW5/Lp7un1/U1g
	7EUMXHFy9tLEE9EGf1ynQEyXQNSS1jDC38VsXhENGN9msmO68yoztWZHNhxsLLw==
X-Gm-Gg: AZFdTZcTlHBR+0NX27CI7TWtAG7rrX7jrufFzmvDqGlrbZVysAPT6+NnTEvpYM74ZjM
	DN09vLyXU/WJ9f50PizzM2PbeTip+jOcTPNu8H/VqaRxQlqW14xvkie5RZcTmvMEa0nWNvZS++e
	P1bPVYSA2JTukq8vdQhmvWkDzfLqNWewWsvjBA8CCN8O8CN2yCYhwq1913NdwXefFAdQhCLe8IJ
	LX8SuMLI/7LMOLgKqbAYY90JC0vZ5UCkQkPm60w9U4vIPfFHFO3qpEIQmsrFm/u//r5l7IaQVM4
	ozCT311iwd3XVrnaMOYRhcfyg6F7If086hf+gu1kLSa6tmgEAyOKFCfhnY+qS9jvhb1J/KpNiv5
	cEkmsTrAoj/9/VmXUhPzb4Y3vM2qNRdw03ehsBnzxpMZdD4Aqv1q/8re9GORnqkSRhU+ruqs9Cm
	u4hwWCqIauPLA1kZE/eqPPlQzDi0jDWXJFaqB/U6U8J4aWyw==
X-Received: by 2002:a17:90b:48d1:b0:3b1:832b:bb3d with SMTP id 98e67ed59e1d1-3b41c9817dfmr9091509a91.57.1795404082679;
        Sun, 22 Nov 2026 19:21:22 -0800 (PST)
X-Received: by 2002:a17:90b:48d1:b0:3b1:832b:bb3d with SMTP id 98e67ed59e1d1-3b41c9817dfmr9091488a91.57.1795404082223;
        Sun, 22 Nov 2026 19:21:22 -0800 (PST)
Received: from [10.133.33.103] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b828ab9sm5057963a91.2.2026.11.22.19.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:21:21 -0800 (PST)
Message-ID: <681285cf-b668-46c6-b6b1-793782925602@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:21:17 +0800
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
Subject: Re: [PATCH 1/3] cpufreq: highbank: Put cpu clock if clk notifier
 registration fails
To: shyckless@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        krzk@kernel.org, peter.griffin@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, alim.akhtar@samsung.com,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
 <20261122-cpufreq-leaks-v1-1-96fc17ff7339@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261122-cpufreq-leaks-v1-1-96fc17ff7339@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxMyBTYWx0ZWRfX2vFuFkIvRHLU
 6TqokAkDWimWnA6NuagK/XxiY80l/MQjlDKiuemtlSmpHLo9+eb+hBZmBXL2EkTdvVs+gzGmah/
 lUgHsKyDqtklR/pu6dntmBr/0TR8zDjbYtMvFOemjFRhOGVX6bqwi7Sa4AgbGDuw2pn3YiKEYWo
 yF1IyYU+tDdhkkqFtDQB5MCACtLW+1Hy/h4i+R6HIDDEOp2sr8sfF7olYr1gIBlhCugUwlhZXz4
 VQsSe7d8aTqHnO1ubYUzv/jW5ldqTFFXmfQoSWPaGPCfdy1mI85G2BjbK9VjylildZ01aE8LyE5
 yqMZoOepAwMSFmRFrJPiXm2nG/g8PwY0oSDEoO0qswthgZ7UCKgyP+C+mjwm8cAvJ6DB7qYOsES
 IX/ZeaMe9TMYDvBjzQ9wpK97v2bxcWxE/ZtjbUhX7Bde6soqdOkSkvoGrzGdKHG57BYaUUu0uwl
 PXAgzCDsVfmWlOk1NNw==
X-Proofpoint-ORIG-GUID: BQ4GsTrL0yfQa3DYN7Qx6eBf-9kM28DP
X-Authority-Analysis: v=2.4 cv=LITz05W9 c=1 sm=1 tr=0 ts=6b03b133 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gElGNr783DhJT2Mv8Y0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxMyBTYWx0ZWRfX0fEBGAPFU8et
 JUr6PbI9CV9MDbgfjKyuuci88j4+CsP9Q2WopufSDbuK+TLrVfCFE1tGxt/irk6DzNularMnl6X
 eEsnTWBBRciGMuxCwdvYewGMlTIsICQ=
X-Proofpoint-GUID: BQ4GsTrL0yfQa3DYN7Qx6eBf-9kM28DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230013

On 11/22/2026 7:55 PM, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> hb_cpufreq_driver_init() gets the cpu0 clock with clk_get() and then
> registers a clk notifier on it. If clk_notifier_register() fails, the
> function jumps to out_put_node and returns the error, but the clock
> reference is never dropped.
> 
> Call clk_put() on that error path.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 6754f556103b ("cpufreq / highbank: add support for highbank cpufreq")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/highbank-cpufreq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
> index a45864701143..ccdaff4384d2 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -89,6 +89,7 @@ static int __init hb_cpufreq_driver_init(void)
>   	ret = clk_notifier_register(cpu_clk, &hb_cpufreq_clk_nb);
>   	if (ret) {
>   		pr_err("failed to register clk notifier: %d\n", ret);
> +		clk_put(cpu_clk);
>   		goto out_put_node;
>   	}
>   
> 


-- 
Thx and BRs,
Zhongqiu Han
