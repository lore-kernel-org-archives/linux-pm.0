Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00F3E3D93
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452854; cv=none; b=BpF5SO0YonPfnDHK3K8CMMNfByTn1rQIcOFM6nI49EwE0ocSsChgLixEsO8J08kxAXtKwjYa/3zxkzoOXTgfA6WIo7FhuaFgVheTeg60GWovSyiLkup3/i+ug6pYXQ/RGW0zL/lIUPVz33tqkTzW5E26hY2PwEk8PAhvb3/N0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452854; c=relaxed/simple;
	bh=vPGIzMiyO5TeElcR4phkh0O4Z3y4C+7N0wLVWgHYFZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CySCv+f66fwbmemkmzq+4cWmVSGX5/CXesoZeA/HIAO7nhHedwEwsgdsN3nLZFnWDFgybu33j8lguLBzeYFL4foSOje/BJNfME1Nd/cqawJxWnCd0g+vKnb4z4ygfSGRCFN+frybusmn8/3G/3E39uiMviYituZl0Hcm5/6Ru0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hazzhJ4/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rvoevsrs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hazzhJ4/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rvoevsrs"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFHFaa2162050
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 15:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JJbISd+NYRXiouLIvxTEhljHuABzyURDFTMQeKuO6e0=; b=hazzhJ4/WcyRYWXM
	X0WTj0cuikqgggof07qbKtXmlB5xRBQ7g5pcoxOMdz4P/do9TK1qF3OAB3ty7Osu
	4rmoOaVwtoxWktm0pwI0V6vCTc39XSml0d1L184pV7vbbcyRBYkDKaRHAuUQKGLd
	f/sYS61TVXURYhMt/A+KN5a5kUjMVAoyz4X9ccDAjqyGygPIR0Tbb3IxSD9MMMeh
	WvvPd3Nngq+lFfuXyUqOT1VQreyKB0pzG+qmTRZkO7n0FNte0iRJj3IClck/SqvK
	GYfvrrATvcq09P6wX0y2lXzYjSIRdv5MuUWCjmL10BKZ+jSU5K4If9/lqMczuXI7
	eYSz2Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489wjd5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 15:34:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0b0aae381so18017555ad.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774452850; x=1775057650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJbISd+NYRXiouLIvxTEhljHuABzyURDFTMQeKuO6e0=;
        b=RvoevsrsVJ5bEkLg4N2lHlbe0NcXQVvM2yzeK+bEtz7spK82qShPL+5Ky8TH8TiGxQ
         +efVxgJPrmmSePhulfOwZT4/1oJwjhMuN2Pi6kQeQVUT4xxQRMEkzjcihV54WP76jnJd
         iZ1dlmFtJmqX9pAJRfCd63AKqaQZmcSFcei07T3e6Ih7Igcp6eRaZKj3qiPml4zqT4kP
         lyVim2Z+qIDNmQmGA2lmDqnkwAuN3Rhx5qQshYCJQKCrwE753qof4AUFmxXpkwr/HruP
         RnBRHrWJCxEy0tKRCC0p1aRE/+QRZbtY1Bz5ClYwdq4w10HYhizj1LwSJUgiOv3mg8KQ
         38PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452850; x=1775057650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJbISd+NYRXiouLIvxTEhljHuABzyURDFTMQeKuO6e0=;
        b=oc6NlZKTyINppo4kVtOrBF+a2tsdnPLBpYKFsTTqtzvsaSXEcNHXv6g17HmXndUOo2
         CghQUm4FcSjN55FPFLC2i8kkYfVZCxb/mUZu9S2ZHgChrP6MMyWfNvX1uAr/uFYYErCy
         a5Tq/rQ1w/EEE2VY9D9lDd2sZHfPbZi65gZ4ghB6AIdljpZiTZK6e5NcPhmBi2ytMfog
         anQin2cMow6pyLYbcFoV2Maz3zqe4nUOcxItc7r/mVLTBCJBRXS4bRMU1OjE9Eu+GCC4
         NTQXid3SPid+OgCeh8feIbvq1ev6elt8tyNGdwrDPgktWr9dCnz+hsdtAQjkA+2TtcvM
         NFgg==
