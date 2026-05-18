Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E138735A
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126909; cv=none; b=Hs7w3O39usasY6AE4JWsYRzQwfQU/ieQwG8iGlU/U21pw6yOc4h2Eth8gtAnuK/hEGsQrE8fxecYhsO5QZAeoQkqpryOqCzHABBb4qWghTp6DN7aQnldiBtl09/1i9QqjS6rd9xBJB+Rk6a+T2Mtmhwv4QNCGEkICCixUSQ62rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126909; c=relaxed/simple;
	bh=ODrXmadF82VJ/EPlo2DxnQdd1EJqpj0kf68DrDo2zWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caG7q+PuZYtVa83NwFf4XClyaGlx8L3Dw8f5A3C9D9Hn8z1dfQetzq6kItBt/LKxgnuyw8n8WSXlFMae8RHKi8IcpTLwV2RJciIlz1z8QWdt82ShTZQUtDCEqlxtQUPakZqU23/MXsOgT72754vLqCBeTNUN3jofCUcvgzP1nJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iua/ut3o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Idl0ooQx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iua/ut3o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Idl0ooQx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHR732482391
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4AocTjO4gmIgKLGXc5PJ8ZnjWk1YSMV9SJAJEvfWfg=; b=Iua/ut3ootig+/4d
	U3DmbUCJmbi0PrlBYQna/3VPTgpqOqm02kLU8p6MW4AYrxQZia/YeUlCXjiaA0Lq
	V3Cgr0dl5T0YigdGcjZwqFMJqRRPMcQW7rA5Bk8CePWTEcpNAPKBcbfs7Is/7rHp
	DM/FHrnDpV9sLjN0++OtSMKVbtTpiajoMA/D0BcUCDSUSCvjhuOjapF8sYKnFVKD
	byL9rVkSUAMzzsZK0SVOCFPGBoaoNbafK7tvR0M1NMhTwIlDiZF88MggKuGC8Tg2
	KHvie5RCyMTXuzUYrYtEznD8M3g5b6jZ6oVC+xTQy6WiQGvFhWYpW7CC1JIGP0sm
	qB32VA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvhgpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:55:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514ae0e3ad6so51456941cf.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779126906; x=1779731706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4AocTjO4gmIgKLGXc5PJ8ZnjWk1YSMV9SJAJEvfWfg=;
        b=Idl0ooQxhHlgymAhc9eGqVw/ZKbsK5ttPZdjoffVp0D1jBh8NoJD962+z6pzYcJtN3
         Nwh1Opsw1CwhOXF2nMUKcTk6dn8dFRSon+/oDNBpv8hqEsB1tr562VT5zrxx2pVDEHSB
         lHmh8UEkYMjnqHeIOHksAwPsrhYxnO2QltKLCKhkpCICqKX499YcVXVU3T85BPczyBQ9
         O34/P2Y5CZHMoB14Lxi4fjQJM+gfHKikxGhjk0davnVebGLOQJ9Hg/Uul2J574EdQ+zo
         RYWltjmKwH57aqHY/hlrU7Pi8oerQyolMD+MVo8mleu9NfjNlnkuP4mKb1beln6LLTq6
         Yzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126906; x=1779731706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4AocTjO4gmIgKLGXc5PJ8ZnjWk1YSMV9SJAJEvfWfg=;
        b=LOonE85ea+PaTrt9/Z/7C80XFOCFGmca7qslo5vUjHWe/I8NKViY4YEtC/9YcBGr7q
         vVcpRvKhONPXl9g2tr70NnfkOarm/s7Oxe2PBD/o4/zyF29tujLtxrGjdPwa4c4086ZS
         2KJ04hdiYhXlTNzVdNWVQ11Uu7aFjthzcdFOphxs3gQ970WiyT+c8SR1KqSren8Uo5M/
         TfH0EIaHCxYoAQ30vPS7HSLAbQ/ieKtMlszIaS+ceIqKMhhEbWS+9ws7wug7Q3PnymUp
         X5vsl1ZFIGKHuHkmu71W9dPpWz9J/M+4s4ZtuwvWtpghNPPvotFmbtEuNdFGwUJ0zfKI
         bTHg==
