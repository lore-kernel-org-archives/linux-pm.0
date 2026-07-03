Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB026A1AC
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073658; cv=none; b=izVYSsS0IKpaDQvl1Nh5wb/HLZBTBKjxE9kYjKgoH+A83u/DosBH0ckFOZ0Gy2brLKf+7u2YC8SejkS2LprdF8uSh0lvwXn1ttro4GfuFqpBODGwD7qnRu/xSR34VZFLWxDD2XfChXGu/IlpatTutKJSBlm0F6UtijNwZrmaaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073658; c=relaxed/simple;
	bh=OG4yzh9m5tXYU7JzloUdXPR26V6HBgZzOX6TH+TU2F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqloG+O8s04G5Qy4/fA26PqnAdGp5eVjXrgc+ind37PZLRVJeXEmhhU3fbMKd8o07zZJHZk/64jpBgIHiQ1rryuRkZzNp6qJgmJ+tszN8MY4iJF/I6dihimlDLIF44u/VXA2HvLh7lAi/jLrkz2xhnfzFE9T+yQDRWDBOD9ywbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/snRQ3s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1va09do; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/snRQ3s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1va09do"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rm533136311
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 10:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=; b=c/snRQ3sHra2mRRR
	bWBzcIEQ8j6mV72//Koy6uD2Ju1x5jrO1iAnaQrWhvcJ+3rbjIPMJJJnPJflFecM
	ZTEZpYiJsyX3VJoJZvVpWHdOhQT4bXAc7L34/hrL+mfME/fWMJZRrNvGVSnXcpPi
	leadoaz6z9KhD9wJLc5CDtXDj39GuFX74hTIEyH5jzmip9BWoZXAIZ4I8ZP+mh6D
	XK/vOpL15JCfXqpp47VwFsn5QlfUU5/ax5JFUTac7jm24pZp+cmTL3tiwnqnckct
	CysxPec5rjZWP+bVVV21kgUiljUX0W6mtLBAOAFB0xTEVg+OFRuz9E7LJPiqpJgi
	PlVT4A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59sp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 10:14:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8479586724eso351102b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783073656; x=1783678456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=;
        b=V1va09doKOyDgwZoqhIfZMYo9N1KOmnLazew4C0kEtD1IdqTISOwxYrPCIX5F3KiTv
         QH3dUhXdmvKu+FA3xPBokNxpKzMGJtyoQe1s6l5bA85uszfUnwPn3KsZk9cYS50U7/Fs
         KmicSVRbiLVzIIiOG5npJSr/By5D/napWyFzWLIoHAkb7BfPh9VUehG8q5hhUeEBUuBv
         6m1uq8l3iAIZ0WIVIZsx/GBfZE7d1H94v/E0EV0cIGXzauvX9cF+yIh6ABOVThPH6bQN
         /g44yRbS4BjYJGWK4DbBFyZnmEE6DO8MXSvWKMiAu5vQarUeWWj2gfEkU9diWVRPMmxy
         8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073656; x=1783678456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//3AgTE/yNQNqtCsn90+XdpffeOaj61Ucj8VYvhONes=;
        b=PHV7SS3X1j5AUj/c4yPtU+Oi+5Xb4jlrN05DrryAf36PQBGOFLiN6SeqTKfGLhXNj1
         680KpKjrIjjGG0wR5NDQWG6ScM2xf/7LtUbfg5cyuCKebroROASvU+QAdo3CqRMGhA6Y
         tETCVlIi/I29wXwGfC+FuWG90EvyHasCM/VT40kErukEXwBvy1TqINJDAEja0h3fhjqG
         2RtGp7/bYciY+Rt0LLl94ruNd3MtYEtjxlOageZUDBQNCLG83CSMXgylPt4sFdkw6bc9
         NBnQjxSudNwaRqWvRD15FerlSMdzlmArsrJdlzGLNwBPJrg8hxPnyoBSp8Y3hmnqTjlf
         K8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L0blYPqYdMwYBRKys9eHOUaOmTQwweIzb2YqdequeS32Mp+X+c8v1WH2AjDq4VxImWZhgNNN4Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdBcDczjDiqSGEOseLh8f2GvYvfuOOYiN2f6cAJDrzJq11f7Q
	fb3Pd5htbRwLs2exv7d4XxoCzfjGEXvBEGM5jgubw2pHWlLABbDU27vzTlu/NZ6OL4UhFFF7Ya4
	Y+utSsjZ44/EGMqv8Onac1288YVM9l8xxt8BUQQD0JbUTzP4tmGeFq4NTLz0z5Q==
