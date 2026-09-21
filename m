Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C6457E4F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980381; cv=none; b=RxM0er57VKYPeu1EDQcQRU1Qb9MI+6RVaxrbQoPwCaR4G6ET37e9Odh7+Jdbztc9EL5o5AGBpUs6syV7mIfcrDG6Xn/6muedokKecHb0g1kTFPib1NrRtiszSbmbSFUBwjiY9iQ85JdGaKPqPHJGKb/jdCGIzStRLfBHhRlmupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980381; c=relaxed/simple;
	bh=H/Oq7DCmmKlvAofUgjpQ4iEZ6GqCaDK/Q4LrOcGlYX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMoBkSw8NWccxsPQkmSQgZECtte1TG4KcetjwyBdjo6L0fLjsU4OAqMDKmgLRbP95Nkl3rZ3C/GUjqwRtJrbgUs71bvJWvEwYoJ6LwC4TZgmuSP6WgWmFt9VyowOKyKdWVuAtjwbPzZJG99wO11jMqScv5Zf1kzqwVWYEmFwu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHtH7cie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cS+yi1VW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHtH7cie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cS+yi1VW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79kCa1458257
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=; b=kHtH7cieHkVvlPt4
	amzlnKDl37IMwUn9NHB4e7xhpEeyJ293VQGD5i6HA24E12l+KpTEDyY8I/EFs0Dv
	xYAvDI+A6eJMp0UEmRmYdW9WxPXs98Fcg8neSwBNeD2YYVqRRbqE7RQDzo8oW8ks
	uUF0fK7SiLd0zv42+y9VlJgffgggRTzXWA8FBd2mndCIVNWbWMtNmRi1KQyEKZ8G
	cuEv/0n3gWYUnzzbxXKxIworWDeYJOsuP28Sc+HQ+X1rPCdOseKB01QlXpTNOccW
	n9o0/rjFtjf4xavMGQbrtO40u6HnMCgegUm3rde71VoOD5AsMMtLFBg+mdjFynV3
	aKMkVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3v9g9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:46:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92eebb130dcso88661285a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980377; x=1790585177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
        b=cS+yi1VWCNWAefQ4zml/gM0cc1QgOA7mf0JWtvdgtTlbmAqwQW1g0uOwNU/cFWq0uM
         2ameIwJ8RfH6+DSv100NLpgMBGlmNOx4JYRCJ2quGYi4aYKrRliq4fwYSCH2VwpqWPSO
         qtMZ7icxscUCMJL8XdCVEkC3nuxo3IbGAaqB1zxIIc7LiEOvz3m5zpn0EKFLwUdHfb0D
         0iWuyacxs+kvwbrDN0ChgDnY8YxrCyqofn5fWWusTciJWspNK7HhHIES2DgUUkZ6xeeJ
         S6HXLLdB/RTjKyLwzi6flcv3YbSQuTkGm34dDOEwcSGx7nbLy+9SdGEbFtswE4IIgAAb
         dwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980377; x=1790585177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
        b=hRezTHH2aJAnXGrA+ajkH8V5TzkJd9R/9xTDCmJtuW0oyPMUDENahG6+f4LUPVbGbN
         Azq7vgZ71wahxtgM1wLick3bPKaKY1CNYlUhEGpoVYbR1CoQLSi5DJxvso6CBF+hnIU8
         1yRj0Zt8P2lkT3QkiB7JSPViMLZhmPaJoALuBjmfS7HjsYCDZseMV7O+bkT0T2Ega5rS
         r19UVPQJu1NGRFFMqGbAE4GVnqGU28X7ZH5s9F9g3/WJwlsrZ4LRoagUHxB1wog+/d3Y
         wWK40PgV96Kwve3j2H+Ieg9fzSotTSn6zaqfRoQlKLLmi9T4tSPtEzB4+JrYqlaC1t7T
         sGxQ==
X-Forwarded-Encrypted: i=1; AKwUvBztgG8jbaMOblglsZoW97CkpvtUKO1Uylu1Xn5+ranrMJ13RP/KAFxv3FySLJ7UooPdHI7+CJivXA==@vger.kernel.org
X-Gm-Message-State: AFuF++nLZUGPcXwFsnDKZDERD5urbn7QNAPXABqt/zoXqAxbB0tmIXeM
	HNq1SH7zY+XFPgEVVexe93oXxcjdbrhrWf6xWB6y9ZBHN6N3xbd3c3bS6GQOhaKcpPrnCaC4fqI
	d4G7+Bkmee8LRQkVATWd0x4OXZ2ocM0ynf1BcUf2HJW4IdOuEcaaHnUtfmYo5vg==
