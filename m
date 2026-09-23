Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127A49C4DC
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161570; cv=none; b=f0mrSaSICIi0haUCA7A6Od4qPgKWbBc5n88dnfQ61bvGbMy1OVgyjngQ4QYhe5OslXaWFWNpNPk77rmfIL7QG6HvPiW60mVQF7MXbg92AC0pAr9RV1mrR9lhsJAWLIX+ulMfiQ4sbr/FF83kK9+LwOrq3oOh+KmJV3nritC4MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161570; c=relaxed/simple;
	bh=ri1HNhpNEI3K8NJVTZY7ebXc6lZQ4qegKWKC0fyDXjo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u/6LpDFAzv/8GgpnF3bLa6K+vocTMaIXCBlgoVIRwYZSJYwLP8lQqrYkQBy+qgNfDgGUb8NdFV3wrTb8AlwvOtcXlpiSfTli2G1p+m2nc2ztrzGc6WZCp+2pSXjD5nMIK0+oXfrgvK7HsYBc4KjzwuLXIyGkucRqq46TciqdK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6aY5p0A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HvYhw/Eu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6aY5p0A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvYhw/Eu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2eIN2429380
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KJ8lUL5dHlGO0bO+PzLCGDgueon+wOA/1PhqsdFHMjI=; b=S6aY5p0AQtp2nezk
	x7UO8r0iOX0RIe3dgAFtTnz302sb7tzZJoy5m8tFjJz1p2B1SY2rMo90QaLG5XyD
	wI3h7K/hpzPHhTKVooOzBgxandIYeCD2Rlgi8zeKRu3YDLM0kdlqPcUC74Ipb7BC
	wPWBaHZPVXFbEnZDrJm5KYhHSBXq3Bhaz2E1G0agi2dihVD0TNY+UuHUqJfILh7Y
	2UvKjjh8/1+/5DvpNBwadSmEb8TQSLyaCKiNQaYok//xe0mJE6sS47C6sZ6TRkhq
	1n0573+GNaeE44VRtN350BszhBobTWF8EAZ94vFB5DPpCAIh4ZTUv9B0roS9GR6S
	+27XsQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqh6w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:06:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso841425eec.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161560; x=1790766360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJ8lUL5dHlGO0bO+PzLCGDgueon+wOA/1PhqsdFHMjI=;
        b=HvYhw/EuUPS6QhN4c7cLl2IbhKPSR4Cv6CHXLXXc44+CCQzgrtuwxsqYPIulhg2RRo
         aCkbTP0Eyiw0QexZmf44Ala4EHNOByUacGyP2oM+CmtlodVEw0gVxvi7FiKbfgnfYZwS
         seqtmHWhY20QRrSZ5Y3Lxn8hxVHs2/x+h2GZOWi3+ZQqSlO2ZC6xOMt2pbh1VSXdZL8+
         Kf0xDZESUB/Bxe6+bw7SWsokqc/sPnqG0mbxZZJlPRs8etTaDzhABZETKa4XpRY2+ilz
         TOJyrIaenXAeWb7DEG2slu2DIX6HxuD4gTv1HrRvUE9oVKI4Q+1WWwQplXqEmPAciMo+
         L8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161560; x=1790766360;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJ8lUL5dHlGO0bO+PzLCGDgueon+wOA/1PhqsdFHMjI=;
        b=cb3isDTut7Wck/8c0pjgl4pKvFMZ1qBaD6xixMAYKaU2Va43FGM2Xym3yvHTiiFLXr
         5rMgwmgktzcB9n9lyYK4a23YZENkOUb4vGcAhfUcSmkzrxCCoovtwxMKf9v6F3fsS6i6
         +RX/J11J0fMwn0dzaiaxdRx8zLqNPxpXDrLKtb9grgv9lsRzh5nRFgA8qrmc2gW5Py0m
         B25Azm8OUUZEwf5Aa7ZxjnUNH4+v/6u/Fa9HQypNMiuZytgPh9Quqdq/oRsAdILu8MXn
         xMcHnKO0a1t8YE00MRTzTPBYpirlOERtJiS4WKyV3Z8vLRmUCOU9O9Rez+y4Zpwbhj+f
         D+Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwWety697l3a3MvV0McgCWXc5rabrcB3qXkM+mfDkWJVY4HWZyox3h3DiceQImGOS6R4/Sh1YVWCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nBTrsvs2UfZk49JpgChP+q4IU0AxhzUDagoBC81PBo5RNj7WBP
	EefeQAFgImg+AierTIRwPxfqJ/jU9bPJK468ltZnSPnYqbY76Z2oAz3GF1eaA8Upf2Shzwskpka
	EUeYNAVSubvJzxjUXUDGn61XPT4TPqJvRqAQrayKpo2pdsUWvIINvgPgivUo4
