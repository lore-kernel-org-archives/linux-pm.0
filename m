Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4F37A48D
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767042; cv=none; b=ndU3WpTQQ1TsGrVHd2oxVNzQNtFlKgPHDjnVPo6m5P/LDecvqd+HpNHnkhK5Zy0wAMIXYKuVFpOm/5gkjhamhPnrO1+/xePyVkTw4p3vTge7jUFeSEqLfYsY1vh7dE1GweceJFh9TjNHXtbQBLbEB1hV/wAcqG3kAgkQX3ZqEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767042; c=relaxed/simple;
	bh=8E5qzq+mZ2iFEEVvuk30mGz2SpkrQKNDsaBE7t3Hf5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF6BwOuALPyZlRZCC/y+2MRKVFYTJWW0W1AjVIU6VOffrTIwXI+npZK4UprwlL/o5d/gbJLS2/erNGcW7cOtG0/Otc+qgdPen28Kn87SmMGHNdJx9oUfq5QKbBAqlup2k07+wha4Kz4d7dRnUdqCtxgSn7HpY/UHD/YgTrCGAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvtMUwOx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jnbnW6cH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvtMUwOx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jnbnW6cH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3X06d3577378
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 07:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=; b=UvtMUwOx+IBw1L42
	6Vx/3Jt9wIEbq1W3cy4jzghi9EIUr2I98o1Xip77t/5rGDmy+0rPIPGnnoOBxFy3
	qKwdu8vlJI9GNln/DNllB1BVC4bQneecQsvu5yga0JMalJHqFQl/DAxiFdn5/3Dv
	VxE/CgMDGRf3OboxAgtogVAfEC6aK5EMUvpczIzOV/6QYcGVhimzs8BhiA2NEU0F
	fxwQaWLSHz6oFLTc1SSzV7P71b03lf8Ds+BrWr8+R+rI1EjGDGRE9c4+j8zcUfGY
	V3E2bkE0kd7GkIzYmaHMk4atgy5EEwF1rjxTMsOthHZScdWFnvMZqxRNmHjVlyyW
	7cVCmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7jfu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 07:17:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91576c147a4so217625385a.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781767039; x=1782371839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=;
        b=jnbnW6cH1RgWV1PZ+30mJFAje1p8AIFn+pADGWPa7E/Z5Orkhe7I2cxQz9K7VxsScs
         OR813jxRuYthujfop5Et1V2D9FV1sfFmX61B9qcgcr1MZlJ1jdkh/0E/8OIMGnpYVeBy
         sG+FTnNL2ONH2xQouxQF09x9nPjCsLwhNJ4pyL/Rsb/QiSe/QLA/ftFdmePrtbYBSt+r
         zGylPLFF0/CcvdKLHGs3FwgFmzOP9tFfbREV285oV3Q561MmE+X0oTTMWhSSQIv3E8WJ
         wTvN1redhyvgWZINzrZhpHfBdGiJ0KwKcP5oSg0P3tp2x1ZVvuNwBNiiNlUS2ucp6oKf
         ssIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767039; x=1782371839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7cu/kThVOp61khadvlTa0ooRt2HujLje7priNd4Ua8=;
        b=TrIecTLT7utWrmz/yNI3TyUsNal3qIPQdRCWRiR6dUP2b1QUyAnLu2mUFSjUZ/TuX0
         6XB0bXQWkcNiDV7z1dYF6kiFdDu+6K+WAM5eRBFPzE8qqeQBfFBKKGgws5+Q8K8TaCAX
         8hbOjiUbwouNiHCqy4Nj4FHRMVfo3qhYwDg3YYN7smeQftcuDorAzJuwpM9y5QLi+sal
         1cdOXj1ynWxT36fMFSAuyJzxxG1jHQ5n2v7ioIR70rT7SbNg7rnPAUoDLKHPVn8fGZq1
         JexiXNDC17KwdSt6ezLeGTHCRJH3A9a7Hm7t9OGgO8+3JlB4F99URXcsCN5lRbJ7x1hh
         8vpA==
