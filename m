Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095A3EEAEB
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534024; cv=none; b=MpgQIIZSUCR/byqNupryQoNH9crcGc7orYRFAHOgbK1xYsAYRnVnBC68RAntWTowu9u2z9ab4ZJdyRT84QCIBMNnkr7muRDKhQpJ4ib6ySKxWloQx9JMa26OBkhu3e+BwUiDkHhlip+InqeNBrukW4MUgSokXhfzQ4eYXlZbets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534024; c=relaxed/simple;
	bh=4Wm4l/st3gWaMHoN5Bw5U9Pr/QJGQ1bGkwqydPvFm9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSqEU7dZCgcGPmis+OthHzoM7rXP14XtEJw/PncV9FrnzwuEwRCGBUsa4LcQBC9wDzZYmLQWT6R6VyH2EhInWAIa+M2rjDrMydmqNge9m606wyY/xy9gvRaiOsU19625WB7xJImisJlEmXFeN3Klwz39gaR8ll+7R9I6+TXPuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDJRlQES; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMKlb5H2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDJRlQES";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMKlb5H2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZGJY2712736
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=; b=DDJRlQESjIFuNyKl
	k5kRzn5+M3e93sSvxkkqq45B/3srqZe9zJXZVifACNYDIxlA2zk8EHg4P5lOw9TS
	2AyUibj0XZfyWZn+OzEDCwK82MpZf/kyLRtQ0Wf0gx7T4CHctCexao+pYbgbTonM
	VX7Df3fRFxTU0hOw3WlmCl/aLRHaSol4NgNiiJfg65WDghreBTxPqQ1gq+W+ihVg
	NNsE0hdC4wxrrm4PJiG5AlvaYGOFLrzBe3ahkoMusiTkNw4OMbujkg+Ir+XNbAru
	2J+xLr8crUW8LumVWHsZxQurWq8d6yzchDDZr7SbZ4ZdIseka+JjqrzfjwUyfApc
	K9vUnw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete981b24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:33:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963df05f08cso606502241.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781534020; x=1782138820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=;
        b=jMKlb5H2zgBDDIVh0W75SFvzkunxYiEMZHANAvpECbjfPAtq2lrbro5253fZe2buPO
         mrptL+ECra4klMIpeX8xuCv9Hokd8XvSFdnQJlXEvfD687jPgG482CycqTfEMb6/ZiCK
         +Vkt1eh1LsA3yj49Aevc0OvawxxS/mGLoIFhk9FVFbbUnZgN3N3BU5poEiOuj6C1tIDI
         Q+cJHSA+BmIkUuY6UYxL1EbbaZ23sL9eCORleihRw1w5EYKMkmfeitdRRwWp++CUn/ss
         4m2zkqcCuMmTVsu2UKn36S47hWSGK/v+x3dQ94zlEoKCPtxE/7WR4rFOU4kZ0csuyPp4
         7EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534020; x=1782138820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGb3OAKHAE1yyRO+IKe2XZ30dzp4/YLjRoSdCH3llnQ=;
        b=m7ubKUvb+A0VS5C66JnVaUBAxoTl9ivVqQBQxA8KaDLFwHukp2Ly7XQXMOx+FuQHcX
         9nYUKANJ+tRsrPqchnpWQIpDIYmrjS7dfe6lVuFfQf89Pc5o7GX8YmD6QvBHPGNe0K09
         QisbLq2nXZMb6ETJhQwu9a2ecRF38Op2iOcr+Zpip+/PJQh9uct7ndXO0GvnCTaXVtD8
         M1UMgVW2nr+wy7gP544TOrABciNVx5krw3snmtFqkAPTb4VUZwdyFgv+UIBPAhbxdCT4
         +60lPlJsH0G1Ii2b/gICfhE6G316o6q7VPNZuM1dSw1T/ipJBdSRFzZgbgU0Akv7R6X4
         zjSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6wmz0pTM+xqnLIdDxlOdTZyPsyMN88lNqfH/99HRe7GImUbWTWtHX4sumP+EoEot06ieLWxAkxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tE8I92YB0xL0aujFAXita2al9tCxfDO97+Sz+Mp0YzQ0TOhM
	oTdAmkNGBWLefqU/Zjq1w/XUoWJS93lE8sKhcoMEyqlnSgzoTbVOjIPRpahZLKbvEpJYFJewg9y
	MYllFyOn7vrGuZQHZwkRgQguDYIZUGn1+H0OwndX+CwdtCaT83CRjkKrtCsV3nQ==
