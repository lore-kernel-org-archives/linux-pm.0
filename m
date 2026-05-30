Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83180274FDC
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165556; cv=none; b=NHba5pUP5rwnwI8/inERZSag2wvPoTciVF7beIn0S0YqhD4K8wCPXhua8cq6W8eITossdyMKD2CPjnCa6uETWLzi+YVL+mSipXQJvyNiSamqXaU3N9TC/CNElSQ80IeNXF5GPEH8a39h0kJQpDKcA6T4yCIYdfX0z8dW9JWppCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165556; c=relaxed/simple;
	bh=XNmqWPCjkIT/ZliCL7TlGnWUU2zGS6zXacCYJ+HC6OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksQtwn8uecGE+JV0AE+bgKo4vlHmlVGfjO/98HsC3V6BgrUyHH06xNGPSnhLRcDEdesjemX5QIzllODi64cQoa491vSNWQpjk7XElUZW5VgPP84CMiIQCm6iPoG+uNtrTq2XTm83PPNJDx4ey6adBcAsmdqRb1EYc+lutIvo2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TijMDtyU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKsg9ul7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TijMDtyU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKsg9ul7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOeOt1748786
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=; b=TijMDtyUksXbENx4
	d+aImu6vsUm6cKeF7jyCAeFqL34FQtwHNmXWsztJSJDV4E63VjGzkCN8tROGRD7B
	t70O6Xu468DmiuvBhDX20cKH6gfbAGGAQRlmbHBdid0zVRE6lXK5C3Ado714W2Q+
	wsnyCiXVh3tb8HysTNNQVqV4WKeJ0Fvi1y8saliQ4t6ea/j5lR9Dq6rgSb/6JUv2
	KT7D6Uv0IqXHTMEDd7vVIBZy0zMZA8Fy9pXtPEuxhkelEhPjPRcLCrrlu8wWkSso
	SCslM+laEDjUySQBc/EeSkmxBh1d9sbaViq84AdSfKxCX55WX0BpJMMR5bmvcUkX
	1oXaAQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr419rdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:25:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8584e80bfcso533260a12.3
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165554; x=1780770354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=;
        b=SKsg9ul7N8nU0RyAXsMfatiZlqJ28463emdvbN/4YXmKNAnSEgXKqM/t2XDbNO0/ck
         irrhCfYrnldPgaSfBMvXtJPNYcjF9hmLdknjVO/QS59rrXgMXF+zDtnoRPJPhMOKvNr6
         g5vSeGQWwW0DtAekSoBEiAXjhqq6EhZtVUl2fo0q0TykQKNWcaUzq557m2CnP25n62rt
         tR9qzWHFddl/XQI0F/F6iB3CKdIvWDPw8rR18iTqoHBTZ5JfIFXC2BlvW3F4ERRC2q3N
         wOHsHs7idBb9Bg5aw4Scnyb88dyiR3bGPMlJL1VVQZE4H9bGXP+NkfhxLP2VRgJnsR8A
         sC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165554; x=1780770354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=;
        b=ZJACiWGOm8DQjrtbbWotmfgGV5h+WACDDhLbI6f7gEeOmiV/AD9hxvkiCkqZ/1RhHq
         jpSfQusfvIM7CmXZnMJah/IS1MOPz6mdh7nd4PJAPc8oTPtLndtcjPosvbpm6F8EjWWJ
         6ZKPBML1+csj951eM9x0WjQix6cyBL67Fu+VxeA+BvGHOpeQMjmA5jKor7uyu8IvR6A5
         E5xG9bEBN8pHMbVTf/WhXZQph7eNiX1Y6MQLHtPDEdYOyNpsDJNjTW6SeC7/1K3hdver
         qVsewDdVylW3y3KPinNHkFXXDe4mWRyi8hzd4CPTFShsxSPQHCl9FuqQpYe2MLrFx77x
         s4Gg==
X-Forwarded-Encrypted: i=1; AFNElJ8StZh4Dzplw/4Ae0X1cUXLhfUorlf7hrNicWj+sJdNJN+IgNTnUqt4Xe1ooqlpouXvWBdQSElKSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGn/N7pOLiE5k8tJd1HaVNaMCxi0/UrI9t+ztWmdagy+bwxEn
	APZwQf3XkTPZN2w8YS5QPek9yITta/lYHQq1UfsuDYDUtKb56GeSO645MKSekSXm23zr9RzKmv1
	oefPQ4wYf2Fg4VgrxbDYAi/W7iGF8CIHaRBt5oDuw9uCc1SZpCKrJDqR5e/bXMw==
