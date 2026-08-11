Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C243CE6A
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444475; cv=none; b=U2zrPvANS1P43BHYMGn3eUdf9uPZuHiXd9ZLPbccILnXKrJp8OLn6Y2ejLop6xmSACa6IkbxKx2Y3WmAhnPgFaBUxwxaxLwOjtd8MzXce7T/rSECDWGvmd9DC+RNwADwUZid2tC7k/TDG8TXcorqC/oMrw/vvw6lZ8CKlJZ+vyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444475; c=relaxed/simple;
	bh=khlQxXBFoIYgGCKdLKHy/O6Ag9LzLbpRU1Mf1asnSLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0MMOjoYioo28gehaBMADHkGkKYgxFckP3zuieI5lKwjevFgMC28lhaOiZIO4+P53Rh8zHrDIutmbLsLIJczFKG0uQnOD95wdyrGi0LJ8q/TLrcJKtU2eIT4QUZnLr/pxTYA6+eZxD1CO2Gdv0/UUMHpENOl8Qp9ZTQrPn82n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHL7C/FA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UrmIEfkn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHL7C/FA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UrmIEfkn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BAM9cQ027462
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pX8gmMmDKg3afhYRts2RaqhPOxNS8pLkC/Y+vBXD8qU=; b=kHL7C/FAhKGInXCO
	zA3KOpoL1jYxsGz71CjF5j6uWbu02n6O38tEQp1ZcyNkVkB0zD8ljTGeGYgiy7Cw
	7y9wU+ofY5nqQrE41en095MaX6weRe0DVl2E4bPyDrVjBbqDo/DsIVbCTbQeAoP+
	VZzr6pcQx/2VyVShuYjMR46nBtyM5FPqXLzTbCLRbyc43hYTXxgc+wU9Q6NkftV9
	lK6Peguqszx/rCxk+DG9Ic4LZ0X6n0MJxe8+0FyETtGIOz245k5SksLmb7lwUMc1
	hGf95yZcZl15lfE9FGT1TrryvSPispZXkuPZ1UF7nOTLnc/jI8dVj/zrBLmufgRp
	68A9gg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjskr7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:34:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf1c86963bso7378355ad.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786444467; x=1787049267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pX8gmMmDKg3afhYRts2RaqhPOxNS8pLkC/Y+vBXD8qU=;
        b=UrmIEfknFq1aLfzZDf1aGkY0QiiNMT37pNmT7HpKVtgf5SRW69JMyNFDC2W3dnc0Z4
         4CcJcqBJlZFHqR4fR2grAInyPdDUOVvOAjX9OzumqKp0kMu1XxyL5PNX2eRnEiIUqmEQ
         KmmC93oAfXjaFlXM6WlzyqsFZB6r89HIurpmhhRCGf4WdVtPJZhVcAE8Z2GFQQXpx5O8
         bout68ADxNBaE1JtZaHIXtnQMEuZWZBNbpiIpW3N2oRD/Z7y++WszJ6+18GX5ldNJ3Tq
         4WObu04RYGRYra5oD53RdCBhRTYDi7VWFSugiipjssRj7d9Q+Wvsdxh1OGAMT0NJU+Oa
         Z8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444467; x=1787049267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pX8gmMmDKg3afhYRts2RaqhPOxNS8pLkC/Y+vBXD8qU=;
        b=LvzRQW8rnUAHPQhDDGEufMZE+fEz93WPL/9loDN/TBwD/rS5LWRs2qFifkgqJq3OxN
         kkdBEWZYtcxRWxb/G2nubxSO2dxz7sVlzB4cpGtaf6p7z56k810EXsmYxZgj/+9RXUmc
         2JIyUAez6tDyWxgXFOO/KEk0R/tC+xm/L5RIn4yi8SmFlGO/gjMEnam1KfZw8ylOCxmF
         wo78bk7fZvorBFsJ6Zd8CgERWZKuyJl44xbYuSgTrZ0Mg9ybLvs4Br+trnyWo+/m4kF8
         5HW6BYSlRfShrbAFEiKFiTjBETq+l9UcS+93WpClk+s0K5Fsi3F14nb4+w1Zc++RgS2S
         wDvA==
X-Forwarded-Encrypted: i=1; AHgh+RpxGGNbLx0vtGBTfAmuZKLpjlp9My4U8m3/qDU2P6Xt3oVubWbLduxZO5ocIDoeIpbcXlvuGREaNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHuOH7H/Ws+p13dPvsFfL9S4dQTNZURC3uhR1N33P5vuHRC5m
	b4jcsGH88VazFetsYLSTL0Tpx5LWvnp4g9dntayeNjabpZEskWJts4MUj+HYf1tt9KVo09oq+a0
	TwRIJkv+WLBZKZUsd06nnrKuwqkWJwMbe1DFMyEu3ALVn/Jj17zLLvvRJ0vHVzw==
X-Gm-Gg: AR+sD10/k9PckccZ+ZZpbOvM+R+4UpdIRLKaEqnIakzWEYWmNWR98LI4EOHYGtVnWZs
	xnOKrEOuwb9gga/KL3nSlI7vVm2Vu5teO4uipx6CUxY0T3wxBg/FGZ+ubOCE4dhXvWEeAwNfYI0
	Vi3kNuhlsBhz/8GyhR2PcbKOWo0edrcqBT1qYNByVc0xwryzFo4GgjdnIc7E61rf6PdsAFzDCdD
	kJxQN4chxs11Bq4O12MrJQ+xkxD4Nz4KQNim0ZqAS5xXn/Q4nl6/Xliykpdj+UpypRsjOy0ZHYE
	LPdNtuSGsihc8QjxnA+kEK9deTptKrRu44ATNYnuOuHXEkt1k08geLi6Qjb57bYpypqebSSxpHt
	FkVrmTrl205luHepmJiz0c7ABB5BY7+nNuw2PYyU7gBLASo2kLjlNBjcCcpvb3O6W7/gGKYikyP
	SPb7m2BhcD9MM2BBfgmzRWVg==
