Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013A2DF13A
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319472; cv=none; b=G112ZRuZpfik66d1JFUwV5X5zLY2xi/UhszcCE41hk3hDxh1OCziqd6wFp8Kzyqmi65HM+9T2XYppCLy2EH80zI7n49JmEqe9BDM3ZSB3PYbmEy13ptXVOd/yYNQvmK5T4O1u+zo4D4Hak9ND5WG3Y2zy31VXSH3a+8cEA2WAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319472; c=relaxed/simple;
	bh=1ZVZAFCFHtfrGNr9S1XLBBMCeJj4TmZiFJFCxJ2Pi5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN2bfxc3Y8RpgUNQ4cfIYfMWLFPpnmOK4X+E+lKP5W/iCo4THSiSiKlVTZNkPjQ+LPpiTQLS74x7iJP2oifRMckmIOeBAv0CNiBJuaLxyjdOQpu7DfYAfwKW2c5fNlnGRiOaRf6m67DnsOQQw21KUx8qlP5L3HTKc3cIg6DvDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7emnMXB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iBUipAl8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7emnMXB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBUipAl8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G1Vli43089448
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iQ5icNOmFIieJj0wO9ogPa0sSKFt+wk299/xfGEJ5RI=; b=a7emnMXB7wDRR9h+
	iPhfy/2K3fT3sotUqANJGRp/zS0vsmT0M27rC+bunxFFJaMRgVXe9NkUGHKhzUNp
	vTnUzwGCW+UP8SY6WwfRJowni07Xes6Jfz8oTVWcO19HV/Vg/y1dsuk4HUUga3Ox
	BYt2O46898aeKDY9RwIDxfj4G57p0T9fGd027jNTq/RX3RWufXl9Kljq8e++Pmjn
	rS5j8/XqBzsJsByp4DP4xRwbLyj9JDl4DLxsJ9oloH2eqbbCxhfKdWoBb69ZDpA9
	QeqLFN2/AVc4uKCkHJLE0O2H9V7ksBdXUpc72RIIITsl5lG+opIc7PCWMGeuRmsr
	OKJ3Hw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djp6a8qps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:04:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76bb22a8ceso8245922a12.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776319469; x=1776924269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ5icNOmFIieJj0wO9ogPa0sSKFt+wk299/xfGEJ5RI=;
        b=iBUipAl859zKTKgt6EMKl8xtFinunZdwEdw6YGcwAefFU6MCi4xbfiG7pszaNfrr7d
         fPkgYssiv8oOypldb7+65zFVhCeVyyr0xskZQ0Sl4CMXFhWy+dw29Uf4KIcjeGRDXvl8
         CBI8XdSi21dZdZuh2ssjxzdu2htRwt0VPbpvtkb2+MbPT/j/zJltRLPaTQhuxuMnFU8n
         yeKb3vSVRPw8lSg60Gi7CWVNPKpJOXMXH4+uHI6L2bJXgylfCR7ObbgUHf8aS0wVdeW6
         NlQKZYVNbrrqY/1Bh1HoYhuumkLzSroNH1sH+FCOT1wZ25I8zMDihfVVIGDLN0Ilf9Lb
         o8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776319469; x=1776924269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ5icNOmFIieJj0wO9ogPa0sSKFt+wk299/xfGEJ5RI=;
        b=lW72O/83yhgOLeXaP8ajN057b0eIsRa1Z26m1aYUDh+56GP+eYHOYSbT2uXmAcw9RO
         HVI+R6Xm7jh5liw3KCEvQ+CQI/f3WMEyB3ZMLKFJ5gZDQWpBVi+2zRh8qzp/0seVp8Va
         6ZVWLROzXOvCs6hoohj8NJq6TOdlVTya/0QQ3nhpBYyErb5e8jXzjWVP2yFXvFnUkqEz
         kKUhmIKbUmiuI5ox1d8Fyw3tzcTs37jgfWNMXx2R6K0Krag0x3KwGsmkry/NTKhlx/O+
         D1eS8nnHwUy4nOy8WE0Tgk90j8SlJcvT6lEfzYMYHS+o4/XZFqkjcC0pM7hSsNipE41t
         OFUA==
X-Gm-Message-State: AOJu0YyaxB/CRoAg7OxQN5LcS6kHv0xTYkux44UNOy+usEoI95Lde4Su
	9MSOuUBdfmNtxQA64u1n1rHm9mh/eyVrd7IMkad1IXZARUdwDzMq7YzW82PKjqqBdmdq7AfbGVn
	tkiQoA0TYbSHOsU+pTDPdfwWgYx5kM+b/gBvl0fyfy6TU5zFgtNBTYv7QbP73rA==
X-Gm-Gg: AeBDievhub68FUTdPQhj+fVnnZd7lDTwWmuxJdTxj+w3XW1bSCVSS4NO2ig/zZoq4KF
	oYCLEKv/Ev5Jc601LsDjAJ6EwqBsKP23PKAajBkxtWFU0rNTpYzvQY5SzQzD4YTZ8VGHW02jVjO
	HaegPobEM+a2T3ji9DbUZPOJgnc5Nc4fJ5yVHVWoVtJfSo0c0pnCPho4kkkc+go8oTypTaC7SKB
	3OuIQ/AQRhz3XPXXEGN/ZbyBV0aUgVmYui9I9YrQMQjmjYBo3alMXZsIlf8WUEWvcTLdOf9chh7
	bi6021CR5JmJenvPKYgw/Y+7L4ddOry6rlT/1ArGVTa4F8PFinEt3kAx3eqibDtuo2sKJFnEOHg
	2o5yGztYSVttzZZ+ZBbR4cD0/UtBdG0hG27MeFMYx9IUrBA3WfI1X2fi1RLytu0Zbsg4Ki0oxbx
	zxBUUXa9SG3QX1c8eDQe+Zwx3TjF/Z
