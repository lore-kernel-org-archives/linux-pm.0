Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2236B047
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515712; cv=none; b=mqaOQ6UZ6dKrT/iguaggVq6czQCxO24l/198gzAdcrnaZ2S40bCYGK6iFpuAOrF4pcIHLjTJumm/dnWjZXljl0krBk0+J+RIWpeRFf5nmUjozOKaEgkWK05KHdHKq0inQNbz0x8KHBa2BOqOIPNnY1atzx/xENieXjjaLpyprjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515712; c=relaxed/simple;
	bh=8BV78OzUJnjd8dgqkKXNuE5mAG2V/G6kGOC05Qcr1Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqsoFiTCyBF0ZfBfDOsHB4W4SPn7OKPP5UI5mliVYqKdp1MhWWGHNN3qREWj/ep1+uWd6wDusvPWqBSEiM5ddgYLDZQvg7gNa5Zi15S95pivF+zDS/F8F97XOJIUS63X5lRddFPepVX3OgoTGHC/V53MAehdzdi0wg8IL4FDwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erTIgXXz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D55W2imv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erTIgXXz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D55W2imv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q8OHOr3959349
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=; b=erTIgXXzaly5BC9y
	iUvSXFvd0hEhB1bD66c2CJbhVqLfIku9bGEzTdlpAWhuSkGSP7Bb7fdVK63c4/XC
	j3HGu3XZVdUATcIwh8rAdBn3yfc4VRS//mjUoEF7X2g71yoz4dCqkScXID/aE/8v
	P21na+psMCvAC/V85KS3ROjfPNz9n2jh09SOcm4ajvPJ7eCIBLCo5oFst/uecmsD
	0CGA0uRMPb7Pwkj91Eyfl+JCCqLX3+VAs3LyPynvRFfPxW+F/Fe7eUCGnlN8hPjV
	6rNHNH5I4xl8+mr+uqy8oMp+82RoHKs0sLoZl431ka2Zht897JNGk54+RTgr5cmn
	SwLlDg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tjahegv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:01:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a081737bbso3310526d6.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774515709; x=1775120509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=;
        b=D55W2imvO98ItVNdPPH91QCHhxRkuzqhU2QPsF0YTDaKRZAy3Q/6E5MRRkTSvD0+vZ
         pVViOyVl9T6YxJSCqxBYjha/enU8fA5e8Mhwwpn+qvBLlvRM41I1H/A0ph4nOmLJgVcl
         BiCg4tq6RkLjRf64mA+i1OGpqtQx3UfrcbkxZE21lPhYT1BruDwBE7svRT+lSXKgoUgm
         UBCYjHaxpugzeUwrNCL0reKr+iGG7CdrXs3jg1XjJkjw9mrWlV30jJ8vpDB+QBw2EwUV
         5El2Le/sYySXDgrm74RpWoX25BZV7UEDD1GaGw7L+JWmnLLkBmuTkxTgUIk2opJTSCAa
         I7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515709; x=1775120509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=;
        b=LPE/IsOattdWhWQqEXjSx/uYPvtL6BQADzwmZdizZtDBDR323vdCfa03OtFLVECPsF
         iXzvAmCY5emRZ2D39BXwMUorOogyFRcsMjw81Fpu9Sl/32fqtJTUSK+IQEhsfh7E3/6s
         8DYpwMNr87QoJ14VqH5n2kQgHCyXVxz2/dnSPCSok0doknBl2+tLVzWzBeCtxaGIV7RN
         nJ85dRAWd9sn6wn3oeOtlmHIIIDSNdN3vjeGEeLLkvNNG/tsmUsvvYF6rF1QkvfZ6fRj
         1aHFbG77SYfAWhZ7ZrogtE26H3Zv9rcELoGc+14PuFWUFHRDhVPNKRSU/6DQ1PEefg4e
         3JrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFxc8PEjG31ZIAaGuZr6B6ytFW9ksktxfTSBKxt21claXlJk1RJVweGRL9G17W9nawWCyXEZ8f6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyFUT5KO0wLHeqm11ewaZ/0r0dqxUiv6dfopqZ/examrWlNKe
	iP0QIokq8sTUgPWLHqsLEvinDkkCe8Z6oUfa6umQRdrmM6F4Hya366C9pbury7Pl83DX8+4emBJ
	UrRkTPf1INu66B631nvRVffCVblpHtYe4sEY98ZMl/9q+J5oPEE2nZHO0O3mDxg==
