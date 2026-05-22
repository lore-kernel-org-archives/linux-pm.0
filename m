Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70623C4B77
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443295; cv=none; b=lojWXNFiH9HQCy3U8XcLjg+uDGut0bffjzOgzIUf1Tm//fw7EYi7ILB5+dTAQJ4Kchp/NMeDdYcNAM9NOYl6CvfKETmO4QpspwtmWE3uKtBSHENJ866Wz/xZydRWzwo1WF5IpMy7bvLoL1jFnKFQqTyupAMbqgv6ND6mBnHyY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443295; c=relaxed/simple;
	bh=fnA6TuXjxoD/qV1B06x19WzNk1sYIqRGpslMrz4epBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEajAtKZK0VQnXL9Odk1QWelhg+c9QpXoVh1dE5XUTX3l9hIWhHKm2MMUxr0kZiJIYTMCgaXQq6H7r0Pof5r/O7T+p7i8yr7LWruj+LP+V4z24pJ6lxHVaCj2xRm/TxDLuekFlZWpa6GXMMc/BcxaoOfyoIMCWo8iwPAHIChy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyS96uHt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWow4lY/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyS96uHt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWow4lY/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8jdXX399240
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=; b=KyS96uHtCkpE5n1Z
	uc5oOH2s/296hUuAs+RcnFf5CRcGGR0W1W/RqqXGXFjFSrCdXpqIS9TQpFRfaeu2
	M7avenXbaIkD36PAsueW5xEC8uNDvHthDDNVtLilgy+0nWZzwuVz666xJIK/j/Ju
	Yi8+/sVa5vCxoSxOIrHUlwGypi5MT08n/aXvSeBo8kr0wYhmiE1/vfqg0nZKrcwg
	iAcRaxhkUC/exClJOVte+fVM0XwOuCpagD46sVONTbrrOm0HxydVxvmc5Csfdy9J
	FVfvpNuMDJCZOAvRJ+3DiSFZBu9muHQ0KjxjoaGirewuTp69oeOZculMhDZjVrS6
	0/QqWA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9uqjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:48:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50f1b94ac9dso27251981cf.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779443290; x=1780048090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=FWow4lY/160LIc+An86OAeZoQBZq5ytgpJNyeF69bMPhbCb7Hsi33CavswpILh3qVc
         7vzvkC9EbNMra2mVPyD5QhNm9ZfJrfs0tmOA+Pc/EI3cqA1VQNdzhr7RglgB/P2AcoR8
         85O6IqdHrLCKS3/wKuvB12quJa4zlG6qmQr0MnPJ12Yoab+QVvDhAQuTQ1SIqcFkQFmY
         B8jB3+cPQroCcMEt2sBD+ByjAtUTfxg9gfQugOUzf1s9ToVMoFXc46Twe/DRIbU5Nd/x
         jpk2La1i9VEmJ2ocrErDwAmDfs2JoJsGujV+oYhBJ9O30CwG4XguJcAtsFfSCcY26fT1
         hdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443290; x=1780048090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=SFsYIz492DPMymzr5G4muDCO9U5VHJW2yGcFfZ46JQXlfljtvnnSsPA+jRk1ouq4ds
         3W1giy6CNyH/k7pBZAKWnLOn4qdWRSkBoUzOnvI4Q00KyH4qVmZtbEWQVvh2J3DYypX9
         h/lZEoZuK0LYioCY+S3csdibrduBWbm3RubalOy1YVJF6tbWk1yBL6tBB6KWyApH3d4Q
         aHiqr8tBUyI5HZwPT8kunkf3lphWHwSF/ygpCwpRVyJfYYQ1nocYkxUHdgjphudz9v4u
         x+xx7zIiXQv3sZPKRfHTlUbfLqB8vKo7KkgTvWGwpmHB2O0MJ4zl3Cbv7/NvCUzyw2k6
         CDbg==
X-Forwarded-Encrypted: i=1; AFNElJ/MKA2hYwrJlgw/KuNgueRYUmDZBNUI9kc1FlCznNackDQDR8Kguvv8ZIvbLBu9rb8kV02mnvUgYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0vR3HfxiJna9hWaQlgae527aAEcQRJEhSF4/g/XRoqYIlRBq
	++fqMNAm+8aJBp3jgGgCYwSJ15BB4IsIJkOXKgRYEg5npJJJJdhgIJjjGLzr5lWfgiIC5qLQVdI
	+zdt/MpdYxeZov0Tkbl4/0gYbT7w4sKahpfzvqepgwPrD7MKOdiGLqCZCjS5lzg==
