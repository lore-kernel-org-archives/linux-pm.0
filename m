Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDF2F617C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910460; cv=none; b=IiiIz+XxSBoCd16joOH0S+iOjg4pRQBfWk497uj5VxIIc50R3hXYOVoPc2tfDHC0XXM8HiIdfuHd0urpQf/QuygkWna9DP6X6C7Iis3npEXlZkbzWyS5kGpa9cAa7cGM5lr9kBkbNVrAAaSDoJyEhYcbQHrvZroSHwRifyms0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910460; c=relaxed/simple;
	bh=V3ZB7tbh/dBJlzSpmCP9KFqGD72MYXvj7vP8C9/9tWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j52/rganleocSnv98RwWgNosI+1ZJ9n29r14vUe1HO90VKczDPGl9qlkfjinSAK8roCoibQsP0xsMaOyeKL30qZ0DzimsUOvLaxggutWdjazuEkg/5riJrAkfpX14pEbJvgTq0gsiagVA4DAnykXoHDZ/M41ITcMetTzAMWKlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2BI9SLn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrJDt6ou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2BI9SLn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrJDt6ou"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PkiX2733104
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 09:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dm76rGTSr3btxD4sk+JohwPzQz8nsVTx8rS21SkE/iw=; b=n2BI9SLni7ikwF5l
	4FyToO9jutAaAsYms2egJWXPeBRwIBHpqdGz5w5yPNw/OS9fJFgfA7fq5WzkpS0M
	g17RchBt4lvPnkNFre05zDt9kDERh7im5BUBe5ketl3HgShcj+MKOOkku6onU7wN
	7P5vDz+2TXRdh/RuNBlaANPGjZxCurbPI3UzyUmONPcYIUE9WaKwMcniL06aHmcY
	S+tQr6FFqiWXeIPX2E+W43tFDTzUX3j0T5I+uwelmXI9QJsDzyCnrSeS0lQaQrvu
	I8zU8IQul55tHSdCwAV1bYh/8x11AHmm+Af0KhijiRGDAs+enL6VFaDV9bGvkoBJ
	OjzLKg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf75xd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 09:20:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5175bf22b2bso7721661cf.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910458; x=1781515258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dm76rGTSr3btxD4sk+JohwPzQz8nsVTx8rS21SkE/iw=;
        b=hrJDt6ouObnNuUHWUs1NEGr9juyXhz9fNTZdOVwa3wyYw37SeTLJVXeMMAQ+zhe0cq
         6MYcHzRzIIF9/h8AjQRj7huSumb2xV9PFfTWTgC1RN2bZbMhxl4UL2Q6nfimu0TO5Mcr
         MiNeC5t18F00LWwceAaEOPpPR/AW90osCIQZBOE1a6SzP684ut2LSijcwPwNfjIAClpQ
         dPYV0BiV8ekiRdL0BfTt5RaWKxJ+DfFrDFwdelIxNKXxYRHI51gyT5g9clnxPjiAqe7G
         y+cq9kOYDtsLu1um59Ul/fAVKzS3B2326AsuV4W2xOTrleFxD8BK4t8TATaShBr8x5bs
         pZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910458; x=1781515258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm76rGTSr3btxD4sk+JohwPzQz8nsVTx8rS21SkE/iw=;
        b=fZZ4U7pSZ/JiIX9mbYuZhur1aHqpMqO6SIyhqTARKHaMr+L1UzjMXIlampWZROTEQ7
         ifGhbRl2TbMYggMN1sfERyK0IobG44XwZy2fka5nA7kWbHHLA0j/tyKPfgi4LAsSYK7O
         uW/H7iUmwWaGfnCveezXXpe+UqQOK+vyYMUixQIGMkOV55snhos4H/r7oSFmO9yXh+Qq
         ZIX6bE1+whiwYg1nH055We/SF3xq1oudCDsZzbBZwrW9l9dUuOeJf1GpN6o3wA8T98Vy
         Xrz16K+umavSrJ5DTssnQ2mv/fNeIAJMTuw5AA39iu1xBetCAw01yMEdlarPN+pOc82z
         0c4g==
X-Forwarded-Encrypted: i=1; AFNElJ/ki8cb5SNZtE9Q522mevYJse0ozZkFP8JL8OZFL+0cI16bAS/zpKsBMKNWb3ah7mv3zyM0jV73/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZtRLmZQudDp0NURAwrWHSJ59pT68cXJThTPvGPWN3Cu9ES3r
	aMciQmlOl0PGLViZopOWnhQrsUofXmRFyoSlSCZVBXBj3YTUjxbKHN/AdqQi48Qd9Z2kqyE4uKM
	EIY24BgYShKcKmQ/ieECjsjpSBOhgFO8UMaq3mKC8f4O2MNove9/xKTchCSXydw==
