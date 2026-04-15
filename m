Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E531B100
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244565; cv=none; b=RosRg0EkcgK5RbNdSVLbFTLrlISzYV0wCOaeof+6BgeQJP9wuH6a3Q2sNoeQHBqUf6kkp+lKetgqWX/W9kQ4sYk/MLllRSVNiI0FyCcyMgvsFoFNCQTnVnRijxZ0qmUjFUDeQ32iPP0DS77h2zvtGIRHItrRoyA5xmHD5JHaoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244565; c=relaxed/simple;
	bh=QNkwwdGTplaN2ppgL9tu0dkoxibRzxPJ7lAH0JdJOuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/SgQZJIZvQ7fv7o6pPBtPp/lOrlIRKtHwqeiGALNsDskAhOxV4tTWPGdIFbexWyE5WkDjMfem8Q3mw8InBhSyA8tNBXcxxbvlLkSTn+FwAPAQCva1MWzPov3uoTnevfUghlYE9He7mDBYSDeDoaXth+1RGOrkNbzEolUy7D2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJHux/B+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wqqk0ISu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJHux/B+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wqqk0ISu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F8XsWa2005529
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 09:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OcJQkkRgQVV+PCbtYh9f5UrhsxuCpugR62QKiJTInmo=; b=fJHux/B+MSZxUAtW
	8XOr52d4EdbHyx9korRZQW743x+WL7K7jR1eaQLSl4fJYjzLuOfSfJ9vWxRKmR+r
	UIDyr/f0bpXRwhX1mvQKsqlUqKx/58Ntc8RZC7YBmHBoaHpcfYyMewm6UNGvoT3+
	AYoTAaD16fI1gUXqCPWW+qtDHko+Ddt9/ST9aBEn9J7P4bQKJCjjnBNtJwVL5nE5
	ciEhTFBY2JoJuyEUAZ/gQFonQXL5Ivmup2wQ7e2mNvnGXAv3oRmpJ7REdFucZtJT
	Vn5KAvJcIfNE38Ek/u9JML3KCOzPrWoeckhncb97onKf7ldW9wdoII8aHJln2H+N
	F+BfXw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrsju2d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 09:16:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cfe29579d5so142129685a.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776244562; x=1776849362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcJQkkRgQVV+PCbtYh9f5UrhsxuCpugR62QKiJTInmo=;
        b=Wqqk0ISuES9nK86LxcOAAl7P0Jv9+I56VUxtI3/eqDk3NK3pfIxLPKb5z5+FCPcWQk
         rKykZ/8mulA3aIBpD4poy+M5vn1a706rSKtaMqO6CilPWdotwU3N4TJqzuPnu2chMwZy
         70DSuAz7EK2vNykGpZYOlXV+29EmHzOCT0LcCR5ZHP7+K0KoyF6lrUMYnWRLfW5JgRKo
         Hwx0hwiMBvxfvFVcrEoANf6fAm1sD4XEXS/pcd1aZeWW0ieKsRpCMNxdOFgGhSyP5f4G
         v9yDOhS/LC6bbYAhqMTX2UxICszwDEOCGM5G3wAxK6uugbnHtl2PH+ySH1Brj/gESHkL
         MHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776244562; x=1776849362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcJQkkRgQVV+PCbtYh9f5UrhsxuCpugR62QKiJTInmo=;
        b=KG/PkWfLvBu4iCP/Ny1gpuMY97z8TlB/gZ1wFLpDmpCBGpJSkqJQgwoXv0XiGD5FbY
         fo63BBp++mWEF4JVFA0kfifWcWb+mROG5yb8B1etGohGPlIcVaep6PbKBkjBiBBZU/6a
         8sFs+mTIxu0vF33iq2y9hSaiGXPhrTDqFSOHEk6UGsA44+1ajWnjM4BIndatXKO3C9vO
         mGxNVMMgpAwGO4DC6RQNjheERXvsIXumMYCVgq+aTTwN451SwPSHrDY8PVLMDV7Y3qak
         S8cGiOwYXARvrmWNvjUMrt8j/1FV83cVIHQLcC5+4uN0vjMDmtPGDaYTnOhz3oWcAIlt
         wWXw==
X-Forwarded-Encrypted: i=1; AFNElJ/2LGzeUhy/bPXHp3Ad8gurvnpYKn5TzusrlHJ0sS2vjxHcv+nsZ6TG0qTTxJPWRhKCdO+Slbk83g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uZfHcH0GfIjBwWHsjXWFUjMmxOQEO+P9LofBGByBXTRdE5mV
	JwELrxOSr7kuYUnGx6DR6tfEARwk9cy1IwK1O5e0v1fqGXHiAz0ZYhDPocUsL2TpjfKBfYlagPQ
	l3Wfbe6SHuXk2zpoa2KPoDxcxQ6xjmBl0/2amaM13Ph8gjPRGT/RyG+cOosB8Nw==
