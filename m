Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDC405C44
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537601; cv=none; b=IwfrR6D0V0iubLcnRQF8ck/5lGatdiB+Q/b/ELZsOZC632XIG7NNEY1/HX+dcAdAZV/OeS8BqTCVDe8cAkg5Xb3c3/534UA3ndD0fa0+4UkZGDsuBd5Zhf7NTf/UKdRYik6HZ9jWtGmsH5Ji/y81hF9k9zLHDWFOlPeI6K8TXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537601; c=relaxed/simple;
	bh=KwUenCCTGlmgA/VcqQxmvfMpJVnf0YViC+wBXBgr9oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tos2f7PBjDGCmH4/b7aAlhczK+s2OSC5XyVMvVUUIL2ockvfd0zE6+mXroHFEZZ6E9goOuOhN0UyzcgTUelAdg+XgQo60T3kHPDMLSoRrMFZ/FqR9pWTWZQyuo8CL3DBRy8z8y00+XCgAZFXqLH7e97JMIXpVjfgFl4Kn7UuCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACi9lPJz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4FVspkn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACi9lPJz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4FVspkn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFLoHY943116
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=; b=ACi9lPJzRqm6Ft+O
	dQs5XME/f76WWxRbnjH7GJ7yfRAJ2lHzskCTVl96VVuuwqmcqBRtVMUqPQwW3fwS
	5F9ZAoMx6bOYAxIPNQlAWCSXjLoJ4Um3P8BhymdqZ2s17XAFb4Kao6Of/JHgdHUE
	RRvkmeUAi1K/Hu99t6ZtQ7AJOh2FiEv3YyIrtJV7JS8h0jxdJV4ijb0mzl+w9tKL
	FUpM643/Y29wQJ3odnMZPs0FD3oeVVC6ozRBJ9OmCs5L15B0NNVkHRkkzAVhExJq
	RWspUUlJU1bFkheNdOxoMzD1T7sL4hrierQXWZ0N1FFreFhI9v/FL/0U6kwB81US
	d4yZwQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhgysw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:33:19 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59d595bfd94so1813096e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781537598; x=1782142398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=;
        b=G4FVspknmIx4qVoSmnuMkxSLBE9M1h+QgmFvJXAkA0MM+xpJ291axmz6HFAZwv3vbV
         OA36TNKiRxVHTbo7dpXJzXXQYWeJTuBTZ1hqm2lHvt/9iZvBNUxbsq90/joqunGa1tI0
         FitYOUNVbGxNZ5cHkGgZZAW/4QU3R4bZycwOYedYlfHLqWULuA++qFJirzs/TqpUqJ7I
         l3ZaIjh9+Wu8rECSW+EBsEUzFlvSysEKDRwcJ2XnuMOKfP7Z3+961fcu70S0aP5wCFxi
         1ypytZIQmWUr7zKNG1K+y5kP/WtElpaK2bR6QnqO2xa5G7pa/erQJ2+KA2OY0/4yjccJ
         HNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537598; x=1782142398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwMQO0LcqR49s8kdpKn9p05zdjYBTA9VDNonkRXI1Ww=;
        b=kA94d9/6z0LCEBH5/ZY+AAd/0Q18KuQ6oHVL1rVJiGfj7KYF6zyupVDlQ3xXF7QM50
         bca3JZoCWOdU+kV6wy010wYI2e0E3PRHHbOX3HuqP9mRcHpuf/Vq+i6epg1xDt/nOfon
         dpug1zkcrodgs4LO5gi0zcvKJRvhKAOTeKoTdNDn+xJIqW8UbQtfVaDYWIO3tGE+HyXS
         73f6XhfrPQSMtcJrlXyNwMNTv/EHbnFSPGac5+3Gwe5mlHe1o8tD6P94FIZYkXrfAwuQ
         p99ou/p2EVuLCQEP4CTZbzUH3uKYxIL0fK146y1fNSyQq0djUkSvitreiKEwkxxlPG18
         yELw==
X-Forwarded-Encrypted: i=1; AFNElJ/eqXtV7HPaJYnqP7lmpKmykt9JSz7KVww5ZjkFwvyrzbir7BWUG3OPq/lfzdECArwJdtVYDOe+Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAvuDmffYJpkMtgXuppmokTAaJFLZm/f96iqQmw/eqX9TfKGA
	nc6hTfhad1oF0MVWAWK43pCFHbakRJsVKKqsTSU80cQeoMuep9BFdzAFndCjZtamrJ6K6HUpDJ7
	myzpoxdvv7DfyeLQ6ls4Qm+qD+r14JsiYuD+5XXqh2mAwu23UlwhjAibOTtZcUg==
