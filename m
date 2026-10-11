Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F13BFAD4
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728209; cv=none; b=Ppmgf6+B+Rygy1Lfb/G+phavMefi4vpurzbMcodha6TMDAnc8ubWnM0/17PCNxZwju2N2c/mK0EVvVao5/jsSKFldixqG5bqrc4ZpqTyDziMPDT8S8buojYTSXitIBxTOAfz7Jxc6cY4X7QeD8jJwyuPIMoo+xXnVfvJ1nFck5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728209; c=relaxed/simple;
	bh=W7FZNSRbWo6VxKmxkMfSfrz+K/NtHoDLIImLCIZ7IhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZzMUd9FOPXqpsUo4IE6m6horPM6PEBL8fuP+pYbw7/fCH2HRQvAde7WyRRup9TK5cGlukE/Ga6GabB/GMPMambLPL79f5zI4ulSA7iie4jCvMdFa+f1FDMQEsk9Rw6oScU/2dkPkiPkUCLdVbRW9VoopUc5kO4mqRCAEmwww2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDsrGf4C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvoNuLmt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDsrGf4C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvoNuLmt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B85H8O1512952
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 14:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2N1+nLpksf0tEB2SxFBndBmGIzIOlWOd60HbVRm1fA=; b=lDsrGf4CP7iNuKoJ
	eqvpShDixlPtH7LO9lT4tgDs70zd+gIiEMKDQpF9GIjAW6n23e/L2m0fijRff/1y
	Lb2vMCz/Yt9y/yzQQbOoaOILdChgwudSBcfAfQVjoa0srSWjE3iUJ0OY0ebEpda6
	dK/g9Kb2I72jGbxfUjCsgOoV0hVq4oQI/Yc4l9IjbNICyXciKBo/b8aijQTeEj2x
	816xxFTDazdWJjciaBvUxPf3BIKcL49cZSMoPo/CSLfQ2ypSYfQoDhZVK00owE8+
	B9kn+cbgQXUdhH2/uEKFjtTiXah1UJJhL7TRFBDJVSNbSkQHU8xh3xuoB/KP8dES
	1RMN1w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjk1ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 14:16:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so1812026b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791728206; x=1792333006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2N1+nLpksf0tEB2SxFBndBmGIzIOlWOd60HbVRm1fA=;
        b=dvoNuLmt+6X7kZWSo5M8MNBHMRgYTEOkTqHUzoyOYJxyy73hn19mEb6r4JUZtGDPEy
         Y0yHq1IP6rak7i0ccLV3siT6EgMdFFMtdGXram0ceM4J02daYuf4Q/kq4Vec7cyo3+c+
         QEcQjbz7uUrFMfBvEWNhXjBho/esPFsD5ICSAJEreilM/4el+N32LxKN+FbJFGZ2VHxp
         MOc7HzK3+Ptm/rFOkOFslLBDY49ZxdVBk8nRx2y9DiY28QjWruNbOA0l6vGiy5WVeWhQ
         8jzvSAJcxnOTF3Vj3n2siOP21T4P8GjPGqM3CMPo5Nny560AqG/BC4Mc4S1DHWSI0dUr
         VhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728206; x=1792333006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2N1+nLpksf0tEB2SxFBndBmGIzIOlWOd60HbVRm1fA=;
        b=K9tYnarClLvAlbQkfZrwJER3vSz00498J1a9N929VDEa4h7qa28F2LJIuT9B45sRt+
         gIC2ThKn1q01/CHYrj+If0ybpO7Pt+i0qyfFXvsS4hEyFIT9yAxmI/Cv9zDkLBbbZZQR
         JZ4/aUTr+St+mJDtCU3/yvih+UoXzCn1fpS9IYyWHS9d0qg54X45mSjdNrpp20RXto27
         DEtUrtETPIHREHA0B26kOjH+hZddfiTbYuA2EuJwq7jWCy690uNrmt4NuWEichXTrFkV
         k7ula8OScnvcTtUJdFXj4XlM46Pm7pxzFloGoF5Hg/vLrn8O2R0Y+T+0mkhBuqtJbbt8
         VWgg==