X-Forwarded-Encrypted: i=1; AFNElJ9rikurUDfPopB7cU1jnjkf5PGkNa6fAPsi21QDqldsKAfTNFwX/H9bQqYWSNBv6ioruITJ5Fe9WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGT/5Jd5d3lnmQmYsw11yTLUmOKwEER+bCH39sy+U+ekhaNSrD
	wm/ydLbqgByxh/+I04kl9l4ao4m4NLrIJcan1Cu6cNXfF+zfbU40vvrAiya/yQTrZBg1Z68AnYU
	nZYKItuZbG+P1Wk9EKcyxRUDesNWobsdHxIYdLJ82EOm/2/lzBIsFib+d+zq4kQ==
X-Gm-Gg: Acq92OGLPmZYcpaYnIlBDSu24JyDKp1+WGJ0DN77zMvH7TORJ5AmgH+NrjHX8SG3eH7
	YaZhKEHrG3Eki79UskERh08rSY9FaxN9Uf4b40mJPoQM110GcPlJyZynUoK/q7eq+6U6VCuDXHk
	uBzFfstCAivN3FBKCi8B5BCpaZRreL+4nTNAdxMO4UlOLUWduE7Y5b4THUtxxGZVnFmrf4Y/lSB
	8eW/1p1ySe8hzwupKiT7MWwXrRmDWTGP0Di4wmZzd7DSWle01POl/PIq6B1STv5mf0qNObszr7n
	eHQydslgFoegM9FvVeeIo61bEUY53Pfsl024kF1azGIQna1vpC0KsHMkcEZQe+643OMiVgUUNKc
	8zVe5JqqQR8VcTZeNg1+6sLeKISilgyOJbUUbzO0OC6NmgRHczsUHcMpMzjw4tps1cY6fN1brlQ
	==