X-Gm-Gg: Acq92OEnkQm2iifMF72vUlxivJOif1td7ZMhzDd4FIwkN2EWOuEm5OJUd82oGa9tohR
	SrjRKtXUJHxfJddttwQ/C0FUzC77gSPFTJT6Zn4PuOJnq8r7rStnSjxotboNagZRvbuEg2fuEuA
	SGEJ0MEDB6XzX1q2IiCALcDJfmL0eoRoL26j11PEgqrtnCVOLOLdSSKlWXryk/TKZBVQynDQOwS
	rqmfxCppQPsbU8Uny/iVhxXsUu7mAS1kOJY5N1n0qmABrIVmZfndlsokyR8/GZxrKiUXrw++YG2
	v7PYmuL+QgZhVJd5mDn0fGZ8aKSpDlmx1jLL4kV2iyohhWCbHobwYckN7WefIWR3V2lM53dLopu
	9UlPNN8K8pmxLP1HSIjCTwI2oYsjMY9wkIH6KLPwzUTatyWV1urDvemBTNasic68Q7hHGAAohGp
	yFPBegWPwwByy/Aw==
X-Received: by 2002:a05:6102:149c:b0:604:f849:462e with SMTP id ada2fe7eead31-71e88db5afamr7325411137.25.1781534020429;
        Mon, 15 Jun 2026 07:33:40 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:604:f849:462e with SMTP id ada2fe7eead31-71e88db5afamr7325358137.25.1781534019875;
        Mon, 15 Jun 2026 07:33:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm30916812f8f.32.2026.06.15.07.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:33:39 -0700 (PDT)
Message-ID: <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a300d46 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=y33DeBKr3xWxJ8ptnqUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: nlJkb4oOg6sKpb9HQtlJsHs8qniRAwXh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MiBTYWx0ZWRfX3eSXjVVehlPL
 JwiKFyv0ZcZPYV8NIrsg2ciHqT0iQMkBUmto49IYbt4kne666mpmUdi/dYwPOPm0c7nwQzGp0dL
 sKghJKa9lFBry8zvXcf7Pdbw5tTQSdo=
X-Proofpoint-ORIG-GUID: nlJkb4oOg6sKpb9HQtlJsHs8qniRAwXh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MiBTYWx0ZWRfX2Kav/LsPyfyp
 klfWnwB26lST0XzQKMo1sUPyOhcQchfN38ut83Yt2OurZ21Nxjiv734XuQAAaeeEO6sfOW9/I84
 QrecuUQNOhfPVoPyiptL3DSJpwJMHYOcuvs+akMuSA8ujNl4dnNri+Zvqh7Gd+9HX73lQnc/qVF
 o92NQFj5Jhzn62vkANSoFMa4vKkirL592Sb6DrwYlCtTpW4OSkXXSTh8W6MAzcPddwXhWuHv6If
 x4NS4qqcVWwf3hBAh/l2eEP6uExVKWB7MA1bK8IZOBmXxDx3RDHua/TvJLYEV7qCLgnT64spQAT
 VLsDGrnO4U2OvnQUJbvPxj8z7id7TCwrGZEc4NZ2KPHbt/dsaJNjFXbKX0qWKQXm3py6EHeJUji
 NpY9MP4cvQeWnGKkl8VTfIE0K4yophyGHkEsOHDJqzaqh59d/AjnbFW9GkqAZqHX9zYBH/LnrW+
 wz3OLXRUznQPRgflorg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150152



