Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705794;
	b=RPWD3cGkH6g3KIAinRBIbR4ztmI88Fj3XCNOXCfq43QYnUYIcGhFkkI918uLORidZBTk
	 Wq+rXpJKAALrPFDSjpx3WCVa/JJwB7gDfdxUah92iCelEeqG9xXczYEjAd8e8m8dO7KWL
	 uv3bpyLZr6UAqRC+VBV4+GnXN2BrO7afZkxTyEdOQ/sXvbDZz/cSqC+vAOhrfaL2UQ5My
	 r+4BJ2zKTkRUUk/d8NAMfn4e4KdWqm9kUDPqRrNcRq+k9ATeuo1AmH5BGQDlAX3QIa+Po
	 P6ThdBDqwu7avbyyGnm/p+oZdoFWD4dugoMSY9s7dGc8Pp/5hGlg2FNCo3nPnSmfOxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705794;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EYRNIXN9GIDPEJwoIApz90EAE3rM4QaSJO+X59CuZJk=;
	b=NllAVapqQSnIWz5rrrAAl4yBTmWeM+KPnYVOFDDGCqZ6Ehe+5wgmOebSwn0170Qw8Cdk
	 TKZDETOpZBAkB5Y/ru3LYpfW5T9j/cnm5ijQLGtzrXqcS6mCG4PH+WqoWM5SdUqKxizL2
	 Yfdfq6wi6WOeVALpC2QGobbGlHLxMHTUNKPK59ZM3J7fvfntxjlJYqcl33vGgQo49FQwq
	 ZtzvpGN5MxI/Q0SAjimo3l0ygEXnt3IPCEpgtrwVdUMeph7LL9PDp5YkhPitgGkcOSWoO
	 QYHgX/V5D3t7dyrCh0ga8zlSa9NM0Kbg0h6hfvbmSNIAG8kZKgp4aSKCvG6fszpphiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5+0mxal;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T0m6DfYT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D538606A32A
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D538606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5+0mxal;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T0m6DfYT
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEV3iK3170999
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYRNIXN9GIDPEJwoIApz90EAE3rM4QaSJO+X59CuZJk=; b=M5+0mxalerfQAfG/
	VBtQQD2bhDLEqFEBr5v0KYDMrm8TEtiotjQMl9sJgPgU3GuTpivuTCRCEjCQoUS5
	3fVbygbhIYTlnVfzy3lx1Tcqte1yli1cW/I9U0oPv3jg4JK1g6Roe66obavTQS4k
	Pj3XnVmmRTQIw6S+PQpepTIf6LcbWBrr0jmoiWWWB4LTVu8+Gl1c22lwnMIKBjRH
	cAGd/k04gjbAf0BxdfPZa24KoCaP56Ve4kcA0bH+9R1YHlBDyQW0G2w6xGOoS8lY
	67phASZqXf3AAwYisT9Bz70aogbW/cGWRv8TDHiLKNRNlMCu/0Hytk/Z/kZTpAg+
	qeuE7w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfbegb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:09:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f0651873abso51426915ad.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795705792; x=1796310592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYRNIXN9GIDPEJwoIApz90EAE3rM4QaSJO+X59CuZJk=;
        b=T0m6DfYTf+ay0kESLPqGP/mOTGZRL6yO7dQm0aZA8wkcxEuFsMjmQfh+Jvjen4K6Ao
         Ln7j6aDoapO88cIfPTNzWdSxyN6qiMfjQ3ckTdTmb1gLspR9IndqF0Md2EqAetOPG9w9
         rQVqxpFPfxRBT73qyfpCB+YvPgSrFkXMT9Zm9lKE9OoIqi0NJd+UOoPwq7C7aIJAeSIN
         uNUM9z5St4ePA0iKPMEjb3SLK17Uc1ep02UVIVsAIBEHJhUjtsTJfRYlq1msqZl7SzBL
         o7ZqjfC26PX+HNc8N9ZvlPW3CYUsqRqnlY3n4UUHoQNT4uK9dYULSh/N0f7NU+/RK6sR
         DDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705792; x=1796310592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYRNIXN9GIDPEJwoIApz90EAE3rM4QaSJO+X59CuZJk=;
        b=FVfFZrMJMQYd5wRlLERejL0jyfabC5K6JgYpvOVkPy77ZYsYEj6rLxAaX18NQvD6vQ
         ACuD8uNQoTa7QhnLTPPYIyYGcn1aC2LGkV0+WVsJ1gXSW5szB7bo+IKzeTHvh+SjJzx/
         Ctirvza1GSPcwGwcoRTIrCW2gW8NzD9NkDaGhqFx+BuESRQ2nDY6Ow37s9SnN5ObyKtR
         W1SGway5a+YcFT3MeG0xG0HGUAPJ9i8L4H1W99D1HZxS5JHrtXe95+uOcO7B+jH5ihla
         PNtnqteIDMhbxPG0kRLJfZ3kpchqhqCecqzjP46faf4NRoBEQFVirKDtuSVi+QXdwHv2
         DwDQ==
