Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586F3CF963
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781348719; cv=none; b=grkuEQOIw+rBLGr+at55O1iLmVZ563NLWRmIRmOWRNcp/X8btmccKxAlH1qH6peWjhTHTnYNZnpfKFzrUiq81FFVh3TRfFugxVXnKtX8wvQklttf3ZpCOp21W3H2+xJfb1zz/UwMaJB8/+w5gEVQPHAfcydsIM7zOEB877L9bI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781348719; c=relaxed/simple;
	bh=hFuLzAKLku9zjjLmyY1LU1Y3IkgnibQ8as7e14dCSpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qou0gE36crFXw/6Y9YRiW/g08pXhuVV1jD7a0XJpwqBJAfKBzXVSOo497O0NA7oLe2Q/rRg0LyZX1cx8hIgg0AnUP0jMtpy3kxgvj36BDyS2O+1fZI4kLKYEvPcT58JTHu0whwRVSTpUEX0GZePcoX0sBv/AQQgiO+XjMM0tt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+0kXTNF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LLsHKpje; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+0kXTNF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LLsHKpje"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DAwmiU2609990
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fRqve/iiEi4xLe1x8p2XFeA1tSQCSNKv74uJA29YfFI=; b=d+0kXTNFVgiLRzE+
	p0EZbjEhCmptGdcfghbY0edkgREO5wWW4mkF+qxGEEFgU05qKexaKw+J2YIbE/Jj
	7WzQbN6Fl4jlgjttjwrsuVCovdW7fEYk5XTcowxWAuAtSHUw8NFGXIDqPDfJQ66F
	2QE0nmM3wkyJT9cqAXdbTPZEUTfEO49cCGMcKi9al0+vOgSS2bgoy2oFJ/CR6q6w
	qxpzdDsyUycixWla2S74qN20ZjTgFZD/llKZt5sePyJ5HRchOo3o8ssmt/QyHTL6
	I1xlM+gd769eNTsx3dy4sFT++VPAu+0DXps7Mm2DQOoNp9FTYWCsJdHWkjppGp2A
	dxTZqQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery950uej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 11:05:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85d9f0ace9so1922861a12.1
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781348715; x=1781953515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRqve/iiEi4xLe1x8p2XFeA1tSQCSNKv74uJA29YfFI=;
        b=LLsHKpjeQu6OhkG9dnxXSyAD8c83lLCc86oTgHfeKlb1IHK+GZbrYS1UXCGHi78zXq
         YSq17K3K4eyHQ5EiitCjDmnLeKTuCL94TQTPoBEkgLETw1EAXH9guSJto0TEGW5bAEkN
         +I7VehrIeteLr06M2hzYN4n7wolE8VxfQFI4iiOdOoiPMu/r/ie1Wsnqc7vycY8i+aGi
         2Toqn2IA9mQyX+Yy53dJQyZp2riQAuOsjMR7d9swt4io+Dux5thvFxQAeABoEtH/8Hp3
         BFi6jWg1cDxQlJbjhRBBWIKc021pFuYitnCdB6GFrySwuScJwLFCPqGxbs1nGZcOi8FR
         TKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781348715; x=1781953515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRqve/iiEi4xLe1x8p2XFeA1tSQCSNKv74uJA29YfFI=;
        b=SkqzWHJxYwqv/PYsP9qANrHf4PNduLbgPu8ZNGROf4s88Ie7LUYh2rlvqaJno0Jx0V
         1F1gOZ5JX8vPD4H8KVr4QlCvibr98mb9HEIuqXkV6TV962F+0EMhVChTR7oIQuzQ0S+N
         3e2fCCJ63wRDIkGq0zHchxjW9ir1JiclbWDdZWkyJP1B4K0zd9GVDLC9vKtKKBxbceIS
         pbeJsNFb4CbyMICDCBsWGBhWSFPLLhOeYuDlEk7tDvA44rl3RdvmBWogcygglhp66MIP
         OZx03D2sOa5oKbYaRNGUDH+hmwSQvmocuUDttBR3Kz6awTeV9o4LkszYnabuuHcHVfNH
         xJcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9OriP4aLtI2b4mZO+ESEelIRiw63E9j28lfijtho5fmLa0WHWiynBsMifk9A4otPlH2f+hALmCAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuV65F4vQbzlsUL9UoYCrhapDobg9K+07bTZHBSjgOL1mTd7eq
	ApAHVJWPCvkFoJbutPMYfxHUcS+Dnjf1GPifzOVazcaJhg6RxEWaJ5a3iqcRJE1R8sefJcwSNPM
	CbKUKqgVPelRzqe+udZcwbvXXzNJPzUuczPUhGJlGEuTl6q8QzI86DSIXbiVT0Q==
