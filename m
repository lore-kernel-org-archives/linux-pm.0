Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769D3E4C6C
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582932; cv=none; b=Sk0ETUzYYjrpY1+VBnp3G99Ws16XSrkOmZVyu7tZC/8uV8Rj6DKAS6JaioCG9AnxQ6uvkhQpaCz3zqnX9xjz3Gs4sPjpoNorUW+78HJ+E5JNBpHoHD2Z7uxtRT8yICBpGbcB7x2bcI3S/yqNUqP9Kg1GrGTMU9LCn2XtfdGDMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582932; c=relaxed/simple;
	bh=bPecE3m2OmnvvsAJ5paIV4IX5QUb0uPCLNDhDlmDFJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toczc3wQqe5Km+9aWux7rAiJc/9LjPv6gLGjQBcTWgjy6dv7z3jdZc+dQojyCAHS1pUhvnIGg/G48k3Z4OZvFK+KHXu+2zO4ww7k9saP0ufyB/R5L1Fj4D52zOb8qdvUAd7p42yzeou8htzwQtRRKPwJJWWruozMrGnjQ4Ddie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZB+EWCLb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ew3c2/u5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZB+EWCLb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ew3c2/u5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960ZsF837398
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=; b=ZB+EWCLbVRB6LAVY
	FlMili/eUg16k7aTqUKZRX+ZMpA2U7vuegYR5qNnZW1RwHoEcP0+uKC0mP9Ub0Z4
	JjIJiYLu/dLPBSdlAabzq/UUwSZ7Ti+dguYtNhoyBOVIRnjrY8liV/5w9smn96/X
	nwMvx6RrDF2KbPojgd7h+GLG3TP8G6P6nUrn0wC3PxRH6PgsOEfksA7tJ0G3qppN
	3cUawxbH8Be088noUzN8PduC6dAhZN9szo18STmSgbqrMI6AkpIXCYYDjQT1C21K
	zONAgxjidpJ0xHDxaoOOcroG72xYNNi8Oz7ilJM3/jWVq0T/gxLSneiwT1RGZU5g
	hIkDSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwayxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:42:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c33f48ee4so19136211cf.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582928; x=1784187728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=;
        b=Ew3c2/u5/rIcCDlu2Ao+lMelsIJBb/bph9WEBSD0JbULnfTJx3IVT+CnClr5MLxNbL
         x23jP+ilN8NTw8t2NeDbzbcn+V01iyGXlVMdSoJ5wfgw9a20RXrR6SdpT17ASntEzo9w
         pt1Y9sKBthnHWAQLbAma9kIGU8FZcseb0Duz9zKcZWaJpB894PxwT3TSLBqeUR9ptRFd
         gSDYoy/rLZAVJLe5SA4vbfQhj4vShT4jCxTPdEmk+3JPP0on9SRsuqEXebIquaZxSyBv
         1HaExdiJomY+SvdQQqGIS4kNAxs5LoFKvxWD+cH56DlILyEzE0dJyufvZAHk3GgWm2K8
         DsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582928; x=1784187728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddJ7mGajey7LP3OK141F/vuXmTY3mQQg+XD/eLWAZHQ=;
        b=p6LXyVLp1o9yYOxx6zvCyQ6RrNiva3vhAy0fuTieVTZp1ReU/lN9r1Ru/zodE/x9UX
         h9Z0K1Wdb2sT6tAfUB4FPgtK5fXSvDSmdCXgbMs98kjUGdSbEW7WN7Qs2YZVKNUAUM0D
         6GVoYCPOBtFPZFEqbEmUxgmMa4Lo8oLgu6j91A3aaiiM7FrefkRfbnQaiT+SO1AUP/06
         KB5LIcOWO7xt6Fl7/uxL7RjRbgVf4V1+0WBHOOKKvTYqgNdRm9l7D0vpFQ7uqsAgw8yj
         Jus9bhCt3sD73LVJ6gaLlAwLuvqPTacB6S3XOU/FLC3o0wMD66WA0MuU20K9GwAfvW4C
         OVPA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4YCvet1c/RhNrVIvu7OGh2k31JALdcbLTB+LYjVU9YG3FmC8M6IELTQ6+w2T4kF9rqg36SCmr8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUdBB7fL9+FQAZlxwLjBrwuAMHGRXMs0lk4bPuFVCSv3+m+GY
	1EJ+Oxm3XOBjxcvjjVxIPvf/LLQftsLUzAbPe0g2MeD9eUnOT1+kV/J0tIhKkxU+qGY2q8rsS14
	SD/53I0w9n0fkRoA2HWxz3npxzMyOqcXR4xTML7WjHQ9NTVU76AR9FAcXsjGquw==
X-Gm-Gg: AfdE7cld6Hr8AocOIQVXY2Y18spnQGbpVIQ/2q/vAckwraLXkmGB3nNtu1wynHEmJMH
	zCt78BIh5OOcl92DBH6Sd4lAS/lPmjfs8H3+2Z1srgnfWgceHiz55G3A+lYr1OCPEqiYEaniSfJ
	44I/d5WZeTW9C7WUcJeQkHetDaac/AyPHYa9DSPQBronS+HS+qOJi+wzw6oWAjEzS2V540k+TbB
	Ir75H6TS22dHnHTEBzjpLh68iNxFyCahMS0CPysJDI2cgLjaarc6ZoG0Z2LFICg/r09oOnjlf5g
	8csSWHIeYPfH5bgzDOHMCDnR18JEdYum6G8IBP+aB1t6AOgLJDkInP1tgmV0r3PQZUaereUwKnm
	Opp69Opeu14sV1jbWivtlLDPkrsH+EEWQCuR6IZhVHhEz