X-Received: by 2002:a05:620a:4722:b0:915:8502:f808 with SMTP id af79cd13be357-91f27600dc1mr350112885a.25.1781767039523;
        Thu, 18 Jun 2026 00:17:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:915:8502:f808 with SMTP id af79cd13be357-91f27600dc1mr350109585a.25.1781767039081;
        Thu, 18 Jun 2026 00:17:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5ac4:8c5e:b742:f9c9? ([2a05:6e02:1041:c10:5ac4:8c5e:b742:f9c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm55095264f8f.25.2026.06.18.00.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 00:17:18 -0700 (PDT)
Message-ID: <61765401-3397-497d-a0ca-e9bf9d76cc6a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 09:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfX6m1JOfjK5CQj
 H0tGwZTLLQTKSZmcvpdTva+l1iQPzShSz1MVmBXw82uSPWOyNpTg+e+IIR2qauXfp4NbrecQ0Up
 WNzus0iboNkDsKw5kpFuG/939jqtUsgoBaU1oDQNIUnOYVfC3pW0OixdDHGmCdzB8dgOjY2Pj4x
 Pnv6JPQeVFMie8U8qPiML/exarxEq91tO0VosANhxNuzB3CERul1Sgh3wI1mPlc5iRkk8M4L6uE
 mFFqgsNAVLrjAKtpPuNuzRV5kzRSkdS3uALBp8p2TEb4uv7ViR+SvrWmgRJrOccUWxgHDUK+ddy
 O6jqxRwC4kB1EYbmc4ZuOL35xtnO09cnssbdRWpBpSCBFqBo2UuC/diY0pXZ5LH8nAR/6p+2S11
 I1Nm/aGXOkhcJL7ktuBvdthShTNgKwFpzwpmqDXIDZcHF2eA4dBmyxlCjrLFONM7PvPSZwfBolt
 NtltmMtTwySlPw+Y7JQ==
X-Proofpoint-GUID: tpGGuhNGfPT_Dya0U599E_12JdrB_HlC
X-Proofpoint-ORIG-GUID: tpGGuhNGfPT_Dya0U599E_12JdrB_HlC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfXwe6Na3/roUY8
 hpJ4bS9H5dR9kFfjwonrnpMW0dwyctuVGWaOnolwNLQqzT1n1ioVhW5cHyCL9XR96bRnTzKeWlr
 qEcPmxeUbbbKhRfeTvioghcmFdXfJfY=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a339b80 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kCrNj1x4bCXofucgv5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180065

On 6/16/26 06:21, Krzysztof Kozlowski wrote:
> On 15/06/2026 14:30, Daniel Lezcano wrote:
>> Hi Gaurav,
>>>>> thanks for review, shall i use driver data, which is basically pas
>>>>> data structure like below:
>>>>>
>>>>> static const struct qcom_pas_data {
>>>>>       .crash_reason_smem = 601,
>>>>>       .firmware_name = "cdsp.mdt",
>>>>>       .tmd_names = (const char *[]){"xyz", NULL},
>>>>>       .num_tmds = 1,
>>>>>
>>>>> Is something like above acceptable? and this will also help to filter
>>>>> tmd names as well?
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
>>    - The QMI TMD returns a list of names, not ids
>>    - The QMI TMD may return the list in different order than assumed
>>    - The cooling map index points to the name of the TMD in the DT
>>    - This name is used to match the name in the aformentionned list
>>    - The index in the list and the id in the DT can differ
>>
>> Krzysztof , I don't get why having the TMD names as properties is wrong,
>> they describes the existing TMDs on the system and the cooling maps
>> index points to the one to be connected with thermal zone.
> 
> 
> 'xxx-names' have a fixed meaning in DT by convention - assign
> identifiable strings to the 'xxx'. I miss the property 'tmd' in such
> case - its definition and meaning. Where is it?
> 
> But maybe you just want list of strings, so I am open to discuss it - I
> don't understand the need for this property and commit and property
> description tell me nothing.
> 
> Really, this commit message is basically non-existing. It explains what
> it did and provides that much explanation WHY:
> 
> "- tmd-names (thermal mitigation device names)"
> 
> Really? This is the explanation why this change is being made, why this
> property is needed?
> 
> So sure, describe the problem being solved and WHY this problem is being
> solved that way. Maybe it will fit DT.

Ok, I understand

Let me try to clarify.

When the QMI TMD protocol is initialized, the list of available TMDs 
provided by the service is requested. They are identified by a *string* 
not a numerical id.

We can not assume the list is always in the same order because the QMI 
TMD is a separate subsystem and the interface is the protocol. The 
protocol does not refer to any TMD with an index but its name. 
Hardcoding an index here is not possible.

The name identifies the TMD we connect to and in return we receive a 
handler to use when sending the QMI messages.

That is for the driver part.

I understand for the DT, it is possible to not give the tmd-names 
because the it can go into the driver's data structure.

But the thermal framework won't be able to associate a cooling device 
(one TMD) with a thermal zone because the cooling mapping must point to 
a cooling device in the DT.

Initially, Gaurav sent a description where each TMD was a child node of 
the remote proc node. And you rightfully told us it is no longer the way 
to go as stated in the documentation. And you suggested to replace the 
child nodes with an array with the tmd-names and add an index in the 
cooling map pointing to this array.

The thermal framework has been extended to support this new format and 
associate the cooling device with the thermal zone. This change is now 
upstream for v7.2 [1]

The resulting implementation is the driver gets the tmd-names array 
property. For each name, it connects to the QMI TMD and register the 
cooling device with the index corresponding to the name position on the 
tmd-names array.

On the other side, the thermal framework parses the cooling-map, gets 
the index and do the association (binding).

The tmd-names array property replaces the child nodes and allows to do 
the mapping between the string based identifier with a numerical id.

I hope that clarifies the approach.

   -- Daniel

[1] 
https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/
