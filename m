Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD03D3480
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213098; cv=none; b=LwIhC3O2wL0E2hWvOoZK1BYTy4xGkNFUI1uYkL+laKnhsFC946F0yLPz+m19iZ3GT+amggDcyFDM9M5sHllYuT1qE6dSVaJ8QjuVgyXpMztNl9Vdd9BPlVZCWd5e8GYOsSQamnARblFDRroC+42vGG3vj8vrE5LWmk1e5NB/4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213098; c=relaxed/simple;
	bh=muGmIAE3ctBmNTCnYhUL+xgeooXP1KN6XjPvfxiE1yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocd9kq9GSSYgSZ7FcOraS2RqtkAOFLTQxMRwVkB5flwoo0Gul2mFuTAxh4jv3ZxZ9zTxBRFMJ0d6895zT7nKXOGeMB80xMIPY1V+p18GbnIC2rw3AnGaCq3cwI3UdNTU7/3DhWfL9N+lLsAMwuDedqwsG5BimO7AeNfXPdgTSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KfIlS2Fi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DgrgUsrG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KfIlS2Fi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DgrgUsrG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAsMCV3578686
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LzqALdblDXBZVqRJZi+H4syjn1xGwSVWvWykJOUOihM=; b=KfIlS2FiSRKwXgD2
	SQm4aPtXMMnxMnt/+PKgWncIAaygKsJulJ8+cwWMbp+dyEhAoqGF50l5k04SEBTB
	Pvi5su5MM4e55GTuM/MZC9ZrlEyrdIqlF4xK+zsxIHuETI8zsshyOTTfnVIEMzEk
	U527Hre3A7xhknGfXVEyF97XLYutT1xLnFnI9iiyzRGRO4g++ahwjWrkzCqsn+wl
	jGAWkNvT59N0s3U/6z2fXeKNggw/H7h3HXtjntHHlvnUop+V/Kvzzz8gORkmn4sk
	3Mj1+NpKPBZtQk6NYNEemlfJLhzJitGBZm1XiLgPthTsH/DQO2KUJzt7otoTZoV0
	ammrgw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygpaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:11:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517796be724so9741801cf.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782213094; x=1782817894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzqALdblDXBZVqRJZi+H4syjn1xGwSVWvWykJOUOihM=;
        b=DgrgUsrGmddcfQM3KS/ybwBKPBoG/o3r/cC/9qfRBc5FbBbueZchDGWt0iET0Bw6yZ
         zd7G73jDlK856krFqME0HtfzH3pYsltfTpxuuJYXzow4lkorMHln7mgBaJp6e0+CEEKy
         cASxkhZlETFIIUu5W+TYZLRXvsYFBC9uWsWFNy/lEVdBYsimq8F9kTDKQxbIbriIrhaD
         K8/oL+gvgE8o0HPvuk4OF5LssS3qmCwtDSCIhLsvSMKbCH7seFdiJYASFwvkMm0dcSxQ
         JGwii/f4ILorJimBseONf16bpsaYr5gPQbkjKEntBN1mZKrfOeulnxLw0oDY5n8tDgxF
         u+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213094; x=1782817894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzqALdblDXBZVqRJZi+H4syjn1xGwSVWvWykJOUOihM=;
        b=TRmamOvyLD7u5lralqPEeBYt4t6C8VfeCblTvuhDBFegx81JsqCsZZR1Dxu5eqy5nt
         6zT0PmkcgOmRu6fxQCsW6sl+PEnyrpQlKAEHTAwEGzd+2hmvsj/vsmQRFoOsTTEjr8aR
         Gm5sMn+5nynDY2nPMxVA1mMZYfh3RWbyKD5TMlrO4LtS/xY7xM4SeExCqe8Q7h1Un1ds
         y05cMk5mJeAw77pjQ/0iUUJ9nNUCx9XL6IzEI8F5Ne+uu8nNozFooR8AztEEa89c2QNE
         rG0+LuxONJCbXKKGhOLu5m4HcWrECtRpGw4rhGp+9vDlDHg6+tdxljxzlhMEIOI6lp8B
         OCRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nSIAb4Jf+X9yc46ciAic2upfzejxiyWGKaMvy6Z2tXwHLIyPIEzaDy891PYlHz7+1+KDxtH3VRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5i++ycQMJuKLRX7DXzNMLMGzzhpvEjpK46tmv+bP8OeP6eLq
	HncthJtCdhAhWzu/k3lttCniaCyKc0AQ0bNL84DTFiHW2lPLisUv+mkBo9HnioS4eDIOyipvV5Q
	uiTghYj5HtC4e8Yvt5ovHkdkZChU/w7SCr796QmwcUlO5U0IWqO0fu2GIIEfGjg==
