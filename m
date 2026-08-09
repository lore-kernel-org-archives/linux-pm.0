Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CA379C5F
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278829; cv=none; b=mEN2tHhFHtSHwbtCV3JxtVJfpUAnX+qsdlKSi6u6/yzjLnXF+S3MbzTz06hY4uBkZC0xLgBjzUiQ2KdFCj0du+21aqCVBFHhb42CBE/gwV/zidEHfMWuGB+UXLVXGhykRiO9CA5ehUlqoPpou1LweIbW1ZybFjSObKwbb3jjgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278829; c=relaxed/simple;
	bh=510uDvyd32sgzhlGwCfHMT1JRWWiRprn1MywQxgm3J8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N0e2TSPH4Rd31PHWICOg77npAwrjoMYcW7QJEiWK2xZuW49ag4a/eFgu9TxSRp9MOlRRda+tliMM4PgNSmHzJyDQaDTKEXAO5bE3rGb/PfQEbtljji+P+XihSamkJbfIp8CxlyyEBM1Po78/GQL3gy6mlo2em9xJHBrX3wH/1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVQ8uHC3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NthjEQMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVQ8uHC3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NthjEQMD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C2HYB3229701
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IrQTEGA1d6JWldRyNS6hURK+2Oil921Orn6sio9wxXY=; b=OVQ8uHC3XxA7Q8nv
	XVGk46q9ZuwlwnDZTmfQ/bk6+36LWyl2TFmbWnuqA11kgxHJKEs7HQKz6EK1e4e6
	Vcr6jLRu7sgzUCREkzclgY7Vkjgi4lFYMIFzO0vv9RnnsrKdXcrGbCKVpZr1SrPA
	yjvrY5+Z5banNVDsyFhd5HDqRYhuEmfa+D+0q1mcB6ToeRsKFp1zRLd8FZyP7JQL
	ha3qZnt+aKs/mOlJ1RW8OKoVIeNHI5m7C71C9ZJbGdTzYSdszyA+qAJkMh6SaAc8
	iHOjt5H0HBn3Ievggl5+cODUR56kKkMfT8QdZFQiyCs/OVuWmgUQgfAsX85Egr8W
	uFDbPw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwudqjxdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:33:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so2942407a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278826; x=1786883626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrQTEGA1d6JWldRyNS6hURK+2Oil921Orn6sio9wxXY=;
        b=NthjEQMDOKPlMK9gv4ep8oAZ2y4ZUpBCVNWIPzYL8DFZF9JA+EYEP7VdsePsOCPTbg
         gdtCguCplDK3D5dGtdAeETPJAkk4UtqoCGMM0hPgykFggzWSiNa7wH30zpA4b7EA1OfV
         AD/oI89r33jHM3QaQCUaCR9Yzm6uzTRYSDybjyOr4keMlfPJ+CH/o5HsPIM2eZgTCZZg
         2a8sXM4c45jjDV0iRkICAN5bUTGgXr1Xqj8Ue7jzB7QNmLc9GBi/HqLfrS86BCi/9Z5V
         2Gt6gYuF45kFMKA4MhikEdKas5J6f9bZwOJnC/1ngvolhLVZL41sob7Y1USTeVG1lDox
         ETIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278826; x=1786883626;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrQTEGA1d6JWldRyNS6hURK+2Oil921Orn6sio9wxXY=;
        b=CCHHUgpMdxWML16QDzvTRojZvsdtkOqWvxpsTSqt6HwZs/moXmrAanzpYdAlHpSNbz
         gMeb+rDRJu9VkfIsmLxz+O1vnoLywdLnzgiR9VV0SVf1qCIp8gjmvfz8g0eMVzAMWcSi
         umii7alzAOCKuKFb7zboaUDEMkDAWK9XMNDUaGYjOlSbP8YXHsT8sE/e18AWFU31WEX+
         9/XL3FegIscDfQB7FIqevZ4+yNEfqD9DbLZcNJv59ocTu/jmsqLFXkXgtoT2fd3VcceH
         bncyQK/taIkpOYcdijPCoa2QEcjzAeZuD0+2n44XbbSYJpy84oUTy+UEOmWHYpzQ7sKj
         cbTw==
X-Forwarded-Encrypted: i=1; AHgh+RpKYT8iTBuAfDfrUGbMH0EXbf/UfqsEJllCd4wMpOfXJqjRugpf3NQA8Kmr0qeFsuCJSoyxcjLYPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzihD4vITN/z6IzHN//Ed3C+1gUUBcE1KsPk+OQHzb9nMruBryg
	uoszLBKpqouPSF060IMSrHTobAFq0gdGfpx4xfW9xm6Viq1b/tVQUL5lrN/LEyt8jPAj63eBe1E
	eTZ5B42Y8JRIumpMdlBgzLR71RI0CbFR3ukQZkFfqssWel4xxp2Blv/HbvqSFkw==
X-Gm-Gg: AR+sD13OhriXJ63uRaUYATycm2/S/N4KZLw0w5O5mr4rmmxI+HTKPH0ojR/MaIkc5CO
	KX8QkThvt8MPYimc1sWxB33aUHYaekl8uzF1sXq8T7vUD/bTHbbFbBF/QiCj4uvKVwpZiIEaGPv
	H3rxg2nB70n3atJcaqP7OcBfqxRe0gVNCq3c7sv5sV6/M3C31abHgLWBpKLHjMQmQ4HW75sr3ZK
	b77hPZDDcHEI+/3KoCsPUz7pBOnDmg1qPHRkBokNrrgwQAPyb44qxpBzB4hnSrv0DkpJg6GylF5
	ll3LPL4mqDlXlb3vI8Pv39YKvD9L7Hd1Q6l6ZKscupZhUamIBGrvHxv2ZkiSAf6XRiDCzFdtQJj
	sZd+st7MxcVWWdKnU4FG/+AQQy5u4xbU=
