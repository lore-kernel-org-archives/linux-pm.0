Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D7382F14
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723817; cv=none; b=embntXqgCe7EEzrynTMX1jbiSjLn8SPPmjtZ7zgzhlAxhmSFOacDO4veR3LblmFlM1hS1zvOT1SrP/E1upWBMhUM6Sf7tWW9OCKB24lWEpEicBO15jW9VGdSnz0NxziwTTrloxFtwI0+8fWQ2csNM6tLjKXyZV47M3DIBo68dsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723817; c=relaxed/simple;
	bh=nmfRCcc5TtyK0Be+bysKEBxnSEnCJxlUIS0OCgWMztw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5+B5vEdGWq5OO4EIf7UrMItrpLJg9FtnYz7Ua3LHhAi2O0Aixh6wX4DRz1Ctu0yYxJmpLvBusQ4Lo1sArTGHLugQ2967RvrG2swVM1NM8alsGiak0EvS5vx6Q4QY1x7D3FeqguIcmXlZLAfycHHPpyQX+pN/hgsOtO802yXhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mItdRo5q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/2XoO2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mItdRo5q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/2XoO2V"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PBTLo3168750
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ewXbDdakYnrrRU8Qr5G4czCVNZomYu79jonEsMpT64=; b=mItdRo5qxsvFEhQQ
	amk1JNBUwJ5pFZjwTlDQBPpQ/1eCcJU6zdJ8ffU3r+G1IjDE6jvQsZhYoQFdQA3a
	pR4KZGs7So1J+Ku4D+/RFgA53zaiPRIqGAvRuoe+lyiIF1Ogxb/S4goVFC9XUYft
	HpYxlfhiYTcghKMwI55SuNuXNpNFWWoCI0MWERHKQt9G3MZEdSpl2BDbikbAw0sY
	24WEE+lank+uRMWOXFrSPJ1KT1qcS3/edFuNdTtfoTw5CNkgGGqnG6mRNw0NLF0V
	ZMwEJU1nnGv0TgxWSt/vfhVlhsuNo3PxxSCqf/BNQ0M+8IkKm2e71wsBNYqDYkQl
	BW4m6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0xetc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:43:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d38bfe83so80941281cf.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779723814; x=1780328614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ewXbDdakYnrrRU8Qr5G4czCVNZomYu79jonEsMpT64=;
        b=a/2XoO2VnZse5uzr0yzNNpWEwPXzeZQdpybbPy1oBddVQMAX2UEjPd+erfeR4xjr7E
         j8u2RSo4PhorZj51LUfYdesLXJM+E+IT7kmAKpzWNdLS0FqsPBAOkgOG2KbaOWXY+9iH
         CybwWuu5oftI7MOSSHU3yBCm/1SG7iorc6HI9oD7WkrNi3aZxwm1nyCziqrnLgrM5NJ4
         s74N2/u0BgwcGayJeJln1BLPDaS0o4MYG5x3EcaRgnUVKRcL4lbwnIrKtkRAoiU5fmHZ
         Tfb4CeeevFks+qZIgwNS33Q2Ks1fuucIUNDD9DXuPcBmqhWCs75Kb9FIsuzR7cIn6r5g
         EXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723814; x=1780328614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ewXbDdakYnrrRU8Qr5G4czCVNZomYu79jonEsMpT64=;
        b=fxu4dimxu1k0Q6pSOe0eKiCHF2VcW26DtbAD0jHX6yCljBAKA2bqJ8FDwZbpKv8E0u
         AlgkOKj7M5MiURsB5proGfqUeqAbnJjWkcDGIQnbKIJIcYPa2eec0Ed4Q+Djk1C4olYf
         JZHQESZocJw2haf2JFHTTb1QcOyyK8uzhFZNITRf+y7w1NKkMQcZMa6Vjc79YylZRMpJ
         QR6wjQug2WOZegxd8qZgIdNB6aoqBjzeiNyKawDkKTLHe/CmYRVilm8m75c8v3jPNHC9
         oNkE24Iah8/GWXElzfqZjEKupWxX5ejAFsCJ5xoboLU2VDZbPe+2p7VR63Lz1spVXk2/
         Q/jQ==
X-Gm-Message-State: AOJu0YzBl65+BmoItpWohBWn7fxH/spedEIIAcf3rakvomLOleby7O1u
	KCSqYwj8/6M7HBD0fk7rQFvMrGszS4x4SZ22AsVcGghLV/V/8w1bnGQAJE00nJyPvJlqkNyVWDt
	S4SPlt5kIY4fn33Fzvd1DsPWzcxg3QOjw1okm6VvHZLuziSVQIuAjVVz6Y8y8Tw==
X-Gm-Gg: Acq92OF4g0fby0K8iauQ/MtYleraNHUMPLEWYB1SRQ2ihM75tZ3uDObZ6fgo4D6Mzp2
	SfU7Esl+g6aRIqlI/mSxE67IrLRow/BKo6r4jPArGu8S8bTmzaA0McrmzYDCIhIsJjiTyCSTgbk
	MA3tu2gU8sEm3pLB2qO+wBTt/rO+k1AVb3t8+9L3S0ck5HkCoA3a8Wv3Djl8pnK5ig01uz0roNZ
	6nlPTGW0IW65gDLd99c04WPVpInIdM4g9tO51QUUb7cr6VneQgArHsnu+GusJzgZWAUYn3ujzWn
	6kuPzzS+arTC1njTtZtHxXBXs82tijO86kWmtVLRPizWHvGo4PuUTjpRF1nh2SRn/HNWxm8LDEx
	9U2/tuna2/NCQhIT2Hc4S9ooPqpJoeBwptTYdVOFdtDZcK6aMyydgPNp/5SiE9t5WDVB1RDL+1Q
	lF3dm8jp35PyyBGWaG
