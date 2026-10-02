Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5D446BEA
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927264; cv=none; b=fly3pBLyOz0Y+y11akbO4xFlLLLz/b3v2AflIn/rYgo3Cw7ujX08kPZaNTnu1ocN1pUeTDmsXC7G8/nTYb/Y34mvPovg5z0V8ptzpcZ1WdtfcccI4FTcL5kPv55poS/c9zc9bZ+9wpx5J6eXs6Gh7tJ1YG1aOXyjeYGXM5UK67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927264; c=relaxed/simple;
	bh=GsiBeouX/gtaMf4zOeo+rrTtK4Uq5wqLAWhlg0LU0nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4Y1ChxTiEvfr47RCfW3ACd1ZJr+XS/rnBWFyYkZAKiZaBF3GS1bQY7+voUkNDH7uEuB9WJaocNiop3RNhBXkr/A7eWFjl4gTEQrczHbEZ4fti3L/ii1zXM9EZSZnqIzkcZgoRrIY9Clvy0bXQozuknBDm7CV4O3/iWDTAvypbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLCHH9ji; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXifZL0y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLCHH9ji";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXifZL0y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925jEKb3415591
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 07:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=koV6fU0fBroPWgISEdPaMuGQ
	L0eL41QYrOdoT4EtC4U=; b=cLCHH9jiXbsSGmJ+tqO9aDNUTBNApEwWtKKes23z
	sPBxgFVeLXGN4ueIFrGFXakHGUflp9yq2+7fm1ktVfD6LArlcXfLmHuCxmcdkkCT
	D/WVc//7fa5pibXdEyoWnR7CWLFICLA/BY4F76o6T6gl8KifANcjwZ6Pw9S0PWKP
	EEMaPqbszLMf2rS95XltMTtP8lwpcGgKlr7z0mc2wcfN8EWp+dtqobSrfX1oOzVW
	o8u/unPL/QlRx8FVT4uQWNS9qTnDFieviRbc/uBesDPZ3bonBGn3POFCPxZsg3ZT
	YNVThu6zCo+P4cgSY3ILopBFhCH1qkBMfl8ypq2ILV+KoA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxea6p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 07:47:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ca9b53afaso634272285a.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790927261; x=1791532061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koV6fU0fBroPWgISEdPaMuGQL0eL41QYrOdoT4EtC4U=;
        b=UXifZL0yeFI3n06Jy/5MUP4vbqsJbnSTA/MbsdNNYWLRsMANKmg+okhgbJVHWQDWnl
         0FePA5N2RnO2LVPefLs6a7x/JNd+WQfubY55wD19RQ9N0L84BQmvGy/G+1g85ATNwKbw
         W9hpxBFLNJEwyzEoCS1Q7KEwHNVdTfDDQRWT9ZM26eexdU4E+WMcw6/6DtEocVtbAZxU
         MXo4tCQucvWpxbA11VMN4PwyGdLnuMHvBuAlkzSNhITtOrZK8MM7z4Y2Euc93Bn4wwND
         uys174Ee9tc5pAIHnO+be4uJ8iHpZrNElcGZXeieezbQuAilCYCZd1hzUBewQIs5+489
         E7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927261; x=1791532061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koV6fU0fBroPWgISEdPaMuGQL0eL41QYrOdoT4EtC4U=;
        b=xP5n6RpkQ8V2pU+5LFo+JDpUqjXXOiHHiqW/6Sp8BPAyd4JJkJ2J+Z8IlLFYE0LiX+
         7K5u4RA17MpUJcQXCVlsZpKZ9mGCu8RVZ7zPulpWakbLoR1tzfTQ7zhF1Tvgy/z/2n9T
         DjWfPGkBd7J1J51pKf5HQ5DNt/G89OOKdexxd6MKMqvQ7gQTtGvDqS+XieSuJvBD0vOB
         nb82aQ6DcGlv0XGPzvHU5Wa29T/cUhQDjE2ScQk97awQCQ98tuPh0JqzT3ZXajQRbKtg
         qwGEYlW1Qqwm45vEnS9Uom9SYaySXQjpwHhpjq5PkLKehOG0fXXGGPH8xbECp1nEzTrJ
         EW8A==
