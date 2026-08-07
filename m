Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA43911BC
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113187; cv=none; b=l0/JVl6Qi8193Wh5/PcxxRvceBDWLNh3yuHj9n/UhNGMvrN/xRi4K0OY2WvvjBRpHoh8su3zTPDmzpC3TJ5jRzw7sodLDH4nsawBBkskYiX9w7rO1WBAt/aV8u7TfB3XZhD993lKwxQiKCuspaJgndGAl1X3pQLtmfqawJtQOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113187; c=relaxed/simple;
	bh=0hzL95W0DgdNg01n0jx3iFRTfBCebY5iM8aNdz1ZD10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz0UZSG52RUAsMFMvweImBOIaj5yqUs29XM3Iz9aYY3Q+fHQjuyBaUsCNFaiDXb9sjB6KDLtmVmwAcwjBMYVFfG2XZMzXWGE/XkEq4igt1eel8Uxv4+aSOp83a1c/NPBhSlUBm/fuHflNqY/z9aykoJlsnoaGrvG7s6cCNYnXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4sUpvH4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=geCx6kMA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4sUpvH4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="geCx6kMA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgM6Q1294638
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 14:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	901SYsPovy4rPKGGIpqTt0xDPadw7CcjZOa24G+R6jA=; b=m4sUpvH4M8auwoYu
	oi2Wbn4CZO84wqDghNRFiCR9TwpFHws1ctR7KfxDJdEHB33Z5XE/Cmm4bm478BCu
	0mdi5CgB7WFCrSKRCmmZP9GHh6y/lzn2S+bIQ/giDWhz8io1IVKJGPt7Bo0Z6CKy
	TdHicwf+4dqRBqghqRoDUXRpJRbuye7mMv+60Gf5T6+EzNNMmW2/LPOoqTljZgkd
	ymp1S8s8hBCbiCOKy4sAhUHOkZZ+t4O2PCv5QEmp+z7ch02CEzHNxUZN+neu4WUu
	qhSPN7zKKRR/yvtIEUfMilz+EohdXoBxpPr1mw/ffZy8YPg9CN3BBGGxtdadlcEn
	Xe72vA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvebq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 14:33:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eac2620cb0so35998676d6.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786113182; x=1786717982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=901SYsPovy4rPKGGIpqTt0xDPadw7CcjZOa24G+R6jA=;
        b=geCx6kMAStffg5uox+A5gO+0KSz0SQrK8d11pVTeI/EN37v6lsx9S1N8CnD5QZysB/
         wSHouaSq11S/wxEQHxWciSZDLbjA63hYEonI1L+/AgjwqvVziGpcRg5nTEtwm58BBPg3
         s6Ebf1gKOxmf5M/524+n97/jMPYsMvxutFsXTXZS50MJYoIHV4SZRxrWrlWqCEAYaFLI
         tmdivgIFYWrkPkufPMxjh8ou+/dSM2/3mhuOtMUfxMp92IqBqrwrxutBKckAo7miqG73
         XLDLMcNVhdEhrdGm4UYcP0yDyX92bjCcsiSPjEjRx4ugrqkgfUrxyqHy7apO5qlULjMp
         mrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113182; x=1786717982;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=901SYsPovy4rPKGGIpqTt0xDPadw7CcjZOa24G+R6jA=;
        b=Roev+/KnMW4WVxhTOdViJ7VWnMTWKP1goc7gy7eCVDUSDl547u/Am7khXQ/Z32M0Hp
         fD6LyP+9Eaoj0a+P8OBaF+vLLAzOxLVdwJ2bzgB54RH5cMyGW+nzHGAv9hu0yMup9vMC
         0CarzR+V66lJeKuYyqRUTzOCdz3SbG7llcwt6ZqZJntjR0npxPCAANUup058OXYYuvsZ
         7AxOvDychHkSeyplUesGMGZnnLRo2DkUdt7pS6FPR3DwsnFWXOJyRSaSkF8zLmm4xBhn
         KIfzE+z+c76373HdBqwLp/a0BPz0veQMeF3cqiMh+rJrqoFPupiaQH71xM/X2LvaiDSu
         eksQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnOKE/adkGD1/IXElCdkOkxIXpDeIRKaARWdE9g/h3a0rUP8KXX/kN1k5m3Pr7KYMy7PcoTGZMXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0Mb+QfO3mxy9e3x938pPzwzuckr/7NF4GKCWHtF/tMzbjFBn
	Q2uCK6NaCuwqCdgj68vuSg0VCCFQtxY1kd5Y5jx1frZtcCmUfOy5lsv2umyojzR8PY4XNDGBbj7
	97mQN7QaUz4SY27yc2w6Ol8h97HAmvkeCpYd7G1kSPGEoSeqrGRjddk/X3XrVUw==