X-Forwarded-Encrypted: i=1; AJvYcCXoBCcId6rIWfVPkszuRDGvj8YRDFAnmC3n8l7TixeoQaqKgvJtSZIfpObCrqYkLKbwRft12SA+1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqig1FZvrhesu0nw26P4JseT35eGGtTtxN+khcjOqbKNDlMlI
	fUbP8q5birGYxh+o/gZ/Wo75bAuQ5QKlCHlA+4r+JNK4g0f4DWILp3KcSv9nxmgeNqXlwQpxTKd
	iZmIMbKg9xs119fGALiTOj1FHAdE/SJX7aK+0o7xf7KHIYzxUnM8KK3nHg0QW1A==
X-Gm-Gg: ATEYQzyHNWXyid4FNPkzrRGDz5tDkz8ZbbTufimq6rU2NN7sx5XGTlZs6+liYmjpa87
	KA/ow/CZ6XqNbmv66Onk192EYiSb8KyIW2SKIft4c52Nf0lha4AOf5wRJI2B46xajkLOMFfs1m8
	gT2eHwjFSZVbHToO5M25nS9TPMee5ElOchypn+5OU3lhEXNxlqVJJ8krYbJ5DppH5ED5VEqH/Fu
	47a9K4fZWE6colxigSEaBTOovW4+TaMdQSeVfH9BMyzkuvrLqC/sI1vM+boo5q1f8Bv6huVameR
	FmaWElszi21ulZwywlssXDepL4BTxv7o0w3IoAqLFCAuQuUlIZha50a9eo+m2EdlZ9uQ80K9MsY
	8utovwOfH496aGBY9O15iilha6YsBG0FpmAfJnV+rY7bKuQ/BzAmI
X-Received: by 2002:a17:903:943:b0:2ae:4445:f397 with SMTP id d9443c01a7336-2b0b09e0913mr45260765ad.16.1774452850480;
        Wed, 25 Mar 2026 08:34:10 -0700 (PDT)
X-Received: by 2002:a17:903:943:b0:2ae:4445:f397 with SMTP id d9443c01a7336-2b0b09e0913mr45260405ad.16.1774452849948;
        Wed, 25 Mar 2026 08:34:09 -0700 (PDT)
