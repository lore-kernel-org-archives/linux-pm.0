Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88883D6CC6
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226099; cv=none; b=c49FJp5ocaJ9BAELsOAbw2CtwWJ4Bx5SX5Yw+wWpNstHX8z8TChvJyF8M4zFwO5Bha6/b5MQ/8Py1n9mjcHbeTJosOK8FrTnNbUiGlrmSXOkS40mNJ/1Uoyu92p9Qtt5fvCBeN8KcUs9O8u6bcCsu0xllmEwZfezO9tRKMqx6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226099; c=relaxed/simple;
	bh=q37I5XVI0Q+iLKP5qsaezNyPiLXtMNHajU5etzKIRWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuTyUIIC+WFYxsCukGMhf7j5ZBfx40377PpShxuYChapQrsZ+lgY88yV28/tWNs7IsYcoTQYDriVQQVCAerNm4Dtj3qn0ll+RxgxuKaIr/x2CX3CS74/cPgM/wwpnwlKTsFMtRCFfCMyqhsXrr8h/b6CdkwLMDKU1MVVKEQrjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdX/o1D7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FK7RUKgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdX/o1D7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FK7RUKgH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82D0D2480113
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=; b=MdX/o1D7OfoL8HbX
	6wCEsSoj02rlpqkKU52J5RHlg60Ps8R6YvS/USZmoqQBQysjoVVFUiMF9b58/W/+
	ktsQtjwLoB6kQXwVGOLytuNZ4ZXrOFW3u3D7/OhUPKlU/93wE7UpQoWZyynoO59n
	1KLPwm1+JLNrFcrwCwPCnImXhKE51stSwl9h4lsxtTV8ZdApNKANFRCDBLca1DMd
	oXzDNp4fY0kAa1YyijhBuc8JJidNUne3vASoUVWmfKgjN4qsVeriiBFReKBoOGWp
	HhaZdWrPfrvEYmE1PFrjuuonQHI1CXdRxaHiLgx3kpdd+50VX2R73Lo4b08f6n2N
	7YugXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy10w86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93105103d06so16522685a.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785226095; x=1785830895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=;
        b=FK7RUKgHtJ8cMzxm04rl6JmdvDDNJfZQpzYzaT6LInA6MQ62IWOBtOsZqKWSDreBVZ
         BBPtuZpUmdk1nuiJzfvZZz6MPF3vVxBeBySJKwD60aGfQXSQz0UrJb91a/RKzmfW+vOo
         D8lielY1dDIet9x4lTKYT/gxybfzVpMG5DRjRgtzDZtC+JoWClFfMMKg2hxZR4laNPQa
         v9dIRbHDnOTyF3NP22fn+GW6PfV5+Eaq8/JgDfBz0dsZ6GihmzZHQ+p+Iwm58V5+bYvk
         875vnqc14AI6s1UgmGH+kUnMOpezBQx0/1MuPG8TMEQglQnQuSx4SffnM9hupkHC2W0U
         wUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226095; x=1785830895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=;
        b=YZLoNhRGKIli0tAiWfBAxfD7Pqv/BztRwQ2j2TJWqmuAZMldsyGTSTW0q26CwK9tpc
         yPz6fFfYW6MvLbNLynnxS9VUxpNz0DXen8sC0bTL8cIDP+PtnoA51ZgXgnpATWU6FmVZ
         hN+EyJddStoJloPVJr+ndV+THm9G6GiVvsvATUYy68FwsX3WIcAfwtnwj4YXxRvN6XLw
         w6DYJ6tHrA9ta6D3pFp/RrBRuWtjH3KCykz1Ew+NS0YNWnsfu/mcbbK+p0E0BKDx2zyt
         dRQ+M9nR+SMllZOkxxTat2pTifE6ZNz01EU9FYVuzDACIIWvmMc6ja9uDjVkCg38kLDy
         h6Vg==