X-Gm-Gg: AeBDiesUg2D26m91oBG4eQiZaODxSxuhK6dIzm/UmlhOLLgUJ9FvC+HTWcGauoF5Mwf
	lJOGNtQXH5dj1TV77ng6T0OMvftEg6LzA6dIGUlKE27kIXxuiJp+WKLqxnO+qOc6UCq+lldP9p6
	pGD3oOm+oOIa6BEKMQItIVYdL7ImQJntg4h8bn50JnqtVs+5GxMcpBqPjJQOuySZYpULL9QBNFZ
	ggXWrA0F4C0b3BkJ7aV2u/HtjSY1+DznadyrF2KVlVQlojp88erHa3Geg5L3E/kPkA1G2E0CkGE
	UclsCdK+Fx3lLTX63qg9rTqGxwyTXqtsBu+ZkLzDtAivYBuNbVz288kXZbupNX/Bu0TXONHR0VP
	EO8DgXfPHacaDKnP0ip841YmU8Z9bel84eJzDF9TOk+ItH6wT/T2yOesRNITRVCQFYrCGbvy21N
	xnNk33WDzk6qsgoA==
X-Received: by 2002:a05:6214:27ce:b0:89c:d639:e7be with SMTP id 6a1803df08f44-8ae6a92307dmr16676596d6.5.1776244562039;
        Wed, 15 Apr 2026 02:16:02 -0700 (PDT)
X-Received: by 2002:a05:6214:27ce:b0:89c:d639:e7be with SMTP id 6a1803df08f44-8ae6a92307dmr16676316d6.5.1776244561523;
        Wed, 15 Apr 2026 02:16:01 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341bdf6sm35888366b.1.2026.04.15.02.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:16:00 -0700 (PDT)
Message-ID: <4311c618-f084-44c5-86e2-7f97661d887b@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm660: add thermal monitor
To: Richard Acayan <mailingradian@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-4-mailingradian@gmail.com>
 <e72ede03-94cb-45c3-95e7-63dff0ca3888@oss.qualcomm.com>
 <aaXKyIJQA9SFqt41@rdacayan>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aaXKyIJQA9SFqt41@rdacayan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WKhPmHsR c=1 sm=1 tr=0 ts=69df5752 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=x7XoQ9lxPK0ULKPy1m0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: M1ippmSKdYiKdV_K4B9XYMOolOZpYs_N
X-Proofpoint-GUID: M1ippmSKdYiKdV_K4B9XYMOolOZpYs_N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4NCBTYWx0ZWRfXwdSfJFZs742u
 wiFBlLSEQgncTjKu6Tljrny2DNQGxKL6Q/AYzrxTiwzuV5VLhdAPzJHHzuiFt+AUZ5XPw4a93MG
 5SJb9wyK0YhliXuQthADYoydLhejLI0jNW7AdRJu/jP6wxT5gUiVkLEKmsNsaGWpRNxBTiJlqmJ
 YTwhoW24pop+Guh62x6FQ/t2H+x2slz3atYSHJ/fMV7ENOxrRy5+X4xbxP7wvnJyof9x8WJj/H4
 BTJWkIi4E8uyEcbmaaPFSQwoeeKPjk/JHtJBJCkEJNBp7YHn+ks2XjpwvO8TPGv5tRxNi5LBcld
 XXnHZepLoLxUCuSnrTuuPi/a/54GqINSCpcNDvBbh+ZGCu/+qSG4ZCnNvl4Y6LjKlR0t/OjUoRN
 peV4XNKNZoQpZNKf2Zkf074030e42VEPvcxLd1VUoLvTOcWFszptTY5pBV2OGuVHknZPNVdvbkg
 5TDv6i9o0nXdI0v4+1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150084

On 3/3/26 3:25 AM, Richard Acayan wrote:
> On Tue, Feb 10, 2026 at 10:59:20AM +0100, Konrad Dybcio wrote:
>> On 2/10/26 3:18 AM, Richard Acayan wrote:
>>> The thermal monitor is used to monitor arbitrary ADC-based thermal
>>> sensors. It is suitable for use in thermal zones. Add support for it in
>>> PM660.
>>>
>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/pm660.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
>>> index 156b2ddff0dc..7cedf6980b34 100644
>>> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
>>> @@ -197,6 +197,16 @@ channel@85 {
>>>  			};
>>>  		};
>>>  
>>> +		pm660_adc_tm: adc-tm@3400 {
>>> +			compatible = "qcom,spmi-adc-tm-hc";
>>> +			reg = <0x3400>;
>>> +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
>>> +			#thermal-sensor-cells = <1>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			status = "disabled";
>>
>> Can we enable it by default?
> 
> This is for the ADC thermal monitor, and not the ADC itself. I don't see
> the need to allocate channels just so this can be enabled by default,
> since the thermal monitor's purpose is mostly to send interrupts when
> the ADC values go above or below a certain threshold.

Sorry, this fell through the cracks

I see your argument, but at the same time, there are channels that are
always present (e.g. VPH_PWR) and any way to reduce the boilerplate is
welcome

Konrad
