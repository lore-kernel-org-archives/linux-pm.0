Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70B42A14C
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011115; cv=none; b=eikNmdA54O6jYaOpCWDUsFfg/tunr3bqv4/8N/v8GphnT07wslpkNiWAXSe8Qkpa6CDXqAPyo1OAjDuegGmLOC/0MXfXk0f+MNQkAFYbP9cvQamyFo2II9xezhJgi+KkMuvLeZQ6CSSHVFvPuG0hDFjYYEl4nnTBxBggrXQZC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011115; c=relaxed/simple;
	bh=KdOKQIu9p6+SyYEBoGDCNLAS5tRMNLNP838WoXX5zns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S70JePgiPxZzGCc/sjq9T1XiIfuaI7mDsRDVVR+9R2UgWZeTtU2Pw0/ulgrT00VbqJNpkqgtH2+5NRzKSgnbWsVDMtCkNToMHSRUGNuf767tXpM1BBVt/aH6J5Sc/kghd9aDPIxR8a62e3ymKRzop4YOFhBP1Zf8/zZzmZiPf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRfOVKm7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cnxpz2TJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRfOVKm7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cnxpz2TJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhAR1578793
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 10:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ViBCPXoXGCzT+QcXi9qY+7bZO+RutuTCDXISRu9DuM=; b=XRfOVKm7fGAX5MAb
	Ocf2PotNBj/ihO8eNspXET5ys+uC3/hbIIplO7M36qP8g3XiapwT/mX+S81roXnw
	vJxcDnVhTiSIdiYI42JJ5JFdoxFQOUdCMbocUINg4RKodh5r8Up9NLFIk11BKp0g
	EMuZ4ixOt2mAmSRlOuc+9QCHyIofiPvJZXVI4uYXx8qKtzkHzblm5KeMtqHwr6q3
	BtjqNQfyp87Cb/kPYpdofS+eM0/LWtQlqd+u6OP2IBNOUeq3pPfklqnGK4NuN52R
	YX34Ey/U8HwLVsHbhNzwQYm5V8A1X0Vx9gR7dPAFlOxlzcmtTIHGfZzbhzHdV555
	yE9Skg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8hg68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 10:11:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf1c86963bso9153395ad.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786011111; x=1786615911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ViBCPXoXGCzT+QcXi9qY+7bZO+RutuTCDXISRu9DuM=;
        b=cnxpz2TJylu8ePjfYqpRKIIh1SbKQx5ELrLAgrjLIYID6PSY+tGywc3U2EsRbqAYpi
         OI2e1e2yl6Y0H/9PTxa1N7TnSo52gkGRTrBfs1JQhWD6T9eHCYBZWaJbfwXDBb8tE2T/
         mOXXNIx0/e8VAAShCz7xAT5jhwdCzv7XGV+2UMVMQq+db8Bna4UCc0QeArLOn7NRQOSx
         lrT8AltE8PbsqctiKR53zKIGgYpXoK3dCgtSyyJFa5wcC1sKu8lcuqZ0pVXtoNp5UQWb
         xF2nWtGJvS48MFzFx8+Usv4m5jeNQ8E+PhGfMVNv9GygXC/o6O9da8CyOTQOyBtelaej
         mhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011111; x=1786615911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ViBCPXoXGCzT+QcXi9qY+7bZO+RutuTCDXISRu9DuM=;
        b=Dr42mwO0ytaYT5A/EK9XJImYPImaTQ84OnH/JaXD8n7s84cWjJtxbWvc7WAhLXDf5V
         RfmEGSYDyjqBdT+b9zn0Q4nP4KMNduYP2Xddsl9KdXVQYJOe5P0Jb5nXFs7daRN5g+EN
         AxZOZA/fjI9VcC4k9xK543iB/Y8v17xKulJpSYtE+MQfPxMR7/bFLkzL3sj+iDgLHfky
         LOqXQ+27S8x+T8oes0tR4hG2Gb1nmwMe/nCBjx5CR72z7Gye2c0eLXja1x7le5X9PWO9
         Jdrvx3U1HK05eS4/mxm6PkXWrbf1tD5phBrETs7KijgDVTLVykK7x7Pu98c2ppvrRQ5A
         zwRA==
X-Forwarded-Encrypted: i=1; AHgh+RpTNoOAi95vmTxacICrJBoDSfyLvC4EQG9poRhfbGwTB2q9CkzM7Y3mktbkKjYEXS7bqs9vGLhKJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45PIZ6loHz7zd8stsSqGmAW2tG9LfTaof3cjCpsRHzZNiy5ZS
	PdCcPHTRHiVVGhhnU2mOMC9nPoTUEEkC7+rXOcXP3Vqs1TQCmvFTZOvXXLfVQznvMl/XTHQWpjB
	JjFaKuSwBKyePK4pp5RuqVrsOi1LSqNo7d153+50Dt9zOplg5lWQUElykTPvuFg==
