Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AD306B37
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387977; cv=none; b=hT1jdXw7dPGqMw4fd77q27aLboB9SX9z0CV2Xnsyx74vXfUmk5q0S4KO4o19AkfU7eL3npcO3ifTr2Egof7bq2Y7l18j+zxYogMp1sb1pkVUXpU9mJpfoRwGKQP0xSJMEhT3W8m+RGlwDp7MgQaptRa1YJQPI9zuyqKtlaSHv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387977; c=relaxed/simple;
	bh=DwsNzm/8umZoU2yzq6nEGCvDC6V/+GpxI2gZHBpjzG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXY7HH7uhIigGfPfvAOAPeMvoUeCy5uH+mF67JaAONsfCOjDB6feMMRipD/p8Bd1jtRlwyepx2Ujek01/SDHs1x40/P9Uk1GraC3vDnONkJZTDR7/WN2zLt1y34hTjjLwnJ6/Cj27ViDPW7f0FmYxqhMHWGBbzZRO6GCPqhfLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zp7VlQHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpS34Eo0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zp7VlQHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpS34Eo0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6oShw793119
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MKXWuhbjCVKuOeOL9GK+KdDaxwdFjNW9tU6NIKF7NXM=; b=Zp7VlQHxHBa0ac4l
	PIsS6mdr95epoENf8VTt8BFDN+CWdZwOr7X487eCZfs/UmYuLUeT1hbZuwGQz1X1
	PN/ONCWXnKlUWfzCd7aabpFuPdrpRB7FUWxdUV14pcoR+VnnL3zVeAGJ3EvoS2ew
	mnhzlql1YSIpsQmj6goTdTXRQ1EdLZ+AY40PCz5Lx98k7XTXnRogvI3pV/RONVSr
	6jvRxWCkQ0+pnu5bPCGHAKydb2Qdz06dXq/GaHj+4pv1mI30PbRTvezI8QhD9ifw
	x2DfR7a+EQaNm5/hrratcbvPNSMOlI1mWncvL6XdpVYoRhApEmy9LeUvkodxx9Pf
	yod9Eg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvdnt06fp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:46:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aecd4f7ca1so5703835ad.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773387974; x=1773992774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKXWuhbjCVKuOeOL9GK+KdDaxwdFjNW9tU6NIKF7NXM=;
        b=BpS34Eo01hd+bCqRo0FS6oT8u9uEHAq4K8iSWCKtLzuWcgBdSIjpqtWDkTg3dYw1+m
         kG5QCgJ5qsZ9ThSRq2ftp2vB7M8DkIK04wAn2fqkAa7VLOpFNgJ4Xs4hhqBwgVdcNE1t
         B6cd33vA3QFCMc55xuA0+9n6XAkFjvjdbwc3BeIK5LSLswJceiICOFyiCtCoKKIEexrx
         SkVwMiJrkbVPISiDIUG/VehMrPXlT7I2EcOECYtE+19ZhiUeIyuJnMJg+iF45LOp92I2
         shiEg8HlwlG2C+WpWpMtDNeLQZ0h082FEEnCa5e2v7KG8BKwM0aT4HlRIymQonCnra4F
         gzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773387974; x=1773992774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKXWuhbjCVKuOeOL9GK+KdDaxwdFjNW9tU6NIKF7NXM=;
        b=PFOsEBBlKuGcHhHK8OX/WDu3XMEDlDFfJow/aA1b8RWuamD6MXzmWOlV/HisdYyrnT
         86dF3ki/QBQanh2Pnuci0SID7y1GQGBX+2mCme7JMORVV+0Sh8o1914S7LsxbgFa4+Fh
         KCoMhyqn1f5ReleTQmjztWuQXFCjXz+5cKDT2qc/NtLlaFdbnuP+qTLWm15oA53kqH5V
         4xJKFiLyyA+UPPn1fGA5Hez9/Er1fNDp7srzTLgLgzoCXgY/h10n87m8aDNyv8KdZXS+
         me1FBbtHovYaDkrHwKQt7W6FLBSwMiOM4SsdAMNFXWQTYG+hD/11g0Rmylp9IkGSRQSs
         4EmA==
