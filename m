Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC535E1C3
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049521; cv=none; b=AH8clxHVBCwzjRBz8JI46i9GPKHRt5+rmN2GQdu9MJ/tvowmUW2eEA2RZY8EhRFaXs/dRwwzP5l4pIh6aFyjXKAnLMpNVQxSDITeQDZBRmXeI/2Y4Uqu4k2R69spWQNy7RylyLSvEOwzc1tCs7+jRe2MtsFuPCgIjTEHKS+w6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049521; c=relaxed/simple;
	bh=RGM49AvjO/SWUeLeg2sf3XNzCTqLcvOQHO39H3cp3+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pU0uVOABGTqB0ThcjAKFNChdHqoGn+HTLKrbARDRkbtkRdeg12Xq2l2dyPQv9JIhE8yX2jQS/OcpGZ1WuJVezsJPwMC+nWRpCdBFRZ70Pr0AW5M0SqT2+NyhySYBf0jTbt254s5wOXC1ggRFX1bvj6mPjnLQxVZciSDzbo3Qxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PqwF/bWf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kIztQswe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PqwF/bWf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIztQswe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T74xnO1829455
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=; b=PqwF/bWfVMP6ZobJ
	CAXucgQX6239mSS4aLtKbYiL+25Q/dehvcnhVoTgF4J+qmJ1Sq0dxStCcR/t0HYM
	tCjZ3IwhcHxcDziFhd4dB7emSPdOu94OHy5C3G4UM90CRu2Yt4m5pJV/esnH5ipH
	605HFM/nhAevnilFjF41iFD4Qw77I/cq3IPrvZBiPvNFEgyRD5AvxQqS40MP30G8
	1vCNJ9E0vtpLSNzaoWo/KAI3tMVarD4dpjTgOKBB2dagySp0nQsoMpXdr/RwQISs
	QEt25WJazBae+WtcX/pExWW5gLQeW7kJoJirsJR/d7KCQ1bIhb3ylbauzUNzcr9R
	wtRO6Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m2qqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:11:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso7413149b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780049518; x=1780654318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=;
        b=kIztQswewLUAtHOryxhqpdI4hXxvX3SHOwFOuqqFuBBhExd1pvSBAg9OE2dqzVtqsQ
         Xgti+Z8CIEGUwWrSVVBNw3A7HIrhE9mOaT7IL82Fa7//op9KgxXm074mYn16Rq1E4Ykt
         eDt4o7vw2RIXHUTMW1CA92C39eEgR6Kjb2ij/TXN6ljvG6ZopFYl0Q24Qm2rc2MhNRlI
         s0ZhEC1w15Ac9qsZjJ0J0L4rxsDEt4c2/z3Iq4bx1egcojQJyn/K/3ePECIcOnG7SofH
         oOIGZP0/VL55CvFVPmoU8G1bHr5ULUaJkc4xT/Kxrv3l9dfI1h61EhfeJLDGAa8QqqOa
         q31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049518; x=1780654318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=;
        b=kQWRWkioktOI3SqEu8a9Zub3rOMqTOw6ajdOGJZHnP5NXoZyaJME7Hh2KLk6fVyMr8
         gCg1UUc8Zqbw8XNZj5sacfag4bCa+2khU2ZG5WgRLlRgSHUWF7BxcdTXrrVVyNATcl5N
         wObTdN9m9k/khqCKBs2EO6wP4imhAlKO4NeaOLoBLWCcYLCRDUR56kWWMqFME7Zcu6UK
         l1nyw9j04Y2TN8HVmOU8Dxf0K5jd8XV3fPhYpb1NR+xPYj49NAZH1qcuT2XVBx7vVMnG
         2eBbfGsvZdbiW84u6BjzUJ5GoCRdGUnATiqouEoEG7Vc1prA6pqkSDdglczxDSCssAf4
         Xx3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8pLnHa+qpz6C1EgLb75xRLtqpwlc1gXZlgSkHkUDg/cOBbg34YRhGb+BS/sj9WWW/NpgPpfL7sUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BUhFDcBKoM12pXUVFR6KgS7EpUreMpE+Ip7G4R7wV0BTeXba
	r89LIS2itD6XFA9hEXES/WQ/U+Kpepe1BG+61o/jdKjx7he5TsSB1ElNQmaXgFzEABauQoA5Y4D
	87d8cPn9LBCpvfxORJ9F7od1l6FlkwhR+41qf9WA/eah7JCTOqdzg+xR31hQ2OQ==