X-Received: by 2002:ac8:5d02:0:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-51c8b54a8f8mr64314991cf.50.1783582928477;
        Thu, 09 Jul 2026 00:42:08 -0700 (PDT)
X-Received: by 2002:ac8:5d02:0:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-51c8b54a8f8mr64314671cf.50.1783582927994;
        Thu, 09 Jul 2026 00:42:07 -0700 (PDT)
Received: from [10.111.138.111] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d799dfsm10078060a12.17.2026.07.09.00.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 00:42:06 -0700 (PDT)
Message-ID: <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MSBTYWx0ZWRfXyPcfIvxOrEgm
 Gst1aKLyKO4kX8YY1ieZNwUkiYQMlsin386KXuFi6bzGRHIYdRE7ya1kDkRupVlR3mFq5665vIz
 VrXQu6GgNlAlQTAB4qDqn8VUs9QIu1mF4fR8YMuk+VSNzboQDF9rzU3pEnbLg8lwP/Nq4nAHvFm
 e4wu8avfaE9kE40xzDOA1Xy5ijs+zgpO2zb+eQ+8cjWu2UiBldVWGBI4iYxG0DqsFxivHgM7urL
 kAa2PamPxlRALXMQcClfJ3GNZwTB0+yW2P6Kmfi5YoAgwcj2Z9MkWDDPlLiGqTOKsWDPy6LrCiO
 ClGaf4pCrn+6hxtyKqtFbjhmExcNi5Pi1+GvieJO+7sV90lM/ZvU6T091vruwK/D6uZuSUr0U73
 oaH5KpXwxkddoplmEiOCR5ot1qd7T+QwB7am9G9u/+KBYKdQrz5UybOI5/v/rpckGf/WXB/ICs/
 IzdC9DWutzw3TESqRig==
X-Proofpoint-GUID: pkk0wyfqW1VjNhUnVrpW0ZzePxVjsfsZ
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f50d1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=fjlDWTYzx9GH-NWLRPsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: pkk0wyfqW1VjNhUnVrpW0ZzePxVjsfsZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MSBTYWx0ZWRfXwgFEu1feemht
 RVmZeYH8koygbpafwF+KJPWBWIs2/0Z2A71CExW8QkRKSfuZJOdKb1gqa2YXJLE8LAne4y6anXU
 3o6Lv2BO074gzje0RXATC6N1xHJTxu8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090071



Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
> On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
>>
>>
>> On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>>>
>>>>
>>>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>>>>>>>
>>>>>>>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>>>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>>>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>>>>>>>
>>>>>>>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>>>>>>>
>>>>>>>>>>>>         <&phandle device_id min_state max_state>
>>>>>>>>>>>>
>>>>>>>>>>>> Define common TMD device index constants shared across currently
>>>>>>>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>>>>>>>> additional target-specific constants can be introduced while preserving
>>>>>>>>>>>> existing DT ABI.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>>>> Why are you using only those TMD devices?
>>>>>>>>>
>>>>>>>>>> More constants can be added as needed.
>>>>>>>>>
>>>>>>>>> Kodiak is one of the supported platforms.
>>>>>>>>
>>>>>>>> What would be the benefit of having more than thirteen cooling devices
>>>>>>>> declared in the thermal framework and having only a couple of them mapped in
>>>>>>>> a thermal zone ?
>>>>>>>>
>>>>>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>>>>>> need to add them ? Can we do that incrementally ?
>>>>>>>
>>>>>>> That's what I am trying to understand: why the implementation uses only
>>>>>>> the selected two devices, if the modem on Kodiak supports others. How
>>>>>>> can we find out, which TMDs to use on other devices.
>>>>>>
>>>>>> My understanding is that is an initial thermal setup. Gaurav will add them
>>>>>> step by step while setting up all the thermal zones instead of sending a big
>>>>>> patchset. And TBH, that will be much easier to review.
>>>>>
>>>>> In such a case it should be noted in the commit message and/or cover
>>>>> letter.
>>>>
>>>> Thanks for the review/guidance. Not all TMD endpoints are relevant for
>>>> kernel thermal zone binding — some like BCL and cold temperature are handled
>>>> from userspace when needed. The constants here cover only
>>>
>>> What if there is no userspace? Or the userspace is different from what
>>> you expect? I doubt we have TMD-speaking userspace yet.
>>
>> Thanks for mail, The TMD userspace implementation is available upstream at
>> https://github.com/qualcomm/qmi-framework.
> 
> Is it?
> 
> lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
> lumag@rohan:/tmp/qmi-framework$
> 
> I found no traces of TMD there. Moreover, I don't see why QMI framework
> implementation would react to thermal events.
> 
>>>> what is needed for modem and CDSP thermal zones on the currently posted
>>>> targets.
>>>
>>> Again, SLPI, ADSP?
>>
>> Sorry, I should have said "generic subsystems" rather than listing specific
>> ones. SLPI and ADSP do not require active thermal mitigation on these
>> platforms.
> 
> Could you please provide details, then. What is cpuv_restriction_cold
> TMD?

It warms up the zone when the temperature is too cold

