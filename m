Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05493CE0A4
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388378; cv=none; b=KJLH/U4S3r6VW+2pRpHjxhy1PvLxweI6yEihu4y4GabHA8ytiU1P7atAHG7qNfzEg/Kp/Yah97YrSdEBH0tabaGYrRmVDNNokjkpc3TOHIaIhiMfzlSTeyLfO87AVdDe/IPMp7ePP3QAZfgp4KbD/FROeS6FfbLGbASAAnI8KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388378; c=relaxed/simple;
	bh=3sAE/VMNu80O+WfuSL5iBs98yx63G14GTapXzogclNE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mCTIgL1TZOffuh7moDoedY3t3U0VCa7MmOtT6BRKaCW12WeLgfCCi0aTA+oHGh5mChTkqScluYZMb+v/wvQavQhaO9/lXSygTaqx6wQ1CE64zeJGrVp/2hZIub91kbhSWV5tCZC14SPhli3Cd0R2xL5KqS96uvIC0zKtCa3gaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6RBiN7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SPZbt4m1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6RBiN7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SPZbt4m1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9jtWi1723011
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 11:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cxK7ioiXaD8p2DdI5Hqejs6IMcrdhSLYsitFgDmOuW0=; b=N6RBiN7Albr7Uwb+
	n9LHghEu0cWJcld+Y18GGJx4RSNXPR+QPqdi0sGQtKsplA3J9+KVRtzNs/+R6Uzc
	u8FXAmeRWpE6ASGQlk3AqY52m7yS0E6jWS8pDrXOEIsrIoz8LOaZBuBfgoHD6jXY
	Qict4Wr68n7NKH8daHgYRwSfumA6lel9MKUbYA4w9YVmGIGzpyMH2DkwLAoiraKI
	mDWKO2SbmiRVdT+Hs9KtO+RQ+ARGj2ju+DkCmeLBQWY8G1x1tPVwEas3slVp9bSq
	v1NkqMZ+xQc5l5cD8PGSjxxCsRjrwPAVKcyiK4vTELn81gS3jDWWtJT40eQcLntt
	YDABPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dv4u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 11:52:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84238e83851so1604899b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782388375; x=1782993175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxK7ioiXaD8p2DdI5Hqejs6IMcrdhSLYsitFgDmOuW0=;
        b=SPZbt4m1Urz0wZMJgst4Re+3jU/uQuj49ZcSBQiVIoxK1YljKpZhizJEUwMP3StMzs
         3bBI1lCW+xKm6CyCMiTz93ISF0Po8P7/jhA1AToX1V6wiEBjoB3OjKR9FmNEyr247t/v
         nKO35oSFdlBsGXQxeGS7hrEK88Lqm0zjVEn7BBSI57Vg4dCIFKaROmrl0L86hyo1VenG
         zBw1z56UAJvCCzdZaexuPOEEStHmQWfmbJY8q1HsNLhk3W3ZBeJHvPysUvGNgnRYhPma
         xojY1zZSmSwatgYwOKdwCLpq8yEOK6+SIQBIGfr7wNMkm5bQcwRYEeCIbtDrteeZHMtq
         qYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782388375; x=1782993175;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxK7ioiXaD8p2DdI5Hqejs6IMcrdhSLYsitFgDmOuW0=;
        b=E6JHZDJue9ngZj0N4kbbPrKaGjXYkrWkc58NECo+8gb45tKKQODHSDE2PfvaD7jE2r
         0sxupWeNNp+GEpHt3EbsvtnuyLrnK3bXNNBs6IwTBVxerqOkW2BaUMCf6fuqqCgNUPG+
         kjuXezFnNNKrDjuRzNVH+KJHPYmdaqMDALrZuoGF4CcmSVpwp6ft9zG3+4EVPmk6IIVs
         WiBgTiEFs28QHeeyAboiJEtRV0ZvA3JG5QaITAFvwaI1fuSdUnzlMFeBvmO8247A+5lo
         eG8wADZqIoNfcChtZUMGO2C2LdB5z+wuG3A+WaGfSlTYLSV1ByruCDCq50kq5csgsjvN
         3AzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIDCCI04uCJ7GY1yBToZLDZDKDA6UGToSoPTrSvfwatJmSaAN7EXPr1fhbDXjOMxdcGcGSOCVHmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJD4QhoacvVKLI43AtMcQi0NN37GFAinyjb1ZGyb+WF0brxMCQ
	qNEjnxeL6c4hPGKYsdhhiskkTfvakdiJeXUSjR+A6xf65zupidRLRuMxgJTMzXq2IoHRWZsbp+4
	+DEmPnYR8mVdepXI4qlsUdrM8TcVj9OTj3VR2Y2JjDv+a4iSEwKSHlEhirnMX