X-Gm-Gg: Acq92OEXqWGM9eveThX4sjCl5HZkTBjRIbGJHnFcX6xlg9tzwfCMxXFEOud1iVOxIAu
	eWmvomYlHYOkNOcmRzB5ZrJH2hcauxhRxPWXeNyJgrf9WzaQ+Cxxc/n3ASHjNojOZRWyiv6DHMv
	t4SSq9gEkfNJGbdSPA/P49GhLHEA8uujdhVDzhrUmZQvYx0M1JCSsPm0JpEsIP8dqnx4+VVjozC
	NSwUIMG45yYWd6bLrfmVRof1ikFbagIirYycHNsLj+uFg326EvEBxFxYwanBIWiFaUcsHTjsaDz
	ztNGvuXiHGJ0QpGHdeb9bhqA6rooN2weJfeJ+oJcQYIN8GXf+DXAx1UlhNC4lv+Q/oFgNoaK5Vs
	3RlOpL+Y+g2qG5xp26NNtWWYNIqKM0DphID3svZBVkUcmFmk1Wekf9XGhDdxw6SQ/yujqkltIWS
	pSckMF4OpIWjlzwQ==
X-Received: by 2002:a05:6122:907:b0:5a0:9ad4:7016 with SMTP id 71dfb90a1353d-5bb6c13290fmr6584835e0c.10.1781537598504;
        Mon, 15 Jun 2026 08:33:18 -0700 (PDT)
X-Received: by 2002:a05:6122:907:b0:5a0:9ad4:7016 with SMTP id 71dfb90a1353d-5bb6c13290fmr6584791e0c.10.1781537597998;
        Mon, 15 Jun 2026 08:33:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa51440sm739885e9.9.2026.06.15.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:33:16 -0700 (PDT)
Message-ID: <dcdfe9f4-aeec-4d85-92a1-a42592fe11c8@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:33:15 +0200
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
References: <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
 <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
 <mp2hl67rupxrssa43dcy36m3dwatlxsu7n27l7qdqsguo5i3bp@bo6sdzxglxt2>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <mp2hl67rupxrssa43dcy36m3dwatlxsu7n27l7qdqsguo5i3bp@bo6sdzxglxt2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NCBTYWx0ZWRfX6XMDgwQ1qKl1
 ZnHReGznrjfo3c2XW69ghcuITL/XJuEsB4Iz00QPe0GahN2Z4mKYg1gL7qgW7ofRFXHDy1XTQJf
 Wcq9+KTxfJ0T5xpucdrrpeQ6q7oE/Yg=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a301b3f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=UGbA0b5lBdDrEDKOv_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: zUxvtgtIBYzK-yBuzT2BFYqf0FhS6Uhi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NCBTYWx0ZWRfXwNFSAVym2ule
 xNc7e15yWqPI2P7tMSw4NrYNsj0CYuuy8KUwVtH8Jq9k97e8FDMKcKUtHbTGiVK5DpUoYRmE1Yv
 vnO3VhbDunhXnaWeF/+bWnKskmvgNBvVTyNclMjLM7xpxaLK/uPjcW7OJO7gql5OWY0AMqXvgRA
 Pkz6GkU1uOsADOcALYWHpxMdCvdjrd76MaPCNvUQOCGDcVdmltWZHaN/9aCpV1F1CZkaR7VZVvs
 j80u15Ug3J+LzUsJbt8yJVg2cZa7fLO/aGTaQQvoAxxbIMAyNbCLWoOcJ30gqLHtpAaVetJnaip
 L6oOdkXTpj2jgPO4yLRR/nzh/CbuZJRWFYOopIBm4fSgfC27qqFMEtCZQFTAlFJ8t63MeJl5gAW
 P05Om4wE/tjXl6HafOVlnJyZ/bcCwK3C138kTY59HGDxnJwIhTE1uaQ0jj8fTwFiM3sExh4lIGO
 aOnNovsynC6+Vu55VwQ==
X-Proofpoint-ORIG-GUID: zUxvtgtIBYzK-yBuzT2BFYqf0FhS6Uhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150164



