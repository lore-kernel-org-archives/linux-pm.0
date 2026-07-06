Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161B3590AE
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315357; cv=none; b=kBCFp7wumoRO5/Ld3eCwxaU8fRwO0UB9uDbU6LsKdBd0X0GZSFJbw5PSt9/HjK6qCzVxp17IBkHrgeBgPlgPqRRajQ7aBBiZ8HOwWWBVfnfjrDU3x8FV8eTGIJcmdpBlU0SBBLDNmaAJsgszoEJBjqww3jbm8YF/FQigdB9v8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315357; c=relaxed/simple;
	bh=fgHrxfJ4suBUW0kN+8kLcEywmhNEd+44JP4hCrz3Cs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKV3Z62kTxzVsDrm+A13vMYD2TXC8eqK4L/s4mKgbW2lMKWxbE93rVx3M2XsHugo/HJ9arRBW4uB4yNYpfJfehze+HXquXjJrwp+NS+BU4yDGYpjvXnzZbrCLN7Ku0nJ5q1/fKkYafzWXwIJDNyJT7o2MqanuDw+ApRxf2AeM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyuSX+PT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MG+2H0Ff; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyuSX+PT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MG+2H0Ff"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641UbN3593754
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 05:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b4/rkxRtX0uFMh6gYc/GZ4w+bhzIdW/NE6ERvdxmeV8=; b=NyuSX+PT5xfcw3hE
	vY1joPs1yagJOjhbrj2c1kivpQ/Q4Zs4kDfZYZRLxim8JElKPUSBZEDZFvaTTYTR
	6sjrHJXg1jI1KweZPaoJRA554xcXicrOXPDhpk4nDSvZbN350b2rG4Cvhay4x5SW
	2smmY2eFF0ho6W4l/n6iUXApA/4J0XmeYHT4nYXUK33mordC7Av1O6plbRnxuaa7
	4q9U+u1BvrRJrYPlG2IMzza18hKO8XZ3iMrkDaycMsyzSPq6p/K2lvAfH3VrSMk0
	o8LKmxyZpgZsfnjB74tEwX5CIxfgwF0zu7GAO31c4d0ZZqn4uvSSoftM1V9ZM4Ts
	FedYvg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh4k0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:22:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so2314371a91.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 22:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783315354; x=1783920154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4/rkxRtX0uFMh6gYc/GZ4w+bhzIdW/NE6ERvdxmeV8=;
        b=MG+2H0FfUC3ULHBmq9AsRjOq79WaLvS+0MM/svHl1r1j6MTJvWnQrJFE1tF1IVcbsO
         Q/1/8Vdfw3KRv61lRnbs9sjusHgFGBV3FGN0jVDoqdtCkjEypqSwxmSbOeD6Pn41yAv3
         xczNxWPhSYMcMFZZfWbcbedI06Ppw0BblGkUGlqAxu7uMP6gbeqhA45nuCmLvko04wJw
         yhZBcOfcExZLomxG+DZGAjhgWNHF2D38EQDsHWegSLnpJQzFPitibBNFFtqseRv5aifl
         6EKF85zumFLb4z6WBG8Dm/X5LPqhFTWB+d+85labsQ0sOFQjT53peOwqILqij6AMw6BS
         TuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783315354; x=1783920154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4/rkxRtX0uFMh6gYc/GZ4w+bhzIdW/NE6ERvdxmeV8=;
        b=C3D5pi6uDgcRQYRtKbTep1Jyl0qgaWNZ+Ynhp3r/icHQCpZL9lCdex9WK01/1MvM7p
         GeOOmKH5jA/D634YHuHVDEPDQ0f/AMtQu7WYDAdyeNOeCZEaXvE55OSuLWyjHt6Jqw9h
         enN6PseFPB8ApMOjp36I8c7la968kI3AX/UH1VnTNK3vQsiQcINISPgTndMo9PqyPQ6z
         OI6C6LQt6NJkLXR+O4G0hR1EoNyzfAP+F7ONnFQkcs0O5nq6t85oAkp4QPRc8u6L3GIl
         HM1tF+JL3CLJvkKfjEOqfwwFRl/ffEXlsytOdvm4mVWUYnLtAOG0JOSzD3n/E6E3R7+2
         Ikrg==