X-Gm-Gg: AR+sD102zdcHhHd/Q04RUEotKYqINkfHENcMY8fU1yg4pAoTAHcxgOq9Yn2FXuaTA3z
	My7pN1jCFJNJwnVyxm/v0RIpeRdTTsbMwTZBJjBCy2c1tVvylnHBXuxCCAjIh8RHqgDA1NGON/s
	Wpj7uJ+DwlfmH89gGvB+wt7U6KaD+Rmj8m/SmvWSHo5QS2dYg2eKv5hDqUXap4dLoxvlUgDFoUp
	Eo+NTObhWZnHbm5IIdpjdmAfOw929jQXGsS7yraMz5uM+uchn0mv136ybzchs8pwFnsutzUF8yt
	F3w2bht526G+WKUYgbaJAKFrJbS6pff0N6w0AuMfmXGEV6cZ7TcOYjNt7W5OE7cGvtwfTN7hPtM
	vvhKLa8Yda7kzL+CwSiHAQ1ALFkchHtAXnchrv+pYX7hGbAObYG4qP/BKPGT+fV29SMDwSg2xTB
	g6xDF3XxBLrngNy1wn/A==
X-Received: by 2002:a05:6214:48f:b0:8f2:5a3e:c619 with SMTP id 6a1803df08f44-90a345985dfmr7374326d6.4.1786113181509;
        Fri, 07 Aug 2026 07:33:01 -0700 (PDT)
X-Received: by 2002:a05:6214:48f:b0:8f2:5a3e:c619 with SMTP id 6a1803df08f44-90a345985dfmr7372926d6.4.1786113180952;
        Fri, 07 Aug 2026 07:33:00 -0700 (PDT)
Received: from [10.190.200.255] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a92fe515sm9918976d6.24.2026.08.07.07.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:33:00 -0700 (PDT)
Message-ID: <c1f9c858-f14a-405e-97ad-0c1748b7c5a1@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 20:02:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/cpufreq: Update schedutil's DVFS request to
 reach the boost frequencies
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
 <CAKfTPtDQ+843t5fgknAMcfkYP_ZLxxYU8D+KJtx8QzMy=qMoCQ@mail.gmail.com>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <CAKfTPtDQ+843t5fgknAMcfkYP_ZLxxYU8D+KJtx8QzMy=qMoCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75ec9e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=gPUjsufZEJvEUY1ZO68A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: oe-hzcwwwoF6xHQrtPLWJ7F5kWivdGck
