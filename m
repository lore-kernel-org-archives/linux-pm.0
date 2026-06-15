Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838A3E5A04
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525622; cv=none; b=iVzYXK/XMzqve309guPeDvyMFbXHl+GFYFdPxFJRddUPDjC4EbMXmDMA/78BRqf6GivfdBAbVg3IxanEdRQTCyY06F11YfFK9NRtFkMwS5071zC33HPK5ePwKkBsGbn3xVq7EZAzGN2FQOYlVenjwmX8j6R7zJg6C8Y+fvxQbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525622; c=relaxed/simple;
	bh=HkSC54Hy2rTVz4KTKC8+QN8lXf2J9rcMYlJ5TLyivOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKcyrUJUviTUWC/ue3KRTZlllwrdbY4AcnDC7KJTf/kMEd+oKpNk8kNB8aAwygdMoO9kueDIheYbkBR/j8aEmmuLRiGnhPqaDd22frxI0paQ8rFuHQF05gLTYJ/WYuV79VLdqClohtODyi9totSvPc5KMYES+RFmFCE0kCcJsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRmPZ4ex; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ANAmGXPO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRmPZ4ex";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ANAmGXPO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAobRF3885885
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYxdeCGcyinNCr/XFcysniXGZfkyVzQu72/fypNWtGw=; b=hRmPZ4ex+NnOrMvL
	TO4BVTHcDDa2GEkZqYVsO8jgmlj4XBLN+KyRGDZtssYJ51xNuUbgs0gnw3V3sefH
	HVy4I0hlUrgdO+F6zg4N5GqsNiD4dGPstwaexwknWxlHnH4fwndLzD1OJgXTGRnx
	v5Vq4gWTSHgyIcDZcUGlCo4o+NO+vgGWv1k2ZbpuUTMQjksPspAfJIlbgueeOCEG
	EyC/PPKsCmWrzP7hQRAFXCmABNOtjGeCRa2Idqoy6zhfJoW0bMebEcuqxASys3d6
	HcjCOOeQXWNAK0aM9r2VBx02XfeYiq/+N3Hh8UfX0K4SOz/ZPc02G7FCJ8327RZg
	azmpqw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjrkb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:13:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5a787be4ee9so4438069e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781525620; x=1782130420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYxdeCGcyinNCr/XFcysniXGZfkyVzQu72/fypNWtGw=;
        b=ANAmGXPOhx2l8gcpETlv/wnOH5x+OkyL/G3RoTnyXEeTvUYZj7P1SGKOBL5/55W/22
         e3smen2yXE9LozAfzfyUVvMXC3i/k25F9dm9M+X5prLQIjA71Ov7xBC5b6w+1mWW1LZg
         IHGE2oQzuc67MR5RBNRbrkN4373Ttb0QKhN88nyW6A/vGLP4v0V/v/l/3gdCWBjRuCh3
         6jn8tH/aT827rQZzvKPH4jQtFelh4Q9+zok74wNA7y4x8y/n4TGiwcvArWb4Td1opsZV
         hRe21Cz9AXQmO9k7E9umeC5i1Imhc2TrQaiotcbQdZ6g/0QG65lFfNBnFH6kUulaINVW
         MuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525620; x=1782130420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYxdeCGcyinNCr/XFcysniXGZfkyVzQu72/fypNWtGw=;
        b=o7owVRKP21MoA7IipIaHSl05p8/u+datOlevR4LNliHn9leU+3289uechYRSXmk9i9
         TE03Bd+BHfzMMAueZMTEEFTBc4xm38fDI/azndu9cmvhy9EOzQuumzYOT8Xpb8OiO6jI
         4Mj92uGGthanK5zNkgPTx9SBg/b/xS7DKENQsSlDwv602Z2zetyfrCNJUzeh6Won0T7B
         j3nPun/dgOfi0W5BMaGPQ+zeokMS//rhZUdwz06cx7xae4vnGhuH2o7Zs3r8S8H4t81B
         LTTXwDRuXR3CU5zYyWvp1B2MFNqyFyQf9ty11RJWDY6hXBljIq+OCl6eHzj5/9w4FYsU
         qzjA==
X-Forwarded-Encrypted: i=1; AFNElJ+7NFH2Q7rcPYbI9C9+Mascm1VIedSPCdru1gUwDujH5wqfWBnfWCeuhD0Jb0uGi0+zVbU0edZggw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s1nQQwdDR4vWfOlAB5UBvKR46oXdh2HhfjK+eU1Kv16Yrewy
	XXV2D9FK2gVpVf8cSXP2iRB1OavCPvkKAt93H5IsdGP/8IrDZJA0HXDAb4KQhDy3g617m1ojIPK
	X7lAxAaCoKoddiqV3/S/lhmStVOiw4UosUzuGfp/RE0JtRiXvoHN7gU81VzPNgQ==