Received: from [192.168.29.179] ([49.43.224.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e4e4sm1852915ad.38.2026.03.25.08.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:34:09 -0700 (PDT)
Message-ID: <fb66b223-329d-44f4-b0a8-0a6b321f9dea@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 21:04:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <CAPDyKFqJX3rN0GY1j3-RDXGc0jCcMTG=OmWzi9+2y7CXJOvY3A@mail.gmail.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAPDyKFqJX3rN0GY1j3-RDXGc0jCcMTG=OmWzi9+2y7CXJOvY3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FaH3QT-1Z3WeJLT2cLjiValQtM7bZTQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExMiBTYWx0ZWRfX5Tlr+NGw+vac
 rUNhc7rnHsTvvjuM7GygyoQwaKCaGSaeEv4qxyDx8e//zXJsMVbt1fq10FSGs2YMAPvWo8Cwog1
 STzYKusYYd6j/O6xb0kdTqlj+OGzPdxo4TYVc41Xh/EvgAj4U8zBt+j9t6U4eFy5WzJBi0zeYMM
 JHaRMiGE2u/me/IZIq9dbUKe35Vqf2ppt/XaYySJx+df5uQ1FmTjKTclkR8E+Qu3DzsccjFXxTK
 oii2P/Bm4JvdgRk5+/w1GpCxykXHHFczJc3NppGSER689U5j0Cgcf67l1zlXua8hMdPDv1Oi+20
 I5KXaToIp5AP9zBv8a+zi19FtHo7pmhfSvnGQ2uJflwfTIySISbQdSOffoBwCvTq/B86Xbl+nQQ
 MYUHzZHLqSfTckd5N16avH8Y2iQdOkVzQUNZYJnutR2q+gd8TEoC7W/q81x4d8kHDTxt0SFPAi9
 pFh6w/0+zPFGlhfKX3A==
X-Authority-Analysis: v=2.4 cv=e/gLiKp/ c=1 sm=1 tr=0 ts=69c40073 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j/PqwQOCDgRQPIT2BnD5zw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=okY-DNlmIvmWAd7kz_EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FaH3QT-1Z3WeJLT2cLjiValQtM7bZTQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250112



On 3/24/2026 9:16 PM, Ulf Hansson wrote:
> On Mon, 16 Mar 2026 at 08:38, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>>
>> CPU can get IPI interrupt from another CPU while it is executing
>> cpuidle_select() or about to execute same. The selection do not account
>> for pending interrupts and may continue to enter selected idle state only
>> to exit immediately.
>>
>> Example trace collected when there is cross CPU IPI.
>>
>>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>  [007] 154.892211: ipi_entry: (Function call interrupts)
>>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>  [007] 154.892214: ipi_exit: (Function call interrupts)
>>
>> This impacts performance and the above count increments.
>>
>> commit ccde6525183c ("smp: Introduce a helper function to check for pending
>> IPIs") already introduced a helper function to check the pending IPIs and
>> it is used in pmdomain governor to deny the cluster level idle state when
>> there is a pending IPI on any of cluster CPUs.
>>
>> This however does not stop CPU to enter CPU level idle state. Make use of
>> same at CPUidle to deny the idle entry when there is already IPI pending.
>>
>> With change observing glmark2 [1] off screen scores improving in the range
>> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
>> clusters each with 4 CPUs.
>>
>> [1] https://github.com/glmark2/glmark2
>>
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
>>  drivers/cpuidle/cpuidle.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>         ktime_t time_start, time_end;
>>
>> +       if (cpus_peek_for_pending_ipi(drv->cpumask))
>> +               return -EBUSY;
> 
> As other reviews already pointed out, this must be called only for the
> current CPU.

Yes, addressing in v2.

> 
> That said, did you play with bailing out just before the call to the
> target_state->enter()? It would be interesting to know if that changes
> the "stats" somehow.

Yes, i did play moving this and "stats" do change with differences in next idle state selection.

below is high level scenario happening when the IPI deny change is placed inside target_state->enter()
or any place which will update the rejected count.

Using a menu governor,

 entered_state = target_state->enter(dev, drv, index);

 - entered_state will be negative error when IPI is pending.

 - This makes rejected count increment (which is okay) but it also makes dev->last_residency_ns = 0;

 - For next idle entry, menu governor will log this last interval as failed,
   via menu_select() -> menu_update_intervals(data, UINT_MAX);
   this is because menu_reflect() is not invoked for failed entry.

 - This makes 1 of last 8 intervals invalid, which don't get accounted from get_typical_interval(),
   hence divisor value in this API is never reaching 8, the goto again, loop inside get_typical_interval()
   will get aborted "faster". This interval logging have good influence on next 8 idle entries until
   it will get replaced with meaningful value.

 - In ideal case get_typical_interval() would go from divisor value reaching 8, 7 and then 6 and once its down to 6,
   it gets aborted if not predicted yet, so maximum 3 trials, but with any interval invalid
   it finishes faster, often without prediction.

 - sometimes IPI bailouts may happen frequently, in such cases we have 3 to 4 intervals as invalid in history,
   effectively making get_typical_interval() not predicting since divisor value in first loop would be less than 6.

 - Not predicting via get_typical_interval() can make deeper idle selection more often by only going with
   adjusted sleep lengths.

In summary, 

The benefits seen by aborting the idle entry with IPI pending getting nullified when it is logged
as "rejected" due to next idle entries can go deeper.

If we ignore setting dev->last_residency_ns = 0 for rejected cases or make menu_select() ignore the
last rejected iteration to update in intervals history, this would improve the chances of get_typical_interval()
to predict a meaningful sleep length (in a separate change).

For this change, IMO its better to bail out early without logging, since CPU did not make entry to idle driver yet.

Thanks,
Maulik

> 
>> +
>>         instrumentation_begin();
>>
>>         /*
>>
>> ---
>> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
>> change-id: 20260316-cpuidle_ipi-4c64036f9a48
>>
>> Best regards,
>> --
>> Maulik Shah <maulik.shah@oss.qualcomm.com>
>>
> 
> Kind regards
> Uffe