X-Forwarded-Encrypted: i=1; AHgh+RrWQvldSRRf3kJfJfCvIt1VoD87NTo6SvzWm00sns9RatO6WQjZK5DkPmYvNJp20g1rKauBW5MrBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04syHajPbbxpZHaRE50izhgl84CNF1F0JNjc8cDup/Hk+y3yn
	lq+cm3ORA51fFW7rXnkN1AccAdgUmzsioCTe3T5dgobdeMe3NJmpdXEBIxySgsTulUP3knr9Jes
	xsJRXGP11vk7UnSlJBJDRB5Ed0ysc9NhAAWA6jqL1xOsswnuwlwTmTi0gFQmujkWs/J/Cgw==
X-Gm-Gg: AR+sD12u7ET02og0GMVhKzq2ZNRVY7wRWhJkromafoPTJZ6JvtufxiYtG9Zrmg1Or5v
	sKtRSHuqsinIwaIJbI4NE8Gn9V4W/d+aBJaL6Co23w4hOihGToybWwaisJq8giPU/owap0+9fU7
	YIgO1WVxAuDXVIgEC7/vPUnUCLqe0EP1AdWwGJQixen7l/cBsWWJcHWDM+BVHuINL7HuTmdfueZ
	rtgqn3Xurd3EaDDKP2BthKTEEOjs/qApFhsvcs7baHGEf+HgGjfGKkPG/QZEy6rFKB3PCCKclx/
	npOL35UcjpISDmyCWVjBAuD1ndFfw1dA2VTQ/0TIUzt9wiPR8C4sf5psgroPNg0/fVf0u5Fue4C
	gIPFag1rOMsguZwp3L1swYt8C
X-Received: by 2002:a05:620a:a01b:b0:931:23a:83ca with SMTP id af79cd13be357-933027200admr143514885a.4.1785226095302;
        Tue, 28 Jul 2026 01:08:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a01b:b0:931:23a:83ca with SMTP id af79cd13be357-933027200admr143511085a.4.1785226094885;
        Tue, 28 Jul 2026 01:08:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a798a5sm720897566b.9.2026.07.28.01.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:08:13 -0700 (PDT)
Message-ID: <3e5470ae-887a-45be-963f-ee3ab10d36d0@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
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
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2r99yIYEL3BDAETDXeplJoM-jLcsXcN0
X-Proofpoint-ORIG-GUID: 2r99yIYEL3BDAETDXeplJoM-jLcsXcN0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXzIIXV7GyGVGJ
 ez5mAnz4mGv7Dap21i8k49syPs3mYigGlnUAUe8CgCnhUGNs4FBjQKyFn605KWFbCZTp/kaSyuH
 Q0B0xAsnBFspd2VC+q7uUquO2dmdR8g6r1f0FBbTChtINiU9JX9/2e5n/RMRKfBVUCn7AWN7g2T
 I0DPRgNjeJu0QvitD+/ZQII4AsaqPrrMXWo7pxeavHtRPoYzZUidLUS2EYwSaJlou3wmV+Wuz9a
 1jh6YfAORrJNjEcr0RkryUsvY8218vtH+BamBAhzGI96UOTVn4duODRa0Ucbj3bmiNNDXONUOSE
 /Q8xV1NzmcxClKU8xcCoGPqMCNsVmmS15BgMBoU39RV3aJkswZWmzKKwANY6MmY18ambZ2ynFie
 kuC26S6oaMRmbXFrph8ePQa3IVZabYymKTD3TjQZ88M6H8AfD178B5K8StAnqy8oNDB0khV84qA
 LoE4uNTbcaU5EkSML8g==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a686370 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXy+gBgi/KuNAT
 ewRLYBPzUT1kS1x9zsLipIPkJO7CebIwNrPZWgjto3ClpVf7dFYAD9mJUqfD5a32UnPrjovLiQu
 PitWihC84gWSl1Yq2LntyFDO89DXG8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069

On 7/28/26 9:06 AM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
