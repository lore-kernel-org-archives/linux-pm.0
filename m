Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C348820B
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885608; cv=none; b=kEe2LyiJzuowCoXzcfJ/xSJ9aKdoPPL+PadFsUK0VDuX7OKjoh96wV8Aqp9ba9QZGP1vR5m9dPenWnN/l0XJ/vFKD0eNg4/BaNYqWm134v3+qFrDSjr9SzQMac30hS8RnwloUdFw6lUZ/371+Xq41vD6qyOlHs6OfAtgcvPArP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885608; c=relaxed/simple;
	bh=tPuke9GZue1598rJs945YYEbvnGdQO2FD3TmVsXbGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROsyfDpQJgFI0w9Pw0TYL2XFA3+D9Bg/38h5beHPnPngj7ZxwhfpgoBW+c+/o7Du22fEfZA4uUSYqX/6Rdzq/hcu0otc6pztqvPs3rfFh1lu+DtgR0dcnO1ORYJkZmH40IMx7uLV+RBUiLVRId/GxgKCL6HBSk79deXBrG7G7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIAk8UvD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ON5Sbcg/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIAk8UvD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ON5Sbcg/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8ZjDR3054783
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=; b=HIAk8UvDljORE4jX
	4/vr0PByQOq/FC2imvFYV30TGaKOC5OsHNY6mGoV9r9vLRSIkz7fe42rJkls406f
	XNdnn+9MuVMLAsXj2m8/RN/0LKTQJop2dUvqK12WHyMwXlzU6CtIzLjUcfnjcWOK
	7hbC0HVYuonELceH2QW45VDzI35C+BR2qiM+nc0GcnpGNiUmZVmuwT0l6VfrfcUO
	xgRNxVUcuucOJU40qWRT7AKOV/YIGmRaA1NeZh6E+v8hJfKH7+g390Ff5yc/niZ8
	eoka+PggHkPly8uzatMw/TWPzhvr0fwBc1FdNsYnqzlhGNubYYMOHZGa9InFzqVc
	po1c7Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeup0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:00:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dea1b6c89so536657485a.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885605; x=1792490405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=;
        b=ON5Sbcg/IkOxTEqL9l39RNefOphsxQIVoCJ06ts/KcC22sWrXcKlVlYVvkYkmgiTG3
         M+gWaPCcyqKpS69c8U4QuGTgBkgLziwjlsk/f1pKa2Rf9QMmG4uJhnbaTdMp7DTztRQ9
         fhg8NJNNRt5WyjE+5hfVDvghGRaOB2of3aD2IwMyHwJB153myPfOVoVY0wIbyPQiLTFO
         9MgB05ywVCSZj1r23bthQ5cAoLH4ZjZkZsC+j9MN6VPClvyWqhcDjLJHOSHOc/qwswXW
         TKiNz2/iaPVV8kFs1wkocUwXQ1faQB4CAVQL9TY5q31c5/2hn0cZ+52G3FT6mT43UuYT
         KOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885605; x=1792490405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=;
        b=vhYmTjTe0BwAM2dGbtyaeyXlDcKDj0YiG57gK4/E56tkhD8mwmXP1CtHENvjzY2z9K
         wQHtq8Drz3X4N1j+VlLdan6JQtGah7YJddubUYKJc4HDnR00oPorUQGfOkgyyk2h91XI
         8C3xfqm26TNi1BaC105ynGda/gTT9bn0dRm8HDMm9rl+6Uf7df2uADXcDKV/rh9MPtkZ
         U2homHFKZcFmIyRx5QN+rlJJ0BQ2cVgjfb7oFEZwpZbEfDgS/S0au4Ypve2SMO6nfZFy
         JYna3o+/W2CTv6E5Gap56rwwf8LAmKQiLTDsh16idbhZpYs7ksvw3Oyd03vkD1+KVeRS
         kvig==
X-Gm-Message-State: AFq9FYKqphlQs2iRSqs7f8krWLvLVNHyissHSWbPc1vFxGhkobmu1j9L
	3w2jAy8xve36UPjSrOu+0IUCtbUr8LRRKKJoOrXydU2dNvq6oup30MYmeZRjHJI0CtFVC0MvrFo
	3syQwTRgZbPpo4/o+GrEWSa/05MYfpaZxQlYIz6ThjNSQXp+noL9v8r6jzPSq2w==
X-Gm-Gg: AYBFou2aP8fRBUZL7HcjbD8cX/8cz5dl/o/FlXTXoG6zoEriK+hkS9cJQOFWxcuoMPF
	rlNCD/dv00KztL3GNh7t1rJVJyltkLWKBSv4HF4mfHEJqxpTAZ0Bs3bUCHLu0zficPUw2ZzC8Z5
	vmeZY4968X6U3k6u91ofGCoIXOF2NTF9ruG93CcXjxOMB3y+cQzseUKOYk9Y5sZ0EckvkIZmNRN
	KDNKuVc2VElSeI/LXSULwVCnYdJ4Dj9P3+Y6I3kr9x/XRGVLmVI7AgDIZQ4fsG7vGEm3r0VeFFr
	PK75KK8ZCI9TjF0fCKYecGnTj+j4W4HPs5r+Pbcv/cjQ1b0SNtzLtzOQjkPkTcQj+EC51WsuaOu
	X0vuxoAxznC/cg5UljqlJCZCpSLXT3U5PVJLrKsrdHeM0As73OYUsEugK9rlkiQ==
X-Received: by 2002:a05:620a:271d:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93ebd0df02emr1885362085a.6.1791885604864;
        Tue, 13 Oct 2026 03:00:04 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93ebd0df02emr1885354685a.6.1791885604246;
        Tue, 13 Oct 2026 03:00:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaaebsm4390052f8f.14.2026.10.13.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 03:00:03 -0700 (PDT)