X-Gm-Gg: Acq92OGRCXBK86dVZ54tpbCYYjzKBh4EmF/tX9q1gMrXB6y2tNls4gm6fGxX4Uvd/Jt
	qzUZsc1Qyy9YiOsaKaYmxCGLlXw7svXPzvS8lr4Yvt/gA28OErYEpOLOGBme1183mG6HEBAySdT
	p5ao5Dy2qEPPMKWuH7H3xXx3wmOvYb8ZKPXbnv+o0KLlMeOOLZo8qY7nfeljn7gU07QicEtj+Or
	miStWblUiRTC2I0E6xeEebx2hD1ytQ6RXKmfnEov+2TnpXzolThrXwhIXcmEgn3Xysv1uhn+2/u
	2GMU7O+0p48P0Ua0eOcj/UetJVp0bosemcmG/ptgFBMsJ7Z+5mKCkb/+egQlfCo1VxY8p39jyzL
	d7X7X0wvLjjjSHOLzyVKBFx+2TTZUmo01EymkAubOws8dcLkPdAJVL8oR4ZdwhvFFqq7fcIEbI4
	xkRCYx3Um4nHbHYQ==
X-Received: by 2002:a05:6122:828c:b0:59d:8734:e801 with SMTP id 71dfb90a1353d-5bb79c3e37dmr5012537e0c.14.1781525620010;
        Mon, 15 Jun 2026 05:13:40 -0700 (PDT)
X-Received: by 2002:a05:6122:828c:b0:59d:8734:e801 with SMTP id 71dfb90a1353d-5bb79c3e37dmr5012522e0c.14.1781525619629;
        Mon, 15 Jun 2026 05:13:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d2449sm234107825e9.14.2026.06.15.05.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:13:38 -0700 (PDT)
Message-ID: <6a7db21f-a0d8-45e0-b71a-cad63fb043d0@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:13:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/cpu: Disallow offlining boot CPU based on config
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
 <20260605104330.GX3102624@noisy.programming.kicks-ass.net>
 <87ik7x5gba.ffs@fw13>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <87ik7x5gba.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfX4RknOJ3h4jCz
 +rPss/Q/bxAfQyYl89mPYkN3JGpyWXy1nIBrFtqBIRj2X0D+5C07GSOmBGu3OjjllVXLteyf82e
 IeMWBxhyldqXFWyqyNfkadryn/M9gwxLWpU//pzbuPFZz5KUI96asUdElFkR963B/0GlEMDh886
 S0BqDm31uDDFqnaXF87O3GRkbRmSqor9180Q/c4JBNL8lV/4878ntEN+YzsoTULEwfT0agSzKNZ
 M+Y+lYQXZ0U/FETB7ebibmQlPAcSPieYCLnRfDoKfR361bdKaeLL8znoUpzI4brL1Y/U6DG/m5C
 4NTdPH09X0Q3EjvDHq8+odVWkjLNXjMPEEx+m7GwRcQ+lWtxaXpszihfdbfdExAldJtFdB8SJMP
 NUPKCkv3yYUyi7P3PvxDaPUVncz2M2xbTvrzAi3puHOgDOt363jy9/bKIo8qd7CNXd8RrqvpNy1
 hbIOeR9wbpfS2jRc20w==
X-Proofpoint-ORIG-GUID: 8Mpf1binv0361FAVP9IhM1_AiZNcMjOL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyOSBTYWx0ZWRfXxOyizskaFYom
 WHVwIn7oxP0JUJLtGv7fJL0Kv7+TpjODKbt9hk72TZuBeWAywr5s8i+H6kHSFO8fmQMo0tx2C3O
 dJhd4axcPOGPuBuNfzXdEb2p4DZGazk=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a2fec75 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=58ofpu1a7HmJm70nKAsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: 8Mpf1binv0361FAVP9IhM1_AiZNcMjOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150129


Hi Thomas,

Le 05/06/2026 à 14:20, Thomas Gleixner a écrit :
> On Fri, Jun 05 2026 at 12:43, Peter Zijlstra wrote:
> 
>> On Fri, Jun 05, 2026 at 04:00:46PM +0530, Sneh Mankad wrote:
>>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>>> retained.
>>> The hardware design on these SoCs forces a constraint to suspend and
>>> resume the system on boot CPU / CPU0.
>>>
>>> If CPU0 is already offline before starting suspend to ram the
>>> freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
>>> proceed further to invoke PSCI SYSTEM_SUSPEND.
>>> This leads to a system crash.
>>>
>>> In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
>>> config and when enabled prohibit the CPU0 to be offline.
>>
>> Why do this in generic code? Why can't this live in arch code.
>> Specifically, x86 can't typically unplug CPU0 at all either.
> 
> arch_cpu_is_hotpluggable(cpu) provides that info to the cpu device core.
> 
> No hackery in cpu.c required at all.

Ah, thanks for pointing this out !