X-Forwarded-Encrypted: i=1; AJvYcCWQoBzE/L6lTE0wbTaa53TFUILO1IoDmTsXIFotyozbQs6vn0SmphWu8VHJpTwO/PZ39Fu4NLVJDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvinYiMsGKf/dbjh7eTD3D28nKmQBxjpVwya1emoZ0HdGerMlj
	stpsIqrwo1TWSvl/9KVR2dT6xChy7tnnGyyHepMsxMuFzUcbgXKG77KW9mg43FnsRWC7XZSzChY
	ihygFxCMWMjA5rDJyvigldTBKyW2hrR3RDgPBUXmYzhVct8oF8JxNh5IsRzG7Qdy9OMj20BwW
X-Gm-Gg: ATEYQzzaoOY1EY4pAbYM5ZMnnNxolzjTTqLaa5HgUgHWPvDrBEpEMZZ59ufDxHvCSrz
	XZPrBShG6KVWk4x/olVy2fIpx7QxLdB0vS60hx+GGzFZhd+qT86xGersRi+2GLGK1bK5MQhvOSv
	jDl18BTNkQ8DWLzNCLA8VLExviKqYSCQwvV5OcXlch7ukylxidEIjqjOyd/vDN/GaE34wWaAjx6
	YbW1GmXEsMVAvhBBlZA7y4P4Xk/LyQuZeJ0uMFKcHoQG0Rg/CdfBjQ54XH8NUhCP2jW3DuGIcgg
	eVPhhJl7Hmt+F0C5nLp1XGfMjIQVcC7ccexetHH+kvlzlczFt0THPJ08JIssA2t9PcwyHE5PWug
	UCM2M+6dR/3WSkr1+yurTN2PTkTBhBaTFuDC+R9BL4l9sWNg5tTCbt8DUI3vog/KHCG4fORqFxj
	+GVwljDVpJZCxtzNrs
X-Received: by 2002:a17:902:ebcd:b0:2ae:4d93:ba36 with SMTP id d9443c01a7336-2aeca95946fmr21926085ad.11.1773387973804;
        Fri, 13 Mar 2026 00:46:13 -0700 (PDT)
X-Received: by 2002:a17:902:ebcd:b0:2ae:4d93:ba36 with SMTP id d9443c01a7336-2aeca95946fmr21925815ad.11.1773387973258;
        Fri, 13 Mar 2026 00:46:13 -0700 (PDT)
Received: from [10.133.33.57] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56ca0csm14205345ad.4.2026.03.13.00.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:46:12 -0700 (PDT)
Message-ID: <0a154e14-8446-4b6a-b0c6-4164f942bcf0@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 15:46:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
 <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KZrfcAYD c=1 sm=1 tr=0 ts=69b3c0c6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=kGvhgXOsEy1v87aZk24A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: jN3k8dBlQqONVyOlofByoZgkUR2pVjLI
X-Proofpoint-ORIG-GUID: jN3k8dBlQqONVyOlofByoZgkUR2pVjLI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MCBTYWx0ZWRfX2j4MC9Cyi9TI
 xqVe1bukShbSauev4hIS8tVz5n5Dl3vQ/LlA5YYoBOBBZJZxSmNEQ6SOLyNscvglAfOx7nPNEq/
 gqIpwkGg2CQlule3dqhzfMwWrAcf/Jagc3bg61bMBWCSVpEqTXOVOKXYRDjLu3jkIv1KijdPYI7
 9MZ8vbUVrLSNxvl1rZ/Z/yL/Z/0CdRnyQIarENYLf7IysPQ1G14vzNoNQjZqFFsfSnE2kDveOLp
 /sWgb+r60RTmhY5LC4YPGLJbtRK+PEPKmh6cvjjAG0uaXwLU/FrnBiXaZ7OovH52VhNkVK2awC1
 ETIb06BKSjBlSHKAffkBoaK1IA6cuKzv8CefEgwhQKBHrv8ZbHtxQs5EYIhtjDrWa3lhCKErddN
 EwOT03cLtRaf+OTsREffcmDJVgBu3VzObLWgB0Md+mnHXlHF/4u5vHxQv1X/6KRI9soy11/mIyG
 4ZDCcHZTxfuFJUTnpIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130060