X-Received: by 2002:a05:622a:294:b0:516:d9f7:9483 with SMTP id d75a77b69052e-516d9f795f8mr183931271cf.3.1779723814007;
        Mon, 25 May 2026 08:43:34 -0700 (PDT)
X-Received: by 2002:a05:622a:294:b0:516:d9f7:9483 with SMTP id d75a77b69052e-516d9f795f8mr183930821cf.3.1779723813411;
        Mon, 25 May 2026 08:43:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f81:c9a3:ad73:ff03? ([2a05:6e02:1041:c10:f81:c9a3:ad73:ff03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4903bsm26018846f8f.21.2026.05.25.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 08:43:32 -0700 (PDT)
Message-ID: <0808cbfb-b66e-4f68-b651-03b884891936@oss.qualcomm.com>
Date: Mon, 25 May 2026 17:43:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Fix double device initialization
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org
References: <20260525151609.2826121-2-daniel.lezcano@kernel.org>
 <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E2u0856CukDFFcTebzQwz9lEpskVnPkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE1OSBTYWx0ZWRfX4FXfkRPdJ4ZL
 oct2GbCTBdRIFaCbl1fnIg6S7/yXK3ImAJ3Yyw3EPUHI0lftj2nA73gsXbdvdFKe/1EVgPC9ZSb
 1ULu+tQhOU2Te1DwEuUpRJrlzmznNdyq/+TcW5ISqImkf4nbyNtqJmB/txkJZfkYnWtlYUX2A6S
 +hbr95DYSbAfflkvdw1enB3N2KkLiiTMCjIjScN96yH+DKXQVFowD0cecEqh69PerpkZ06mIPNm
 NnxL7ZkPNSrKLv7Zy+xqqX8TAfVkdy1OJZzER3jqiGS5ib6IoZE3zZgOeOdIHLODU47jUoV/s68
 5kCNpmG0cf0qK2LKHsD8ScAFRU0BFktzBsh94KOtCmhbbS7Ds4qNJcKM8p6rdiu+H8KUm/w/Pwc
 qhWyXYPGEOC6gqXGtlmn45ibA9/yu6glRLxnkkuozRZGd8bcfvKTDsBQOZPcGdVZ6us2wGWDChe
 6M7DHjfJxPhg0dspt/A==
X-Proofpoint-GUID: E2u0856CukDFFcTebzQwz9lEpskVnPkB
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a146e27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=0776Mf_gFmipeo2xmmwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250159

On 5/25/26 17:29, Rafael J. Wysocki wrote:
> On Mon, May 25, 2026 at 5:16 PM Daniel Lezcano
> <daniel.lezcano@kernel.org> wrote:
>>
>> In the previous change splitting the cooling device register function,
>> the device initialization was mistakenly added in the move.
>>
>> This change is wrong because the device is registered with the
>> function device_register() which does device_initialize() and then
>> device_add(). That results in a double initialization and a message in
>> logs:
>>
>> [    1.531290] kobject: kobject (0000000053ba73b2): tried to init an initialized object, something is seriously wrong.
>> [    1.531293] CPU: 9 UID: 0 PID: 420 Comm: kworker/u50:3 Not tainted 7.1.0-rc1+ #48 PREEMPT(lazy)
>> [    1.531294] Hardware name: LENOVO 21N10007UK/21N10007UK, BIOS N42ET38W (1.12 ) 05/29/2024
>> [    1.531295] Workqueue: events_unbound deferred_probe_work_func
>> [    1.531298] Call trace:
>> [    1.531298]  show_stack+0x24/0x50 (C)
>> [    1.531301]  dump_stack_lvl+0x80/0xc0
>> [    1.531303]  kobject_init+0xc0/0xd8
>> [    1.531305]  device_initialize+0x3c/0x140
>> [    1.531308]  device_register+0x20/0x48
>> [    1.531310]  thermal_cooling_device_add+0xe0/0x208
>> [    1.531311]  thermal_of_cooling_device_register+0x54/0xa0
>> [    1.531313]  __cpufreq_cooling_register+0x1e0/0x368
>> [    1.531315]  of_cpufreq_cooling_register+0x64/0xe0
>> [    1.531316]  cpufreq_online+0xa6c/0xef0
>> [    1.531317]  cpufreq_add_dev+0x108/0x180
>> [    1.531318]  subsys_interface_register+0x138/0x168
>> [    1.531320]  cpufreq_register_driver+0x1b8/0x390
>>
>> Fix by just removing the added line.
>>
>> Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_register() into two functions")
> 
> In this commit, the device_register() has been replaced with
> device_add(), so the problem above should not trigger.
> 
> Which kernel have you tested?

Ah, right, I did the test on a branch having the patch "Split 
__thermal_cooling_device_register()" but without your changes where 
device_register() is replaced with device_add().

Everything ok then :)