X-Gm-Gg: AYBFou0stJR2zsJDww+9Ac3tvfKzPStBkIzLQdO+FFxeKNDNXvN9Z2/AFD6wBTEg/M3
	4smlEfeSEWJ7dSxZttXwUjsPlWW1dADZrnIFXf4ZkcQgDgCSju+YTETR2/wLiyud2u7D1+9GvXk
	15IaKJc716tFOUwnm9mSVUWBLK2qyqU96NJcIgvZZzpEK5xNjyxwttgg+pjAsv0hKFZkUY8TTAi
	8hh3Tgh8XkAzJbfy0s2Dpm1/+D3YbtpyT39FxgXhlBLBj7aSrWpywEvuOeCww/Mlb9tDS2lijCR
	O3uZlWkdc3uMZIMaQjShK7gNGWUkHokS6fYeoRozAT8ljgW3rxOIJOrG2CQy4qMcibq078Hvldh
	Pwg+rP677hI/y0l7akhRWpb0kkpRFcA==
X-Received: by 2002:a05:7300:2449:b0:33e:648e:d6da with SMTP id 5a478bee46e88-33e648edd00mr2396924eec.3.1790161560065;
        Wed, 23 Sep 2026 04:06:00 -0700 (PDT)
X-Received: by 2002:a05:7300:2449:b0:33e:648e:d6da with SMTP id 5a478bee46e88-33e648edd00mr2396851eec.3.1790161558688;
        Wed, 23 Sep 2026 04:05:58 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684ed70sm5224624eec.19.2026.09.23.04.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:05:58 -0700 (PDT)
Message-ID: <f0eef0f2-bd56-47e1-a3e5-5e83a1680c02@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:35:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v14 4/6] reboot: extend psc_reason with power-on and reset
 causes
To: Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-4-a16290003b7c@oss.qualcomm.com>
 <9ba75a42-a3cb-4ee2-bd29-84f23bbaa70c@gmail.com>
Content-Language: en-US
In-Reply-To: <9ba75a42-a3cb-4ee2-bd29-84f23bbaa70c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lqipvMmMfzC5Z2UEf8S9D4VcUBx_hFuP
X-Proofpoint-ORIG-GUID: lqipvMmMfzC5Z2UEf8S9D4VcUBx_hFuP
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3b29a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=DLwBeq2uPfsNgwiNNIgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX3ovZ1h/qI5C0
 biO6RsXuwR3r+QkVDc6ZVoZDeq/KWU7qhOLX43EaCSxn07Ve+09QcR2cIYuVxurpEgQMWGjCvMj
 Ci1MUwjGs1dgrdsvy6AHfNjTO7mg2oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfXzhxc2Cac6tmE
 LUm0Zijhvt3sm+FgDtaafnMEwL8g8V7poKSEHou5bNqN2xmKFHF/rxSX0Dv6XamiZIntHwZ6s5o
 vXvYWg3HaAjysxGKBaHiNioIfmHi/ctJn/DKtyLXJ9550/u26czBeaXTbtEkjL4vEdlHHxuC4TB
 wQ9hjuYy5uaqf4WZW1TcTTjQE0G771RvVIOgrod7PvHXwThceltiEnnTtj4VlQ3F7Lv4rlMx5s7
 6/8UPnw51KxXRoPySnhXUb5xOIXHdNbUoMhUf26h9wVhlo31JmMnr14X9nOSlDYOWkXuVKA5AVT
 RevPppDn7Vv7awE3DryJF22sRku+0HLUCeDZ4wecHmhEZ0cc7myYmrXzR/MEDKKoskJ5pfnpZnK
 kvNk5G+UIVkIdaIi+/uE8FjTveBXAFWBQ6RlbvFmFq/qulXKwGNkB5RWZzoO0xXGj1pQhV+Teff
 oXe2nmJdlrFhzc9SPUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044


Hi Matti Vaittinen,

