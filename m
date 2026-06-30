Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDD33343B
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826495; cv=none; b=ZT81uRLAYYWS7grWv30nN3C1HitbYk/ouAjpbuAseh+nwM8Nm+BWGTx2zOmVtrToGGpyqDOMnMrOA6VwhGWhO8ManypnUhYVGR8sWaiPm5NBLqKcZgbVbWBLJ6DsRfF/DVLQtwJQxU7uYhjpz6sNWMztrSeRhtM11VB+Q7mejkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826495; c=relaxed/simple;
	bh=lf5muHMerkgYyNulxHootfh/dLZ4mJu+DE9+2JmiVjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxqeaaxUjlX/ml2seiKNAEGl268kLXpGq0oAha7plj19whajBy6vqy0TrWBxJVti3By10YNCiuH5j3OQQxZzgI6Saw2e/YUCizCvhnDnBzu0rT+8mQlRGaDhPfpDernwTRnmeKonEou5na4Gh1VKKUpwdk9FIZtJaNpo58l18lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9vhIgom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AoOZaxoT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9vhIgom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AoOZaxoT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nNpZ1590876
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=; b=Z9vhIgomyWkOT0aG
	cGJYJniEsMVpjTvpRpZfeprYaz+liwJq5kOi2lP6ghNNzQ8KX9pURwoY9zQcOqKm
	xBhZgMuZV49nhbT4evKSYwT8gT7RxF45AYt5nH9sGQZstYyZlGddO5mPZI8x5ftq
	r9yp3LM5vDZWY3w+Gd+881d4sZrx1P8XJ1lhr63ePv594N3JxY8bDkVldyrylBBZ
	zynmNZxCl+RfdARry/1BRaYn54wvcXwV3cSfj61+XyqNx0qG99PmfCjnkeuY5i4O
	erSj6ng8nUICXOErRyLC09gd5FnQ0UD21T5bXFrGYWBP/wfSfSR062QuAoVsnZRG
	t9L7rw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k3sgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:34:52 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48e5de5a23cso5773364b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826492; x=1783431292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=;
        b=AoOZaxoTtbQZFhG08d4xdKuScTjqYv2cbh32mmWNClzntFRRXzDmHsmSFEssvnyi7v
         DCakboZ/D+xUiHhcZ6/uVdItA5+xT+jK7JWZX6BoLp0bi3xqX0bR9FIVkkd4Rd7vdTig
         T0cHZ2Z4dF3bhu9a/QhkbTTkXdlnwLy++2B3XQa6Fml09BkqJ+2ceWRvh2Kf0UUFEjhY
         fooaVE405SjxzKEZQ2Wur/EjkNriDPBIR3k0+l/jLMn6WQ7/mLHsaUu0SUI6/hwqFY99
         6/PfYyDqi9q9BpUCDbKYXa/KwdI7NTZnAtUcLqe8jv6lBuo///myBI/P0Jso/plUB9d6
         xT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826492; x=1783431292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=;
        b=LoOTNt8mKBv5B0wvHNzeP4Q+1VDwwTmIe0e95hYydS2pYZApRSHJ62LbMcG8dmymh0
         gFvBkP6KOgFvPITtUMje8neW4X3eL4A2zAXh5l9F1ju+qiex5oTw9k7wi6ogCclevnC6
         OW4O5zEf/+Ctq9bZQGlHFNoRd8R+tvYjxelyig2gUF1L4vN428fCK4lwMb/X2gby14xA
         4Fs5wXCDylD/X5P71+dJG+QZsmBbTEkenBE4dLhPG6B149SLJ1ftL9OV93sciEiZnvNa
         fty7lajABm1MKRMP9zOdSrsfpTo0Rf0UmzyIx7CnSRCu8x+44w5Ic1oCVdrFksXgiVYa
         iX8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7N4u5iulEEICajlE6GG3jcArsFLmTbVL7nM0Vz0TPGNwyWpVb8fmqmGTzsDDGsO0CSTLI+1cttg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX2e2+LM+uC2g0mUUxBbK1CBRGsj9Gm/0Ap5LMBhbZyXj2YKZ
	5SK4TwM/tONByT8dIjbysI9vrkxKrcOFIEE2UA0Y8iZcReCOgRRPkBJMXCUSMOxFNXRGRDrECLU
	hUSOjlyfAQh8zxyOlE4rhMeQIVU9PgkR/qJydmgpqE5mFkGcitWFXwfueH4Y74g==
