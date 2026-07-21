Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C174D991D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647207; cv=none; b=eBnWcT1Z2fZvkrYEpkyHJIrABNo9SNlBhKWAUxffRBO+i6jF8S/xo/4AQ/KNQ7Wo8KBzr0gU9JbQcwnqmnViSA/kOtySEu+MvMKQWSPekLUjdysVdgwQNoZ0uwJ9uAzvnqPrxGi5vvZ1vM8w1GSjw21NNE7ne3vDM5KFfAxPjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647207; c=relaxed/simple;
	bh=wL7KM+X1ub6h4dq5bSQLMuQ01DJZ1T8pdavX2+xQTSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBca284J9RwjG7woftBuobhzlrcIci40GgFmuu/Ib8N5JhjR9STxjbkENswo//PsN3qs7GuKyRH3OJBFeUiQXw+svZthQIp12RRXDNkeyef+Y9jxKhVZ/raudgx385zJ40TpdNIEUixvLL08IKXYHIjfehI/gZg0LfKFZyDC1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMh9LHw+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BmchI+te; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OMh9LHw+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BmchI+te"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDfrN62071483
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fxTRfeCtn93ROmdfO6Zm3Tc2ULuGkOPFJBqUEa0gK10=; b=OMh9LHw+h/qQi7oC
	MjFcTtxxued3Cbf8kGzhiH46jp6jU5F7rV1egBer1EedQI4z5FLDdkGdBIIt4Uza
	kuvkvQFWg1cEp+3Y0GP74w4n4aI2LgXux0TJiOmq9+w6Mj0qWhpCcm9IHtL/maLW
	Op3gItYoOYRteSVn1RpbvuLJONTzkLYe0WKk0U4Bf9R9WS9is5cTeAMzRiSz3aZS
	e5SZMXN27pAKM+dsvqXuz04tw4RmRtJDaz3L3pqLewLaKQmgdYf8ai0SQ9Qor3X/
	QKQdbu4GrYmu5chjaAo9Mep76OXzPNhk04ZIwWyDKLXvFp/9qSi73qE6ucR4Tcvl
	HD0gZw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3hf2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:04 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bfd77ecafbso466321e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784647204; x=1785252004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxTRfeCtn93ROmdfO6Zm3Tc2ULuGkOPFJBqUEa0gK10=;
        b=BmchI+teLOiqx5erobaJNNlUXPbixnYS8hJzqLJoEMOL6RzMgL/Vp3LQKnC27YLoxy
         6RrmWtqF004ZxQaG3StaQGZ35KX/J4TPyHaik95PxvL4XNwrIVX3l0ZGq6fWu4fl23ij
         D3ax8PjSSdlo9OgGUaYzxrBjizQoEywSPlktjhZ5OtxbdtdDcmiTbpxNrW7FS35AK1ji
         W/azUgC5Kw5r10PJsxQ/RXmlv75zYjWHB8/MAJ66TQ+E67nqUHqPXvf+ATsQUx5lWrt5
         KXzcKSyj7dfqB/YZhcB7X6s7H9MyzITCe3R6FDqlp2IBW/DMqoEEQ4IFGN/z5T71Gy02
         cSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647204; x=1785252004;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxTRfeCtn93ROmdfO6Zm3Tc2ULuGkOPFJBqUEa0gK10=;
        b=ibwwAutnb84BTtuvvjF3C+IyqOMa0rHe0CFKFRSoS8eHxwDgmmYtIp2xiJrS524Aag
         1xi525SdU5Zkaccc46FL83SilbmuG75VKY0GHqbqOIKWDwCcPfz5e+5KCf+TPNRQy13I
         7JXL9xKmQevbMGiNCjLjFwO3wRa8u704ywtZIYGfl3E6fBcE15+u5spWVoOv0bIpWcBg
         asxtAaD0S6yPcFGYLdscrKwCTfRBVBa9IhT1bDZ5H+uUilTSlGV9BTIyFuiypZPuOPy2
         ZFlRLe51811JbqFkltH4gopWyPs6J6uKbDyJZlvGAOumotPcaEjQyEaGSnV3asVebkPl
         vE6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrVvGqsihtzrkv4YAycG5sX65CZEyFwA8nJXAK/ppMlJcAJVVYT5oG43w9W5qqBHXHHbDmrUs7c/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS5YqFVt7Ah5bCjAJJ7s3TW51rdfmlkBn6UqZ36hVRvRswMbu
	cnDiXpIxNqZkMoXF+GlQFxE/UysIAQmoHvddUysPs9Rfwi8k2B7jOqKlDoBLPFK495foMbSP+Ar
	ZizpPsitrjLLieaCSqPeTHlNJk3dihJaD9jPd+QwrFccu1lWlsdMk7txJLuXtEg==
