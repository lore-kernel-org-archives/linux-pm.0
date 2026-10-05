Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8763DAAB9
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203243; cv=none; b=GgfiZ7/8B9gA/GJoKYr2iAVXHKz8cjrYNBYf1DwtIhbYVAeO9iJPr5c8lF/LzTigB3Oe4v07iBScfsKd0Tax3k+XWJKdaQI5bQW/M8svtrvYGlySdYLSFe+ML6pCxEB78v3KeiCCBCkUTc+OhDueSqKZLtKNWCVHhbwDRUKGdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203243; c=relaxed/simple;
	bh=HM7xWW72inL8pVXjHxjEBpKztV5Tkb4GWN6CBp2ZAo4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pFbt3DKbvwTNEaMiYw1QikWuewthrOq6bdiOfQWXMCADkJmq9lNaiueUjHcyOEWkm06kWTh8Hg1svfQYQipsg5Y/9M0GU102DXxQ/RKfojtd4x+DrJYtYKrRBHgwfUDqDPYgDFDp2geRQyowFoX/+gLrrs1jUoyctX/ndFLa4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjWl7pS1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jNyvKZIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjWl7pS1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNyvKZIF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFR3D1726869
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ku1JxzIA5L2qSeOtjta51eOG7KEMsweqrxxJaRm5ZmM=; b=HjWl7pS1l/rXQ5fC
	iBy57nsVs+CQ6C+sC+fjd0uEl54MLMqHzIKkx1wI4Gzsan4QUJYEgR/5GH0RWkUI
	FvqLEOCvkW3/ZIumt362q+uWEcHNHurQ+O1fHBkk4cRevEv/7eFrKWDQtxV1uJSq
	hNk8JG5/1pFdea4OBIJ2ksRtMErB4VCsCSXEzWxQzvO0cjDub7GnbXC93VRpvnvl
	t424W32a8IuNIp+9LZkGCCBN5GuI2c9aO7SyxhteBJVlxQ94xjM+OzL5bDVHWWZK
	mwGWCP0dZYDgIbLDjTCXUH1oS6vBNvBilnk47h6cKCpa6Xhtfy+Hlop7qPHjAfGj
	Vm36Ug==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs20rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:27:20 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-49e379ab077so1951434fac.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791203240; x=1791808040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ku1JxzIA5L2qSeOtjta51eOG7KEMsweqrxxJaRm5ZmM=;
        b=jNyvKZIFzqKokh9TTeAz4ZPXmpKTnspUxfWQmfBbXCCbMvo635rvt0RekjjP33ggy/
         m7l4URmd2Ij2lCRtcRt6Ssw86oOa+Cu0VUcOCIT/aeP0dZXbDpYZjErNhteiDz7kx8m1
         FkvsC1/UTDGalPHqz9GXIxxVRz5VOpMCd5U5MSohy02g+3UDfZxRIsxbjhMObSDayFr8
         HON/Np3C88gh4+PKBWMLVNfJtFomvZTfYxzmp1JkJhiJiX55mgIC9UDrhlDlYpNq7N1y
         9CrcQUwPqbUQ/UfO9jhuGaZHrU6Fan9TSZVFwc7hdC6211oD51BRYgxvD+2ZUMcUyI5H
         nV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203240; x=1791808040;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ku1JxzIA5L2qSeOtjta51eOG7KEMsweqrxxJaRm5ZmM=;
        b=aOkx0PrtkV6LAsRRXjN9iMR6qI+nncttPlp1620KJp4qWvsu200ZstdzVMzNY19Eh5
         AJwQSdxw1k8zoq7L6WlnEnPAN3Hf5o81etwAYTSFkhpm5r6OkJtY03zOJt1RJ0gsYeJ7
         +k4Wnesqq3yNEeI7YTKzzNt53FKRjIam7yowc6cz2/dY+I6d41W+UW+rOq88oQZHEPpj
         Nl1432H4TBhypdUikuN/kmiqVIDhFLyGs1OsbRfHVEGtU2CSfzkvER31Y/uBl6ywgBf8
         JVn5Devm/kI6P3KMDnzA3lm1vsDCUwVZN1i7nVtzJwhg5plSBMsQTXwSNBShAPMt50IO
         yO5g==