X-Gm-Gg: AfdE7cms58ieYk7tf0Ca7z6s9niVE3AcBYkv17gUS81kLNeuTjbpJwF17xbmXMsmDJt
	cjDcGKorQBb/zgI8rc31l1wFryQRx230ZjbJ4xCYMJiv5LnMLX/klbVeBQfX/T2dbIWKkgcLwnq
	JYNpnBg66DUU503dhdrpNBHVv/Kxz+7n+5FE734ZJTvgvVXjHRiclk6Yp7zUXfwXeSzJdU5BBpl
	+jBMMQT6TbYls4rIryP5E8lPDDjdMcfTDTFgMiKvdwtg6Q2e0HJ7hZWCwFIalmE604WSZMZ5j9E
	sAwtFSQvbVoPlPmicR4d8yE42h9Y0EQZw5Oa1EWyc0yi4c2ul2WDc1hrVRnMCKs3Ht10y36Plur
	zjrCW882IKe0y5IFZ2zaIe9lDsSSfRKCf+PY1lF0=
X-Received: by 2002:a4a:d1f0:0:b0:6a1:7ade:766f with SMTP id 006d021491bc7-6a1892be9d6mr2176992eaf.68.1782826487341;
        Tue, 30 Jun 2026 06:34:47 -0700 (PDT)
X-Received: by 2002:a4a:d1f0:0:b0:6a1:7ade:766f with SMTP id 006d021491bc7-6a1892be9d6mr2176847eaf.68.1782826482116;
        Tue, 30 Jun 2026 06:34:42 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448dbb2302csm2293397fac.7.2026.06.30.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:34:41 -0700 (PDT)
Message-ID: <e11f57f2-bf15-4c06-ab3a-ab2843818a41@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 19:04:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
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
 <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNiBTYWx0ZWRfX7VPeVVBW/ly0
 7VyXsqJVUUdbbynauPrEbkNbsNy/uAl5srmnLOETsNXJVmzGgK3MP2kLG2eze3e0vDd5QSKAU1v
 w/aY7Y8pdci3Xb7fWWuwTVHzMLE3n+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNiBTYWx0ZWRfX/rpkfB21VxgC
 jkLcj4FMsgX9FIxRe8wABFRtHnJND/3ZjMHj2Xcv6RIG67Zcow7YeW3xt8YiucCcb2IgQk1uKwX
 60WpIM6akjmt4NF9ZvMaqzjiK23uXlHKn31A+s5pmitRN5tA+tY7L9Huv786HddXFMVKxj7F+uh
 2synsa1xsaNn4EWZt/MgoE7V7sW9IXFA42fJDl58bagmAowK4hsMLDWs4zM7QdZJpIEB8oDA8bi
 fro29LykQV5CPrAP5puEfND3KvSBAJqNHVg6vOkU60K2UAwCiEuaeB+du8Ph7hTqx9cRl+RL0Uf
 AuIhTBd4KeqBkFv1jGsjM2mTRqttTZeYtO6Kud0/MFrDKXg57K3+365BK68ZuWlm9EkRL5AJ5hq
 AVNPzoYLq6ORlUbtMZtjfNfBaqR3rvVzdDOmXZ6julQhA4Gc7SEQVoN+KSgn3CsSMgvuwxI2OMs
 FXFUppBBN7WjnZtMwIA==
X-Proofpoint-ORIG-GUID: uoUK_dDgqxCsIyvQF7Nf0Ay0FzWcEjCr
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a43c5fc cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=IW_wJ7xLveG3VXcQuYoA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: uoUK_dDgqxCsIyvQF7Nf0Ay0FzWcEjCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300126

On 6/29/2026 8:04 PM, Konrad Dybcio wrote:
> On 6/8/26 3:10 PM, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
>> with register space, interrupts, IOMMU configuration and reserved
>> memory. The node is kept disabled by default and enabled per-board
>> with the appropriate PMIC supply connections and calibration variant
>> selection.
>>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> --->  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
> Split the SoC and board changes

Sure, i will the changes.

>
> Should most of the board-level changes go to evk.dtsi, since
> they're almost identical across all boards? You can e.g. simply
> override the supplies in the IQS EVK DTS

For wcn3988-pmu node, I can move it to shikra-evk.dtsi and add the 
supplies in the board DTS files. However, this approach will be 
subjective to per node, as other nodes (such as sound) have 
board-specific changes beyond just supplies.

Thanks
Komal

>
> Konrad

