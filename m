Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D333ACA5A
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576551; cv=none; b=qdRtaxnU/ZuzO/m6rnTFEU6kTN1g1pk+4eko6pJKAXB31CZf2BAxI7/ODto/c5LokFKvb1RL1hPLUSwobA3eZM8GGA/97oqivSHplao+GqOFv7uvIP+f5T6AqakO8K0v/GNoXpB9z5Ut6xdZjgQU1ED0ONrtPb6Hvdl4dfRVCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576551; c=relaxed/simple;
	bh=sXgLEOgI2SCOJhE/tWVh0lCN5/y6oBCIOWbl2fyUefA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNe8NJT9MbJaSXol0Us/RY/pOiy7DLD5DwdcDp3rw0DI5FPhFK/xkcA04LCEjO+/RM6rDYj+QM5lBIjaONCQrG0jfG+n94tLjW2mjuvK+g4rdOJstQWQrr8MZPyxBbpK2m9P+fCb9NfSV1zx710snX22TStfTln1zI87KzAod5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ze1fMsuR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X5pd/MiH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ze1fMsuR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X5pd/MiH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N96Ic038884
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 05:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=; b=Ze1fMsuRHeyn4W+1
	YlNA0umD9w1RYyTxkpudsWTLeSj41d9e84zXLDUs7viAdwxrEhh2WYMHBFVNifIE
	Ovoz1mrUgyDnS9fHEZTzq7xBFlHc09jTvgQiopbi2Wbi/80trFxWhuQhTwjmMt3j
	9QwTLRz79E4OHy2wHH5erokMvSdFOQXIhbjEZw+vitdotq5aA3BaqwHUI5mIAa5O
	wHqDOfueNVyP8oceBmnYhzm+QM+1lO3MIjG/OjxQ9NSdXs+NW8oiXMWcczfuWSAF
	I056P3DAF7oMcrlALedj+HiSweMSOEI4iVmDWOEns0xpsGLjsLEedmzInBCaPVTB
	cxztnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6j44u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 05:55:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso29202585ad.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 22:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783576547; x=1784181347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=;
        b=X5pd/MiHbjvXFDqKzFtBB6oSQ1XQLCzqCWZ49SJluh6nqpj9o1SUPsGSyJTEDIMqLc
         VIxw9xgIxaYYXS0nrmnDPzsBzFcd+QprZZarDauN/qvnecJuv1eOZ1o2QwDn7KhbGjXL
         aGUMlPumuQMJJxgqSe4Yw0J5bauX9nYmo92QXH+hEycZ5PQiAH/MvtTTRguIwuJ1eCI8
         KLIhkjYFfdMk/oFgK5VXkyZ9lpecMvX8SdnBuznA3okxqmXSgarLIPmo0WR82vIMExkC
         5kZMDg+sikzq9AjjlFyWXpEDp/9qyymzIzDyq1huBYiE3iOcsK48jAUHMxINU4zPpreC
         rM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783576547; x=1784181347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=;
        b=L7iXupnI8AU76/MSNuQbHiikltD8heMGy8XCmoinzHMrae5wNQCMbwTvlaa4QfEBP6
         kM61IbwQYzST6QEUcnYksjIjMVWhcCEdLZUSHqIZjaAk9jL41NqzSWMjmSe21x2u1J1X
         /iHalApWOSG7cd1Hq/HauBCAdNgfP1/1ALZ6xzyZ3I4f4mq6sXXk+lVBLpl0TI/ORTzx
         3i5/esNy01K4ziPHkGPZsc7A2f/ukbMDqtA/HXldwS0bEqs6yDU4hxBK/RpFmLWvLxpm
         Lhoza3Z2cuGkxe3z+Q9DKl8StPSEO8zU48wHi4FOykgqshul0659ZGcBsug4MUZvhlpk
         SU0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpcu+X96nU7uViC9um09p8e72f8fnLIoib2uUbuAp/EZ9KxeuJlK7mUUwlXRzVOvqClcAdjsV10kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEbdSrthPaDQSbCi14rkGiKmNUELKM/uHKyEkG4Jx79qJ8lHy
	rCv0pcpmsPjtMaXTpXBZgyHNU/G3RGMrVKjsgRygid1v4MerOIg7Ohlwo4EDgRsX1wcQ5Ae2NOl
	3Hkw6atVwYtaUcuziRaxiBJaulTJt5aHiLrpPXeBZ6KOXaFYrHyvOmd8U70rDog==