Le 15/06/2026 à 16:11, Dmitry Baryshkov a écrit :
> On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
>> Hi Gaurav,
>>
>> Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
>>>
>>>
>>> On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
>>>> On 6/13/26 13:05, Gaurav Kohli wrote:
>>>>>
>>>>>
>>>>> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>>>>>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>>>>>> sprinkle generic properties in random bindings.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ack, will add why part.
>>>>>>>>> These names are matched with the thermal
>>>>>>>>> mitigation device identifiers
>>>>>>>>> populated by remote firmware over QMI and define
>>>>>>>>> mitigation devices are
>>>>>>>>> exposed as cooling devices.
>>>>>>>>
>>>>>>>> No, -names correspond to values passed via DT, not
>>>>>>>> some remote firmware.
>>>>>>>> The remote firmware should give you interface which
>>>>>>>> is explicit and does
>>>>>>>> not need such properties.
>>>>>>>
>>>>>>> thanks Krzysztof for review, We need tmd-names because
>>>>>>> of following reasons:
>>>>>>>
>>>>>>> Following Daniel's series [1], the thermal framework supports
>>>>>>> mapping multiple cooling devices per remoteproc/device via indexed
>>>>>>> cooling-cells.
>>>>>>>
>>>>>>> 1) The thermal framework's cooling-maps reference
>>>>>>> cooling devices by index (for #cooling-cells = <3>).
>>>>>>> Without tmd- names,
>>>>>>> there's no way to know which index corresponds to which
>>>>>>> TMD, as firmware
>>>>>>> may return tmd-names in any order.
>>>>>>>
>>>>>>> below are the changes post new thermal mapping changes:
>>>>>>> DT: tmd-names = "cdsp_sw", "xyz";
>>>>>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>>>>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>>>>>
>>>>>> names property are not to instruct drivers to register or not to
>>>>>> register something.
>>>>>>
>>>>>> I don't understand the problem and explanation in the binding is
>>>>>> basically non-existing.
>>>>>>
>>>>>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>>>>>> which index means what.
>>>>>>
>>>>>
>>>>> thanks for review, shall i use driver data, which is basically
>>>>> pas data structure like below:
>>>>>
>>>>> static const struct qcom_pas_data {
>>>>>       .crash_reason_smem = 601,
>>>>>       .firmware_name = "cdsp.mdt",
>>>>>       .tmd_names = (const char *[]){"xyz", NULL},
>>>>>       .num_tmds = 1,
>>>>>
>>>>> Is something like above acceptable? and this will also help to
>>>>> filter tmd names as well?
>>>>
>>>>
>>>> How the thermal framework will bind the thermal zone with the TMD ?
>>>> (node pointer, id) ?
>>>>
>>>
>>> Hi Daniel,
>>>
>>> thanks for review.
>>>
>>> With id only, in this case instead of taking tmd names from device tree,
>>> qmi_tmd will take tmd name from pas_data(driver) and register with the
>>> cooling framework with id only. Please let us know if this looks fine.
>> May be I'm missing something but:
>>
>>   - The QMI TMD returns a list of names, not ids
>>   - The QMI TMD may return the list in different order than assumed
>>   - The cooling map index points to the name of the TMD in the DT
>>   - This name is used to match the name in the aformentionned list
>>   - The index in the list and the id in the DT can differ
> 
> Would it be better if we define standard indices for the standard names?
> This way we decouple the actual firmware strings from the DT.

I don't think so, it seems to me too fragile and prone to error.

It is a remote proc, an external subsystem. The contract between the 
client and the server is the protocol. The protocol specifies the 
identifier as named strings, the TMD names, not numerical identifiers.

When asking for the list of TMDs, we get a list of strings. But as it is 
an external subsystems, may be tomorrow someone decide to send list 
ordered alphabetically, or per number of states, or whatever.

With hardcoded id the QMI TMD clients break

>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>> they describes the existing TMDs on the system and the cooling maps index
>> points to the one to be connected with thermal zone.
> 

