Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCE3B9D8D
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360880; cv=none; b=JP/xYCyaalUYOM9ApcfbIrG99nfW/E3Is4Rari027tHHbvaWrkZk995geBv63YfA/W6TvJeQxmsx5HzobmFP+67yNC5HCN2nmVv5UhqyCuUtE9wU8pi6hCCwEkLGJk8WnzUO5GMEM+ckTO9EYmiXPsdCswKjucvyisrhxaup0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360880; c=relaxed/simple;
	bh=vJrqIOtAiYgIXdDR/OlqAiIPi7acdZA2xeUi5ME5BNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FqjkCfhAy08R3SzvfnVinYsBkFjM/w/tXKeGKgzh8LV3vG9ZENOBJSNll7NHF0/Q1WUVlUGB22MSwvqMBmLWfyo0Hm0wX8Y0GWQf0sjOk94tmnqtnWfWYP5JSqqpp+jnNlMbzRR2ikhI3rmslVMD1LDOc5Uke/wlrYUJAWqfeHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GumuAdmZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KBXTC/Mg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GumuAdmZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KBXTC/Mg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9S28W1189434
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6c3H0Pu+uyc1iGU45TAJg+O9ECAl7MxfzTfz5+WF34=; b=GumuAdmZXAuA0QZw
	XITYIvKbHLUouXmly2kbrPs3GfvggAjYmsoP5wyG7xnTizoEinEHdSWIBPE47xuM
	OqlJZxBUeqz+WbDoc3cFrrTzB5gEWXf7X+gANb6/4LsGuIcHoHIgwHx27c66tG48
	KoaGc+W/hFZHxi75xGvlQWW0LWlHMKvv01NgSx3+ZDfSMP4XwSQk02LYBBAfycz7
	NUsuXnGbbhzsq7GC9M+Dtvd3McGBaMgc+3xWLKUTNgYFRNJNLf6OQmP0yS4G1p/1
	sQqMuSX6fr68ML77kMq/mCgo/dSYW1MDVNrEr+jvVRv7/01R1LTVJw8YYq5NsKMG
	axcGvA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v298ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:21:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbe9733fbf6so1305618a12.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786360876; x=1786965676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6c3H0Pu+uyc1iGU45TAJg+O9ECAl7MxfzTfz5+WF34=;
        b=KBXTC/MgkaZhvkCQesV+2eVu7uHbdYerg7Dqg715iZuI4YhRvA4auGPI9hprpU6rNx
         XQsCm3LYTDaUcm0+JRy++gUDqLjm4Qs77yBzD5kZR3ZMevb4plHMK5WH3XsCBl4EjQOI
         4aDbLAJZSdItHYnklT7nodiPnGYfvC5UDX+IX3EnDjJsFWJHhf/BuDBE4FivGmK4nRkb
         MrtfDEstCSFcTF/lPdgz15GRCPC50HFKCtk3ZpYVDQU2X1zD5J72YvZnmb78wMc6yurG
         h3T+kqG40cbWtKz7tied73GQXjjoTE/EgWTEQ4pDIenbbL3dyy0rdyI6h6J3aJ529QLQ
         3vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360876; x=1786965676;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6c3H0Pu+uyc1iGU45TAJg+O9ECAl7MxfzTfz5+WF34=;
        b=SdZNW27FkoILvwahJ3n/2RWBdDvkpGE7sZgxH4qkcxtkewfl6UZh9hkWfGtMlB7d8l
         ThSVcyy/WYGjLAZUpOLrc7dC+ozdiRVlT+0PdCCj1di2YmuR1KbqeOHONYSFt9pvwcjL
         83obfCdff+uG+CRhz7S+9QF+NcBLfkzihjRXHr0s6CJiph4H+NY8I+933Rt4zKYWV9Vd
         Ik8Hix3A/Flz4NCJLqew2ukB+XD823aqGJwWbsnYj2jDEXDpYYvnigyvJ1AiOXWHZhjw
         C1Kf6WRarnSTbgDWQDHcvpmwQTPZrUycBqfF7ncHVBRmxL9pJm9i8MqfG9ZXdpkT+2Tu
         /67A==
X-Forwarded-Encrypted: i=1; AHgh+RrE6u1GfxlTgB5cl+1vVw/H6C3aRGeNXbf0Q5WyFx0+5SHWtQF9oIjUgjPn6+CQkpzqTiJRVERZiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3Jb76G3H2nZiLmK82V2dGwkKZMa743rjYnwXVy25atZTv4+f
	g8C/aaZrhWTagIrot/N+35Qkrn8T+VmMvKsq7/8AQ3p+QSTTaBjN0mwMGbJGVoG2uMSEFmnhVlG
	MqZm+5vZu2gcNMTv4DPnIzCbiCb4m8to34EnhEqyJ4bGSSFrcPmCpFpFAlrDRwA==