X-Received: by 2002:a05:6a20:1592:b0:39b:e789:7d20 with SMTP id adf61e73a8af0-39fe3ff14c3mr27343384637.44.1776319468874;
        Wed, 15 Apr 2026 23:04:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:1592:b0:39b:e789:7d20 with SMTP id adf61e73a8af0-39fe3ff14c3mr27343348637.44.1776319468356;
        Wed, 15 Apr 2026 23:04:28 -0700 (PDT)
Received: from [10.133.33.176] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581cb03csm3668963a12.27.2026.04.15.23.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 23:04:28 -0700 (PDT)
Message-ID: <952b0192-4ba8-45ae-a71a-79854d558702@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 14:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
To: Yuho Choi <dbgh9129@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260415165139.14113-1-dbgh9129@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260415165139.14113-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rpszias6ymGp7WmMewRYJ7w1rsV8qmvT
X-Authority-Analysis: v=2.4 cv=NuvhtcdJ c=1 sm=1 tr=0 ts=69e07bed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=OE-sKc923LUAuokmw04A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: Rpszias6ymGp7WmMewRYJ7w1rsV8qmvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1NSBTYWx0ZWRfX1fUBYkOCS32g
 vaijnW5e+9wigEktTY9DUYHb/P3K7Bgq4uNTg/36iNJ9os0roLaw7fWqrvxjwKZ4gwrzqpSjrXr
 8U5rV7vPDgJknbLR0SiNkrewRYPEXRim31TB+Tc1ITE6+ior8jP8Ux3rJjF953AgPLQW5fcANu6
 sZRA8hnXagpsmWd69oQg1bFh+o0P6WYOVbgYGCL7RuiERSMouOYPL0n8CkoFWEzX0YKVWg+Agrw
 KhkLPGjHfMA8bVG8mbJiLo4B0yzVnsLJ4CKbHxvBWvT5OMxFzbDEQkUuJm6tzt/KA9yu913FJGj
 UBm8BUsGqGUFvxFieRkfmsGUOKBNWoTQHFxT7ORb7lvgLGiS/wbtQ5dp0NiUVVQ7Y3j5gEEHGeI
 +8NfC4IakltxGn2UPBCS1tyBzUUuq+DR1H89kl19h4PezPjjEm1COejiju9xOmJleKa3dz8FHGi
 AhnVThBzgBYXc/2N/Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160055

On 4/16/2026 12:51 AM, Yuho Choi wrote:
> pcc_cpufreq_do_osc() evaluates _OSC twice with the same output buffer.
> The first acpi_evaluate_object() allocates the buffer because output is
> initialized with ACPI_ALLOCATE_BUFFER. Freeing output.pointer before the
> second evaluation leaves output.length stale, so the next call treats
> output as a caller-supplied buffer and performs a use-after-free write
> into the freed memory. The final cleanup path then frees the same
> pointer again, causing a double free.
> 
> Keep the first _OSC result alive until the shared cleanup path and route
> the early error exits through out_free. This avoids both the use-after-
> free on the second evaluation and the final double free.
> 
> Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>   drivers/cpufreq/pcc-cpufreq.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index ac2e90a65f0c4..165826b5d6844 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -23,6 +23,7 @@
>    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    */

Hi Yuho Choi,
Thanks for the patch.

>   
> +#include "acpi/actypes.h"

1.I don't see why this header is needed for this change. Even if it is,
it’s already included by <linux/acpi.h>, right?

>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/init.h>
> @@ -351,16 +352,19 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
>   		goto out_free;
>   	}
>   
> -	kfree(output.pointer);

2.Would it be cleaner to reset the pointer and output.length, and let
acpi_evaluate_object() reallocate the buffer? For example:

         kfree(output.pointer);
+       output.pointer = NULL;
+       output.length = ACPI_ALLOCATE_BUFFER;



3.The sashiko.dev pointed out a few pre-existing boundary checking
issues that are outside the scope of this patch.

https://sashiko.dev/#/patchset/20260415165139.14113-1-dbgh9129%40gmail.com

>   	capabilities[0] = 0x0;
>   	capabilities[1] = 0x1;
>   
>   	status = acpi_evaluate_object(*handle, "_OSC", &input, &output);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> +	if (ACPI_FAILURE(status)) {
> +		ret = -ENODEV;
> +		goto out_free;
> +	}
>   
> -	if (!output.length)
> -		return -ENODEV;
> +	if (!output.length) {
> +		ret = -ENODEV;
> +		goto out_free;
> +	}
>   
>   	out_obj = output.pointer;
>   	if (out_obj->type != ACPI_TYPE_BUFFER) {


-- 
Thx and BRs,
Zhongqiu Han