X-Gm-Gg: AfdE7cn4NCqEYFfqOZeqIit/lLtQx/3MgapbUJfhVw7g2Hq3rJuuVR+r0jYH5QIIlzk
	HKuu0ul3tQGdtlGwErHRZzXGTW5V1DG5sCdcpLGbuLmnAAZW3/AQDkHTF8rYpwK/3ssMBSxMiSv
	O8jHKNoXaJfprWmmennjKbbPG1tZX3e6vxZhFUUS4y0M2UnQ2ckaPglx+7kAw4NGS9YnahzYoQU
	ytI6GMXBnotG1IWmYaS138iEZ298FoGymmXCl+knZ/0HJEdgvWa+JCtlSx4lB4rQWhgpAj6GYuO
	VQCF/L7lWQnq/twa1Od0YFv0UdHgCkDEYgCt1Mbfhu5pgTXweGqbtzY1fAnvA8qVKx95ILgz3lf
	EZcYUbqK10Quqg26LZ9VWEzHR6JoVWTIobtE7VjWQAA==
X-Received: by 2002:a05:6a00:2187:b0:842:6849:2180 with SMTP id d2e1a72fcca58-845b3ae2581mr2805640b3a.37.1782388374806;
        Thu, 25 Jun 2026 04:52:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2187:b0:842:6849:2180 with SMTP id d2e1a72fcca58-845b3ae2581mr2805609b3a.37.1782388374290;
        Thu, 25 Jun 2026 04:52:54 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d8f2bsm4499571b3a.38.2026.06.25.04.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 04:52:53 -0700 (PDT)
Message-ID: <e0ee78e4-8001-4c7d-9284-9daf1c6bd3a2@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 17:22:47 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v11 6/7] power: reset: add PSCR NVMEM Driver for Recording
 Power State Change Reasons
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, umang.chheda@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <20250618120255.3141862-7-o.rempel@pengutronix.de>
Content-Language: en-US
In-Reply-To: <20250618120255.3141862-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Nknfg0px5BjuMHY311z3Prd0kBizq_Lr
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d1697 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PAdduzmm4c7iO6b64JwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwMSBTYWx0ZWRfX2GU9pmrZC3E2
 /+WIsYIF5CpTBljTLtsJ9rDeNrgCpczGCIJgx1AYFlMpnuQw9OOGrcwoSGujmjk70azsr668Yq4
 vYjffA/CKGrC3lIjt0w0Stv3YAeYDTM=
X-Proofpoint-ORIG-GUID: Nknfg0px5BjuMHY311z3Prd0kBizq_Lr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwMSBTYWx0ZWRfX0QyMzCKnk9fV
 q6ZKiSc5Cfn+Bfm6xElo2NK3rKbSgBPL54bc7OHnKylaj+ArtZaVyETpwedfVPR39AxVZwyUAEQ
 fWDIxjpADpXwSxMNqB/bCIXnbCx3LcxXM3c1/OlG+hbjztKAe7Xn4YlF4ncSrqi3bghAH9kNxtQ
 5pYRIX4K9epg8U4Vj6soent6Q9biw9yEVf8UnXvmHMXhWczoUOugj6YsQx4Dp51GWaoUDcqbAyY
 8m7o/C7PYWgMxvq8JqgUcI2Vt5aN5qosQ8nURHyxn5OIaw3jrhWNUnjuN3rsmEJRZeypAjmCXaO
 fEYtEwQ3nFf+FwlIWYWZX1nhlQLOY/i5NAR219UwRrTF8tYCU1MgjcNggtuew0i/O3hIpwsuaeU
 iD8gAuejedWv5MGLF5dcEHliMqvzBR0ExrcggL/l0Y/QpkYhCIIlD5L16Jltib0j49pzc8XAyGh
 tMgyx8nyDz5YKKa1Bhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250101

Hi Oleksij,

On 18-Jun-25 5:32 PM, Oleksij Rempel wrote:
> This driver utilizes the Power State Change Reasons Recording (PSCRR)
> framework to store specific power state change information, such as
> shutdown or reboot reasons, into a designated non-volatile memory
> (NVMEM) cell.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v6:
> - rename pscr_reason to psc_reason
> changes v5:
> - avoid a build against NVMEM=m
> changes v4:
> - remove devicetree dependencies
> ---
>   drivers/power/reset/Kconfig       |  22 +++
>   drivers/power/reset/Makefile      |   1 +
>   drivers/power/reset/pscrr-nvmem.c | 254 ++++++++++++++++++++++++++++++
>   3 files changed, 277 insertions(+)
>   create mode 100644 drivers/power/reset/pscrr-nvmem.c

Tested-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

I have tested this on Qualcomm's lemans-evk and monaco-evk platforms.

The testing was performed across the following scenarios:

Userspace sys node to set reboot parameter
- Tested the userspace node interface used to configure the reboot
   parameter confirmed that the parameter is applied correctly and
   visible post reboot by reading back the sysfs node.

Overtemperature shutdown
- Simulated fake over-temperature condition and verified that
   proper reason is being reflected in the sysfs node post reboot.

I did not observe any functional issues during testing on either of 
platforms.

Thanks for this patch - it is helpful for us as well.

Best regards,
Faruque Ansari <faruque.ansari@oss.qualcomm.com>