X-Proofpoint-GUID: oe-hzcwwwoF6xHQrtPLWJ7F5kWivdGck
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNCBTYWx0ZWRfX2wDksFqXKtG1
 jeC4GSqaO9/iEwCaqp7A+VwQSbpjovSU1AcZS0aFR/y00PCqBi+5OiPA1tH/h8UDAVp8TrQF04m
 RZ4FMItnH+4nueuqxgQr5VXpes471HQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNCBTYWx0ZWRfX8vX9YLyfXxA2
 ZGOm8uDOaaizEic8j5QDOoDyjuqEAmbMhzj2eb2/w3M7Svz+t1V08buhzbe/5nNqOgNKDfTeqF4
 5I7M7sU4RMz/z1GRdzWJPx9A93eV2H5bQDX38sKxeXYs9shq1PnJwPSKOMRC34D7st5ruQN+Da1
 dtpqISxbQKQJs+ZXxKMtdAe8ZO8e8gnUQdfj7ElK6VMhY96YSiUURdefOB1uYM5L+O43HVfLGTe
 mHj+6ITmVdPMXdD1NojZ11FNBO8TTXPtrAe8wqB4urCZx+ek8MY62OdLVDyMcy49OBI86VMC18E
 /0ch4QH47ocBiUgdP0aiyvUvSKjfqXVDgl7q5hzNq4B722wR3OtMH8D2R6wNB7A66w8bgF/qz/3
 Rnh4gwaePMjHGZjPboP8Lt3+7SbD26liZCL3tLUvcPAkjcK8JoilEq8fE9SSXw1DR3OGNRv12Vl
 rhUbT7PvuIev2fjhTAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070114


On 8/6/2026 8:39 PM, Vincent Guittot wrote:
> On Thu, 6 Aug 2026 at 06:42, Sibi Sankar <sibi.sankar@oss.qualcomm.com> wrote:
>> capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
>> was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
>> arch_scale_freq_ref() method") as a fixed anchor that does not move at
>> runtime. However, schedutil uses that same fixed anchor as the reference
>> plugged into map_util_freq() which saturates exactly at capacity_freq_ref.
>>
>> As a result, a system with cpufreq boost enabled effectively never runs at
>> boost frequencies under schedutil-governed load. Fix this by plugging in
>> policy-max into the map_util_freq equation, so that the DVFS requests
>> translates to the actual cpufreq driver ceiling.
>>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index a1782755efcc..dcefbeaa0702 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -195,10 +195,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>                                    unsigned long util, unsigned long max)
>>   {
>>          struct cpufreq_policy *policy = sg_policy->policy;
>> -       unsigned int freq;
>> +       unsigned int freq, ref;
>>
>> -       freq = get_capacity_ref_freq(policy);
>> -       freq = map_util_freq(util, freq, max);
>> +       ref = get_capacity_ref_freq(policy);
>> +
>> +       /*
>> +        * That fixed anchor governs how utilization is interpreted, but
>> +        * the DVFS request is free to target the current policy ceiling.
>> +        * Using ref alone would saturate the util->freq map at ref so
>> +        * use policy->max to reach boost frequencies.
>> +        */
>> +       freq = map_util_freq(util, max(ref, READ_ONCE(policy->max)), max);
> But this is wrong because arch_scale_freq_ref is the freq that has
> been used when setting the capacity of the cpu and is there to make
> sure that the translation between freq <-> capacity is correct and
> consistent whatever happens later on the freq table of cpufreq. This
> ensures that utilization tracking remains correct vs other CPUS and
> prevents or minimizes utilization oscillation, which triggers other
> problems
>
> Either we enable the utilization value to go above CPU's capacity when
> we transmit it to cpufreq (and above SCHED_CAPACITY_SCALE which could
> trigger a number of problem while computing pelt)
> Or, you take into account the boost freq when setting cpu's capacity
> and associated capacity_freq_ref at boot even if not enabled. With
> cpufreq pressure feature and the policy->max (not  cpuinfo_max_freq)
> correctly updated with a freq_qos_update_request when boost is
> enabled/disabled, the scheduler and pelt should handle that correctly
> as we normaly take into account cpufreq_pressure everywhere in
> scheduler.

Thanks for your inputs! Ack, will try out the latter since it appears to 
be the
right way to address this.

>
>>          if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>>                  return sg_policy->next_freq;
>> --
>> 2.34.1
>>
