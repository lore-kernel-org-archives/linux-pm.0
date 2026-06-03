Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C13CB911
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489522; cv=none; b=H0VBwP5iSAGyLb5U17hmXrumsmoI2I6heKrEWKhYz0GnK8QTTRLJ3wroKOZCvEex9yOMGL/ewpq1Tjaj0JLfRxr3yoNhZdQlueB1a/ZssZBLtIyVhyIwbAT3oFvdZQ9GWv2RM1V5H4wORtvLgrhQaGie7klxtYQjGyGtTAeRFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489522; c=relaxed/simple;
	bh=JuvqwBjym4t/oKt+K9cOMhnz6jIONEmZ6Dhfwekorgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL5he0TpNWeXOP0ipVL2597KXB3pd9xZi8nNrBrb9H0rtC3flce64DP2OzYng1D6DPKQiIFeXYOLsEHXIDEJYC1kY9SeRkui680wf4sWHc8oaCHr6AgQ0A+0HLKQ4GowqIpPAp8xpo9mmjw3OlVDCVwckQ3XsIrv/SAhd/EZ8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ti+qX2FP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S+s3LITL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ti+qX2FP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S+s3LITL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CGXdd2076092
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 12:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nCV9ZLNRuQ43c4ABS9sAzC9BCFQ6NfEp5U989ijwe4o=; b=Ti+qX2FPMFnRPUGc
	i3nPdN75Kj+WDJL1V5xQC0GPtW6WZ9a2KHhIELU8tC4u2UqQvewZQ8Sk9/hQpwIY
	iIqgHaCP9o2Z+v6BpvAWmYrG+KxW5G6Rb5RFv0cr4bRSJASamPgQZbaeaMMfOp51
	96VhIontED3el1a1mhHRzE2eMnDhXDFepskeEZnuVOjLSctSZoGW0QMteh+TmmN3
	PuYQud7lRl5sxTTkR9q2BXQXQfBiGxqkE1oPrjDeO1DWwSjVs81UUImAi+FUK+Tb
	vITS+XHrXaeL9KFqWFDQPwfPov/QfT86YV/ZgAbH0d75l9tnyDY0JzF1PIfKG8dv
	REIc0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19g4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 12:25:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915737aaf0bso72321585a.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780489519; x=1781094319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCV9ZLNRuQ43c4ABS9sAzC9BCFQ6NfEp5U989ijwe4o=;
        b=S+s3LITL2u0fK32s4+wsHTJvOF/37ht+W98lPUtO3yJT1aOJAnuBU+SqyLC5H3gudM
         S2kBaJqIEO13XaJAK7tpGJTQBQ7K6vYV1wQ7fsGNVDftBesBTZNp94IvUrs7sMgFhXM5
         9GO7iXXQYxAWFZXoGM6KvxjfdgTrKIuGemxCGljQW4DfyfG0J30vjW2Yvap0mWa9t8CH
         c04zEIPUZ4glFFsFSjUNQVUQn7l7vccNiY25Mr0HeQURIswXZwQ4jt6wyP9ctKRbit9Z
         4K4sKDKUkLZ1e6ADHfS+p8bEDSwWW8GkxO9OjHt/atq10BjXp33HpnpcKx7KamDFrlB4
         Yuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489519; x=1781094319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCV9ZLNRuQ43c4ABS9sAzC9BCFQ6NfEp5U989ijwe4o=;
        b=igaJrdyaY9TURVJfo51J3IdrxNlM6kaXEUYeQY3/ZmZHLtAqSyXuE6+a2K/D7YT+Tj
         Unmofy/wWEMcHc+L3vqQ+Qssy674H4+RwEJ+rtD56EbwCKSF+Ed3Ys0DdH/LnrTW8325
         gHVEQNKhtqudd2HFWgDYfIoXpvYlalfTqW8FfzhM5qvSZ8SMsDq09pxOA+YXLpV/JW4n
         6C3KUaIl4NP2w12fYrr3LK6QR6KYEQhOC7gErgX+L0XrfF2TrKcdOOy+NjbbtfnaAsnO
         PGJRAgIo9JsCqkCWwOZzVW4eKGnyK0ymBEJBhI8ZLescAJzYuEyeHNTm3Y35JO+uzxqE
         5VqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BRdmLNsbeCVV/atuVVZJy0EbOiMw07aEZorxKndXjW9k0JNKQ12v9IG4hyK1yR3gaHCmWHlZE4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6RstXfve63vCTSylHzD6EBswRTDbf9r9rfBsBZO5PR/hhXCS
	wbEHb9370zT8yjkDTxkXf6gW4Uqw/hE+i33WlWdj44fUDvJ0P7R0Jkl8q6CgqYjMg0r1isn9RUT
	n56wLHZ/iFXxo16fNX0v0sE3r6iyygFD6RiVy+4vywdKmitJRqFlDWqa5ptJ/PQ==