X-Gm-Gg: AfdE7clyy0unF+GuwWCaeZ1AkIVM78CBnQPrhGtqc9T+/lvdi3b4q61AmDxzqdRehld
	zruVSCCsorB7wrNxYNiQvTtKHIQc0iOiScEqPzJMhWSsXNuCbGnEEjHghfhEaj9XhRspLSDKeHq
	8XXQSq/zPVFVyMbZPObCC8rHDz7wFhlIIa4Zck9yngqMCROf+aKBymbc271wMukVjbce4PrQ0Cc
	hBI9QRg1eh18PjVxu27/ZFDr3/OAR5lPhP3bZ1YXoGIJnCDGYdIE2aGxYW6R7uvvieFw61Hh91f
	LcQvjc7diHj4aIFdPPrjvFyMX668EKJfxB0fxI64gieq6QkyBHAXPS+wKicFRFRVCq5dDq1+zdk
	S5pPbd0pa/l8c554qIn5iIvExYTAzRqIKP6E=
X-Received: by 2002:a05:622a:1388:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-51a4f449a1fmr47517551cf.1.1782213094022;
        Tue, 23 Jun 2026 04:11:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1388:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-51a4f449a1fmr47517191cf.1.1782213093453;
        Tue, 23 Jun 2026 04:11:33 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be64ddasm4436982a12.28.2026.06.23.04.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:11:31 -0700 (PDT)
Message-ID: <22e0ab27-4b80-4a08-9d3f-919014e741bb@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:11:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powercap: qcom: Add SPEL powercap driver
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-2-a3ee6837c18f@oss.qualcomm.com>
 <e203221b-5de5-4cc3-b65a-a3545986a954@oss.qualcomm.com>
 <298cf2f5-64eb-4430-b264-0d046df14dbf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <298cf2f5-64eb-4430-b264-0d046df14dbf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MSBTYWx0ZWRfX3XtC0I8tMUjm
 cXEce/uoDwKMPmkVTZegVLEyn9xB6Xub5DeuPPFo8/RbiGeO1zC4zNAFGZzCONtznbvFwmGps54
 M2bZ9SCE9ZCG18mP5OQtSI00UjbfXaQRJnEVOkzXZRaCTxEzbYmKZhU8VPn3GbOLFrg1rIPuvdq
 ujDTtHpRc1BLE061EGuCbn+xmBpfNRqejop+YTtPN2/RSghbTP99NkS8Jyi5iYaJ5KdBqMMriWJ
 bfKHdJ2TTyKDqPWOz2Pe3Th2pKL83bofMIq8Rg9yVnV/CiKa1gzGqmpSOKglKsGh43Jb5Go5GO7
 q8fJygo1cT7YWem3QuiYu5iVDEVTvorZVvHxh1mjLFGYZZ3GhCzkXy/2uvNauqyxo+24HCHNPZb
 9jWe8TOVQ/vFEem+RlUyDJSoNpA0b8WSbOtvoEPIprqWJxV9LA8E08nyAlFNPjMorRY9JQC84ET
 Z74UVfsTxR3nxXXkVLw==