X-Received: by 2002:a05:6a20:d38f:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3cbc03b5526mr19993952637.23.1786278825824;
        Sun, 09 Aug 2026 05:33:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:d38f:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3cbc03b5526mr19993897637.23.1786278825370;
        Sun, 09 Aug 2026 05:33:45 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec128a0sm34798229eec.25.2026.08.09.05.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 05:33:44 -0700 (PDT)
Message-ID: <e8694124-ee41-4695-aa87-a4ff4ee602b5@oss.qualcomm.com>
Date: Sun, 9 Aug 2026 18:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
 <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
 <amyFARId5K-Izco1@linaro.org>
 <34998a81-864e-42fa-904f-2e5f3490fcf3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <34998a81-864e-42fa-904f-2e5f3490fcf3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMSBTYWx0ZWRfX4tmJ6lCy8e9d
 ImJ2oE5aWzbBK1bFvLOKe5wiBYvsn8CrY9wiUq4gBIRU1dO3CzIXaqEGwiq8kg2PaBh1gfblM7B
 FTajt8h+7dzvj0WVnfncNBcWdlIxeec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMSBTYWx0ZWRfX+8kK87ng3sEX
 xTkGqoxCb+DkHytMbroR+6O2uHO3xfcTrJUipFpZuDeflg1BfdL5ihGlch3JZHgjMc6K1HvkWsG
 cYGN8SeaHenLmuy4ccd/j9TBEtJ5UJX7TXAEIo23B9t0wnfMinYwc1UXO7IrLHyXVJ0UIWfBpxD
 mCjBf7ABFMTvt5L1s/aP9tyj45ggjUPIZtVitUkL0tBi7YFODf1P5PvSgHgHw/+W2Xz44a7uw+7
 MPRYxvIgo8btO4rcsyc/4u8+SVkUO4AC0BKrum8WhbXQ2Cj0sGHRQck6DU37Y22Zg8MPnr1fT1Y
 BMj8KKvqLbyAVgpDU4/+vawM5nyMsHCHGu/nMpja3n4RuM87xomR8OBXtMPjXbovodwFuXobqfZ
 d5CHceUUCqbbUjaOMq98eAG/PbtXMG2W4cQgyX38rxpv/TR51DYfxxSGlXcavwB24Zu9Wcs/xmd
 F4neOUrKdO5Qh/j9HCw==
X-Authority-Analysis: v=2.4 cv=BNCDalQG c=1 sm=1 tr=0 ts=6a7873aa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=y4XuuB6ikNK3uoXrSYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: orsitJgk9xtOFak0re6eD-3IbMyBo5HM
X-Proofpoint-GUID: orsitJgk9xtOFak0re6eD-3IbMyBo5HM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090111



On 7/31/2026 6:52 PM, Gaurav Kohli wrote:
> 
> 
> On 7/31/2026 4:50 PM, Stephan Gerhold wrote:
>> On Fri, Jul 31, 2026 at 04:03:49PM +0530, Gaurav Kohli wrote:
>>> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>>>
>>> Unlike the CPU, the CDSP does not throttle its speed automatically
>>> when it reaches high temperatures in hamoa.
>>>
>>> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
>>>
>>> Add polling-delay-passive so the governor periodically evaluates
>>> the zone during passive cooling and steps up cooling levels when
>>> temperature stabilizes below the next trip.
>>>
>>
>> Would be good to mention why you are treating hamoa-iot-evk differently.
> 
> thanks for review, will add the reasoning.
> 
>>
>>> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>>>   arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 +++++++++++++++++++ 
>>> +++++++++++
>>>   2 files changed, 95 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/ 
>>> boot/dts/qcom/hamoa-iot-evk.dts
>>> index 9fa86bb6438e..a146be1cb5fb 100644
>>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>> @@ -1684,4 +1684,36 @@ trip-point0 {
>>>               };
>>>           };
>>>       };
>>> +
>>> +    nsp0-thermal {
>>> +        trips {
>>> +            trip-point1 {
>>> +                temperature = <105000>;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +    nsp1-thermal {
>>> +        trips {
>>> +            trip-point1 {
>>> +                temperature = <105000>;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +    nsp2-thermal {
>>> +        trips {
>>> +            trip-point1 {
>>> +                temperature = <105000>;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +    nsp3-thermal {
>>> +        trips {
>>> +            trip-point1 {
>>> +                temperature = <105000>;
>>> +            };
>>> +        };
>>> +    };
>>>   };
>>
>> Please avoid overriding node values like this... One quick rename of one
>> of the involved nodes and this will be silently broken without compile
>> error. Nowadays dtbs_check will *probably* catch these, but if you
>> override values using the label reference you would notice it
>> immediately when compiling.
>>
>> All those nodes already have a label you can use:
>>
>> &nsp0_alert0 {
>>     temperature = <105000>;
>> };
>>
>> &nsp1_alert0 {
>>     temperature = <105000>;
>> };
>>
>> If the same pattern is already used for other thermal overrides in

thanks for pointing other nodes also.
For gpu node, will send separate patch over current series.

>> hamoa-iot-evk.dts, it would be good to prepend a patch to fix those too.
> 
> thanks for review, will update this.
> 
>>
>> Thanks,
>> Stephan
> 