X-Gm-Gg: Acq92OGZRyj5ZR1Lm1cL0rfG6PXSYdXz4f8hvgbtKY/tOPqQ6IJsxcxK9iUtJq7czNk
	dVRYl5G4JnMZ8iH4G0gjJ/yCmusJFJiEmCvmZdLiRKkd11TlvN7P4xxeW/XLGhmnojTh/fZ2oJ7
	lTS6OxbwLew/2IM0oE6LQmFiTyb1qtmF75AvoQVM+GG2mOl+v+0TYdhXuC/JhKwQTqjqvxKVFSG
	Sqi+EoPkAwfd9yQ0b1w0+EuTbCey+eRPJhSvcxDtcQztRplSY/HhwG8K4RP3mdYIGAfEJ3m2i4r
	MLC9P2NBIxW0yJmslQRSggsC2I+zBK7lDCma9guA5thPQEufW5BroiodKnqz6JDJZxp2bJSaXND
	qwd7U1P0eoS+et3yr0um9oj40Xqv40vkT+Cpd0DnbRRrnb8IgM1bZdor9ew4nUs0=
X-Received: by 2002:a05:6a21:4e01:b0:398:840d:39aa with SMTP id adf61e73a8af0-3b427f7611dmr4719727637.29.1780165553992;
        Sat, 30 May 2026 11:25:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e01:b0:398:840d:39aa with SMTP id adf61e73a8af0-3b427f7611dmr4719702637.29.1780165553443;
        Sat, 30 May 2026 11:25:53 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.232.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm6057818a12.15.2026.05.30.11.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 11:25:52 -0700 (PDT)
Message-ID: <d4fa00d7-306b-4aa9-b599-945924c381d6@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:55:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
 <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
 <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
 <urft4kklev3palxzpkrbif3jx3fuwdzlj7weyjtodl62vbbzto@v3tpmfvsrlku>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <urft4kklev3palxzpkrbif3jx3fuwdzlj7weyjtodl62vbbzto@v3tpmfvsrlku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fOEJG5ae c=1 sm=1 tr=0 ts=6a1b2bb2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=VhQgrmAlsMqV4Ib2O9uomA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PA2aZWPzbia8iepHnnwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 4axHTZMKRhz1Qchs1kN64KLS8j7yijAL
X-Proofpoint-GUID: 4axHTZMKRhz1Qchs1kN64KLS8j7yijAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OCBTYWx0ZWRfX/R4pwc71Lzo4
 deKE2W5yJ0Tzm/3GCX3SHnpc9wJo3QWIrOcHZ9yKsSgeaGByIARzXbiaQBVHMSZQ40giFoMdcd2
 /vh3vMnuwm1K4SC32WFl47Bu7nXBP2Zs4SqPQ04mm85zqSlSxM9aJ844D6peZbelCw8EHm7osMT
 pahR+KgefKdUTgrZb+w8ig0lMQhPRYt+MwshBzcUw9ULVO2BhEmOBBnTkcCIMdgtZSlg20H8kBN
 atQWzpThrM2ng183xahlsi/QxlUN8uhXjpB3fPhVwjjsTk5QcHehcfLHNefyBj30OPa6SEA5zaO
 yCIN3BK/aa5zDsiTOBIJTQFsUXEI4KY5pBv1kIHMho4uwn0gK12PolZYBY9chh4diR10iE00Scy
 aq/ZK37CYFiUMT3RvzrJAmbs7dqXjXmjqmSGlUreefp2YNn4RwkFiyM2MJetYLWys7sHho9vvkc
 R7y4UDXi/0h6+CmDZ7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300198

On 5/29/2026 4:47 PM, Dmitry Baryshkov wrote:
> On Fri, May 29, 2026 at 03:41:50PM +0530, Komal Bajaj wrote:
>> On 5/25/2026 2:57 PM, Dmitry Baryshkov wrote:
>>> On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
>>>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>
>>>> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 164 insertions(+)
>>>>
>>>> +
>>>> +		remoteproc_lpaicp: remoteproc@b800000 {
>>>> +			compatible = "qcom,shikra-lpaicp-pas";
>>>> +			reg = <0x0 0x0b800000 0x0 0x200000>;
>>>> +
>>>> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
>>>> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
>>>> +
>>>> +			interrupt-names = "wdog",
>>>> +					  "fatal",
>>>> +					  "ready",
>>>> +					  "handover",
>>>> +					  "stop-ack";
>>>> +
>>>> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>> +			clock-names = "xo";
>>>> +
>>>> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
>>>> +
>>>> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
>>>> +			qcom,smem-state-names = "stop";
>>>> +
>>>> +			status = "disabled";
>>>> +
>>>> +			glink-edge {
>>>> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
>>>> +				mboxes = <&apcs_glb 9>;
>>>> +				qcom,remote-pid = <26>;
>>>> +				label = "lpaicp";
>>> No FastRPC for LPAICP?
>> No, FastRPC is not applicable for LPAICP. FastRPC is primarily used for
>> offloading audio, sensor, or other DSP-related workloads, and is not
>> required here.
> Which likely means, no compressed audio support?

Yes, it's not.

Thanks
Komal

>