X-Gm-Gg: Acq92OErGU1pVwwkndXTQAMos0zb4HlAEQSFnfOh4XzwQKUaSLEjKgFqRgtWpgrHxgI
	xaJNRqX+/koY8AlBOYKI7BITFEtekFL/6ZRz0fbf1LtcN23X6UmGuZdqxSG/BObYGBg25vFBfOU
	OaBA4S5IlrbGOnTdi6dAN8zH13Jgt/A0+beq7HmYeZXsenhXv02RfNtXdDLlAXtrUYOdTgKb4gV
	oKt7VVsxUKeGBHH6l4x8aO+XItPVg/PEfcMpyYNDEpR30JUDC7z/xtojIfQuVc9YTd9v1ucpFSj
	8bqHOWJFZekjS/UdGWqhNkgeuyxfilEnCv1UqbAMyp9ok6DbxKw35OlAi8KxugRXRBpSG0TTZ+B
	zTK0vgPE+2pZVJ/99tbfvNvKPbySTRthYf2aCRu4bIfm08NYEayBF/SU+
X-Received: by 2002:a05:622a:904:b0:50e:6311:7380 with SMTP id d75a77b69052e-51795c0d8bemr108304231cf.6.1780910457730;
        Mon, 08 Jun 2026 02:20:57 -0700 (PDT)
X-Received: by 2002:a05:622a:904:b0:50e:6311:7380 with SMTP id d75a77b69052e-51795c0d8bemr108304061cf.6.1780910457279;
        Mon, 08 Jun 2026 02:20:57 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c8de00sm852347366b.20.2026.06.08.02.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:20:56 -0700 (PDT)
Message-ID: <8bcdc105-4393-45e4-acc8-0faae3ceaeba@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: qcom: gdsc: add LEGACY_FOOTSWITCH support for
 MSM8x60
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Herman van Hazendonk <github.com@herrie.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606-submit-clk-gdsc-msm8x60-legacy-v2-0-187a32d2f015@herrie.org>
 <20260606-submit-clk-gdsc-msm8x60-legacy-v2-1-187a32d2f015@herrie.org>
 <yv5t2llliqz5fv35cgw55o7usamrpujlnh3msmpz324l4p5yfz@s5pr4dos7sh7>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <yv5t2llliqz5fv35cgw55o7usamrpujlnh3msmpz324l4p5yfz@s5pr4dos7sh7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a26897a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ISS9l3P2gTKgTzszIxwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 9Qu_1XyVtC6Y8Q2kTZW5Y7Gs_In6vNd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NiBTYWx0ZWRfXwmcraRvNLyC0
 dzd9VWuVK83D1oslFJvv0VwTfVDkIv4/avXZHsWBf+KgrqzpiDsC7/oWOV2ndwGt5/7OYZTrxHv
 x626Oh4qyQL0HgbISbhfuDfX4+PiTRu5zjkyf5j8Il/5U8+V7mNywEMKkukFocQfYpN6Y91qlV1
 civgwoQ7yTWVAohH4X8JOnV9VmoIYvN259Zv9RA9wnkzm59fulkuJgZMfB6sD/ABChfYptzpPnb
 AWo+uHEw76gn7PY8/CKdpv672ycArCc1od4v3aS6cASa3l7FS1Bs2fzKL6a/nnsLczqNeQUb7lO
 nX5kI1z4BKF5Uy6CenWNd8F931raOa7DfBgwVhReOm1CNdG1sD041kq/wzKeilM0RBag13j6FNG
 3Y4NWTMdXeh4C7/CFD4nR4iO3ZoXkwIgiLoXAA3jQjBiWwyva83sqi6ppOpLGUbWzuWE+Ktshu9
 MDOerJTr5uaQ13YNpSg==
X-Proofpoint-GUID: 9Qu_1XyVtC6Y8Q2kTZW5Y7Gs_In6vNd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080086

On 6/6/26 5:17 PM, Dmitry Baryshkov wrote:
> On Sat, Jun 06, 2026 at 02:34:26PM +0200, Herman van Hazendonk wrote:
>> The MSM8x60 family (MSM8260, MSM8660, APQ8060) ships an older
>> footswitch (FS / "GFS") block that pre-dates the GDSC programming
>> model the existing driver was designed around. Adding GDSC entries
>> for that family's MMCC power domains needs the driver to understand
>> the legacy register layout:
>>
>>   - the CLAMP, ENABLE and RETENTION bits live in the main GDSCR
>>     register rather than in a separate clamp_io_ctrl;
>>   - there is no power-status bit, so software cannot poll for the
>>     transition completing and has to gate progress on a fixed
>>     udelay() after toggling ENABLE;
>>   - ENABLE is positive-logic (set to power up, clear to collapse)
>>     rather than the modern inverted SW_COLLAPSE semantics;
>>   - none of the modern wait-time / HW-trigger / SW-override fields
>>     are present, so gdsc_init() must skip the wait-config
>>     programming block entirely.
> 
> I think there are enough differences to mandate a separate footswitch.c
> file. It can further be used by MMCC on MSM8960 and APQ8064 platforms.
> It might result by some code duplication, but I think in the end it
> would be easier to read (and it won't clobber the existing gdsc.c code).

Yes please, gdsc.c is already a bit convoluted..

Konrad