X-Gm-Message-State: APuU4Z+QiDSyLKP6E8jYSBuUWAWjCtk82h9fDbcnw5TiaPWg8A7gGwtz
	2bz9hl38wqJhrI4PXL3NpYvgXqfeDJR4xoW0ZHFkgXUG3QsHFqjPJoc7bOJhNO788qXbLYPWY5P
	TOqlZOe6fMfrjdDK/+VrlQYmz1bpP3HWx90HHUhogvUFX7M5R+47yotvHcmqZ6g==
X-Gm-Gg: AZFdTZc/nLjmyQ0MkQ+1JAEDzCNvD/kHLckJ/lJb9vUxivQR1kHlcrhWvnxYNbp/QAd
	LCuf20K3PX1RckCJldTga/WnQnuKk0BEM4GsgLn7z3pikgp2ZFRTkUatkaKKqDLc3AvaHy1ZlUJ
	t7NiN3Mp9URBs/L32rakRM/5bRzbPcTb4OG4kVaubBDhWUZ8NyCXsEQAMpGlG2HPeVwZ2e9ZMEb
	z74vxJ8f9fF9OMf4l6KcQ5YUazYMD8dGd8sf/GoXaDRsgvcEUJ+IfFWAj+IPI92gTMN3ydEDfo8
	nbgYo9F7QJIKSs2RWw0wTQ2eaoszP7ChX15LX9S/dTy+A91L5yGMiylXuvoDegd7sRDWFoZsw2F
	h8yJy5f1Gw338bNapxW8TJlRcMtGyuRT3HK3D9shkBTHvLfaBlBI75ldukJLYRrScwa346AB3Z4
	8Kb7KH1pq+ucDcFYD7WBWLORIne/5bRQX1u6Py/+b5UvXF
X-Received: by 2002:a17:902:ced2:b0:2e8:c3e1:e1e with SMTP id d9443c01a7336-2f03f246d49mr194662345ad.52.1795705792175;
        Thu, 26 Nov 2026 07:09:52 -0800 (PST)
X-Received: by 2002:a17:902:ced2:b0:2e8:c3e1:e1e with SMTP id d9443c01a7336-2f03f246d49mr194661885ad.52.1795705791591;
        Thu, 26 Nov 2026 07:09:51 -0800 (PST)
Received: from [10.133.33.179] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84027sm104949635ad.7.2026.11.26.07.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:09:51 -0800 (PST)
Message-ID: <2dcff329-4a81-42b3-b8e6-67ffc8c73f9e@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:09:42 +0800
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
Subject: Re: [RFC PATCH] cpufreq: Keep global boost enabled after partial
 enable
To: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Loehle <christian.loehle@arm.com>,
        Ananthu C V <ananthu.cv@oss.qualcomm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -ZhGZDoV-5UyBwEtg7kIewha0Kr2YdE2
X-Proofpoint-GUID: -ZhGZDoV-5UyBwEtg7kIewha0Kr2YdE2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfX/lzQEcrFRu+i
 n3D9cbV/2Os5maF8dARQvZ395sxWj5Qwgo9dFmvJM4e5vJ8M9QY6E5EE2dO7Aj71zNJR3IuflN7
 0/2FJ+DJS37xSHJgWWlt4yguas2Kl6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfXxFl7yt227LTA
 ek0wKXM/UhUvApa4kVeAjQXtNOmbgkEYqNmVyJeTkoq+1m9jCPVG9S2C06dD71LzBxRP8sjP1s6
 L72Ac1v2ELA42La+1QRkN7eAgcov9U3Rkn5HnoHRO8sEeB/NqWHCyYvC3nZugtvvrxHfFqejFKR
 2Zp1rGCOcd0rSNttusTsdGaw4d/O5CuOiAQa5BnaR+MAhXJSx5Qhcx3RkWkNW48qHIB86PrqOLn
 PuYp8Ic14ycRhPjfglJ5qdLzTlZY4vKt1vD4CIvAZ/B0/lB2oeZd/sqdbkuAPSSF7AAV3s/D3tX
 0HfJpr4bf+WgBsDn/0FOwz6aIgrlZ2ywMekplzqBI1skNQqqgQ7F/sx1ga6ECh3OprPjQ+HY5yS
 exrtVb9/OFjJExVPlka8SkMg+mMPYVbkSKo/qlcJ6AogETmP/EQLReY5J1FVwqQb5m8lKCQzZRD
 ImrpCQ8sXEy/7JyT44Q==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b084bc1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=SRrdq9N9AAAA:8 a=yvlZ-AJO8mc1iqAQddwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260059