X-Forwarded-Encrypted: i=1; AKwUvBxK37rmQ6LRjPJj4OuWtLNCO8gmQejO/tpWYUJqoO6CEo9Oqjzc+92nmUablUxUcqhZPo6LCugVKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mS2lGaRyY4+v2BNv+rZ2OTfWN3XXhbQe0wNZNE5NHZrmuEPw2P
	n4lQ/A9N2Es7d77PLOQ0lJujZlYbHadiIakgb0bMHF4JdxE64x7gbiUeKn2nniRaBJdOK8UYvIW
	RL97QngMa7QLwlaV6oIaLw9jjxPMbAjBZzJN84xG8j0lEduZ7qGuhGe08ND91yA==
X-Gm-Gg: AYBFou2c38q/LihBM3UqynMcf82giI0NUV9yep6UG3AIl9hrYyj6z9GQ31sBQlY1t41
	qCuWUaZNwWEqDMit9xW4rcr/GQCZzeaSuA1pyQGgkVh8sBOibu4NVMCiPLZ7pUuKAGAi9cUwqvC
	+SCptfn1a2iMlkzShrHVpFjL6TzqfutU4WLS0KNFoL+AiZB/IcW+8U4S66VkbI/Qar8BTbUSigb
	xnTmxnFc6hMKP4ega2+FsLafykjWdKqvyF3kIF6FO+KL5anMMFYLgRed5sK+K1M3Ly70p1vsTwN
	BOpmPldsiVs87VCuEjrWJX/FcLi7yzsmKsJ+SaWM1iKCJVUjjuPm23K7gDQWWxT8fMTqCyXgiKn
	H1CDkckAl6gCwVr3w9KP/
X-Received: by 2002:a05:620a:1a05:b0:937:5298:7820 with SMTP id af79cd13be357-93ce7a9de10mr312520485a.8.1790927261364;
        Fri, 02 Oct 2026 00:47:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:937:5298:7820 with SMTP id af79cd13be357-93ce7a9de10mr312517585a.8.1790927260779;
        Fri, 02 Oct 2026 00:47:40 -0700 (PDT)
Received: from mai.linaro.org ([2a05:6e02:1041:c10:f14c:b716:c104:4712])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027741586sm59554805e9.14.2026.10.02.00.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:47:40 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:47:37 +0200
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
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
Subject: Re: [PATCH v14 2/6] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <ar9e9-xnxO8rbJk0@mai.linaro.org>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-2-a16290003b7c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-pscrr-framework-v14-2-a16290003b7c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abf619e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pD7qEO7pPVLmAv5tJawA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: HytbbxwxKsinU69HIi71N7QwV11hC7Hc
X-Proofpoint-ORIG-GUID: HytbbxwxKsinU69HIi71N7QwV11hC7Hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfXzesRnZ2nSltD
 l1IF7Jx0VeIh/FHXF7GcD2BODnpomyrdCavFRWq+efzn/fgbQKDlcyBLbwmGkFXDD56kaHg9CLA
 tUqrLEK5JZxaZ6R3v5Cwni7Tan7pP1YsYU7BUz/kGc1NZWP2F2voH/mjlwQIJcf6Y/ElAacl/D/
 EV+u2a1UAVMuVzc06V6YndDgk0a9PopvY1MmD6KONTfdDxcwHxRBmg3/vS4pXhO4lVMgMgtUD1S
 Efdg/X5XrgcCVTVMqFDcqWyb8qDkM7FPe2huE06JD5eslDQhEA9sUFdNw0TfucIo6jXymlqvZEw
 OEre+xG9MB2Z5HJuhSRCfdmTqDb4FyWGSJD3zUhf7otuiIs9FOO8wNXtK83gkLGvyJBIlds6MH3
 BIXPp5c4IiyUIxMu4dlgopW1NNhvoRhEOeoO1953vrymTm1FxncbF4C3dD+AnwSpoV6i79lRlPq
 v7BkSFvwHRv31vwpU2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfX+pk5LdAr525o
 EKXStrbVhfy9NpG9Ye3tA69beaWGQznaIg4g41DSBX5y5/tbVS8TGR89jn8dDoe7/PyO/cUosi+
 N6thHeORKcreT/vvGhgTX2tuFgew6zg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020030