On 3/12/2026 6:27 PM, Viresh Kumar wrote:
> On 10-03-26, 21:17, Zhongqiu Han wrote:
>> Thanks for the patch. The fix looks correct to me for the reported
>> issue. I do have one question though - should we also consider the
>> interaction with commit abb6627910a1 ("cpufreq: conservative: Fix
>> next frequency selection")?
> 
> Thanks for pointing this, I missed this change.
> 
>> However, that change was subsequently reverted by commit abb6627910a1
>> ("cpufreq: conservative: Fix next frequency selection"), which noted
>> that using policy->cur directly broke the algorithm when freq_step is
>> small relative to the distances between available frequencies. In that
>> case, the governor may not be able to stay within a narrow range
>> between two consecutive available frequencies and instead jumps through
>> steps faster than intended.
> 
> Its the opposite I think. The governor stays within a range and never
> goes to a higher or lower frequency. This is how I think this happens:
> - Lets say frequencies are from 1GHz to 2GHz with a gap of 200 MHz.
> - Lets say the frequency is 1 GHz now and the step size is 100 MHz.
> - conservative governor will try to change the freq to 1.1 GHz and end
>    up selecting 1 GHz only (due to CPUFREQ_RELATION_H, highest freq
>    below 1.1 GHz).
> - With my patch, we will keep resetting to 1 GHz (cur freq) and never
>    change freq.
> - With a recorded requested_freq, we will move to 1.1 GHz (actual 1
>    GHz), but a subsequent call will go for 1.2 GHz.
> 
> Here is another idea, once everyone agrees I can send this formally:
> 

Hi Viresh,

Thanks a lot for the detailed explanation — that makes sense. I agree
that my earlier concern was not entirely accurate, and your explanation
clarifies the behavior well.

Overall, this patch looks like a good balance between avoiding stalling
with small freq_step on discrete frequency tables and fixing
requested_freq drift from policy->cur due to out-of-band frequency
changes.

LGTM from my side.


> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index e0e847764511..df01d33993d8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
>          dbs_info->requested_freq = policy->cur;
>   }
> 
> +static void cs_limits(struct cpufreq_policy *policy)
> +{
> +       struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
> +
> +       /*
> +        * The limits have changed, so may have the current frequency. Reset
> +        * requested_freq to avoid any unintended outcomes due to the mismatch.
> +        */
> +       dbs_info->requested_freq = policy->cur;
> +}
> +
>   static struct dbs_governor cs_governor = {
>          .gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
>          .kobj_type = { .default_groups = cs_groups },
> @@ -322,6 +333,7 @@ static struct dbs_governor cs_governor = {
>          .init = cs_init,
>          .exit = cs_exit,
>          .start = cs_start,
> +       .limits = cs_limits,
>   };
> 
>   #define CPU_FREQ_GOV_CONSERVATIVE      (cs_governor.gov)
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 36eb7aee4bcd..acf101878733 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
> 
>   void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>   {
> +       struct dbs_governor *gov = dbs_governor_of(policy);
>          struct policy_dbs_info *policy_dbs;
> 
>          /* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
> @@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>          mutex_lock(&policy_dbs->update_mutex);
>          cpufreq_policy_apply_limits(policy);
>          gov_update_sample_delay(policy_dbs, 0);
> +       if (gov->limits)
> +               gov->limits(policy);
>          mutex_unlock(&policy_dbs->update_mutex);
> 
>   out:
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 168c23fd7fca..1462d59277bd 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -138,6 +138,7 @@ struct dbs_governor {
>          int (*init)(struct dbs_data *dbs_data);
>          void (*exit)(struct dbs_data *dbs_data);
>          void (*start)(struct cpufreq_policy *policy);
> +       void (*limits)(struct cpufreq_policy *policy);
>   };
> 
>   static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