X-Gm-Gg: AR+sD11hr6ZmKfZxmkSS0A2CQI5fWLqD3V96s1bjXwMHXLqSJVffV6bjb+Ehczk5dFg
	DEtj3vqyPbBZ23HioEmyESDP+vV17gPWHfdFl+deLUn4hoRabvnDXNEwTDpeH1bpGL8VRWiI9+6
	K/zzqszAhusDcH6mTWGjgUDGbjtvkOaNmHKZLF0b1wb1Ji+VhZ2Cvt6JQ6HJDx+HcUqpMjdNZCt
	5rF0Ag45LAP4n/bzn9xFgEM3eI/4yAEFlc7pkaxQmo7R2grE19VaCOc2qxd5c+dmeUx5jQ7S8la
	lBKrqNskcExpsE3CObgME5pYrtJ2/DtTdixYbRK1wNNpFi+7O8ttxEKSjfl9mtFqsuUnmeLcCel
	wguweJi85r80FDAPftPyYAOSm3z3aWeJCaQdmCO1Cbj3kx8YvhoC9HwmbrXpePY/ExdxiAJyc4D
	Ef/fSKwzqQ/+cTkrw=
X-Received: by 2002:a17:902:da87:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2d0f185d642mr50957885ad.1.1786011111657;
        Thu, 06 Aug 2026 03:11:51 -0700 (PDT)
X-Received: by 2002:a17:902:da87:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2d0f185d642mr50957505ad.1.1786011110995;
        Thu, 06 Aug 2026 03:11:50 -0700 (PDT)
Received: from [10.79.116.59] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa012bdfsm29017685ad.33.2026.08.06.03.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:11:50 -0700 (PDT)
Message-ID: <42d9370b-aa10-4382-b6a2-bc441fd2335a@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 15:41:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, linux-pm@vger.kernel.org
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
 <35it74zycctxhpnbsuvp6a6aazrjavarhq43fqgruafjv7xkt2@recuceutrqrn>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <35it74zycctxhpnbsuvp6a6aazrjavarhq43fqgruafjv7xkt2@recuceutrqrn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fhXoBmrHHkTbLRd_BLjpZ24Lq0wxkyfv
X-Proofpoint-ORIG-GUID: fhXoBmrHHkTbLRd_BLjpZ24Lq0wxkyfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfXxfW/c6JnAa0c
 QiRkHeez4ZeQxqLQ0+aTqYhcvNiya5jHytRnOE3xfly2/+rvNVMYWaJchw+on4/0pbafaYhpl2O
 FTullEfv1d1gVE5Zwnf/T/D2+DwXoTxe41OzGpJkS8QqX6c+0/Ay9ff3r0UuuVnCktpeSUTmfxU
 u15zxGOye/JGCVCPPyN0c6nVqV6wcs8O7azwAYVvH4kqDx7soJ3UA5GXj0F3oWRjwaIhz3wFJ44
 QXt0uBDiMISsjKEJw1GkY/9zZ2u/bhd6jve4CCDp0lMC6uVV2Q47nyQjybTFwekiTvpNIG++XbC
 kc6Q5Qj69IL5bawR5TggejoK+ZKau9nj/eWF4aPy4K9dVvfy8zNJyH+YOX+HE2QtM3Zdry2nfY/
 iUm/fp+vcDBC/YZxPhjFpaOLeXgbyDXE9APhV/x5dy5BJXnf4DNYwHK4IzDOYirsuH4GhByVu7g
 9lWKGw85Z8WvY/y1L2Q==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a745de8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=msXeGxPGQNx2iT3xjQcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX4+YOzlLKretC
 v5M51towqkEfK6an9ss/XP3P3IjmLjgmnICsAwjUgsXkZR14x9BO6CD9Z/uMuP9mEY6uYPDdDLM
 cafwBexbtnL4xWse3BHsFWCTUtML044=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060080


On 8/6/2026 2:58 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 06, 2026 at 10:12:29AM +0530, Sibi Sankar wrote:
>> From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>
>> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
>> if max boost is known") guarded cpuinfo max updates to only allow
>> increases, preserving values set directly by drivers above the freq
>> table maximum. This prevents cpuinfo max from decreasing on boost
>> disable, leaving policy max pinned at the boost ceiling.
> Why is this bad?

Copy pasting logs shared from the cover letter:

# cd /sys/devices/system/cpu/cpufreq/
# ls
boost  policy0  policy12  policy6
# cat boost
0
# cat policy6/scaling_max_freq
4454400
# echo 1 > boost
# cat policy6/scaling_max_freq
4723200
# echo 0 > boost
# cat policy6/scaling_max_freq
4723200

Currently disabling boost after enabling it is a NOP,
scaling_max freq in this case would be pinned to turbo.
It will be reachable through various govenors. Also policy
specific boost flag is meaningless unless we have means to
reduce the scaling_max_freq.

>
>> Remove the guard so cpuinfo max is always derived from the frequency
>> table scan. Drivers that correctly flag boost entries are unaffected
>> since the scan already excludes them when boost is off.
>>
>> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
>> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> ---
>>   drivers/cpufreq/freq_table.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