X-Gm-Gg: AfdE7clYA10OygRkhrX7V4p0PX+bG8iaa2ldVjmDIxL2Yf3FI6kvw6kOFKUCQ2r3JLM
	e7kxmdi2zH0W6z9JJFOwMH4KCP/KmQOjdxjkfZHkNiwtDI1yOJdtTHg0VbWmdaCiofrRfW3DcEl
	Tz6oeMaB9qXAbXe/UFB+URgWDw9patm34KinHpeBNAjc9lMb6b8ixRfS5r0p8keAfrVFhUZ9ZZO
	H2KP14nDalG4xpfW5Fy0+veMjskAf0TgWPn7KQxEbKHosmQyMgbiSIJpD7f9YYB9LJAUFMu/vBq
	hgnihq+odVMldxSInORYhLtVegu2aw5tnLIIjNg69tUG6yETTP08XD4Ix//92cYHz38y2k87613
	K+MopCaUsKghHZiGBSaIoWdDOEL2YfhSH5bLRNDJFhg==
X-Received: by 2002:a05:6a00:b53:b0:847:759e:f61c with SMTP id d2e1a72fcca58-847c519357emr9585739b3a.47.1783073656226;
        Fri, 03 Jul 2026 03:14:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:b53:b0:847:759e:f61c with SMTP id d2e1a72fcca58-847c519357emr9585712b3a.47.1783073655667;
        Fri, 03 Jul 2026 03:14:15 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6e42a3sm2824907b3a.12.2026.07.03.03.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:14:15 -0700 (PDT)
Message-ID: <54885628-ad41-49a8-8b39-33035753ac5b@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:44:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
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
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <20260703-humorous-blue-agama-4b668a@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-humorous-blue-agama-4b668a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX9c2bvb55hTUO
 e6LOMFQaHNR7lbGTZ8m+ddiuQzhlg0dQ8b6TRQV2HoZOA5RihJrxB+DI7cZGzfqND4KOT5BrhnN
 xDE0/PdPI3+uX2/SYVQXCMyvh8Ynr4o=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a478b78 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=FDCMAMj9kxRoxUuqswEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: U8PzxkbGT39blS7RRCm8uri__dLePl-T
X-Proofpoint-GUID: U8PzxkbGT39blS7RRCm8uri__dLePl-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX5TLmuX2tMhhM
 hOPgsLigdoPGmSbAEaMDqQeUC1jVIOZdX0criDQ7mczalKHWmQM0c1hbufxSoU9uXtSStNQCsf0
 ZuGaWhA26ubniuq2+FW9Up3RxM+H1hwDo+KHSCezjFcrydau+ca2G9c2GhvuyzC2DyFywvzooLD
 VeYTfcwKTGm2zuO7ltgbZJjurtiTNXAo1yo2rgXhgMfNTNM092e775JBXCxI9OZh41yVKrhpecc
 CHwC77Lrueq1WWRr7T51s4JMnJl7do1T13XlsWCf7xNDukP3p0byUrENKnmfvi2nIUJxNGGfaKl
 05X6tqShzPS76DSjQTVw+Qe2yqikSfIBKADPAhcT2aPU1PMO+jsrywlElT/qbtogxgCP543D171
 3THXdYXB/B4+U9x6SoD9+SaWHBZQSfxl9gqRYwnO3+dKY0lOvshcXixuN91mtlLW9LbnDYdru9o
 5mLJwKgk8XFm3aRY34A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030098



On 7/3/2026 1:17 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:04AM +0530, Gaurav Kohli wrote:
>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>
>> Qualcomm remote processors expose thermal mitigation endpoints
>> through QMI. These endpoints can be registered with the thermal
>> framework via the `#cooling-cells` property on the remoteproc node.
>>
>> The QMI TMD protocol identifies devices using string names (for example,
>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>> `#cooling-cells = <3>` requires numeric device id in the form:
>>
>>    <&phandle device_id min_state max_state>
>>
>> Define common TMD device index constants shared across currently
>> supported platforms. If a future target requires a different mapping,
>> additional target-specific constants can be introduced while preserving
>> existing DT ABI.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                                 |  1 +
>>   include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
> 
> As explained many times: Header file is not a separate commit. You need
> binding using this.

thanks for review, will club this with binding patch.

> 
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57656ec0e9d5..ffd85fd1dd80 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
>>   F:	drivers/soc/qcom/
>>   F:	drivers/watchdog/gunyah_wdt.c
>>   F:	include/dt-bindings/arm/qcom,ids.h
>> +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
>>   F:	include/dt-bindings/firmware/qcom,scm.h
>>   F:	include/dt-bindings/soc/qcom*
>>   F:	include/linux/firmware/qcom
>> diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>> new file mode 100644
>> index 000000000000..73efecef0f3c
>> --- /dev/null
>> +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
>> + *
>> + * These indices are used in device tree cooling-maps to reference
>> + * specific TMD devices provided by remote processors via QMI.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>> +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
>> +
>> +/* CDSP thermal mitigation device id */
>> +#define QCOM_CDSP_TMD_CDSP_SW	0
> 
> QCOM_TMD_CDSP
> 
>> +
>> +/* Modem thermal mitigation device id */
>> +#define QCOM_MODEM_TMD_PA	0
> 
> QCOM_TMD_MODEM_PA
> 
>> +#define QCOM_MODEM_TMD_MODEM	1
> 
> QCOM_TMD_MODEM

Ack, will update like this QMI_TMD_<name>.

> 
> Best regards,
> Krzysztof
> 