X-Forwarded-Encrypted: i=1; AKwUvBxb46J1O7Y6SfBsAWEHBY7oolqbITyJmCyaXeil87rToi4BZrh1OHXPXUEmgJf0KnBHAIeyDd/KlA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLNbvrWt7wGMppRWh66nwDo30SyXr7uG6x0t9KvKuzg0KRRVJy9
	AJIygF70UaGzuCv81Lzy46nV9b6W1RxA1dFMwcnBRq5lOrwnHObKbKWIMM95+4vN3D2qAHcaJTr
	AoWUv2JXUm6zEPqP3QRSyoGPntrqwPgkKUJsbKDmmCkAiYrld55wDnM351ESe
X-Gm-Gg: AYBFou0y06Ur8Q9I7ykd651HMKtVRDk32l3Sko1SpH8bXMdACgQxfKnsKLQBkPF/GFj
	/WD5Nm2psqzwi/6pDP3cWD8fo5i55L9zgIswhGFv9Eie1f3tHjbd74Kj1GPxrBv50ppeTMqsGG9
	9I2XU7FxLigW4TEbv+i2L4wAS8wr0YUVDkEBIgv4TfykV2nmwvZ/L6HStGY4dxMh7AoRAhbYhge
	1ReMBJkBYINXl7pAzL0WTqE4GkFeEaXVfPvhV6+E92eYwx1FapYM7yQkbkHOY6yNcpE2Cq4BFPG
	t0QCZ0oMBpnNaxJ4WsgViXRjjc3xNLih4Hu8oI53lRl6vFOd8ugGGx8cnGfA00OTqKLRZyjCEJJ
	GTqou+oYF7i2IubI/bbNxjWEfsNzZNw==
X-Received: by 2002:a05:6870:8262:b0:48f:e363:5cc6 with SMTP id 586e51a60fabf-49e1600a4cdmr8908538fac.52.1791203239721;
        Mon, 05 Oct 2026 05:27:19 -0700 (PDT)
X-Received: by 2002:a05:6870:8262:b0:48f:e363:5cc6 with SMTP id 586e51a60fabf-49e1600a4cdmr8908496fac.52.1791203239158;
        Mon, 05 Oct 2026 05:27:19 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16a4ecacsm9110158fac.1.2026.10.05.05.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:27:18 -0700 (PDT)
Message-ID: <e4ff494b-0321-4d63-b648-1b26f42be2b3@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 17:57:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v14 2/6] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-2-a16290003b7c@oss.qualcomm.com>
 <ar9e9-xnxO8rbJk0@mai.linaro.org>
Content-Language: en-US
In-Reply-To: <ar9e9-xnxO8rbJk0@mai.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2lIxkb9s7v4YahHRnO8cACpoCJsUwx0w
X-Proofpoint-GUID: 2lIxkb9s7v4YahHRnO8cACpoCJsUwx0w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX/9dVKkZqyU+L
 O+77Cf7HIFXxu+hJHyBoSFMm58vifEHbQAqV8qSJySwSnLdicj1gtMUyT1mjwBWPjRktcyrJ1P4
 qaVXNGWB2vlZEnjZLwtuI5wZ/VsAa2E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfXxJ6bPkcaz9NH
 4NKkAjX2sCCGRYgp7fp+74v1irsqcB9YX4wkExTvr8vHrCfEf0LwGdrtEiTrDBXhiWHt9lPwXAP
 OHa67U+AY//dPY+le0/4DxlGXig3HGkCmfKgJASbbOsZi+gZ+dYohCamSUhEMCZ+kPSRnSTYUKZ
 q6s/r9DCA3Wxc4AHGMsMP9lC+ggJJKkO5yB0BELEiSlzArzWM0pbPZ8jwk8WRxNFo59xFr6mWQf
 amk3T9JOoI/y/tAgkVPs+rs0bA/Y+f1s7YbfiGG1uIRVdVjsTQSejGS2SHXf9VW2fUeBmvsOmdO
 NzpOLLADqEK6oDfToQHdQvb/YKosxRNV1IQcE/lrgLyKn3NH9JI6S8h1tXTvvWMnm8R4YHGnNRS
 YY5dv8q2LKLbSIf3Aixq1DsdchT4xd3sx3w29dhgw1iDv9iCPnLOA0QvbVVpcKQNDW/biC0c10n
 J6kYapJUMg0tTvFBwsg==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac397a8 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=djRMLSAIY_qdro3gjIQA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

Hi Daniel Lezcano,