X-Gm-Gg: Acq92OEJF2cZNc7Mb266lWdiDPLDicCevzbQj7iE7vUbAsd34P7b1sjW2LK9GFIETAk
	MrZ9ZLxfm6fz+7SbC1xQ1hEjcmkOiFZI9WGPRYSJYhYm08r3MScyQhSCHTOrrJ09IZUPq6qWJ70
	czWKXtMUyhslGXmwsbx9SCcZIRTro86knBuuVfx244zIrV3rd6mo9YMbLZBszGjtol9tNLP+wKi
	tj2OBBLrBP1wvRLVxw8kVs+AzkWTa39IGBekkeTOjTEQqsnc1Qpal+3iRKnslrcKgl5LPtI0ewe
	XbBjvwd1NB1/vCcrYN1ChFwqyEmqh06Yahr38qbo32mct2g78ymi8TTvWotPaY6FHVbHuVD4Nub
	pmZwUGFrCIz5HXmdb7BlCRH+JOh2KJb1E+UtwGI/Li/TuuyR2jxWyGdC4VaIdUuiWHvQw1kaLiK
	TDthJI85yS5F4=
X-Received: by 2002:a05:620a:46a6:b0:908:a758:baae with SMTP id af79cd13be357-9158a31557dmr354625685a.6.1780489519557;
        Wed, 03 Jun 2026 05:25:19 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:908:a758:baae with SMTP id af79cd13be357-9158a31557dmr354621385a.6.1780489519033;
        Wed, 03 Jun 2026 05:25:19 -0700 (PDT)
Received: from [10.100.11.76] (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm146052266b.38.2026.06.03.05.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 05:25:18 -0700 (PDT)
Message-ID: <80333371-48b3-4cdc-85b4-5625af6517ff@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 14:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens: Disable wakeup interrupt
 setup on automotive targets
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
 <20260601-tsens_interrupt_wake_control-v2-2-ce9570946abd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-tsens_interrupt_wake_control-v2-2-ce9570946abd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g9BxaH9KZ2iAsRUabABzFZaoBZG5NFoh
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a201d30 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=JgYOmoMgnJlLO9fjyWQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: g9BxaH9KZ2iAsRUabABzFZaoBZG5NFoh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExOCBTYWx0ZWRfX24wd36ZwxCdn
 y4Mp6DCTR5TaMp1v40Bq71N7043/1xiNBaQYEyI+y4KBFeQS2cKmck+9QkgB/hkQOU9vqDxn1EB
 P6rdckk5fd0svrZJYEykU3EDmic0lgkQqvl9jqKBD9+y7nkU3p0wndJSj5h4FuxXmhfyy9YSBDt
 8NTwtXy2NVRY1hckGujYvd/joFFbbbdL9q4aL1pmE4mIakj9jUgAH+x0H6pue4+4c5VikksX9TS
 QGQ59xJl0A1iFWVXCo7sh+x32ryRjLaDBDx8cS7mWBZ9KvABPOXZhQwCDpE7nZfYYbfWiBa5BRq
 qor3QWp5Nc312HFVy7U/GWkZY0+6Nra59onSKx4OlSrdS87QZyHIDChLRWxFlLqm/Cse19Mo+gJ
 hlGCEuaQYZQ60YA0bVll8a3Ei8Q2Wu11shkapycs62bkq5xk4YVEHhTS+vtIcREnEf3CaNtokWi
 DpJH3xcVHKjT5FCbUeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030118



On 01-Jun-26 08:37, Priyansh Jain wrote:
> Add a no_irq_wake flag to struct tsens_plat_data to allow platforms
> to control whether TSENS interrupts should be configured as wakeup
> sources.
> 
> Create a new data_automotive structure and add compatible strings for
> automotive TSENS variants (SA8775P, SA8255P) with wakeup interrupts
> disabled.
> 
> Automotive platforms can enter a low-power parking suspend state where the
> application processors and thermal mitigation paths are not active. In this
> state, waking the system due to TSENS threshold interrupts does not enable
> useful thermal action, but it does repeatedly break suspend residency and
> increase battery drain.
> 
> Allow these automotive variants to keep TSENS monitoring enabled during
> normal runtime while opting out of TSENS wakeup interrupts during suspend,
> so the system can remain in low power until ignition/resume.

Can you not just disable the wakeup source via sysfs for
your needs?

Konrad
