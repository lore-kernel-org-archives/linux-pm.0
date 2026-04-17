Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE001EE7C6
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776396553; cv=none; b=lUNdlK4tozSfTuXSR/RvoSmjosQdh3DdI/U9rP2D9SBm+TDBuIYswavBOWA3vUIlaKedUg6REBDjNYQkZ4PHsw49m6XugAgl1+nhv7OfdcQnh+dNmAFdY6qwCwtkdkdVxnqV2ciP33PDWcvRjI9Rx60P0QMsMTb+FZIfSRp+HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776396553; c=relaxed/simple;
	bh=eTyuvWAT+AhQjCTZ+fAnI3d3JtxZ9B0bTLJ9qcIebw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4eCA70+6sC4AvtQ8Z6GwkGqF+pbKaa5zk+Ovv7icrYPHYPZXSWP5NHFFZjghWXvbg3qvxPccwQIqCHKhzbyBRu5x5tgp6+DZdbgabLCPIXkh7oDI4OfWnw5+n830aiq2OyRgEhRI7Am2K4MzG0nn30NtKc2vF53bGg4OuWDycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnZAiVgI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iSmNPZZE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnZAiVgI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSmNPZZE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H0fgJG1092212
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 03:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hw4o6jWf80ge7uRE5y0KQI+QVn0A4UOeJXjsDnVDqa0=; b=CnZAiVgIPp17JV0a
	k6hRhxXiQWsHIpbHOa3uPsP405FOb0o3u2/A9rC46IHXtiZbqTa+k9gDd7mOEBGm
	8PiMTwZTeDZDozP13sV2oFvKC8T8mjt8f9a1IVpfctcuwJelo6i+M1LhWZ0i0psa
	x8c7ts24HvcsTPdm00sBHOPvwJXsqHb6K3DOLio4yR1lLMOKTlRUS6M5Zpr9CbT4
	otGrsO5sBTWYFshBnPcu2qmHEAqfeV9gULa7pu3rLPqx4bY2hfE96fSwyVORnETL
	NXAfpMiFwW/uUe3XFzEzbzl8BYqDCJrMmbVkFH9dO5C8sLj/3yfzE6MRvpt/VYC5
	+wE7tg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227t92c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 03:29:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c769e2b1bd0so77878a12.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776396550; x=1777001350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw4o6jWf80ge7uRE5y0KQI+QVn0A4UOeJXjsDnVDqa0=;
        b=iSmNPZZEPYJNsEyN/BE5sCbX6TTs9CtoMCiufkYb9hRgLntz5SfNN3q1J8JFuXK+/A
         PJIw2JAWXLd/daF8Z/Jf/78y27/7lnOdLsN087inuH1khl9N7j4yl1JBD+v7q+LJ9BlT
         tRH8lyGQcMu83JAaRJnWFfb5xfDNARjGfYyydEfcOWXpQcGM1SGfWvEQeMopevpxq74t
         csJoocdTF122UeT2rPBEPOQr1fNcy9Ka12hlsK7WUYoqpXTpy+TAfPslLrG8eeI4DFx0
         cyy6n8IhoHlI80hizx7+1dZhhouCpItAbyQuYOzmb6pD6ifOKq7LsAAhTBYbRiCQuGlO
         tR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776396550; x=1777001350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hw4o6jWf80ge7uRE5y0KQI+QVn0A4UOeJXjsDnVDqa0=;
        b=jmXcgifP2307V8WMg5KhV+ENBFgxf0kK930Sw9vRSwuXaxbAYecD2fzqnqqORoo+19
         rdo/IywdSoVKJ9YfKK9f7ku+ok6ldB5jmAJPa0TQfVG7UGiCnFkRUC1vicWuGPegs3D8
         3UzpC4prp0FXD3bGjwNXV4tykMb38CnQ97GGkBkn0n1YxQagJRw6co5q2EDoG6YexxXL
         pDmxLYXWltC3EvkkMjSvOrQ4iX49C4S9RJ3Q4p236gAvuhHwX9ZHnVFtUMVlCOCPNdi3
         hIHjY1UpRw1rlhH5ShvFIsAGGdm/olXLaBfFPrQcLGzw9rw4Lt5iMDayoopfvuuAmkGs
         tPZg==
X-Gm-Message-State: AOJu0YyKMTQWl4SCezPxfIhAY0RDsP/+wyVA/sR1w/Ym+5cgWntMHJxm
	kqqe/1QYfawkdZHa6RJeWw0DagUJxFIUcEVCmY6hRGmmTRAqYND9sQnR4k8lj5QQD7KzC18aXS7
	md1g7cGBTwQ/1cvTJGeM19/J7cJbSv2L0UUCM3CjgFX1KqB0USSd/PURU0qQQeA==
