Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5554257423
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652910; cv=none; b=Qc9hH8efpgy9YztRstLHo7ypdvs97VYpcPEG5luEtTmURQ3MDTvsjWZOeJMUDcwfe/QyItgIOsmzcf7f1YgD5n9O/RuJGn5dfJdYBtg9s4JkEiyCR5B4ldAjoLE5pOxNIdv7isRPb3ixQa8zfoTKSr/1kFczYX2xuLELDqwK3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652910; c=relaxed/simple;
	bh=9z3oRLftzUJus6CMVW12jYlu2leblywvUYLJyDLPZZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgSeuXpV90l5hwbxRx5DtOytMbslHckIx/pds2orCWUugY1lbWY5+Ps8SfKW1wad0aLT5Vs1UMI3uybDxD6MF2rS3wBwhuBbZb3J4ORYSTnpRfox/SEI3JAjUvJb/xz5glTl4CqnuVvXHRVz1FKXH29tQUfbNaIbu+iK4spy3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TsW5HJEr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZpxGSl2r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TsW5HJEr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZpxGSl2r"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64dRs662960
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gpp7Zv2c6z1/dHKmZJlMe1c5HvJaIjPxwv9MvslkwGY=; b=TsW5HJErpcA4oD9b
	ziYYt+s4OjmlWs70ggl9paIgioWxH0yrajEpqEEar/NUNGZY5M+zH5mEy2OfUWCl
	r3z1F86AW34N3LiIwKQBPLUl5EORQbkGhes9+81ZCGcY4IDSEAZ7hZG6+VxUnS20
	CC+JvgmHBW6TjwNTlvdlfuX3zY7dEaTf+03UCH/u9v4GeAJFvZaGWk6q5RAwljJ+
	JQ1qYDYh8IZSDk9EUQ16G6+N5XE5uB+a09BQ7xPzdF9+dlgkuWAd5qfnrx3T9v5E
	yJMgptsV/NzBRx81mSzN6n3/VOwP4UaPygF+a0KpQaJT/c0tXApzePShFtEcC3Jj
	DsrhKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043myy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:21:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aecbb78e44so168785125ad.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773652908; x=1774257708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpp7Zv2c6z1/dHKmZJlMe1c5HvJaIjPxwv9MvslkwGY=;
        b=ZpxGSl2rSCrGDYyPlqxvDqoQ6rftMJmgGk1BsT/7wUtHuAyWrIgCkwqb5AEo3sles6
         BSHzdjgkno/2XKuxrMuiIsejrc40XQ35Vp5glUyOWryEnldbq5q8qrK9LEDqItSOGlEu
         9zfZlWVqGDBtmtSiXCUIVqUh9rKzZYCjCetRHio9GR/fMLFKkebVPymDu3Tow1bpu8lz
         a3SAdkhC75ObYtzAAW9ysBMaYBWbhnGs9faDRdJnhfz0L491K3XAD3qqPRnSIyyrKFcr
         eTYIXgVAgQ9uUrYwEcotEuYN3C2whHudzopIbV65m8mKo3YFU3Ym7/Bkg+jyURuxgsz4
         eW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652908; x=1774257708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpp7Zv2c6z1/dHKmZJlMe1c5HvJaIjPxwv9MvslkwGY=;
        b=rpCW0xmvHURUBpz5FynGNB6NuZADWrNe2U6gJphHDyP2lod9r9dagGQqF/mAdEA/Xt
         txPwEea4SLHzQvHlxzRSOaAaBdmF9s2yhsFdXqFm2gsAlaXVxwxrsL+I23hVi7LiV5lM
         GQGzfPcCG0B1gwa5rbQQpVcPDL+2Z41cHxabPi4KzRfeET+77Kzfkj7pU9GvdP9hhg+o
         YOR67CE7m4Bro3ncQNy+tzPynPRQPB6wfDRQVIk6WHt2iTOcAnE23JzCGjU8whmnGQ5O
         2bYOh4ylRjyNzHrmWMG5eNcWLudt4BNMjKf481HP1BfcQvGS01tYuhEkKrPm2dnkKTqk
         zuzA==
X-Gm-Message-State: AOJu0Yz+bBWkY1Z+Tx/MEVGyeOaY2B/KDStQlfNVLecKkT/Kb0c8oEWV
	CdDnx9ju5SW86Ox0zm5RCnZWriXhn12xlH9/ljVE6CZBYKQhEzJyj08EO8UOc/lSnn+yvEaYdxX
	UgILmlWKYCXcSgPr0H4p3XYGjXI5tsOw+aP4ko36I33pCR6SnrBx8l1l9hbd9IA==