X-Forwarded-Encrypted: i=1; AKwUvBy02hSngv5Bo2ZLdD7gFE7nJlWV9hW5j1eBNqBLVThwQw3wCzkWAKMIBaULKdd+YM+6Ko/QFRwJmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKyU5fLECnZeCMew64RRqhjo8KXZoUk3q0uhgQP+mRZhSWhxQe
	zjfsvnIIMoF9myag6tNDPXgIJIrRIHbLGLa6AEDSAgcvcbTgxg7X50gcCjUBM/qkNgcOGs7guGl
	y1I7KRlA3AHlOXfQ4Dw48meE/YyMsyFFtAIr/HX4Qmh8b4fQZVvz5s4UnipWdPA==
X-Gm-Gg: AYBFou3cfBmMwQYF3jcou7odpKBtP5jV/daR7FUH9JsAEiIbAxCnzq6YwkyV3snEK6F
	YmaeiShL0f5B1gbqwS+2WIwP8Mi/9KesTefLWutQFWBH4N2dc/GGo9eJkQe8bIzUU3vv7voFNUN
	SuiacENWyVy0R9H/vjloJcgcmnXtQcJIhdNKF4Brwg7/HrbI6Ys6gCAZzC61NLur9QKTqLNB8X7
	B+W0jSO5L1jdn8OToKya9xJP46KHPhqISM2ipI/cPd8UMY0hiPTzfNa8cuXyBgnrW9AWqS+nPXF
	YQr1W9s/P4t3hTxIkiErZPMErleKORWJ9k3p6jcFKFOnSAxXIcZlvJATKJsM00CjT/nDzpXoaDZ
	aQWhPg96saxScExZ9IPpSUjodZdSc47svLWUOQ0D9jME6vzX1Dy23ohzJtPAykxo=
X-Received: by 2002:a05:6a00:4209:b0:891:6d3e:3999 with SMTP id d2e1a72fcca58-897c701082bmr5887951b3a.9.1791728205951;
        Sun, 11 Oct 2026 07:16:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:4209:b0:891:6d3e:3999 with SMTP id d2e1a72fcca58-897c701082bmr5887934b3a.9.1791728205389;
        Sun, 11 Oct 2026 07:16:45 -0700 (PDT)