X-Gm-Gg: AR+sD10LLXx923DCY1fWQf3oITl8ktuDayce0eq9HIJeTfvtHN8rIjQskLyn8QZ9fYa
	f9ByC0b4BR+h4z0eyN5XlNrvtNZV3aKdoE0dBzG1+OWpBTj4OBv+ng5aYC/18ly7m2iNL4hoYY4
	S+yWK/DLk+x+yyjWNRCfWm71AbKTcT9vOqeM6EG83De4Z2HnAcrf1gs09/3xKjYqB+Fk7zmU+G2
	V/ect6SlUClyCZHir0v7/gYbRgTyPCDTN/EKay0qyMWwdr8lefM0FEhc9h3FynmlmQ6mZr/j+N2
	vFo1P0t8U5QCnAMk3lYNa94ASLLTdZsiGYFlFR1v57NATCTL1VLaEPGPpceOFmSRolXubnxVlAG
	PyKcqXR/1VMHoUJDKYyh6amt5WRU8VlFr3oJCdqskqbfMJAY3H/218+PLAfaIl8ZHFUpOY5o=
X-Received: by 2002:a05:6a00:22ca:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-84f9c9b7f6cmr509669b3a.18.1786360876555;
        Mon, 10 Aug 2026 04:21:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:22ca:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-84f9c9b7f6cmr509623b3a.18.1786360876079;
        Mon, 10 Aug 2026 04:21:16 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a0917sm3738825b3a.2.2026.08.10.04.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 04:21:15 -0700 (PDT)
Message-ID: <3c7c27f1-8ccd-4b1a-a21e-9bde219bd9d0@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 19:21:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: add NULL check for acpi_perf_data
 before freeing
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20260810061045.2397-1-lirongqing@baidu.com>
Content-Language: en-US
Cc: zhongqiu.han@oss.qualcomm.com
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260810061045.2397-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S9PpBosP c=1 sm=1 tr=0 ts=6a79b42d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=zuLzuavZAAAA:8 a=cNA6qdcMM3CCEE3PxHQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: -_FKUH5YCmyxGiY4pw_G4khYiPyIHIEa
X-Proofpoint-GUID: -_FKUH5YCmyxGiY4pw_G4khYiPyIHIEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5OSBTYWx0ZWRfXyyyQqOTRr63T
 z0aDZFWqWXLTFWhyMT1PXQKCgg89jFDIalIpd5oa8Hp6iSvzK1f0cKexXRnNEdNb951MEn90SC1
 TF/ghnqRXfycodkriMIRgt7gJYl6Qx/FJ+gQfC2V8YIg5AIN4gY1wdUo7tkBv/DT78ZYW6cFuwm
 gPuGxpJqu+YTA6LJEUnEbVcAAzOl2ylwvG7rJZKXXxjwom6F/fvCdlvolaMao+ozKCELmZPLRyK
 ZVw/uujs+h7iZgl/VJqjuGVqzLlqFocaMMAYtx2YfX5AEfdE8AOGAV/YnO1hLbkAzjNeIIBl/c+
 NHQxLNh06WcGDEsGITFQLrlYuyDwj7YBFu7XcrkJik7yR4GMgW7TKsFegrOYjY6kOWpAP2h7Kbn
 GBkJIdQE9mBhZ96tBl2mKVS9knTzcf/hEZvRy/pKTTjMwempzAygJklCi4b3yAH80ISA97PKZnv
 AQpwpSDJRENWLMTn8Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5OSBTYWx0ZWRfX1xImSLD+lqpn
 yrJc60Drlo1mUYq3vQGuNsMj4lf/hSN+Fzi7Vi5oUPCwgHxDqcf1KKk6OY96KEzMtyEoQko4mDv
 vWDBqIEBKZA+sAeDaXBUqwlDqrsutF4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100099

On 8/10/2026 2:10 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> If alloc_percpu() fails in acpi_cpufreq_early_init(), acpi_perf_data is
> NULL.  Calling free_acpi_perf_data() will execute per_cpu_ptr(NULL, i),
> which does not return NULL but an offset pointer.

Hi RongQing,

Could you please confirm if acpi_perf_data() can ever be executed when 
alloc_percpu() fails?


> Dereferencing ->shared_cpu_map on this invalid pointer leads to a kernel
> crash.
> 
> Fix these issues by adding a NULL check at the start of
> free_acpi_perf_data() and setting acpi_perf_data to NULL after freeing.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 87e4923..cd2ca87 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -517,11 +517,14 @@ static void free_acpi_perf_data(void)
>   {
>   	unsigned int i;
>   
> -	/* Freeing a NULL pointer is OK, and alloc_percpu zeroes. */
> +	if (!acpi_perf_data)
> +		return;
> +
>   	for_each_possible_cpu(i)
>   		free_cpumask_var(per_cpu_ptr(acpi_perf_data, i)
>   				 ->shared_cpu_map);
>   	free_percpu(acpi_perf_data);
> +	acpi_perf_data = NULL;
>   }
>   
>   static int cpufreq_boost_down_prep(unsigned int cpu)


-- 
Thx and BRs,
Zhongqiu Han