X-Gm-Gg: AfdE7cmDDdTDwGaDBRyADXiCFZau3Qbw6HQhdj7orkGIXhxDACuCoukfX/7/Evyp0Cn
	o0ziqBMRnw1QPPmbP0TDvwiyk7n1Lh4+r3E8MUlx0wdvOfISN/zZZG/vpiWGtM+9p8xAU7f9sTA
	hx6TrnerqrHoXSsmXQ+U+1t/mNt1QftnZeHXKHZN18ynthURDNN9moCMYG7MdW8F9NJjv0EEHSF
	rWVyB7Xa7Vtsl4GOOUAmuxySfpMAa5QvEayB65aLqtKyVelPHVmF8bugqN42NjScPBo2natO6bN
	KdIczCm84/LQzP8/3mBIngJk8Gq72wDx2e/+xft1oOb13HTNvH8mw8IObQofeW67KGwypFSsZ9j
	LR476Yaaz+Pxrz/zmGFZ/hs38Wxr6q76Mw9viFOJXocI=
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr6875998637.47.1783576546747;
        Wed, 08 Jul 2026 22:55:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr6875920637.47.1783576545686;
        Wed, 08 Jul 2026 22:55:45 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5946sm3184667a12.7.2026.07.08.22.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:55:45 -0700 (PDT)
Message-ID: <04365920-4abf-439a-816e-3ae6ff06521c@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:25:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: eliza-evk: Enable PCIe0 and
 PCIe1 with M.2 and TC9563 switch
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <ak5sfkmrhorCY6lf@baldur>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ak5sfkmrhorCY6lf@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MyBTYWx0ZWRfXwHmVskGS/xJs
 NHfGqp7JQeSUpVDL7g6XNmuzy02feyfrJ6fUUDp3RLzq5Xxt80RSJnYIzDBT6yQmfPuWl0Z7mnY
 GQK7ZoIFU6CFfaSsMvlbOlvNSrl4pxo=
X-Proofpoint-GUID: KktFUzn7BPSCi8myV4HCl0AYYWRxqHgb
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f37e3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=UtvHBniHWTLL8wGpZJ8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: KktFUzn7BPSCi8myV4HCl0AYYWRxqHgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MyBTYWx0ZWRfX1R1IKZ6AM4lf
 QwLDfExrsOEStZsK2aK+LiBgFAcLiRozqREV/QoXjf9ekkECWiaQMaUoMKxKK3blDifHsLnvQMO
 yNVWgFbvd6LCx8yk89gnotnSlBQt4QdxhKVe57VOMkN29d+JVkAPvgSFPXMqTU6Jb0lDM+y2G7Q
 ali4bGMPYfPraxgncxWo3yXus/GoUYJLPZc04pZ0gioWGdC4hLig8dDQkj0Zbmsd2NNQm/PWYcg
 PB+ZiOVjUzv3M4TY4zKwqYGirNC6Y4bx1zMBzhU+wCxNU7dIpYL4I9QvwTYQxG2zFx5mEdM6PYR
 A0hzLV8Tg68lT7XZg8pMa5FugOXN3iCeam23haaxaPfeorweBqb7dtoGeSrzcdjnAaGP1IjECfz
 O2PaGyIaHfcTFuSYtZUV0UBGkIkCm+yC/OTxO3YMXvsqPYTZLLsTJ3MdmEC3WG+6CAvFKCDtN1k
 UnCTywJJ59h8NABvnrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090053



On 7/8/2026 9:05 PM, Bjorn Andersson wrote:
> On Wed, Jul 08, 2026 at 11:47:15AM +0530, Krishna Chaitanya Chundru wrote:
>> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
>>
>> The Eliza EVK exposes two PCIe ports:
>>
>> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>>   modelled with the pcie-m2-e-connector binding.
>>
>> - PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
>>   management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
>>   PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
>>   the RESX# pin. The iommu-map covers all downstream switch ports
>>   (SID range 0x1400-0x1408).
>>
>> The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
>> entry is added to the M.2 power sequencer so the serdev node for the BT
>> UART interface is created on PCI enumeration.
>>
>> Bluetooth is enabled with this patch https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/
>>
>> This seris Depends-on:
>>   https://lore.kernel.org/all/20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com/
> Why send this patch, when this dependency is known bad - when would I
> ever be able to merge this patch?
>
> And why are you sending separate series concurrently with dependencies
> between them!? It's one thing to send patches saying "I depend on
> someone else's completely unrelated work", but saying "here's a random
> bunch of tangled patches, good luck everyone!" is not okay.
>
> I expect all three patches to be rebased and send in one series that I
> can just click "Submit" on next time.
Sorry for the mess, I will resend all 3 pcie patches in a single series today.

- Krishna Chaitanya.
> Thanks,
> Bjorn
>
>>   https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
>>   https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Drop patch 3, as this is already applied
>> - Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
>>   and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
>>   pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
>> - Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com
>>
>> To: Bjorn Andersson <andersson@kernel.org>
>> To: Konrad Dybcio <konradybcio@kernel.org>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> ---
>> Krishna Chaitanya Chundru (2):
>>       arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
>>       arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
>>
>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 228 ++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   2 +
>>  2 files changed, 230 insertions(+)
>> ---
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> change-id: 20260629-eliza_evk-6f30686b161f
>> prerequisite-message-id: <20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com>
>> prerequisite-patch-id: 7654ff4f899ac0094a2e791e7f208998fcc7d5fa
>> prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
>> prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
>> prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
>> prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
>> prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53
>>
>> Best regards,
>> --  
>> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>