Message-ID: <f01126d0-4ad6-4f23-bf00-88521cd0c2b8@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck
 <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
 <20260805-pscrr-reboot-reason-v4-2-54ef517084cc@oss.qualcomm.com>
 <07562f41-c269-48b7-9ca2-be324282a456@oss.qualcomm.com>
 <8774f401-7efa-4577-8d03-6fe652e856e3@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8774f401-7efa-4577-8d03-6fe652e856e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 15Y3PvHAe-HzYB23jAXXTiQL40lWQyzu
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace0125 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=a5JEe3mAxTw7QyptA7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX8c8lLWTCyy6B
 zBTXzNf2NWzjPLEqzqq5rkGYU7OxGKjDmV5mxRZYrpmLU134BZL7BcPaYfelFiFqRFBUSGzuIu8
 92B9KzgwM19Z9NP60a8CbhhP9QwWxa4=
X-Proofpoint-ORIG-GUID: 15Y3PvHAe-HzYB23jAXXTiQL40lWQyzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX1ISto0jeO8Vg
 aG7VQtZl7pGJKCE+VUxTPm1PhcUAlocOemEvj2y4shGtASLvUtmmvQ0ZPghRdO/iF8Gf66WSEFX
 JT0WKaVPU10O/o8HOY6zHAX90NZVbjJTjKP6lKdtcL8KGnpgpygWiP+wuJQ9yLChZ1XVstmh5/T
 4rKBzIL8TEZ9msFEzwJWs7QpSO5ReuGfuDKxkBZ7S7o0GeEArCndfCDx4Dk2Se3wHAn5jzV6Wk7
 CV9W86M35992R8Ai4P2lXIG5jbWnJwHtNsYaONDDe7dI9yI0CJoH+o6AU8FTXLfHrtQ4tzMvAiv
 ducVlE1K0Ds2WVZurTY2eT/o27K9/4OYBthXt9pcQJ59Q6SnheQKp8Xs0hOuFR8vGrpg83TDy3e
 Bk+DJjoxKg0pOTLjdcYwyZz6sjwL97BSsy/Ni+5+uydTQxpOYjbuLuQ+byZPv1jPFisJi7O4zhC
 0ky64681566Rm3C24pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130039

On 10/12/26 13:06, Faruque Ansari wrote:
> 
> Hi Daniel Lezcano,
> 
> On 07-Oct-26 4:24 PM, Daniel Lezcano wrote:
>> On 8/5/26 10:54, Faruque Ansari wrote:
>>> Watchdog pretimeout resets are not recorded with a dedicated reason,
>>> causing subsequent boots to report PSCR_UNKNOWN and making it difficult
>>> to distinguish them from other unexpected resets.
>>>
>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and prevent the
>>> panic notifier from overwriting a watchdog pretimeout reason with
>>> PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.
>>>
>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>> ---
>>>   drivers/power/reset/pscrr/pscrr.c     | 11 +++++++----
>>>   include/linux/power/power_on_reason.h |  1 +
>>>   include/linux/reboot.h                |  4 ++++
>>>   kernel/reboot.c                       |  1 +
>>>   4 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/ 
>>> reset/pscrr/pscrr.c
>>> index 8c45b84059a9..b7e6239e207e 100644
>>> --- a/drivers/power/reset/pscrr/pscrr.c
>>> +++ b/drivers/power/reset/pscrr/pscrr.c
>>> @@ -529,12 +529,15 @@ static struct notifier_block pscrr_reboot_nb = {
>>>   static int pscrr_panic_notifier(struct notifier_block *nb,
>>>                   unsigned long action, void *unused)
>>>   {
>>> -    struct pscrr_provider_dir *dir;
>>> -    set_psc_reason(PSCR_KERNEL_PANIC);
>>> +    /*
>>> +     * Do not overwrite a watchdog pretimeout reason already set by the
>>> +     * pretimeout path before it triggered this panic.
>>> +     */
>>> +    if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>> +        set_psc_reason(PSCR_KERNEL_PANIC);
>>
>> It does not sounds correct.
 >>>> May be you should move the set_psc_reason() to different places for
>> panic.
>>
>> I did not explore the panic() function but I would suggest to have 
>> something like:
>>
>> panic(..., ) --> defaults to PSCR_KERNEL_PANIC
>>
>> panic_with_pscrr(..., reason)
>>
>> Then pscrr_panic_notifier() only does the record
> 
> Thanks for your review.
> 
> I agree that handling the kernel panic reason in this notifier may not 
> be the ideal approach today. However, my intention is to add userspace 
> crash recording support in the future as well. Since this notifier 
> already serves as the common point for recording restart reasons, it 
> seems like the most appropriate place to handle userspace-triggered 
> reboot reasons when that support is added.
> 
> For consistency, I added the handling for kernel panic and watchdog 
> reset reasons here as well. While they are not strictly required for the 
> current use case, this notifier is the most suitable place to record 
> reboot reasons. Keeping all reboot reason handling in one place will 
> also make it easier to add userspace reboot/crash recording support in 
> the future, without introducing a separate mechanism later.

I understand the purpose of the series, but setting the reboot reason 
directly from this notifier does not seem like the right approach.

The notifier should be responsible for recording the reason, while 
determining and updating that reason should be handled independently, as 
it may originate from different execution contexts.

The need to explicitly check for PSCR_WATCHDOG_PRETIMEOUT before setting 
PSCR_KERNEL_PANIC illustrates the problem: the notifier now needs to 
know about other reboot reasons and their relative priorities.

As more reboot reasons are introduced, this approach will require 
additional special cases and become increasingly difficult to maintain.

Wouldn't it make more sense to centralize the reason selection policy, 
keeping the notifier focused on recording the selected reason?