X-Gm-Message-State: AOJu0YwW0gvjlizN6945UaV17Bh/itnzLUz8S482y9A6B7dUPqWIHTV2
	MWJbq5lSFm65gYeXDvAMyQ01yMp+s0gfraou+QtxH3yMXDPFii/lkCr253A4j91rA//55bl2j4j
	+saPxbeQ59BzRiVjZgOdceWm3UTh3XNCTmyJfK/BqM1KMWc7QwMDTibJ2cO5N4A==
X-Gm-Gg: Acq92OGJc+ul6YBsL3cHzoddEHDXZgPyC9KoOexfqeThaoDQClPoogTB0PamPsutAc7
	GtQ1bRcD06NewasK1EohmMOcEKjMfCK3ev87mp5/ndBmNaI9AL/REXlTaTcxoLYWKHgngT2b778
	4jD/0TaIRg8+lSiFvhMCgEEBdb+8H7/4TIVHNffiKM6GIGJ/2YsBXI3jmEHx1yMBW7hTH247JX2
	CR9Xdmroef7H3m0sA4Rzotj9sG6HUUZK8MEQdlPxHOVWqi6e2CiA4aTyuudsAjN+8iI1j5JqtNm
	aejkyuMOhVAPABOshG7bLWqX5u+p//FE2AF78cwzwVmokHcK8xQMhQ30uPhVzZlwCL2lgQ97x1f
	+U/2DRs0t+ffsLuQy5lGu4vo/5BQeT6/p/+YWyE6/vGcfop+TFQAPHNnjr2HReU9/ilyLmBeCbr
	R5bFlV0lN6
X-Received: by 2002:a05:622a:a90a:b0:50e:5a1c:d807 with SMTP id d75a77b69052e-5164186dd5cmr183474601cf.27.1779126905852;
        Mon, 18 May 2026 10:55:05 -0700 (PDT)
X-Received: by 2002:a05:622a:a90a:b0:50e:5a1c:d807 with SMTP id d75a77b69052e-5164186dd5cmr183474211cf.27.1779126905313;
        Mon, 18 May 2026 10:55:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9? ([2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf8305dsm124742725e9.9.2026.05.18.10.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 10:55:04 -0700 (PDT)
Message-ID: <bac984fe-b9b2-469c-b789-102299658872@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: of: fix trailing whitespace and repeated word
To: Mayur Kumar <kmayur809@gmail.com>, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511161854.193573-1-kmayur809@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260511161854.193573-1-kmayur809@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NiBTYWx0ZWRfX4rMdfXVTl8x+
 HAe07NNdJ1oEl3Y3ohWW+Mu8Z5XrU3hDB4yMKRkmXhcxn0IGqbHdAJltn0xtEszmdG0fSPQlgM8
 Vh7LwYkhQrelI5Iyha2U9YRNqzKR5+FM0NqQUrur5Z5pk/Fr5Njj30qnbxDPdLcGvAjo5Dow7py
 wqYJfROGGBX6vhxFV3gFLp6cNOpmBl8JOOlJO8ErxczoVIN9Yd37a69I7Bz9cyBRHTwUMzEuCaz
 bHfDRgEjO5taqV3iP7NO2lu4mUDkZQigA+xf7Elvoy8yFfQXCtuxxeUqWblh4yVbz/SwwvV5MnN
 Yf6SlmXp3HNQi2yBdOdHH4ap3uFBdZKQCzQy11x+jd5F1oRBq0dTOvsrUHoXTPgnY4GyZmjbkpS
 hn6yNlimCu/+9spCinsJI4usuyGdaARsVGx1t1vTU9sxz3U9OqdtQQayhjHKvYWtakdl9ePQL3F
 i2p33r5L6gujtRcL7ug==
X-Proofpoint-GUID: 3Ia_h8W9--DHkDhmdrVeg0SpUFFGoMRM
X-Proofpoint-ORIG-GUID: 3Ia_h8W9--DHkDhmdrVeg0SpUFFGoMRM
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b527a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=H-tAn762rhXXu7TOzKAA:9 a=QEXdDO2ut3YA:10 a=4CKv6j0A9IMA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180176

On 5/11/26 18:18, Mayur Kumar wrote:
> Correct a trailing whitespace error on line 101 and remove a
> duplicated "which" in the kernel-doc comment for thermal_of_zone_register.
> 
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---

Applied, thanks