On 11/26/2026 7:08 PM, Jiangtian Feng wrote:
> When global boost is enabled from the disabled state, a failure after
> one or more policies have been updated successfully currently restores
> the global flag to 0 without rolling back those policies. This leaves
> them locally enabled, with their boost-related driver/QoS updates
> retained, while the global flag rejects per-policy sysfs writes.
> 
> Keep the global flag enabled if at least one policy_set_boost() call
> succeeded, while preserving the existing error return path. Global
> boost = 1 grants permission to boost; it does not require every policy
> to have boost enabled. The mixed per-policy state is therefore valid

Yeah, it is a real issue, global boost "only means a permission to use
the frequency boost mechanism" (cpufreq.rst), and "per-policy boost can
then be enabled or disabled individually" while "disabling global boost
makes the per-policy boost interface illegal" (commit 218a06a79d9a).

> and individual policies remain accessible through per-policy sysfs.
> 
> Retain global-state restoration for enable failures without a
> successful policy update, same-state resynchronization failures, and
> disable failures. Do not roll back earlier policy updates.
> 
> Qoder, an AI coding assistant, helped analyze the issue, develop the fix
> and state matrix, and draft this description.
> 
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
> ---
> 
> Validation:
> - mainline ARM64 defconfig build of the complete Image
> - checkpatch.pl
> - eight-case old-global/request/success state matrix
> - independent static control-flow and locking review
> 
> NOT_RUN:
> - runtime fault injection or reproduction with multiple policies
> - global/local concurrency, hotplug, lockdep or KCSAN testing
> - CPPC, SW frequency-table, ACPI or AMD hardware frequency/QoS testing
> 
>   drivers/cpufreq/cpufreq.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4332cb114070..f23b64c2e620 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2887,6 +2887,7 @@ static int cpufreq_boost_trigger_state(int state)
>   	struct cpufreq_policy *policy;
>   	unsigned long flags;
>   	bool boost_enabled;
> +	bool policy_success = false;
>   	int ret = -EOPNOTSUPP;
>   
>   	guard(mutex)(&cpufreq_boost_mutex);
> @@ -2911,6 +2912,8 @@ static int cpufreq_boost_trigger_state(int state)
>   		ret = policy_set_boost(policy, state);
>   		if (unlikely(ret))
>   			break;
> +
> +		policy_success = true;
>   	}
>   
>   	cpus_read_unlock();
> @@ -2918,10 +2921,15 @@ static int cpufreq_boost_trigger_state(int state)
>   	if (likely(!ret))
>   		return 0;
>   
> +	/* Keep partial enable usable and repairable through local sysfs. */
> +	if (state && !boost_enabled && policy_success)
> +		goto out_err;

This function uses guard(), and cleanup.h says "usage of "goto" and
cleanup helpers is never mixed in the same function".

Besides, the !boost_enabled check is redundant, right? so maybe:

       if (!state || !policy_success) {
               write_lock_irqsave(&cpufreq_driver_lock, flags);
               cpufreq_driver->boost_enabled = boost_enabled;
               write_unlock_irqrestore(&cpufreq_driver_lock, flags);
       }


> +
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
>   	cpufreq_driver->boost_enabled = boost_enabled;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
> +out_err:
>   	pr_err("%s: Cannot %s BOOST\n",
>   	       __func__, str_enable_disable(state));
>   

Separately, the disable side can end up in a similar state: if global
boost is already 0 and a resync write of 0 fails on some policy, that
policy stays boosted under global boost = 0.  That's outside the scope
of this patch, though.


-- 
Thx and BRs,
Zhongqiu Han
