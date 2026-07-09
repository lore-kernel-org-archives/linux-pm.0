Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0F1BC2A
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602033; cv=none; b=cJRmpLNjVuWBOPzHhXS0SSU/NiredEcscxpAze/vnQ4q5d6GxImw+F5nwOtgMjH98lyLnz++15LUAyARQig6pTlweaKSACUZ/xK8yht/zfxABfajqbbPR8tm83gi8AVq6hdRjkmXdgIybPOTuBsyeLlLH3aLecdpaAbdNzPVv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602033; c=relaxed/simple;
	bh=2XuPq/WRba3FTjAu98ml4DQzHgnP+f5ycQ4ACjYVP08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKB5XkbAy9h9KWZLoAQMdAyLYVSpoZXZrkdBHqV2gf46ghAivObpiKDecuP8dk3cGhkYK2ouzSZy+VF+ZEzAzsP8S0FLYQ7tpHvCyazYbFQIhDta+QB8nUCnQVOBmfuE2PLlT6raoZxHXpksUzQ8HCNb93zPz4CcGrO6d0bhA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBwA3+2x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=As4/PEOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBwA3+2x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="As4/PEOD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNSCn1672672
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 13:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GuiT3NejTXLTQXJObb98dbO7y/vb+auroGgUt5oDP2M=; b=MBwA3+2xGaMFQIK6
	toISElGCjPxK6UgWx32m1txDEwr4XmT9we+dUbKAYmJyc4GpEG8LyIFR1yXywR27
	C2Yb2pZM+tpB1r3uiQEmmdsdBincSlHAnNAveR3TLbZl6yfEHql9Lw4OuA9TlXkX
	qwx3Dmuv3SY58JJ0qCqN7yx2PadrQD6xrX5SmMbFs4kN/Qu5+oWpVLQQUOfpq3cU
	VfHofYaawGCqbNa151hNxLg5nz5xcrD63BUvHeS3hsH00LA/oAWTa+AhteAVHVOZ
	CZYbzgRRYuP3l6wQqe7J3Wk4Fn1mIOZq8GP1QKv0jWjd1N1LEbD/pEUQ8y0aaIIu
	sSwWog==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqscbx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 13:00:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0e702df8so11370191cf.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783602031; x=1784206831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuiT3NejTXLTQXJObb98dbO7y/vb+auroGgUt5oDP2M=;
        b=As4/PEOD/5cppePo0cS+y0ulj+obpSfEw0Fn9xHPdFm0GNvUxgYp3fKbF+Rgr/WLhs
         auQlMcJJjjOZzre8q8Va+S7rjhSVVxP52Xlb+A3V8UnLFR/Q6DuliLQyI07veAWIo0vs
         PRKp+sV+Nto4AQ9+Yx0ze3+UNmLID1hfV8W2IKcP/j786D3E+wvnZc7S0YZc8u2jHsMO
         mot7QUTceO6y/5yGrJ1vWgQH4QqpIiqKLEApRt+FquM8nbLunhX0a/gvCFje5tWYwNOp
         eu+3fupTvuPXTFXIv3vbO9H4a3rYsfH6m58B69kpCKP3Ba5NIhVMJuKEKC3hLc8pLEjr
         S0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602031; x=1784206831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuiT3NejTXLTQXJObb98dbO7y/vb+auroGgUt5oDP2M=;
        b=WNCu3X1Rmd6T8dVjij2uFQebPmxKdOujsZlGiwm5O/uQQ0/AP0SdSOBo+WpUMnqfOC
         vvif3ZAPX550wxT4V/h95ZkQK84CnXrQZXPDs8GphWZBUpQ65LtCD9MNu7emy/EZt3g1
         iarMiLA8xDWJGBofJfLIk3TXrKp+3tbGl21SIlVwD5hMtqzF1n6uBKLj+2t/aY7NtT11
         geQUHqgJclcDg7XTDCcrBbezia9bGiph62ITRU3SwNUshkKwyPNMsTPeyUXfnA0N9sTu
         w9A44hYY5/F4w1JIwNjTqMhFQLp5RgjFlCBwjdXDiH/Dh4qowOymOzLeXBhq1/SoDrCI
         4qJw==
X-Forwarded-Encrypted: i=1; AHgh+RoDoZd9IkrAmh8lnjiXHM+iKa+hnfRvAiFlkkHlhHqOY0L7Re6H6UVcXtDrcQO1wFX32Arl8ULZqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDRyANDSZFPAJcW2zd0EhGaR4TPUg8I69YQfUA1baxANpF2qm
	8PJvnw5PiHcaGadDHWyDU+U/bSAemg0buCv0hYaBihxq6V6lJJIzQz7fa95pGFSeyoK0iagdWE1
	HIyhZtyo9OMOntrwtXH3GYAkEdm1LaOtypxXhRmr0kozZCsnmYjgKNA28bbZ4Kg==