On 22-Sep-26 1:15 PM, Matti Vaittinen wrote:
> On 21/09/2026 20:44, Faruque Ansari wrote:
>> psc_reason covered only the protection reasons. Extend it to 
>> mirror the
>> full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
>> external, RTC, reset button, CPU clock and crystal failures - so a
>> provider can report why the system last powered on, not only 
>> why it was
>> shut down. New values are appended to keep the existing numeric 
>> ABI.
>>
>> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>
>> changes v12:
>> - new patch
>> ---
>>   include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
>>   kernel/reboot.c        |  8 ++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
>> index 4c5327dd7645..13f004ad1066 100644
>> --- a/include/linux/reboot.h
>> +++ b/include/linux/reboot.h
>> @@ -225,9 +225,28 @@ extern void orderly_reboot(void);
>>    *    management errors, or an unrecoverable hardware fault 
>> requiring
>>    *    immediate response.
>>    *
>> + * @PSCR_POWER_ON: Regular cold power-on (e.g. via a PMIC 
>> power-on request).
>> + *
>> + * @PSCR_WATCHDOG: Reset caused by a watchdog timeout.
>> + *
>> + * @PSCR_SOFTWARE: Software-initiated reset or reboot.
>> + *
>> + * @PSCR_EXTERNAL: Reset asserted through an external pin or 
>> reset input.
>> + *
>> + * @PSCR_RTC: Wake-up or power-on triggered by the RTC.
>> + *
>> + * @PSCR_RESET_BUTTON: Reset triggered by a user reset button.
>> + *
>> + * @PSCR_CPU_CLK_FAIL: Reset caused by a CPU clock failure.
>> + *
>> + * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
>> + *
>>    * @PSCR_REASON_COUNT: Number of defined power state change 
>> reasons. This
>>    *    value is useful for range checking and potential future 
>> extensions
>>    *    while maintaining compatibility.
>> + *
>> + * The reasons mirror the POWER_ON_REASON_* strings in
>> + * <linux/power/power_on_reason.h>; keep the two in sync when 
>> extending.
> 
> (still a nit)
> We should now also ensure the psc_reason_desc[] in reboot.c stays 
> in sync... (See my nits for 3/6). I have a nagging feeling this 
> is not optimal :)

Thanks for the review.
I will address this in patch 3/6.

> 
> Is there a reason for having this as a separate patch and not 
> merged with 3/6? If yes:
> 
Yes, there is a reason.
patch 3/6 introduces the mechanism — the struct, the token/label 
table shape, and the two accessor functions.
patch 4/6 only adds data on top of that — new enum values and 
their matching table rows, nothing else.
Keeping them separate keeps each patch focused on a single 
concern and makes review, bisection, and potential reverts more 
straightforward.

Thanks,
Faruque Ansari

> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
>>    */
>>   enum psc_reason {
>>       PSCR_UNKNOWN,
>> @@ -236,6 +255,15 @@ enum psc_reason {
>>       PSCR_REGULATOR_FAILURE,
>>       PSCR_OVER_TEMPERATURE,
>>       PSCR_EC_PANIC,
>> +    /* Append new reasons here; the numeric order is ABI. */
>> +    PSCR_POWER_ON,
>> +    PSCR_WATCHDOG,
>> +    PSCR_SOFTWARE,
>> +    PSCR_EXTERNAL,
>> +    PSCR_RTC,
>> +    PSCR_RESET_BUTTON,
>> +    PSCR_CPU_CLK_FAIL,
>> +    PSCR_XTAL_FAIL,
>>       /* Number of reasons */
>>       PSCR_REASON_COUNT,
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index e53fb31bad06..5d4ecc82b35e 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -1102,6 +1102,14 @@ static const struct psc_reason_desc 
>> psc_reason_descs[] = {
>>       [PSCR_REGULATOR_FAILURE] = { "regulator-failure", 
>> POWER_ON_REASON_REGULATOR_FAILURE },
>>       [PSCR_OVER_TEMPERATURE]     = { "over-temperature",  
>> POWER_ON_REASON_OVER_TEMPERATURE },
>>       [PSCR_EC_PANIC]         = { "ec-panic",      
>> POWER_ON_REASON_EC_PANIC },
>> +    [PSCR_POWER_ON]         = { "power-on",      
>> POWER_ON_REASON_REGULAR },
>> +    [PSCR_WATCHDOG]         = { "watchdog",      
>> POWER_ON_REASON_WATCHDOG },
>> +    [PSCR_SOFTWARE]         = { "software",      
>> POWER_ON_REASON_SOFTWARE },
>> +    [PSCR_EXTERNAL]         = { "external",      
>> POWER_ON_REASON_EXTERNAL },
>> +    [PSCR_RTC]         = { "rtc",          POWER_ON_REASON_RTC },
>> +    [PSCR_RESET_BUTTON]     = { "reset-button",      
>> POWER_ON_REASON_RST_BTN },
>> +    [PSCR_CPU_CLK_FAIL]     = { "cpu-clock-failure", 
>> POWER_ON_REASON_CPU_CLK_FAIL },
>> +    [PSCR_XTAL_FAIL]     = { "crystal-failure",      
>> POWER_ON_REASON_XTAL_FAIL },
>>   };
>>   /**
>>
> 
> 

