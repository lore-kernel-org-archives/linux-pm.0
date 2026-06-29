Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E07419301
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743694; cv=none; b=DnvVTeKL/XQ3TmMPCy8DjyB1L0lKCSfwfQdZskzw1vM9a0471vqiRp9qj+J+1ss2nEhhpVI37VvzvnIkDMxkaxKDc01hn8yEGNiyRKBvgey0brE4mX3/qp8iXcuO8InLuQ7aAsowUKlEtiuA/y66xv7gvhTdC9sB6lq+O2zTVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743694; c=relaxed/simple;
	bh=d05Fycd2bYo1vzS1RtKd2HZ2iWBH0Agkyzhv3yB91pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0FP4wlvh50sMHylxTjltnuPuQrU3BCbHhOqe/nX283nCf6YQSBh/9/KZY3OSE2NncDO44Hfrwd3DfVC5sLDa+Scajk4BPvXrgInCHvhE1KLTf+uu2nOoshMNd+V7lTQtlRakNY89IAeVdPgsIdRbEzvRUwvRb6xOKjdBFxsDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cakNeJZC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kmsnVjuj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cakNeJZC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kmsnVjuj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASpK02601074
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=; b=cakNeJZC3hkOaDJg
	x5BeMewWb7qRGF+V1MWGBoz41UrKVB8l+Xdz/ZnFv0BDS0gyGoEiV8dzTwa81ZQE
	ejsT4pWOBbJRs36ULqtLgn/YGEgslOPrQaCqyKeZliyT2Euh8nVrdHoI6yB+Krb2
	MywU3DDkZ2aZolbNHMThMC0uNfSxiYh1XuqIr/9kY/lb5IA3F3jViITOCjaH5pK8
	IAjxb+1ypiYLo47pb1CJdswPEnkygWzn48HqPt2tVR1wTJWQD/gGPRExL1QTvpF7
	2pu5DeN8Mw7av9oN2TIk8CcsDtizuE5ZyOkXVn6Y6az2ZwJUp2hzJOPdCOwUTPFR
	J7+kBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw9ase-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe75b7dbso938371cf.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743691; x=1783348491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=;
        b=kmsnVjujkr84UsusCovTuhtg1awcT2LOEJsQN5YvxHhafyNgBfQ8ssj+lyyO1O2jfu
         Qo7m6YpBDg4ahYjSr2ecRGAkWoeONak8z0NGip7/fyo4loKIRGrHAdi3ltNjAM1HaLje
         gwyrX/mR2B6/pAOCeug/YTPRBeHHGToj0cz/4YwDQ7JkyNamtDAismcwoE3TTtW4mXc6
         rPjnr0A73Ig32PQHaGo0vuBoOYQH1yMnr58YGPqxLhNFMXVXvdxtAe9ZiC4t3J1a18MW
         XFahEcylgaKhZDjDhn+xyUM59eAwzN8DoONuCFKy+AkG92cAq+qF8mDkfsXggRxiGyzw
         BKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743691; x=1783348491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=;
        b=gI6ConDNG0uIwnoSynVSrvNXGcILNJzNPIYmlvb4PkwgRbueta+ApPgL39rPe6AlPy
         5EMtE206A8y+Es7BlqvqVCN6g3kEOz4VnTfed2pT56ccK19x1mqONzvm70emPIzPH4i2
         mGLXZeQArYsZURTKgJtbD5x/p0+MrUiBmyuIk7o00ajbWPjR9GYu7aGnRA9WXdFq7XIf
         C0XqtPfXOWgxqDS7rQOD2NnQ75o487uD7cIcxA4PbY385BBV+CsWKi5+AOeTXZSb/7TZ
         f9PEkenCScjmTiUhh8eHALnKnYECrH8S55esUC7qWfbXS3HUiW6IS+KuZ+qadzbMZDcC
         HWzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s2su7BD6NwjfF2Xn1gLi7aL8MkcVLazsD8/Pfl7oCEPtU/zKP0cVYI6d4vDmD2e4YspjRMzoEAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywO8UxVhoaeec+2+uA7kgKUdDTQNrHMIA7g5ewyTtIRYUnnkuO
	4YpySYFZXHdUqRVIfT6tueSzMDTTUcuVT0E3ugiMasNeZO/e6fLFDEX1lfdT8GkCgNiuNnIxFEd
	a2OpINgaJj4zjFju7lzOAF+34yub5gJH8ejP0xiOdOVynWFrEufgyLQU6NBuJMw==