X-Forwarded-Encrypted: i=1; AHgh+Rqku0zm+0qAvM/5Vj1AsQ9KJBgrcoAABZKeH9n6gv0orJF8avINPeX7v1JEkQEmAIRiREW4MUR4qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaFyYxhcZFd5bSxBdSK6tOfTkqOmM09LMVqCElrSgnFY2c2wD
	iUDlKZzBoLrQzcU3b+YPt/tL8ZIZ+/sv+jD8Ax4yIWrNsmfazkq27T6i7D/8Z5VOK+ekZBrHSxS
	nrzzslAjCpLNbIMOarKejaO8Js+UEF36Bs75dt4xkm+mpx6RQwiWmXfLya3KERqS1gsO6Lg==
X-Gm-Gg: AfdE7cmNe4nQrGzb+JiKkXhGoQ6QxXRrYu+GnJEE6ZJLJIYS3YfgV9weClkX9CuItjs
	H67oIUfPqPP50Q51N8DppTyTUCi8FgXMJg03qYSb7zKPyAkx57WGKrM+Jni1mdjYnXzaqj+fcFk
	YKW3ai8r6FCigYpUiP3azB7gK5TAp4gdthuXmfRrFvID8ITJ5g2NdUt2vj10BZQBmXLz04wLT53
	mhamwMXOznkogg34OGNqna2fwBSxW/GGoBwS1lyIV7QAVdC3x3ksKk6lHAuA4yfm38I9798fuPT
	3BLcKKn5FzLFTPQx7v1ufbBWipeMVEUhecKxKZ6uZ4Jr2jsSlSLOnOYuXh54elsZTQlNPkLJQdY
	PlYsBkN0EMOQIlBCkzhLgYKEWCZ9Js7csCtisElopF5w=
X-Received: by 2002:a17:90b:180e:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-382933033fcmr8550238a91.22.1783315353938;
        Sun, 05 Jul 2026 22:22:33 -0700 (PDT)
X-Received: by 2002:a17:90b:180e:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-382933033fcmr8550213a91.22.1783315353496;
        Sun, 05 Jul 2026 22:22:33 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127d147a8sm4232021a91.17.2026.07.05.22.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 22:22:33 -0700 (PDT)
Message-ID: <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:52:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
 <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4b3b9a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XhGPO_9aslPW_XT5sbUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1MCBTYWx0ZWRfX87dc11x98qIY
 aIO0Y9FZiTCd/HIRcrIKJG6mOGvz/cwZHbUzfqESqqMKA5jn27pt2eYjXO5yJQEsJBQEKC2m//u
 Fy+DxjIEZY7/RCjbLaVLdR+mPPdjJpW03udTbQ8/BzfHmhlHt/3cS3eEcYmX/E4LbuoqCbnBb+W
 Qsg4pX5JoT5R5vVN+WxxddDDCBDw/oeR3tEJAefoSTgHkzAoKs+X4CUTc1BrYXQIrkps3esCj32
 5OsNKOgY8rQb5PlA7F6X9yNp4tCejO9GzmTbAo9jhEvSaouYrE5JlV9GrhMbCLYlZiEZUqxKamk
 DN1lCNBCgS2SrDpMjvo6QHh8Opp5XAETRqXjoa2jfzyqBw0UkMkDljsgNCn3qmXjJtnHWppVBhG
 iNkEuJD3ItoPe4VAHbvqBjh3YKsTf/dl+DcWEG7Ged1LmGlWdx8Ii6qfZwwd0rM2tcMfW0No60h
 /2kn6E84L4Rsv6QSD/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1MCBTYWx0ZWRfX4dnM27wuA/4C
 jXTrmPzt8w5f7cHQERxPvmb0BmnGXv+auiGLU1LOk80Uipl14gJ9mu9J9iIkekTV4ndi6zAWAQh
 bE2BwjPVHBX1/d+Oi+STopzrFpn10UI=
X-Proofpoint-ORIG-GUID: WsWVfh3jlfjMcwYlOuscMg8LovLEqe0I
X-Proofpoint-GUID: WsWVfh3jlfjMcwYlOuscMg8LovLEqe0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060050



On 7/3/2026 8:39 PM, Konrad Dybcio wrote:
> On 7/3/26 2:38 PM, Krishna Chaitanya Chundru wrote:
>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>
>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>
>> Override the base iommu-map with the expanded set covering all the
>> switch's downstream ports (0x1400-0x1408 SID range).
>>
>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>> from the PCIe controller.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> [...]
>
>> +&pcie1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie1_default_state>;
> flipped order
>
> [...]
>
>> +&pcie1port0 {
> This port should also get the compatible
for pcie1 it is not required, only for m.2 connector we need the compatible.

- Krishna Chaitanya.
> Konrad