X-Gm-Gg: Acq92OE/xIN9XrK/kTKp/A4+7KnTM1iAzSzk08OWuXv686uORcba81BUdUWqlASGlIQ
	JYjAX98QGYbU8ygJTzPGkEu2yWZCOYriiFsnD3p+Cxm2EzhQ7btzm6rhYhxfzQDxFUOHbiDlxMC
	9rIc0SUYuaNT1yTdDJnIo6zpelSgPT7G1avHp55VFIWG1xkSfrP9g73sk9nR6uePsd21kgYZNt+
	DKRZwH1kx21j+nV3WLbLC9c7EQcbg0B4lE3JTpQdBrMLVxMuV5CYUJs4WbbRKhbtMVboRGbeeGy
	WzHKf3GND8A1TzQAwmt32Ts02/keh01qGGZdhu7nsjouAozlUoCuU5+TMD065U27tWUVlaNBtXt
	vszw/IEYSvGRGbBI3w9AKZr1uMgr1RgqFOfQ6pZDbBopw1SCQkp34
X-Received: by 2002:a05:6a21:7a8c:b0:3b3:1a06:e5 with SMTP id adf61e73a8af0-3b78416b85amr8312222637.33.1781348715526;
        Sat, 13 Jun 2026 04:05:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a8c:b0:3b3:1a06:e5 with SMTP id adf61e73a8af0-3b78416b85amr8312188637.33.1781348715107;
        Sat, 13 Jun 2026 04:05:15 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm5037247b3a.12.2026.06.13.04.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 04:05:14 -0700 (PDT)
Message-ID: <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 16:35:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mB-vaD5QZxBRgVNLfvzuoBdvLuzkt3wA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDExMiBTYWx0ZWRfX3Kdqz5RR+BhN
 eH0ELOMMeMQDJXVIUFMQHbIjWPLhIaN+GoCAO6xMo1yRJrfRPw7aSZFqvPYa/IKspPV0lu9qBrv
 p8L+dq0Q4+4v9RCanBwf804E+sekxLE=
X-Proofpoint-GUID: mB-vaD5QZxBRgVNLfvzuoBdvLuzkt3wA
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2d396c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=UvbFL3pLTf4PkRdXo8wA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDExMiBTYWx0ZWRfXx9CFxKwiIThG
 yspMzswVhMbTrYf3im/6XUvyfmOzyLKPwmqu+tTZRZAdTH0aNmTtNWM+R6sk4vEr8LdZmVrB4Tt
 7s1dHrVee+TtDxYGQTn1v78AtkEP7bCHvtN45y4Hr9kaEPFbCIhAy8eiQkfiYxveJ0AT324Ibeo
 18Dnhp3umTbmxRnFRFDiW1BUr+bEQbiRTTdKERvqtFKHtegC0M7ziipd6pOLRyi7Fm6XIqVXsfO
 uyX/gjoOpNlSDwdJavhwm+bSh20zZ2NpZcb3q7ZIilCD6GUUnBs11DNPej8WxQpWTAOWKuVmQtV
 Acp9KEa/Wdp/XUjyHPYoi2lwCosbj1nbRJv6jEL5t259d1dZx62gvl02ljc+G1xiMX4wmveFEjY
 Mo053EQ3lQgad6CHx4aguePUORkRuKI+9lQ0XHKVmWnQ9xzdEYdYusDkzVZLU+WKo6OQgHfqcGH
 06aJl77aUUOT42yvPeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130112



On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>
>>
>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>> Why? And where is this generic property defined? You cannot just
>>>>> sprinkle generic properties in random bindings.
>>>>>
>>>>
>>>> Ack, will add why part.
>>>> These names are matched with the thermal mitigation device identifiers
>>>> populated by remote firmware over QMI and define mitigation devices are
>>>> exposed as cooling devices.
>>>
>>> No, -names correspond to values passed via DT, not some remote firmware.
>>> The remote firmware should give you interface which is explicit and does
>>> not need such properties.
>>
>> thanks Krzysztof for review, We need tmd-names because of following reasons:
>>
>> Following Daniel's series [1], the thermal framework supports
>> mapping multiple cooling devices per remoteproc/device via indexed
>> cooling-cells.
>>
>> 1) The thermal framework's cooling-maps reference
>> cooling devices by index (for #cooling-cells = <3>). Without tmd-names,
>> there's no way to know which index corresponds to which TMD, as firmware
>> may return tmd-names in any order.
>>
>> below are the changes post new thermal mapping changes:
>> DT: tmd-names = "cdsp_sw", "xyz";
>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
> 
> names property are not to instruct drivers to register or not to
> register something.
> 
> I don't understand the problem and explanation in the binding is
> basically non-existing.
> 
> Remember that all lists and indices ARE FIXED, so driver knows exactly
> which index means what.
> 

thanks for review, shall i use driver data, which is basically pas data 
structure like below:

static const struct qcom_pas_data {
     .crash_reason_smem = 601,
     .firmware_name = "cdsp.mdt",
     .tmd_names = (const char *[]){"xyz", NULL},
     .num_tmds = 1,

Is something like above acceptable? and this will also help to filter 
tmd names as well?

> 
>>
>> This allows cooling-maps like below:
>> cooling-device = <&remoteproc 0 ...>  // "cdsp_sw"
>> cooling-device = <&remoteproc 1 ...>  // "xyz"
>>
>> 2) Not all firmware-provided TMDs should be
>> exposed as cooling devices. The tmd-names property acts as a filter,
>> allowing board-specific DT to select only the relevant TMDs for that
>> platform.
> 
> And driver filters, no need for DT property.
> 
> 
> Best regards,
> Krzysztof