X-Gm-Gg: AYBFou2n/lD14Bf0r0IM+mZw1rsgzyyc6MELqnHyN1/1XuuahVjRsb9jJcHj4Ecc731
	79uyvfngbVoThg/9ymo6hE5PeVOPyGhi2+jmTTZAy0L5aG19TBa0aLUtCvTfU8V7mtO5wxtgXzp
	o1U/GxPrF4yYRRkJanAZRHyQsmh5ev8+yLYSvgzleHNXq4b4E2XWRQ9xcKho7UB3vuuyoF6q6UU
	11e8OWPMWHK26pbOrzYXvIzh4MF15+nDYDzfzoLQIvL/tFLmMcl+AQIktwfbkjoYz2p38AJn380
	itv2S7FxhWMO0MDG3Slr7HAv2MaDB7WmLSUiHQgc0NwkPVntdBTVOOr/pPg9PNhti8cuTWQgjE1
	tlgA//0BM4r966RPRpA+48w==
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id af79cd13be357-93bf57df974mr940252485a.5.1789980377375;
        Mon, 21 Sep 2026 01:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id af79cd13be357-93bf57df974mr940246585a.5.1789980376913;
        Mon, 21 Sep 2026 01:46:16 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ade5asm270916366b.51.2026.09.21.01.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:46:15 -0700 (PDT)
Message-ID: <733a3b6c-4278-405a-be52-0bd22ad1584d@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: Muzaffer Kadir <muzafferkadir@mainlining.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
 <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
 <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab0eeda cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IpRBMZr9S9mwpYgRR9UA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 17LEQ0c--egnXnn6xpPnPasunHSiyLYu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfXzP+3DSsoCKjj
 3O4oK1r5Px8xHFpcrqFhqipev9pBX+zyHxuMr3mkpNcB1+jJN0g43I3USWiy/GzimOd5CNUhFpK
 Fy10YiASxrgDq6U9i3Zf+qrmeFE9nNU=
X-Proofpoint-GUID: 17LEQ0c--egnXnn6xpPnPasunHSiyLYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfXy40tIXqygfzQ
 ZeEF0YzwNoFlaeTbm2DTpP2sb2i/9RnwedkPWcjKV7AsWFBe4kZQKBrQoDwBWIP3ucvvtGZdb3p
 O2unS/HvOt1apH8taGltlD+N+D1CodcSm53/pcdRoW14+Va2wgKEpgaNtFy2Pzgo4fAHiOqAwAh
 TfGRaV9fv0y5gmONK58svTNYUm+e2xsR8fCKmFG5+wOAAFS/+NnUdOw6Ipw7yCaQ6mOrtPVyDyM
 D6zkDVyUZVOXQhEZkRO2/UJHFF34Mdi2mnjaMX6i8xa1mcDwo+4vHMPySXCbUHn9Ya3LQLMQJ2p
 RNSz6LeFmpm3XZPDDvyZuNDm7uaj28jN0Xiz89G6tY0SrTroJ9ouJcmY0d4NZaXaYOWLG41NzVW
 /0+mOd/VUCHSc8bbih3KQ2mC2q7WWrvxwWOEC/f58t41QNuNLXdfVEzl4zBhsnhBPavUKORDKm1
 kjAyvwXNZPOjBXmPMKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210125

On 9/17/26 2:25 PM, Muzaffer Kadir wrote:
> Hi Taniya,
> 
> On Thu, 17 Sep 2026 09:49:07 +0530, Taniya Das wrote:
>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>> index a6c676f68b79..3c3f27dcc68d 100644

[...]

>>> +#include "common.h"
>>> +#include "clk-regmap.h"
>>> +#include "clk-pll.h"
>>> +#include "clk-alpha-pll.h"
>>> +#include "clk-rcg.h"
>>> +#include "clk-branch.h"
>>> +#include "reset.h"
>>> +#include "gdsc.h"
>>> +
>>
>> Add DT_BI_TCXO enum.
> 
> Should I rename the clock name to bi_tcxo?
> Or should I use DT_XO for enum?

BI_TCXO is the Qualcomm-conventional name for the clock sourced
from the crystal oscillator. I'm not sure about the BI_ prefix,
but TCXO stands for "Temperature-Controlled Crystal Oscillator"

Konrad
