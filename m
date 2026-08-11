Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC341DE02
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439467; cv=none; b=sitwbjuoOwdWYluILqiU09WyObKi97+GMS01P190O2aU67v3C9hnvrsmqx/oO0QU7oo50m+YQA/9u5IZKzFBlCivFsQrzC4Ei4TZkqt3+p/lZySOJnQLRX5jtRM8tYslOtYaDScrwFp5l3PAyX/e6dM1nb32HpcYpyiAgTds33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439467; c=relaxed/simple;
	bh=g/sbI5oXcAE+LgcHG3CEAclXiNKltiwKtzuhR22iZJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brlydfUubDacPSXTkdOA+3dJ6RBd41fTUX6m3knNrtH3STfH7q9A7hiqoHxIHsf9DYYif/g6swccdH415hhpTLcXWKPyt6yALdMfYSboUm/uvgBfYWQACwgGZvnv2j+n7YSiCDvYNgxBcEHtsswRjsthS4dnJue74ZHPEpMLACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjcosBLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C9Aumoqo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjcosBLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9Aumoqo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7HEw73552694
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VViPe+Oj+T3kRKRU1AgaHow4Wbuy+422OfMAgT80X8=; b=YjcosBLiv/+poUe0
	6OrKxJu8hmzQ0iSgmf9s2h0iIKZjlHua7o5DrcgVD7dKEMc6xd/YrbXUBNZnKl2F
	uoaXVjyz21Y26qe1CKYDvLVxXJFkIf0rbXWtS4Gs2cE59x9bu+Vj8PB5LXYZTD4d
	a8stiUoMM765CxmkjXO3zE34wXoz1qD0hfzOsy8kTLBLkpT/FBEr5DUo0FmZlc2f
	mEbzVCOsBx13cg5mwHIez81gkwQruIUChl4SFQKdNYBgaGvuvbrlUDd0K20kRnao
	jPomNdpK3THtYsYFmsDfRAS+ZSPI2IqCyDqo4N0xy6U4GFSiLMu1DzmENKuKsjyH
	VPaI8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk20w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:11:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d04908139bso56370275ad.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 02:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786439465; x=1787044265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VViPe+Oj+T3kRKRU1AgaHow4Wbuy+422OfMAgT80X8=;
        b=C9AumoqoA+TtEll4wpMDRd2Emsxj3GvksOqZ6AAYsVcVBY1m2DnsHsPl9NtOKnxp/C
         pdne6sw0GP6dJVHT/7gbHGVED8GxkRFqlIQoD2KxQymNcPYadwUaGmI4MnJ29GWQVQCg
         K9bRZ0YML3zBPzMn3u8zId2mAHneMfvD72NyemileGY+70sEDFZ1EZM2Qs3D1GGUv0jf
         AjfvPt9J0eIczjx/lMaGHa/ajA08GsTnO+Xojw5cqlGsFQ9eaYY8bDAKn6CqKS4Q+3Hf
         7fWT0axOoyH1fVJEWQhfqZkqFvqNJwjaAsx7y8KGBETiKgRbxhkSoU8Y0V/gcYdw42um
         WUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439465; x=1787044265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VViPe+Oj+T3kRKRU1AgaHow4Wbuy+422OfMAgT80X8=;
        b=CeUG7mBSG7JJEFT5PsyIwnEnvWEr+Hz5aF9nqXMqoZX53EjwSBF2qiQaYosWklmeAd
         A5+NDQp+4awBjdYALfW0SOVSwBDYpvqp5mHyEXnychW7+oK8RuWZ0NgyRDxT4IwhYO/t
         eonfx2/m2oyOlr6RRytmOKS0WcXWQG+C6Lq8p1y0EXV1qhBVO6pP82OY2+lAakgWHE8J
         Ntr0k+M8OmJrgyqpZTCcE86Sg5GZ7mQyZQpS7N/mrWm1dChu6Uzq0cM7h/elSMe+lCqk
         gXfClNPPu2T2dLzWfiHuXptgTE2kHDL6JZCeMqEw+/8QPRT7KWr1zsf5zpPex5VCt558
         Arqg==
X-Forwarded-Encrypted: i=1; AHgh+RrzyZmc3o5nzLqZ52JuHWBBwXDaPY8Ii5sXVc2yKkUfY4+1fLx+9fNs7E7fRvM2YSulZJTgUvNzIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoV1WFS6BDTISCH1fFNwQoMwP1IfWjNungnff5Ar7n9pkNAMM+
	hUCzRRaatwoCv1gJKf1n8gZl/yIW//MjcXBMiDs6pZU3gakeKPbmDnOIkEGW/RGcsJjOPMkoJlD
	GIscj9KQNyPiVK7d3vwkZ0k47Wmm2DX/wPHCZLSi7/fF8YYNiUfaW7NCJPCWZCg==