X-Gm-Gg: AR+sD138wOKTTL4Dd1FYi3QDo0NdX+z+lAe6pr7ZUmnf4f2aRRJdkVW1RDn/s5wf5Wj
	uQfEF0/4yHndtREuR4eI6oa5puYrTGLXsH3a6ULIJEvADdtJ0mw5oII/VvcjdLNwNKj44R4rqco
	yQNo6Zp0d3pE2SDxQ6AdWrUaYHdpxeekEtcoWX+kDsMUf5Iu/jpvOreg9CnUyzHhVqTlteuFOyw
	rgwq+F7KuyBBwc5vxRLyf5tlIolS6ciNWTTDTW1rsHViJSn8ydXlmjreTxfR7jmTQadUN8OF3JT
	H+PlDTG+k35Xt69Ig3Xx731ARBwc49N5NJTz1V/kloAo3xKkt4SB+ClQ5KPYnOKxssndPVj7sG5
	3HS+Ri6htaVFXkELVJgmmqsAt
X-Received: by 2002:a05:6102:370a:b0:738:1ef6:51b6 with SMTP id ada2fe7eead31-74abc8c51e8mr572140137.5.1784647204065;
        Tue, 21 Jul 2026 08:20:04 -0700 (PDT)
X-Received: by 2002:a05:6102:370a:b0:738:1ef6:51b6 with SMTP id ada2fe7eead31-74abc8c51e8mr572091137.5.1784647200779;
        Tue, 21 Jul 2026 08:20:00 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c170591172esm616060266b.15.2026.07.21.08.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:19:59 -0700 (PDT)
Message-ID: <687006de-f11b-4360-b3e9-cfccc92362be@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:19:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] interconnect: qcom: Add missing depends to Hawi,
 Maili, Nord and Shikra
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
 <20260720-interconnect-qcom-clean-arm64-v3-2-942e8ee7ebda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-2-942e8ee7ebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX0HCjaKmb+pF2
 RUQuNxC27NyEA1DDyntqEzAd2ZDExbME3OuPE+vu8X9ydyhAUbmOX3skoogu4by/L4o2L25bPkb
 NjrkZLW7zBZh/Wv0oS86EibM/zphkjGsy2CBv0ghqZ76KVuA31eTNWdMKdvWiAI2xbzngUDHMNQ
 qFT0jjAK62xkaP8z62CLJNTejRfYYt5aY4RdDSJVT3QLuPkU99jEDbspHiGM5OzOU1f110IaDIq
 ZoMVN1qhWRTDPGsAGRnzLVQi35/r3Bu7zh2Pl6AVOuglDwpB7oDS9DX2S/b1gfew3NzVks6t4Hu
 Mnkd2e8KjmcQq5FyOcmq0b75vp1eqrJXmFg4dO+wMQQLPxo79XQ4gI+qF1tJ7d/K4X9/yz6DtTd
 YEN/TXJrKmhAnxh3Ln1DchRF5Iy0gzWEDifNLKNsAz16yDz8yBAYT1cBlUgHV3ZxUQA+wirN64j
 jwTAxDAtPA3WqSqManA==
X-Proofpoint-ORIG-GUID: tLnQN7nRilsh11-EuwK3AVwCWnSRLjv6
X-Proofpoint-GUID: tLnQN7nRilsh11-EuwK3AVwCWnSRLjv6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX/QF8UTLcYikB
 DbCKch5LFavmWlhRzyOmmvsJNd4+Iaag8igp7SvMoBp6pe6ZyD/aueWxOMU2pAzspZD0ThI9Q6U
 AA/BGJj8AvuRsTr3hnM7q8LA1j36108=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5f8e25 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0ZrtzkP0fX5WlaHCARUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210162

On 7/20/26 9:03 PM, Krzysztof Kozlowski wrote:
> Hawi, Maili, Nord and Shikra were added in parallel or after
> commit 5b696f065843 ("interconnect: qcom: Restrict drivers per
> ARM/ARM64"), thus they missed the update restricting them per
> architecture (with the same rationale).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
