Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D73BBFA7
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220230; cv=none; b=olsvAOsMja/uPyzj5MUJGQaLBQJuW/CmT8orFtvECkb/fYX3AmKLy2Qd2bbdO/8aBwDvOfZpBdcjNpnY2vZjIeX2ArgL4R1idq7tAXP2vEUc2971XIcnzU3e45vPcKzxHUdPQdvC6k+ldcBLCfUiUAP5J7MNPW0ypSqG7Ci8+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220230; c=relaxed/simple;
	bh=eXffEAGKjk5hZBWJl6zMi/+attHYcgNZsIbemDFtAZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szubeeV+AgyeydlAD6G9IDMLLzrCh9Op2zDsZK9M/jrEwnCrt/0PehJxvcILgcZZQAjaIP99gHOdnyaiLguTI++fTKuE/i06riFZ6QxVRSDuXBaZ0GXPjYhFQor2Q/hFIHj0HP+frzh4SPJOC8UpR69Zaxuan10QHy6+N2FHKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrUWv8E1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMb62xFU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrUWv8E1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMb62xFU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6nATM3732396
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=; b=GrUWv8E1JzQPRNt2
	g+UHy/wFYB6/Emh1fS4On/siAWE2XU8nd8XmNCtn4F3S3G7N+Vj7e8uaiqiQzumf
	Uw48HTxrOFwMdzq9UmulYBxsNgHga1Z1NvveN2GmDqO1Q2ySo9XlD9lPV1HNoKGW
	rricXfDqlvNeXCJr9qeYJKOrjN50RBiSN6NzRzMQOcSV59z/Q353HeJspIA82D9D
	kvtUZvk2YScboJZk20pXxMMu6LaswLpvxJtrWPvpbJu0rzhZ+hTTvezMqKdGYXjR
	nQTjUdVEj4K5SrFWEo+DtsN1G6hzuaCF+8Xe17pzLn2QZIN7HkelcmZtacFb1y1R
	wZj4xw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn88qrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:03:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-851d6af9d75so1489551b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787220228; x=1787825028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=;
        b=VMb62xFUcVrgewbRSXphIjDpyyau6Tk0j4gPcrx2EhobMoEa251AtqlY/y9wkrC978
         4e0PMN7GiDdo/1YV4SWBzpuCjJutZdfJJjNCLVdZs6WtJFA3PAYXcSj/GIHlbxzKNjkY
         Av19n6vLItXw6qxPUUMG0k8cdWW88Npdt/Nhu4gJ8QuWQfsLP8ArbzYnZPKkuCeYhQuz
         9NL289uOPbGtb/d8pePgot8eINsSkvi4aw3J0YqXAa/MD80f0Ch53HU2HJbPSRbT46Ji
         0e217MaJIIg1S25Ol7n21Fqup/axqC7FTMqFn6h+HfT0L+Fr32H/dtkwIr3d4D7brVPb
         KvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220228; x=1787825028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=;
        b=gwED3S3dZiAcdjlgZXbXgkQ+Av4aAKlIf3JZI9RdB1vC/c2CtrwcpMiJG/mh4vSFmT
         BQcYurNJmqf6XB31Qok7cPhXtWu5bHPhzVK9tnz7FIPJLL5pQ5ifhatZ1c5RWvV4hzDZ
         G5ClbtyR3ZM5PA/OC7yp9cIZMeAzZIG/FHlkTItZhGURXMcCqpwiXWrQtEnHFl+GWjkU
         pW3hIeauvZrY+8XBpk5LJTKN4+412Yb7CNT8f+GwFX74o/0q/1gfRgbGSs5P0VeCjFow
         GXcwjY/n+3FT38ZQhC9NXLRX/uSa5WaoICCzgP1WJwE88e4lGR3Q+ty+dvs0lXKnoE4F
         lSJw==
X-Forwarded-Encrypted: i=1; AHgh+RozF7/bITP+x+M4PcnoTHFDK4ANWTHIaAzJ02n684feyflfTUdRftmYqWP6j2UCgpwo7Q9DOo1+eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BkvQFeSXXaIiXzznZwwERkKpAs5OS0djUcywdwDMIRoJ0cJ2
	Uz0ntYuoMc1V1F8vPoPBO2QJTBkUCRo30pK0yx80VZdDkL2V37AYLbk+teKSLIt+4BEr894Grvi
	lr4D/kTmz7VuoeFPvESIMyjn7Gd90frv05GqfMOwVjvCQcewsnZtp0dB/ODE/6Q==