X-Received: by 2002:a17:903:40cf:b0:2cf:41ba:96c2 with SMTP id d9443c01a7336-2d31914fbc7mr8891935ad.12.1786444467193;
        Tue, 11 Aug 2026 03:34:27 -0700 (PDT)
X-Received: by 2002:a17:903:40cf:b0:2cf:41ba:96c2 with SMTP id d9443c01a7336-2d31914fbc7mr8891755ad.12.1786444466630;
        Tue, 11 Aug 2026 03:34:26 -0700 (PDT)
Received: from [10.149.102.240] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f48547sm5405795ad.36.2026.08.11.03.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:34:26 -0700 (PDT)
Message-ID: <4bc060bf-b5ad-436e-a27c-57d5d0a89638@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:04:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] soc: qcom: geni-se: allow selection on 32-bit ARM
 Qualcomm SoCs
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-1-5e0ede4a0c72@oss.qualcomm.com>
 <7f4qs6su5fd5ilecy4r72suk6mqvj7oouz7ahgatxthqavrfia@wxilczij4unf>
 <vxpntlaebf4an2wgebgbwk2rdkingzjecdgylqv36wmxtyqju3@hkip3wqgendw>
 <7cc49120-8f0b-4e07-a008-145504e00dd0@oss.qualcomm.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <7cc49120-8f0b-4e07-a008-145504e00dd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NyBTYWx0ZWRfX4caSihINUIjj
 aHvaNeM1ML+zHjA1F//kIy6Nbo6r3Z6V1kTWNcVyk7RN3xGWzTCXpDCRc5etZPl6qlsjSaw7tWZ
 b4FMRWuHo7k6bWmnH7ATZvZi4BPyLnU=
X-Proofpoint-GUID: yk898XOpur-zWf-YjwJrlfoZQEbYKVOC
X-Proofpoint-ORIG-GUID: yk898XOpur-zWf-YjwJrlfoZQEbYKVOC
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7afab8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RCP4fZz32dXd7NFGJtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NyBTYWx0ZWRfX1ZyJ7MSXLUJI
 wgQJkvQ1AXaOZvYBbeYfKq5bkRCwbxvxS9vMonxU9YeVj9IUCqNkY6pSJBVSWJCSx3qMKGPxMAT
 pNM0e163oNR+CdV8Tn7J8NTXvha1unjOKSLq6z37G/eJ8ZRRXDw0iEALnLuWraJtgimaLMmP/TD
 U5Sniwna2Ou1ZNuYxPEp8FjoymZ4LFeVtruhX2aTaEI8HpJ64oI/XYOdQNVLWLIwesPqpmTf/Bv
 ZhIooTPBvFnJezt+Yy3GlH3RwDCf1+PYp0wL2cDb7idX1S795Mx7LzYj1lH28WMCsLDwjoDyqQ4
 fYgtGmqgS4hjmueLv783if61Kf9+wansOtJXlupxAeUQttwrYOMThl/JUI2XMGF9dd1x0pqwppM
 lBXSlkhUNc37U5gLpiNGu+uJBGyUR4sGuQulwPP9I3aYhrcZYUJ6A7Va05ViB93pSZjI0TLWLD0
 EVBmV9dUAZWKLugNahA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110087


On 8/11/2026 3:14 PM, Krzysztof Kozlowski wrote:
> On 11/08/2026 03:15, Dmitry Baryshkov wrote:
>> On Tue, Aug 11, 2026 at 03:48:00AM +0300, Dmitry Baryshkov wrote:
>>> On Sun, Aug 09, 2026 at 12:57:00PM +0530, Hardeep Sharma wrote:
>>>> Commit e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
>>>> tightened QCOM_GENI_SE's dependency to ARM64 || COMPILE_TEST on the
>>>> assumption that no ARMv7 Qualcomm SoC uses the GENI Serial Engine
>>>> hardware.
>>>>
>>>> Kuno, a 32-bit ARM Cortex-A7 Qualcomm SoC, uses the GENI-based QUP
>>>> wrapper for its debug UART, so this assumption no longer holds.
>>>>
>>>> Fixes: e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
> I doubt this fixes tag, otherwise please explain the bug.
>
> How Kuno could be supported, as you claim in e10b198a94c6, if we do not
> support non-dts platforms and there is no Kuno DTS?
>
>>>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>>>> ---
>>>>   drivers/soc/qcom/Kconfig | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index fd4d4ecd2df0..5b3c9d31fd7f 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -39,7 +39,6 @@ config QCOM_COMMAND_DB
>>>>   
>>>>   config QCOM_GENI_SE
>>>>   	tristate "Qualcomm GENI Serial Engine Driver"
>>>> -	depends on ARM64 || COMPILE_TEST
>>> depends on ARM || ARM64 || COMPILE_TEST
>> Or depends on ARCH_QCOM || COMPILE_TEST
> None of them are needed, because this is part of qcom soc.
>
> Best regards,
> Krzysztof
Thanks Krzysztof for review.

I'll fix this in v2:
     - drop the Fixes: e10b198a94c6 tag;
     - reword the commit message from "fix" to enablement framing;

Regards

Hardeep Sharma