On Mon, Sep 21, 2026 at 11:14:17PM +0530, Faruque Ansari wrote:

[ ... ]

> +/**
> + * enum psc_reason - Enumerates reasons for power state changes.
> + *
> + * This enum defines various reasons why a system might transition into a
> + * shutdown, reboot, or kexec state. While originally intended for hardware
> + * protection events, `psc_reason` can be extended to track other system
> + * transitions, such as controlled reboots triggered by software or
> + * maintenance operations.
> + *
> + * The values in this enumeration provide structured and standardized
> + * identifiers that replace free-form string descriptions. They are designed
> + * to be stored efficiently, making them suitable for use in environments
> + * with limited storage, such as battery-backed RTC registers, non-volatile
> + * memory, or bootloader communication mechanisms.
> + *
> + * Importantly, the order of these values **must remain stable**, as
> + * bootloaders, user-space tools, or post-mortem investigation utilities
> + * may rely on their numerical representation for consistent behavior.
> + *
> + * @PSCR_UNKNOWN: Unknown or unspecified reason for the power state change.
> + *	This value serves as a default when no explicit cause is recorded.
> + *
> + * @PSCR_UNDER_VOLTAGE: Shutdown or reboot triggered due to supply voltage
> + *      dropping below a safe threshold. This helps prevent instability or
> + *      corruption caused by insufficient power.
> + *
> + * @PSCR_OVER_CURRENT: System shutdown or reboot due to excessive current draw,
> + *      which may indicate a short circuit, an overloaded power rail, or other
> + *      hardware faults requiring immediate action.
> + *
> + * @PSCR_REGULATOR_FAILURE: A critical failure in a voltage regulator, causing
> + *      improper power delivery. This may be due to internal component failure,
> + *      transient conditions, or external load issues requiring mitigation.
> + *
> + * @PSCR_OVER_TEMPERATURE: System shutdown or reboot due to excessive thermal
> + *	conditions. This attempts to prevent hardware damage when temperature
> + *	sensors detect unsafe levels, often impacting CPUs, GPUs, or power
> + *	components.
> + *
> + * @PSCR_EC_PANIC: Shutdown or reboot triggered by an Embedded Controller (EC)
> + *	panic. The EC is a microcontroller responsible for low-level system
> + *	management, including power sequencing, thermal control, and battery
> + *	management. An EC panic may indicate critical firmware issues, power
> + *	management errors, or an unrecoverable hardware fault requiring
> + *	immediate response.
> + *
> + * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
> + *	value is useful for range checking and potential future extensions
> + *	while maintaining compatibility.
> + */
> +enum psc_reason {
> +	PSCR_UNKNOWN,
> +	PSCR_UNDER_VOLTAGE,
> +	PSCR_OVER_CURRENT,
> +	PSCR_REGULATOR_FAILURE,
> +	PSCR_OVER_TEMPERATURE,
> +	PSCR_EC_PANIC,
> +
> +	/* Number of reasons */
> +	PSCR_REASON_COUNT,
> +};
> +
> +#define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)

May be I missed it but where is PSCR_MAX_REASON used in this series?

[ ... ]

> +/**
> + * psc_reason_to_str - Converts a power state change reason enum to a string.
> + * @reason: The `psc_reason` enum value to be converted.
> + *
> + * This function provides a human-readable string representation of the power
> + * state change reason, making it easier to interpret logs and debug messages.
> + *
> + * Return:
> + * - A string corresponding to the given `psc_reason` value.
> + * - `"Invalid"` if the value is not recognized.
> + */
> +const char *psc_reason_to_str(enum psc_reason reason)
> +{
> +	if (reason < 0 || reason >= PSCR_REASON_COUNT)
> +		return "Invalid";

s/Invalid/Invalid reason/

[ ... ]

With that fixed you can add:

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