Received: from ?IPV6:240e:400:e20:12c6:a578:1ef6:8335:64b6? ([240e:400:e20:12c6:a578:1ef6:8335:64b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-897fb87c459sm2827960b3a.50.2026.10.11.07.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 07:16:44 -0700 (PDT)
Message-ID: <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 22:16:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arch_topology: seed capacity_freq_ref with highest
 available frequency
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>, zhongqiu.han@oss.qualcomm.com
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-1-68de169498c7@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260929-schedutil-boost-frequency-handling-v3-1-68de169498c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1NiBTYWx0ZWRfX2NG0dBduIIl/
 dxBBQLa7Es3mXHa0omff/1zl+MPqsmDLAkN4qnHpRo+3mHvyjbPe5u5Y9FYIiHa6gVCClo/0gKQ
 ZcROmccWbdvgf0p6LUI/I+A5XuALrAG+3muntv6ClLrPdzmqez1iaJS96u1+zC6dPhnwprCFXGx
 khDp/0R9A4ggmic8PS9c/GbVkPyOgvzbPugFYfnX32oEEcf2fvYOyQ/Iv6QI8fNKL/kG9rz9xXp
 8WvxFanxfGL8HhqZ4MnKBF8XJegW/KaRmDc6IqcO1SrPDcgHyUs86PD93bVv4OW7JFiAtuE7Mjm
 Diz8tOVDlZLcVqjNVZbYUjG0KpxUHytNzERMKJK9lQAE0B6qJxQZB/V17kWhesNXnCIBq9vDQMt
 FRECTSBLkBSfJPjQ9ofsYu+A7gt7IYV/66Umisx0eJGi65Cry7gZ+2030JmCOhxDsPVI//xI7Rh
 y0RDgxXgoYODTzy8+0w==
X-Proofpoint-ORIG-GUID: BNkLUWM4yyczRwYSxnDUg4h6zoml5Rzk
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acb9a4e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=mPL7UwSLHth3KX_UYEUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BNkLUWM4yyczRwYSxnDUg4h6zoml5Rzk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1NiBTYWx0ZWRfX5MFFufpflbmp
 h1tmONRzFxoxwWQ+1kl7zPIWZvKrxxVMzRx5oCJLQxblwRjTe5WD2BUIuc63pOSjkVbVN9PJ0ki
 FvhqF5yXoh7tK7Vaa9hStcUSDz7muuM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110056

On 9/29/2026 7:38 PM, Ananthu C V wrote:
> capacity_freq_ref, the per-CPU frequency-invariance reference used by
> schedutil, is seeded from policy->cpuinfo.max_freq at policy creation.
> If boost isn't enabled yet at boot, max_freq reflects only the
> non-boost ceiling, so capacity_freq_ref never learns about boost
> frequencies for the policy's lifetime. Enabling boost later raises
> policy->max, but capacity_freq_ref stays stale, leaving schedutil
> unable to scale utilization or target a frequency above the non-boost
> maximum.
> 
> Seed capacity_freq_ref with the highest available frequency regardless
> of whether boost is enabled. Runtime enforcement, still handled by
> policy->max, is unaffected.
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---
>   drivers/base/arch_topology.c |  3 ++-
>   include/linux/cpufreq.h      | 13 +++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 8c5e47c28d9a..92966be712d5 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>   	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>   
>   	for_each_cpu(cpu, policy->related_cpus) {
> -		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
> +		per_cpu(capacity_freq_ref, cpu) = max(policy->cpuinfo.max_freq,
> +						      cpufreq_frequency_table_max(policy));
>   		freq_inv_set_max_ratio(cpu,
>   				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
>   	}
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35ce665edfd8..f048c925fd98 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1107,6 +1107,19 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>   	return idx;
>   }
>   
> +static inline unsigned int cpufreq_frequency_table_max(struct cpufreq_policy *policy)
> +{
> +	int idx;
> +
> +	if (!policy->freq_table)
> +		return policy->cpuinfo.max_freq;
> +
> +	idx = cpufreq_frequency_table_target(policy, UINT_MAX, 0, UINT_MAX,
> +					 CPUFREQ_RELATION_H);
> +
> +	return policy->freq_table[idx].frequency;
> +}
> +

The current implementation looks correct and works well. That said, we
might be able to optimize it with a simpler implementation as shown
below:

+/**
+ * cpufreq_frequency_table_max - Get the highest frequency in a 
policy's table
+ * @policy: the &struct cpufreq_policy to inspect
+ *
+ * Boost entries (%CPUFREQ_BOOST_FREQ) are taken into account regardless of
+ * whether or not boost is currently enabled.
+ *
+ * Return: the highest valid frequency in @policy->freq_table, or 0 if 
there
+ * is no frequency table.
+ */
+static inline unsigned int
+cpufreq_frequency_table_max(const struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int max_freq = 0;
+
+	if (!policy->freq_table)
+		return 0;
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table)
+		max_freq = max(max_freq, pos->frequency);
+
+	return max_freq;
+}
+


>   static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
>   {
>   	struct cpufreq_frequency_table *pos;
> 


Besides, could you comment patch v2 Dietmar's comments? It seems that 
patch 1/2 exposes a pre-existing ordering issue. On DT systems, 
cpu_scale is normalized only from the CPUFREQ_CREATE_POLICY notification 
of the last policy, so the cpufreq pressure of every other policy is 
computed in cpufreq_init_policy() from the raw, not yet normalized, 
capacity, and stays cached until the next cpufreq_set_policy() for that 
policy. So far this was harmless because capacity_freq_ref == 
policy->max at boot, so the pressure was 0 regardless of the capacity. 
With 1/2, capacity_freq_ref covers the boost frequencies while boost is 
disabled at boot, so policy->max < capacity_freq_ref becomes the common 
case and the stale value becomes visible (102 vs 79 on Juno R0, as 
reported by Dietmar). Perhaps the limits of all policies could be 
refreshed once from parsing_done_workfn(), after the capacities have 
been normalized?

--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -454,9 +454,27 @@ core_initcall(register_cpufreq_notifier);

  static void parsing_done_workfn(struct work_struct *work)
  {
+	int cpu;
+
  	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
  					 CPUFREQ_POLICY_NOTIFIER);
  	free_cpumask_var(cpus_to_visit);
+
+	/*
+	 * The cpufreq pressure of all policies but the last one has been
+	 * computed before topology_normalize_cpu_scale(), so refresh it now
+	 * that cpu_scale is final.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
+			cpufreq_cpu_get(cpu);
+
+		if (!policy || cpu != policy->cpu)
+			continue;
+
+		guard(cpufreq_policy_write)(policy);
+		refresh_frequency_limits(policy);
+	}



-- 
Thx and BRs,
Zhongqiu Han