X-Gm-Gg: ATEYQzzDHB7d/tpmh6eMsHOrgyGC5aXrF5DCBaVKk1rXWKQKXAceI+xaKVlsbcEZuln
	PWuy6o8o7RbH/zIO1up6+i2v20fvw+c3zWMgVpZggWYwt/TeuVWrPoZoglmQ0vsBamdxpaYVHwE
	gkWMSzrZ1c6+alP5N74xrTzZVo4UUBGXQt09ky1QnLFYp7B1/eEV2n09/86u3teYfQg2OVRXkkF
	TyqJPyTizo82T9k3EegZk+ABDXSGAm/vCo5goZLQx4Dy9cPXw6qDGwWVm2Z2gH3c+LWUymN+aVd
	+LtV5Q8dLe74RayFrZCDNu0EYOVyj2lujquYwSzaptaVNcsyzg8AkC4ayX/uiT0GTNcj8XQdkGN
	Sm1AE9KYyEp2Wtou80aNzzSxSze8DeZi52LjQWuq21UcobrpnbaK21L25mvUXZCFRtXRd/vSwYJ
	CjR4M=
X-Received: by 2002:a05:6214:c67:b0:89a:6263:feae with SMTP id 6a1803df08f44-89cc496bdd8mr71021196d6.2.1774515709546;
        Thu, 26 Mar 2026 02:01:49 -0700 (PDT)
X-Received: by 2002:a05:6214:c67:b0:89a:6263:feae with SMTP id 6a1803df08f44-89cc496bdd8mr71020086d6.2.1774515708327;
        Thu, 26 Mar 2026 02:01:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203ef95csm87469966b.52.2026.03.26.02.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:01:47 -0700 (PDT)
Message-ID: <b43c3e0e-33e1-4ddd-8415-2c11f6ecf9c0@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-wireless@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com>
 <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
 <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BtWK51RIQqdYbDpjj9VzcH7QvOW-duoT
X-Authority-Analysis: v=2.4 cv=Nr3cssdJ c=1 sm=1 tr=0 ts=69c4f5fe cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Mao_WS8moKRl95PynMsA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BtWK51RIQqdYbDpjj9VzcH7QvOW-duoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NSBTYWx0ZWRfX2lpOpMGuBIMd
 T+wE1utr9JN9HpOKjBgJ3Q0wSQZPWiCn+PSUwKbBmy+U6hUAwipip28qFk2DrvRPw5UPufvDXKh
 du6Ofr9Y+9JzpB3wEnnHm6J+IMarmyJ6hhO5bg2ARtnxxb1QWar+rs75FGSJURkzFHly8i5cb+0
 yq82gTqbaFNhyf+qQEvQwyV2rmO0r7cma57CSpRJGAhAXxRhEKzIdkwSpfmdPv1W8/easHvd5Vf
 mPJ9E5YyTEmTzxE1hDsTlZ80KIC/GfGZCerxp2ng7SqgzmkmTlhS68dl5ZdwTHe6Khiuf432lnI
 2zet7F8qTXXddZTubguuUjuTTdPGk1L+DISalJPsYIrYE+/VOzywCH9z+M+7CbMa++S2fwdm8Aa
 1ekthX642762zFZRI4y9gYG2q5QoXXPrTfjbIIGHoFsMVNEVLDirLNjVL3IdJHP66BqIq9NdhBl
 NAlCZd6oMefJqhJMD9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260065

On 3/26/26 2:59 AM, Dmitry Baryshkov wrote:
> On Thu, 26 Mar 2026 at 02:02, David Heidelberg <david@ixit.cz> wrote:
>>
>> On 19/01/2026 18:08, Dmitry Baryshkov wrote:
>>
>> [...]
>>
>>> +     wcn3990-pmu {
>>> +             compatible = "qcom,wcn3990-pmu";
>>> +
>>> +             pinctrl-0 = <&sw_ctrl_default>;
>>> +             pinctrl-names = "default";
>>> +
>>> +             vddio-supply = <&vreg_s4a_1p8>;
>>> +             vddxo-supply = <&vreg_l7a_1p8>;
>>> +             vddrf-supply = <&vreg_l17a_1p3>;
>>> +             vddch0-supply = <&vreg_l25a_3p3>;
>>> +             vddch1-supply = <&vreg_l23a_3p3>;
>>> +
>>> +             swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
>>
>> Do you know if the GPIO is common for whole sdm845, or it's only recommended as
>> reference design, or nothing?
>>
>> I did test defaulting to GPIO 3 on Pixel 3 and WiFi works as before, but since
>> previous downstream kernel didn't touched GPIO 3 at all, I'm worried about
>> toggling unrelated GPIO.
> 
> It is an input-only GPIO, but nevertheless, if you are not sure, just skip it.

I think you should be able to observe its state and deduce based on that

On a sidenote, 99.5% of reference design choices seem to hold true on at
least 90% of devices

Konrad