X-Gm-Gg: AeBDievH44kU5LiylHPLWserzaLOiL1ZDJyerprFiHQ3giqLte8RApOWXkosODQ9Ee7
	qf3EtQ2vWwpK1PL3nBT4NPX7GrYby//GApb/pUF4a95c4peFC4zNQdLD10r82lgrlxzpcMB36FD
	/zen9QABvOwELXnRNL0l/L7b+HW2Asd9jm1NmEZBimI/pwIkf0UIQIilphRBp4KLNvOlHnsliUh
	1a2K9zvupJbhVVl0W+Juk7SGAge9UAcY/8xvQJkAA2XVxQipWOa1Pvn3uTZt9Qbyqq3T2Ryzv+3
	2cmXshHWYjRmbZvC7ifrDhxyu80dPGsHlz5vpJ6Nadz/PX/EZM2a4AVIXUTll/zvJx/tBR7meqn
	HYhch4Kqi82sEA2tdyrxi1A/Wgcc8TlV1dXv9wKRlF4JRlliPpIi7YGKOOH7xa3ehKJff0WSWiD
	EGNdY3x0doaZtLMeI6yg==
X-Received: by 2002:a05:6a00:2da2:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82f8c8bbe01mr903986b3a.30.1776396549873;
        Thu, 16 Apr 2026 20:29:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da2:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82f8c8bbe01mr903957b3a.30.1776396549407;
        Thu, 16 Apr 2026 20:29:09 -0700 (PDT)
Received: from ?IPV6:240e:404:2520:fc28:96c:a6d:1e5e:8796? ([240e:404:2520:fc28:96c:a6d:1e5e:8796])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm258949b3a.3.2026.04.16.20.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 20:29:08 -0700 (PDT)
Message-ID: <203f2e52-bf9d-4055-88bd-d911bfecf082@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 11:29:04 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
To: Yuho Choi <dbgh9129@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260416144621.93964-1-dbgh9129@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260416144621.93964-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAzMSBTYWx0ZWRfX01xqyOX1zTch
 AQ8GhbysO9Qtj8gVf6lsWHEmT2NiA/F6h/MVZm8fYD1kQV6HM80E7LqHkw73QBvAmuOWlL8E5Nl
 ALaqnhlSDBx/VAzAPIX90z54vmqNC5w0zSW7wAcbK+naL3TzHe9zNUxg8jDGAgq8iVJ16mog7EX
 kqkyFvUu/cSIAyx6V2T/0lFdyWBgvh6q/x0bKF5HI223wOj35p77AxPMibyMusTy0gZf+jGohYK
 bw/oaCW1H5RusOWxhx6s2ETvhcOTcNFWD3kA5thlVZa+cHZ1Er8ELrtfJ43+s9tBE3NPXyrKgY2
 hrlM1uoXaES8NlOkmMG4HeTg5ONc5Q77SdkaSWkTN/uPM3i04Tg5QxDy9PQp0E1RO1hbtw+/5gD
 QKyrdBsvVSntCLzRK0wTDbPwSJX2Ey1jnzOyvRhgBllG92/9TzGHw1Jgcw46/Qs+GqmkSw+onh4
 DMyJTLA9v2BDfc8WQ6Q==
X-Proofpoint-ORIG-GUID: tBQSeJwgw3xIWvYXc5vvFYRfREJLW6OV
X-Proofpoint-GUID: tBQSeJwgw3xIWvYXc5vvFYRfREJLW6OV
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e1a906 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=aIcA-GvUrLZ_5u2auIMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170031

On 4/16/2026 10:46 PM, Yuho Choi wrote:
> pcc_cpufreq_do_osc() calls acpi_evaluate_object() twice for the
> two-phase _OSC negotiation. Between the two calls it freed
> output.pointer but left output.length unchanged. Since
> acpi_evaluate_object() treats a non-zero length with a non-NULL
> pointer as an existing buffer to write into, the second call wrote
> into freed memory (use-after-free). The subsequent kfree(output.pointer)
> at out_free then freed the same pointer a second time (double free).
> 
> Reset output.pointer to NULL and output.length to ACPI_ALLOCATE_BUFFER
> after freeing the first result, so ACPICA allocates a fresh buffer for
> each phase independently.
> 
> Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
> 
> Changes in v1:
>    - Drop spurious #include "acpi/actypes.h" (Zhongqiu Han)
>    - Keep kfree() between the two calls and reset output.pointer = NULL
>      and output.length = ACPI_ALLOCATE_BUFFER
> 
>   drivers/cpufreq/pcc-cpufreq.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index ac2e90a65f0c4..a355ec4f3dd4c 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
>   	}
>   
>   	kfree(output.pointer);
> +	output.pointer = NULL;
> +	output.length = ACPI_ALLOCATE_BUFFER;
>   	capabilities[0] = 0x0;
>   	capabilities[1] = 0x1;
>   


-- 
Thx and BRs,
Zhongqiu Han