On 02-Oct-26 1:17 PM, Daniel Lezcano wrote:
> On Mon, Sep 21, 2026 at 11:14:17PM +0530, Faruque Ansari wrote:
> 
> [ ... ]
> 
>> +/**
>> + * enum psc_reason - Enumerates reasons for power state changes.
>> + *
>> + * This enum defines various reasons why a system might transition into a
>> + * shutdown, reboot, or kexec state. While originally intended for hardware
>> + * protection events, `psc_reason` can be extended to track other system
>> + * transitions, such as controlled reboots triggered by software or
>> + * maintenance operations.
>> + *
>> + * The values in this enumeration provide structured and standardized
>> + * identifiers that replace free-form string descriptions. They are designed
>> + * to be stored efficiently, making them suitable for use in environments
>> + * with limited storage, such as battery-backed RTC registers, non-volatile
>> + * memory, or bootloader communication mechanisms.
>> + *
>> + * Importantly, the order of these values **must remain stable**, as
>> + * bootloaders, user-space tools, or post-mortem investigation utilities
>> + * may rely on their numerical representation for consistent behavior.
>> + *
>> + * @PSCR_UNKNOWN: Unknown or unspecified reason for the power state change.
>> + *	This value serves as a default when no explicit cause is recorded.
>> + *
>> + * @PSCR_UNDER_VOLTAGE: Shutdown or reboot triggered due to supply voltage
>> + *      dropping below a safe threshold. This helps prevent instability or
>> + *      corruption caused by insufficient power.
>> + *
>> + * @PSCR_OVER_CURRENT: System shutdown or reboot due to excessive current draw,
>> + *      which may indicate a short circuit, an overloaded power rail, or other
>> + *      hardware faults requiring immediate action.
>> + *
>> + * @PSCR_REGULATOR_FAILURE: A critical failure in a voltage regulator, causing
>> + *      improper power delivery. This may be due to internal component failure,
>> + *      transient conditions, or external load issues requiring mitigation.
>> + *
>> + * @PSCR_OVER_TEMPERATURE: System shutdown or reboot due to excessive thermal
>> + *	conditions. This attempts to prevent hardware damage when temperature
>> + *	sensors detect unsafe levels, often impacting CPUs, GPUs, or power
>> + *	components.
>> + *
>> + * @PSCR_EC_PANIC: Shutdown or reboot triggered by an Embedded Controller (EC)
>> + *	panic. The EC is a microcontroller responsible for low-level system
>> + *	management, including power sequencing, thermal control, and battery
>> + *	management. An EC panic may indicate critical firmware issues, power
>> + *	management errors, or an unrecoverable hardware fault requiring
>> + *	immediate response.
>> + *
>> + * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
>> + *	value is useful for range checking and potential future extensions
>> + *	while maintaining compatibility.
>> + */
>> +enum psc_reason {
>> +	PSCR_UNKNOWN,
>> +	PSCR_UNDER_VOLTAGE,
>> +	PSCR_OVER_CURRENT,
>> +	PSCR_REGULATOR_FAILURE,
>> +	PSCR_OVER_TEMPERATURE,
>> +	PSCR_EC_PANIC,
>> +
>> +	/* Number of reasons */
>> +	PSCR_REASON_COUNT,
>> +};
>> +
>> +#define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)
> 
> May be I missed it but where is PSCR_MAX_REASON used in this series?

Ack. Agree, PSCR_MAX_REASON is not used anywhere in this series. 
It appears to be a leftover from an earlier revision. I'll remove 
it in the next version. Thanks for catching that.

> [ ... ]
> 
>> +/**
>> + * psc_reason_to_str - Converts a power state change reason enum to a string.
>> + * @reason: The `psc_reason` enum value to be converted.
>> + *
>> + * This function provides a human-readable string representation of the power
>> + * state change reason, making it easier to interpret logs and debug messages.
>> + *
>> + * Return:
>> + * - A string corresponding to the given `psc_reason` value.
>> + * - `"Invalid"` if the value is not recognized.
>> + */
>> +const char *psc_reason_to_str(enum psc_reason reason)
>> +{
>> +	if (reason < 0 || reason >= PSCR_REASON_COUNT)
>> +		return "Invalid";
> 
> s/Invalid/Invalid reason/
> 
> [ ... ]

Ack. I'll fix it in the next revision.

Thanks,
Faruque Ansari

> With that fixed you can add:
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