X-Gm-Gg: AR+sD11IBbPp6NxL5XbxgYue0B1Krnq0dlq2HDLY81s6hYL1emJbhYnqipflAxg0j7k
	qw0pUhdLeNuEbhIhm8FDBYTXGfPBnzkTZiC6GiPFkrZ64SVBpV4rcpC/cDVZbA4M2dwAH0awMoP
	Ti113qm+2LycjPbipZOmKRQyTH8HbCDhU982oaCQwdQKGPckZrbo2jJlf3JsX5ICb6uolOEW/V0
	Z15gWaeiZhUBmtp87Qg2KzeDpd4cB+NkWHGYK/gvVmtHIgJfaucxhVFkJ1Q9kjlFnZ/RpYyF7Sj
	MNxpw+tCCzoHD0UcCoE1bRUDW7aD3iB88r9u6sEjG3Wg4xxQECBfZK5f1G9TQUOcgtklmk4GNcG
	jN9Bmj73M5GXL2m4sjAjUMZnrucd5VNNojJS/NIlwl6JYDcgMBtcOACPrZcC5Kuw3Y5SrPs5L
X-Received: by 2002:aa7:88c8:0:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851d3953ac9mr17929928b3a.17.1787220227597;
        Thu, 20 Aug 2026 03:03:47 -0700 (PDT)
X-Received: by 2002:aa7:88c8:0:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851d3953ac9mr17929843b3a.17.1787220227125;
        Thu, 20 Aug 2026 03:03:47 -0700 (PDT)
Received: from [10.133.33.222] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33627ddsm1488181b3a.10.2026.08.20.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:03:46 -0700 (PDT)
Message-ID: <e07d3a93-390f-405e-85ec-21e5ad9a6738@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:03:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cpufreq: loongson3: Adjust the width of id and val in
 smc_message
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
 <20260818123921.3600606-3-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX/xTVnumbFZ92
 EM1VkDoWq7iDPy9XITD/PgwcFpa7ERiVoCMMxcFeSUdKO0jbpHwA46su7xy37ZU3+K+c0yd1ugk
 kMx/MskuJfyDAw8bTuCykJJep7YJxzOFYat3zCRQFqhWKdjaF+XKmxEvu3HMK71fjQSHiLsz3BD
 gTnfqdWvTyR3uhXHT3RuBW+D9yVFYIlYNL0K0B/dYBHPM85Jpie0qAQ7D72tczysiPLrbdPps1T
 9myDpA8UH8OCHaQwYKB6kGdooTlgiX4AZgDySExcLOu3tEX4VJYMSa/foavNZXSRiqhuI56pGVg
 PqeJn1uDNFoE7JeuPqLro7+3nPdT90o7cgsnHkq5Z94WQ/tE7jbfTNDPUm21oepJVvnHJFHwHbF
 tskntCkd/v0jhM1EArK4bj/g0wsedrLhYFCXq4fdCAK09XD9qo0BFT2+YwFmdskh4icW5a2bu4c
 xf/URyK1zjqDZKKiyHg==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a86d104 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=2sVyCrUYgtLBleu_eicA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX6Z7NI1MRDZLB
 npevqrkz56JAeV9w/VdtZbr9ELcY3j+YdZazAcWzU73UTi7lSrXNAQgPlU2Mmt8tedm8HMjnZ6W
 uvw/euUtZrU5v7eQ4Mf2BjgduETkTUA=
X-Proofpoint-ORIG-GUID: 4nvFYG_GLKcsXgCwL7gzfqTIj-IJclgQ
X-Proofpoint-GUID: 4nvFYG_GLKcsXgCwL7gzfqTIj-IJclgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200074

Hi Huacai,

Please feel free to comment on the question below, or simply ignore it
if you do not think it is worth addressing from an architectural
perspective.

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> The id field of smc_message is usually stand for the CPU ID. In the past
> this driver was only tested for desktop and laptop productions so 4-bits
> are enough. But now we have servers that can have as many as 256 cores,
> so we need 8-bits CPU ID.
> 
> On the other hand, the val field is usually stand for CPU frequency so
> 12-bits are enough to represent 4GHz, and for higher frequencies there
> is an extra bit to extend (enough for 8GHz).

The extra bit appears to be unused in the current implementation.
Perhaps it would be better to enforce the limit explicitly for id and
val bits, for example by using FIELD_MAX().

> 
> In theory, this is a incompatible change, but fortunately the old SMC
> firmwares are not widely shipped and can be updated on the air, thus we
> can safely adjust the widths.

Not sure if using CMD_GET_VERSION check can avoid such incompatible
issue?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index 1e8715ea1b77..630f679aa739 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -21,9 +21,9 @@
>   union smc_message {
>   	u32 value;
>   	struct {
> -		u32 id		: 4;
> +		u32 id		: 8;
>   		u32 info	: 4;
> -		u32 val		: 16;
> +		u32 val		: 12;
>   		u32 cmd		: 6;
>   		u32 extra	: 1;
>   		u32 complete	: 1;


-- 
Thx and BRs,
Zhongqiu Han