X-Gm-Gg: Acq92OEeEZoQjsjvYPqaoVo/o8E6wz3Yo5nuG68XQJ7CniAPF+6D+uCItzWR6ioigeA
	jAR4OK4e0j3As/u6+3wun3dShQYtsHP/6su0kaul+hEQWIIAhTkwb69UIj30Lq6fSUnder5d97a
	7IKjKdvqv9nvbt9aIInjl+pVZT48iG47qkV4gUI+r4D2o2oPTesR8z4ZQbMuy8PIpZkZJbZRQfq
	tlhxTpct542blCJ5zgGYA7v1w4fVfIU1dOOQ69sofzSR4OduYMQHiM6qxYU0DmjvrbedBwFPoRj
	3tF/9O1BSQpbDiqWelRLZVoIFYkoiAgqq+6pkofV0wj3M1EkJBdkJzkwkoVArJV2Wzpc2je4NXF
	ltk3Rp1I0CNbCvBgfbV2JuV25SSI0/Fr8Vki7kLuWjRSG3XZgX1BvN6W6UoI=
X-Received: by 2002:a05:6a00:a215:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-84212d394efmr2331730b3a.44.1780049517833;
        Fri, 29 May 2026 03:11:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:a215:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-84212d394efmr2331700b3a.44.1780049517352;
        Fri, 29 May 2026 03:11:57 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cebf6dsm1459830b3a.53.2026.05.29.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:11:56 -0700 (PDT)
Message-ID: <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:41:50 +0530
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
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMSBTYWx0ZWRfX6qB/Lwpxqwdy
 6taKHWoYvDcbaUzE7e4RthmDWOnCi0uR2JwBv6McWdquSl+2BEf+qbUIodHm5Q0/o34ijsYQbGa
 TgFUjrOJy0qWbUeRkYxXvRAKmW4gMNN+VDAtfIGYzhRno7/sTTJXN0FzEn3SgmvF/L5MGoYCaq2
 lyYIFhOOTbTsxiBbr3AIauIZ88bOMD7Y2v+5w5GtbLS7bMdBT/x5IuNTpSM3237IjOjo9TQhwOF
 T7W+V3lagBHGucObJg/BvS7NRj0CPmSkvecxBeyMlbczwuxvuHnTv+3wJhLrpYx426jqeNfsUcA
 1rofH2/YObPxcvnfkhuqw9BN+tksW4DiXslpfeaVIQ6ukHPIT67TQ8RNrRY/TuC4vvQHn1FZwvB
 dQehdCJWrN1kpJ7fmvIWrr3ydZdxRt+HMHCn8I9RAo/xclA801Jzh3QtEmtyacrZqdMBNiPKaeE
 6vUN2LlM5dZQ0LjM+MA==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19666e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zUxKe6W84NKXZjXATOUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: FHmAVpx6PCR13bL4yBE-25oV-QtqJPAF
X-Proofpoint-ORIG-GUID: FHmAVpx6PCR13bL4yBE-25oV-QtqJPAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290101

On 5/25/2026 2:57 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>
>> +
>> +		remoteproc_lpaicp: remoteproc@b800000 {
>> +			compatible = "qcom,shikra-lpaicp-pas";
>> +			reg = <0x0 0x0b800000 0x0 0x200000>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
>> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
>> +
>> +			interrupt-names = "wdog",
>> +					  "fatal",
>> +					  "ready",
>> +					  "handover",
>> +					  "stop-ack";
>> +
>> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "xo";
>> +
>> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
>> +
>> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			status = "disabled";
>> +
>> +			glink-edge {
>> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
>> +				mboxes = <&apcs_glb 9>;
>> +				qcom,remote-pid = <26>;
>> +				label = "lpaicp";
> No FastRPC for LPAICP?

No, FastRPC is not applicable for LPAICP. FastRPC is primarily used for 
offloading audio, sensor, or other DSP-related workloads, and is not 
required here.

Thanks
Komal

>
>> +			};
>> +		};
>> +
>>   		sram@c11e000 {
>>   			compatible = "qcom,shikra-imem", "mmio-sram";
>>   			reg = <0x0 0x0c11e000 0x0 0x1000>;
>>
>> -- 
>> 2.34.1
>>