X-Gm-Gg: Acq92OHcDKTbYDxYZhQ5TACWpsyiv0o7wiIZAH566f16hgVl2WzflUWPajJoVYwa+//
	zeQpigRBIc2+SNQ3ytE9Qfgii+JhdVkwLbUnQKLHKyhVN8J4xngRCphZvTKUHBgu0PCEnizco/V
	Q2/HEhUdm0anu82ymNwnknfPyQFy1z49om4QoEWA4O9Z6UPfVaTZYW2KvfGJIWtidux42UFF19V
	EK+1xxYd3Mfpx/n+LR8yDuVmoBAf2BfkBlbgx3+Cdk704CMbCVKA0SXP6eFYz+gnP8FTOXq6sq2
	ltTNIgtkHmfQJded5CI5grU3Tx8l9SGLi06iBYdisuKgF0evf0rPooCVQq4XBMgpFuQ0Xombt6U
	dYyylpxLSDiZRqp1bRNAQmKNUYd5g+lKIIo58Xu8VdvAvXA==
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315381cf.7.1779443289732;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315241cf.7.1779443289307;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc3652b34sm36909566b.28.2026.05.22.02.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:48:08 -0700 (PDT)
Message-ID: <24f84ae8-6099-43a1-91a9-b50a0aaeb3e1@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
 <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
 <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a10265a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=aCkQYJryizutyd-nL94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: jKJDx5ebPEDC37_hkn2XPIZLjHN2fp-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NyBTYWx0ZWRfX6Q8JMNkohK5C
 YGbioi9aAT56+C6/I4mY+cpxV8qMBQWW1+CW1DWmI+Ggeknqfwohp1oZMLCWZdzo0m+fS9aFV7q
 j6d6C4Oj+gO8gfqfgu9FgVj9NaFTtd4lXWkFgQo6Jo64lqLeapfteWrHD0itm2Hw8/MeFI8AoMs
 DHBouJnkZ/vePbN8QkuWAYesOArCfGf9or3cVOh4c4BqPmyuYLtw8XJPswXseD0lQ/CmtM+gjGG
 g+n2RgOJDa/TscWMMEx+0qZAQdoo2GD7rt4ZIZs6yEbxspF1sNCaD07Z9vvrj7GKBVnzPl9525A
 NN5Rdtv9ygiyGjm+p7cZn+1mUygMJRy2nHpAy1wQfDZebG2qc+UFLAOgMZWesKC+a0+JTXSVudo
 zdcDrmyzdz7lty3MAUhC3AVuApO1ksGUxS5rqKmiHdVKTOYUTQRLG/Iah6rjgOlBqSGKckUvR1O
 sPlf5ZOQjKRfR0IbpeQ==
X-Proofpoint-ORIG-GUID: jKJDx5ebPEDC37_hkn2XPIZLjHN2fp-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220097

On 5/20/26 4:41 PM, Loic Poulain wrote:
> On Wed, May 20, 2026 at 4:36 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
>>> On Wed, May 20, 2026 at 2:34 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>
>>>> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
>>>>> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
>>>>> Arduino VENTUNO Q board. The module is interfaced via LGA and is
>>>>> compatible with the M.2 Key E.
>>>>>
>>>>> Add wireless-lga-connector node using pcie-m2-e-connector binding,
>>>>> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
>>>>> the Bluetooth interface.
>>>>>
>>>>> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
>>>>> the pci-pwrctrl driver can acquire the power sequencer and enable
>>>>> the M.2 slot before PCIe enumeration.
>>>>>
>>>>> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
>>>>> (gpio56/gpio55) used by the power sequencer.
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>>>>>  1 file changed, 65 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>>>>>               enable-active-high;
>>>>>               startup-delay-us = <20000>;
>>>>>       };
>>>>> +
>>>>> +     wireless-lga-connector {
>>>>> +             compatible = "pcie-m2-e-connector";
>>>>
>>>> I think it was discussed that LGA can't be an actual M.2 E-key
>>>> connector.
>>>
>>> I am not sure I followed this discussion. Do you mean that I should
>>> introduce a dedicated LGA/vendor-compatible string in the compatible
>>> list of the pcie-m2-e-connector binding, or that LGA-based designs
>>> should not be described using the pcie-m2-e-connector binding (graph
>>> representation)?
>>
>> I think, it should be a separate, vendor-specific compat (maybe using
>> m2-e as a fallback).
> 
> ok, understood.

Oh, I reviewed this before looking at this discussion.. yeah Dmitry's
suggestion is good

Konrad