X-Gm-Gg: AfdE7ckktTc10N4N7Ouzvjew4BVIc9mefLNa/hT4yKtrkU9dDBIVcXq5+6gdk2LgkId
	FYt3laUX0auytus7XGgO9QwPGu/J1WnH1oiton0UrxK4tTizfw17UXSm7IbCkrJ9VtidEH1dGHe
	xr0OtWUumR6tys7lsVk31I4C8JTh9b1kp26xsaJRrsWK99eNgd6g9cTjiAMbWchpbPKsmTDjha8
	tJqFgU30vFy3PqDNU52mbWzgILroQs9qDjM6oYEki/iDiSv06VJ6bkK2y4qGKL8ISUDNeyb9A71
	fCRKOovHrPMzbGY2dDOezJGWmfXjrsKr1V9ZFzXf/uQtP3zvuPFfvmniAlg6ppB5IrCOEo0rV0D
	+eMMdcWGRmHkAnn7SI8m1VyxuZRazP3dLXc/dti4TvkWQpLzqrZpDv7JS5dotlkjg8lUsUq+jBA
	==
X-Received: by 2002:ac8:5f0b:0:b0:51a:8c97:937b with SMTP id d75a77b69052e-51c8b3f56a9mr74712051cf.67.1783602030388;
        Thu, 09 Jul 2026 06:00:30 -0700 (PDT)
X-Received: by 2002:ac8:5f0b:0:b0:51a:8c97:937b with SMTP id d75a77b69052e-51c8b3f56a9mr74703841cf.67.1783602025383;
        Thu, 09 Jul 2026 06:00:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8e86:6bca:4a7e:8b62? ([2a05:6e02:1041:c10:8e86:6bca:4a7e:8b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ea082sm62035225e9.11.2026.07.09.06.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:00:24 -0700 (PDT)
Message-ID: <6585df3f-2d4e-43b0-81cc-72195a5ceac7@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 15:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
 <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>
 <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNyBTYWx0ZWRfX1PCLFd+n5QhY
 FBWxHSpvXASavOAylcjeIk98Lw+zddp2W4Fx1Xa6KY7JitWTkFmpaEdcC2oT19xCI4n1sZBvWq+
 s63FNOSZ5lj78O51kqx/9I5ERgH4LJo=
X-Proofpoint-GUID: 3WbDspbpcOZUpUT169AV65_aymbPX93L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNyBTYWx0ZWRfX3I1KUJDPHaEL
 19ExRlJhyzrImrwWESU1njEPkNV673X+JucHW2WwtRE/qeeQM/sRKetutbVBtwQY4B+30oxZkB6
 t4g8aM9PpM24V0s23BvNWJ5plLiTFOsUBAsuVobNKzX5xWGOikFLdlzgszd5D5efnr9BQdb0pqp
 OqWnKYSU137hpHvI9LyPiotGGjLISSWY8yLbc8YZEIZjB5so+Zi/E97KgeU3f8Pz9Zi1SXit1jf
 QXuP4fYAYGcLOD0s4NSxORgdz3S/7/bWu/g/ShcCEL4m/mSN3nj3wn28LNkc38v8bLxX4ugUuwJ
 Sc2EYKk74MLS7M9f9wRPpwLoTNefBlC49phobqnUOBUFbTGdOuvEDqGFgfFvzgrIc2eW4dPdj/O
 kfaXXwFjcZDXSFbi94g7nMgCvmfXRa7sxJm+ink3LNLzpJvk0iP+/6lwhPe0QUPT2k1WbZg231g
 FYu/OPF20cLdpzkc2SQ==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f9b6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=OGcXQ3cJPyzbm-w1UIMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3WbDspbpcOZUpUT169AV65_aymbPX93L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090127


[ Cc'ed Maulik ]


On 7/6/26 11:16, Sudeep Holla wrote:
> On Sat, Jul 04, 2026 at 08:43:39AM +0200, Daniel Lezcano wrote:
>>
>> Hi Sudeep,
>>
>> Le 03/07/2026 à 17:51, Sudeep Holla a écrit :
>>> (It is always good to cc all PSCI maintainer for any ARM64 CPU
>>> hotpug/suspend related changes)
>>>
>>> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
>>>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>>>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>>>> retained. The hardware design on these SoCs forces a constraint to suspend
>>>> and resume the system on boot CPU / CPU0.
>>>>
>>> And you fail to explain why they have that constraint.
>>>
> 
> I still need the above to understand the issue/constraint better.

Ok, I think Maulik can give some details here.

>>> Is it because some secure context is not allowed to migrate ?
>>>
>>> We already have a mechanism for that in place and this hack is not at all
>>> required.
>> Do you mean a mechanism for the secure context or for preventing CPU0 ?
>>
> 
> I meant constraint based on secure context.
> 