X-Gm-Gg: AR+sD12OT0ge/KFDor+1jVB51ZLrigbhkBpphaVDNvN/P6/Br31SF+A72WXwivqZgd+
	PApQf3N62t7m7w3fYloPbF3fl+li2pUL783iu4fpfA9BcogQB42YDo+lF/BTTknIAgKdCRgcQVg
	vTiUZ0JCmAXSkbhQ362NhLY3UkxHisDt9YU86d+sKWYtKj12/13262CCdaWOVi7/1kcXB1sxu68
	lskORWpFegIQV+bW/JA28niPM0YrCFQKyygxH8TRFwXTOa1CGyM/5IGE5mDwF3BYkaNuKpZ4aYw
	2qMdRw86odFo8X9m76t/tydiMJyVdq3xytDlGulHhTS1BmHmackGKGKXFIad4SNWzJdX6TlNsth
	FSTbixbhDLKX1x5c+kZ1aTU4J
X-Received: by 2002:a17:902:eb8b:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2d3177cce77mr22356165ad.2.1786439464682;
        Tue, 11 Aug 2026 02:11:04 -0700 (PDT)
X-Received: by 2002:a17:902:eb8b:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2d3177cce77mr22355575ad.2.1786439464191;
        Tue, 11 Aug 2026 02:11:04 -0700 (PDT)
Received: from [10.64.68.239] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d31621a0dasm4306675ad.69.2026.08.11.02.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:11:03 -0700 (PDT)
Message-ID: <ef0b034b-a969-409e-a2c2-4c7fa95b57c3@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 17:10:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] dt-bindings: interconnect: qcom-bwmon: Add
 Maili cpu-bwmon compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-bwmon-v2-1-80f7f150ab9e@oss.qualcomm.com>
 <366132c2-273f-4b8e-948d-4956e5241881@oss.qualcomm.com>
 <d8d89181-bc76-4023-87fd-02e85f5c8d49@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <d8d89181-bc76-4023-87fd-02e85f5c8d49@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NSBTYWx0ZWRfX7A3M4SsYtlZ5
 8gvFNKBQU+PMcf9zbLXtY9ImDdDjOAKkKdF/Q5jrDlWTkJPHsbxWBVbAJzgro4vsePdWb+v4Dk4
 kz0f8SHRZxCttbdp4L9heVYruvCWwPpQWtA44I3XjRzqXzSKCNWa8I+9cDN26cn4UFrrqg12zI4
 bcC5r2C/qr3YiKiuqUW/FQHorXSdgR5DoA/f9huEkR12JjAJkBVp+g3MTG7X6jMwewWTFX9raIb
 MECS4a2/AUjpRKr2jX94KTWGIVr2WlqN9pMvZ+anwLCqmZlT3pLrZfuQJ212sgQrWWvzVInVOsU
 v4UzLLZpRksp2TaA84wPahILXxnAiYwFrHveKE6Z8kM61k78TpwVf61+3eGOGrxs/74B6HmR2mO
 bLNfMImTpHb7dQ8PMuUKFjydy+4AHxwu2zcxRcLJl31E3goS8TngfAHRDxV/xwoAnAAQoRPPiIU
 OW1zTdGyKlQwXq0MEog==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7ae729 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=DiU9YXepysN1ymkdEgsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NSBTYWx0ZWRfX3eFC1BtLAwfH
 8i3p1MUB489cw6uDKsGHmIw9+xlm+60Tzd+H2O3YE2149mL2FNVUCA/zHyK65fQTwKPUylVYbF7
 yli5KoAjnLrvPcuY420Gk1W5dWHhsLY=
X-Proofpoint-GUID: m-cXtMWtVM_Cc8VK5HOIUI2Jk3RXH7nn
X-Proofpoint-ORIG-GUID: m-cXtMWtVM_Cc8VK5HOIUI2Jk3RXH7nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110075



On 8/11/2026 4:57 PM, Krzysztof Kozlowski wrote:
> On 11/08/2026 10:53, Yijie Yang wrote:
>>> ---
>>> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
>>> change-id: 20260512-bwmon-ecb43fda63c9
>>>
>>> Best regards,
>>> --
>>> Yijie Yang <yijie.yang@oss.qualcomm.com>
>>
>> Sorry for missing the previous Reviewed-by and Acked-by tags. I'll send
>> a v3 update to include them.
>>
> 
> So how is this resend actually helping to get the code merged. :/
> 
> Best regards,
> Krzysztof

Fair point. The patch itself hasn't changed. I only realized after 
sending the RESEND that I had dropped the previously received 
Reviewed-by and Acked-by tags. I won't spinning a new version just for that.

Previously received trailers:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

-- 
Best Regards,
Yijie