X-Proofpoint-GUID: _Ul461lTNI9ww963CTuZvc0ryQvxbL4-
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a69e7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Y4jFsmSDHp3uCgbhOVEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MSBTYWx0ZWRfX4iw88gvZFE6M
 OmDGA8wUbVGCUR9mQi44gX3XjzwkyQqpXjJc1kLpRUGcE9f7mOIlI58ShUBqIG+1zjNQ8BPtf3N
 T4vWlWvU+xI7fbLAZ5QUpdu5THwwcJs=
X-Proofpoint-ORIG-GUID: _Ul461lTNI9ww963CTuZvc0ryQvxbL4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230091

On 6/23/26 12:58 PM, Manaf Meethalavalappu Pallikunhi wrote:
> Hi Konrad,
> 
> 
> On 6/22/2026 4:31 PM, Konrad Dybcio wrote:
>> On 6/19/26 10:39 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>>> based power monitoring and limiting capabilities for various power
>>> domains including System, SoC, CPU clusters, GPU, and various other
>>> subsystems.
>>>
>>> The driver integrates with the Linux powercap framework, exposing SPEL
>>> capabilities through powercap sysfs interfaces.
>>>
>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>>> ---

[...]

>>> +/* Domain configuration */
>>> +static const struct spel_domain_info domain_info[SPEL_DOMAIN_MAX] = {
>>> +    [SPEL_DOMAIN_SYS]    = { "sys", 0x40 },
>>> +    [SPEL_DOMAIN_SOC]    = { "soc", 0x00 },
>>> +    [SPEL_DOMAIN_CL0]    = { "cl0", 0x5c },
>>> +    [SPEL_DOMAIN_CL1]    = { "cl1", 0x60 },
>>> +    [SPEL_DOMAIN_CL2]    = { "cl2", 0x64 },
>>> +    [SPEL_DOMAIN_IGPU]    = { "igpu", 0x08 },
>>> +    [SPEL_DOMAIN_DGPU]    = { "dgpu", 0x44 },
>>> +    [SPEL_DOMAIN_NSP]    = { "nsp", 0x0c },
>>> +    [SPEL_DOMAIN_MMCX]    = { "mmcx", 0x10 },
>>> +    [SPEL_DOMAIN_INFRA]    = { "infra", 0x18 },
>>> +    [SPEL_DOMAIN_DRAM]    = { "dram", 0x1c },
>>> +    [SPEL_DOMAIN_MDM]    = { "mdm", 0x48 },
>>> +    [SPEL_DOMAIN_WLAN]    = { "wlan", 0x4c },
>>> +    [SPEL_DOMAIN_USB1]    = { "usb1", 0x50 },
>>> +    [SPEL_DOMAIN_USB2]    = { "usb2", 0x54 },
>>> +    [SPEL_DOMAIN_USB3]    = { "usb3", 0x58 },
>>> +};
>>
>> I would expect that the names are going to stay common, but the offsets
> 
> Names also can be different here. For example, hawi, It has only subset of these domain and it doesn't have dgpu, it has only "gpu". cpu domain
> names also different there.

Presumably we can unify the names (i.e. use SPEL_DOMAIN_IGPU on both
hawi and glymur)

> 
>> will be different. This array should probably be called
>> glymur_domain_info[]. We may have another LUT just for names of indices
> 
> ACK for glymur_domain_info.
>> (i.e. [SPEL_DOMAIN_xxx] = "xxx")

This approach would still save us quite some bytes for the names that are
the same

i.e.

foobar_names_lut[] = {
	[SPEL_DOMAIN_xxx] = "xxx",
	[SPEL_DOMAIN_yyy] = "yyy",
	[SPEL_DOMAIN_zzz] = "zzz"
};

glymur_domain_offsets[] = {
	[SPEL_DOMAIN_xxx] = 0x20,
	[SPEL_DOMAIN_yyy] = 0x24,
	[SPEL_DOMAIN_zzz] = 0x28
};

Konrad