X-Gm-Gg: AfdE7cmjQqh749UhwmOPNaS+gV5KxsMCZUxk7za0CqpNnLdPRdhHq3M7Dq45NC6+MHs
	L9HnIvOiWrvFtAnjCVoDcBBNu6w9O6N4llQCUDSBwmp47G6FSDi3QJLIGyTuwZ+cI3X0tPlZfMy
	eMPeR/kmMLNhPpiooYhnL+tDj0nVyEaXfYmVIxBJ9BOXHlNHWDfNqJO22euzLNK+C/XAooIPxIX
	ucQ377C9j14WrnWgq8cweqBy6+qHh419ALalVP30p7kW5i+0De9zRVIg/sfXztIcZMpPykG9wUx
	/CI2WRYRbQtVHYjkptcVA4KOubtQ2z+W3dSeSFJA2Qv4yQR+n41HQjm+C6Uqo/2RsyzJ0TMTBGY
	62WlnIlk/bokY/vgkis1sQEUdJsp3ABoVUGU=
X-Received: by 2002:ac8:7dc7:0:b0:51c:a85:bf91 with SMTP id d75a77b69052e-51c0a85c063mr13123861cf.3.1782743691182;
        Mon, 29 Jun 2026 07:34:51 -0700 (PDT)
X-Received: by 2002:ac8:7dc7:0:b0:51c:a85:bf91 with SMTP id d75a77b69052e-51c0a85c063mr13123191cf.3.1782743690417;
        Mon, 29 Jun 2026 07:34:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1250a80b04sm289378066b.34.2026.06.29.07.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:34:49 -0700 (PDT)
Message-ID: <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:34:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMSBTYWx0ZWRfX3BVnd2WH8IDi
 PsrRvFEEPeq0WfOu2yKZrj+8w6a2NGUE/qc6Gs3QaRmm9jG0d7XS0R02JoBgEAP8WAeX1ThNlxJ
 ROpe1PAFxiNXlRSW5nzLrcObihq98Hw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMSBTYWx0ZWRfX+UaLe1TMia7j
 Ie1qJAAwMA7LHnPauuCIr6Sb+736cI6dPavVCDErt1UBrRgUu8KHgwbIgrDE5pMvwNdYzgp/Uxa
 YaOa1IG0QVCpUZGJt3mAF63vrh4eomj9ZofRKPafkGf2tKprfmnPMNPnU3Dzbn1y0WbfjLXZ0Js
 fbh1WHpBbwoxVOzFC9iSxenvrwbs+9Hg9KUdrMCckEaCVSrlREcQhksIlFHbRz6Pjk2cCU5A5hn
 AZlXG/KnHdD7mOxOtMnGNbx7mxtHN4JAH4ZRQhziJdB/zPMCtk7qbEx4yk2LxXZnHACQljB0W2r
 YPgtNU8YAsw3UpkvHgVH0alseOP3QuhnSZjMENM2x+uY1gpgPhrtJxJDYTx+ccuabGBV0rhAwoz
 DfxLqcJjspO6mVxpIMCy4b9kIwVqO6PFWtuPdg/FFn5YcAf41pLubnpVKaCKbzfWg6dOMCkPG2F
 n3JD3kof7PubEi4T7rQ==
X-Proofpoint-GUID: 3ecEcsvQoECdANhxFgJYF1SOZ36OFDjR
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a42828c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bA5z4lzVfraiEpfBxBMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3ecEcsvQoECdANhxFgJYF1SOZ36OFDjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290121

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> with register space, interrupts, IOMMU configuration and reserved
> memory. The node is kept disabled by default and enabled per-board
> with the appropriate PMIC supply connections and calibration variant
> selection.
> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> --->  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++

Split the SoC and board changes

Should most of the board-level changes go to evk.dtsi, since
they're almost identical across all boards? You can e.g. simply
override the supplies in the IQS EVK DTS

Konrad