X-Gm-Gg: ATEYQzxYKKDgxnDkCNrfdh6kbeIXGHwGwG9sxBlcRYy7ZcCBzvpl/xl8/t/qdb8DRu5
	JAWuCHfGjVew15b53xtjrThh7rHCePwyInYBys606kLdT5vo6PbEOIlwGUJAyC+bnNPokuYshY5
	aQsCqVSMzpCqHNpWUh+Dplz8J9Ui2RMS9w5ClrvZY+2eLeFARf3WNE4THIN7GkbQlnxj6DyjQS8
	92X9rLhUednZs7qAvTIzK0Xg4cO0OnO1ub4raVeOCjEqNjwLB5YMz/ltPUxEr+Pgm+ICDS+xKhL
	memgp5/wwiY4F2YQdnJLChxS4K3HjPiwPeFF8HZJ+vzz/lpDd/zGoNFlCTrecP7rSnXSu1AKcFp
	lkWGytgNOeO2oWizj73KoQfeTYm47YEFFbOaN4MdDvhjCZwtgGZ8=
X-Received: by 2002:a17:902:f601:b0:2ae:c99c:7902 with SMTP id d9443c01a7336-2aeca941540mr132566725ad.7.1773652907932;
        Mon, 16 Mar 2026 02:21:47 -0700 (PDT)
X-Received: by 2002:a17:902:f601:b0:2ae:c99c:7902 with SMTP id d9443c01a7336-2aeca941540mr132566445ad.7.1773652907510;
        Mon, 16 Mar 2026 02:21:47 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81cde8sm103984095ad.70.2026.03.16.02.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:21:47 -0700 (PDT)
Message-ID: <9fc2ccf9-095b-478c-867f-2a6ace1ef1ce@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:51:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MSBTYWx0ZWRfX8DoPXXpxLhia
 0qd+yLB2SudNHB9IT5nnPOJSEZy8c0HzOlujz6c/it0jmAO1DKcC+CWbKzywEBdjc+ko/8t8Dv5
 Z07HsLs5/n4ZDm6jbo2iqekNcNVhcZ5c1+32u8eo+9XTbxo/04ulZc0onQOIKbJbeVnNwHcWyl1
 V6zAJ9bvQLsyfZSxdkp/GOiE9H8buOJ+1kLhbAJULQ3jJdt7oQ5phnaljsH5eC7ZA3sehddom8d
 v4+niokJ2yo71bRxUa0Rl5JDTWVokv4NQ/hSuWTeyLb/EbNIoq7C8hlZmIyQqbkukAyap4hQpGZ
 ikVu0oZq2WZQvw9Y6kJ5ZPLavRA+SyrTBPQ5NihSr7yDTDjPquwhPsWTvW68M/uo7cnVI2OZX7Q
 /87/pYyLQHRCz7ZEH9aexYXR+CTroP16iZ4Z5Y++daqCjNNQWv8CkM8C8royvTHgEQGDMscPeXY
 1ax133Hh/BSFUmR9uTg==
X-Proofpoint-GUID: xF4tUFr-p1k9Ptkz9kPAGuoT20gIFWRD
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7cbad cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ezScEkVGZYqAr6NFzwwA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: xF4tUFr-p1k9Ptkz9kPAGuoT20gIFWRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160071



On 3/16/2026 2:25 PM, Christian Loehle wrote:
> On 3/16/26 07:37, Maulik Shah wrote:
..
..
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>  	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>  	ktime_t time_start, time_end;
>>  
>> +	if (cpus_peek_for_pending_ipi(drv->cpumask))
>> +		return -EBUSY;
>> +
>>  	instrumentation_begin();
..
..
>> Best regards,
> 
> So we already do a per-CPU IPI need_resched() check in the idle path.
> Your patch uses drv->cpumask, which will contain all CPUs, preventing idle entry if
> any CPU has an IPI pending?

The IPI interrupt became pending after the need_resched() check,
when the CPUidle governor is selecting a mode, but before the idle entry.

On qualcomm lemans-evk case, drv->cpumask using cpuidle-psci is having only single
CPU but seems other idle drivers may contain all CPUs.

Since intent here was to check the pending IPI on same CPU, this check be replaced
with another need_resched() or using cpus_peek_for_pending_ipi() taking a single
(current) CPU's mask in the argument. I can update this in v2 based on recommendation.

Thanks,
Maulik