Le 15/06/2026 à 17:14, Dmitry Baryshkov a écrit :
> On Mon, Jun 15, 2026 at 04:33:38PM +0200, Daniel Lezcano wrote:
>>
>>
>> Le 15/06/2026 à 16:11, Dmitry Baryshkov a écrit :
>>> On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
>>>> Hi Gaurav,
>>>>
>>>> Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
>>>>>
>>>>>
>>>>> On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
>>>>>> On 6/13/26 13:05, Gaurav Kohli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>>>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>>>>>>>> sprinkle generic properties in random bindings.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Ack, will add why part.
>>>>>>>>>>> These names are matched with the thermal
>>>>>>>>>>> mitigation device identifiers
>>>>>>>>>>> populated by remote firmware over QMI and define
>>>>>>>>>>> mitigation devices are
>>>>>>>>>>> exposed as cooling devices.
>>>>>>>>>>
>>>>>>>>>> No, -names correspond to values passed via DT, not
>>>>>>>>>> some remote firmware.
>>>>>>>>>> The remote firmware should give you interface which
>>>>>>>>>> is explicit and does
>>>>>>>>>> not need such properties.
>>>>>>>>>
>>>>>>>>> thanks Krzysztof for review, We need tmd-names because
>>>>>>>>> of following reasons:
>>>>>>>>>
>>>>>>>>> Following Daniel's series [1], the thermal framework supports
>>>>>>>>> mapping multiple cooling devices per remoteproc/device via indexed
>>>>>>>>> cooling-cells.
>>>>>>>>>
>>>>>>>>> 1) The thermal framework's cooling-maps reference
>>>>>>>>> cooling devices by index (for #cooling-cells = <3>).
>>>>>>>>> Without tmd- names,
>>>>>>>>> there's no way to know which index corresponds to which
>>>>>>>>> TMD, as firmware
>>>>>>>>> may return tmd-names in any order.
>>>>>>>>>
>>>>>>>>> below are the changes post new thermal mapping changes:
>>>>>>>>> DT: tmd-names = "cdsp_sw", "xyz";
>>>>>>>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>>>>>>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>>>>>>>
>>>>>>>> names property are not to instruct drivers to register or not to
>>>>>>>> register something.
>>>>>>>>
>>>>>>>> I don't understand the problem and explanation in the binding is
>>>>>>>> basically non-existing.
>>>>>>>>
>>>>>>>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>>>>>>>> which index means what.
>>>>>>>>
>>>>>>>
>>>>>>> thanks for review, shall i use driver data, which is basically
>>>>>>> pas data structure like below:
>>>>>>>
>>>>>>> static const struct qcom_pas_data {
>>>>>>>        .crash_reason_smem = 601,
>>>>>>>        .firmware_name = "cdsp.mdt",
>>>>>>>        .tmd_names = (const char *[]){"xyz", NULL},
>>>>>>>        .num_tmds = 1,
>>>>>>>
>>>>>>> Is something like above acceptable? and this will also help to
>>>>>>> filter tmd names as well?
>>>>>>
>>>>>>
>>>>>> How the thermal framework will bind the thermal zone with the TMD ?
>>>>>> (node pointer, id) ?
>>>>>>
>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>> thanks for review.
>>>>>
>>>>> With id only, in this case instead of taking tmd names from device tree,
>>>>> qmi_tmd will take tmd name from pas_data(driver) and register with the
>>>>> cooling framework with id only. Please let us know if this looks fine.
>>>> May be I'm missing something but:
>>>>
>>>>    - The QMI TMD returns a list of names, not ids
>>>>    - The QMI TMD may return the list in different order than assumed
>>>>    - The cooling map index points to the name of the TMD in the DT
>>>>    - This name is used to match the name in the aformentionned list
>>>>    - The index in the list and the id in the DT can differ
>>>
>>> Would it be better if we define standard indices for the standard names?
>>> This way we decouple the actual firmware strings from the DT.
>>
>> I don't think so, it seems to me too fragile and prone to error.
>>
>> It is a remote proc, an external subsystem. The contract between the client
>> and the server is the protocol. The protocol specifies the identifier as
>> named strings, the TMD names, not numerical identifiers.
>>
>> When asking for the list of TMDs, we get a list of strings. But as it is an
>> external subsystems, may be tomorrow someone decide to send list ordered
>> alphabetically, or per number of states, or whatever.
>>
>> With hardcoded id the QMI TMD clients break
> 
> I was thinking about something like:
> 
> #define QCOM_TMD_DSP	0
> #define QCOM_TMD_PA	1

Ah ok, it is correct if:

tmd-names = "dsp", "pa"

Or

#define QCOM_TMD_PA	0
#define QCOM_TMD_DSP	1

tmd-names = "pa", "dsp"

> cooling-maps {
> 	map0 {
> 		cooling-device = <&remoteproc_cdsp QCOM_TMD_DSP 0 2>;
> 	};
> 	map1 {
> 		cooling-device = <&remoteproc_mpss QCOM_TMD_DSP 0 2>;
> 	};
> 	map2 {
> 		cooling-device = <&remoteproc_mpss QCOM_TMD_PA 0 2>;
> 	};
> };
> 
> 
>>
>>>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>>>> they describes the existing TMDs on the system and the cooling maps index
>>>> points to the one to be connected with thermal zone.
>>>
>>
> 

