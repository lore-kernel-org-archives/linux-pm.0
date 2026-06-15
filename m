Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7830B535
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519701; cv=none; b=IcxqyMaxzObZvuJH4VP8DFTz3RsjVgP/ftsaJ0GYLV2HUTpPYJhrK6nJU0gl5/tmmR2VM6v4aaITCeTdmPEsZ3wCb3EJjVGo1mvajS4FoAZbSgK1aqy6y2m5MjeKaohtznybYmeCvV2YjneK6gd5RRlDPd1KGVeBSomQkrbPP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519701; c=relaxed/simple;
	bh=ypBctaFL7zGGiToTo8r9a8VYheJSEu0MfATFvA99hvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gn7GXvk/lyN5QTF4WoVwg37HOxa/OD0oObfYIZraxc6x13cyF8hiqxR3jQZ4NGsSJ/RSnx0+jf1wjSf5WxYWyEOH4vD0RqCANvbukwlxGuF7BHKShI5VzBt7Q6IsikfDNMz+l4LMVAL4lXxRaw1V7TtPvN545AzueY45YDYg8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3TC/Ii7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcisMqyn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3TC/Ii7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcisMqyn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAIfYY3885511
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 10:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hVyefM75Zw370S/eMkrghTpPTfewflO0/F6QE0G56A0=; b=n3TC/Ii7lkQow8q3
	/MnBEYSCoIk5ZB8W7nj47y9dD2AqiGDhaoGGnYMzvGAgDAclQAc8Ks6B1TqIxoXQ
	4WbYSH9gqlVST0nsnPVWsQ29Kdpw0Hm9ZBsmJ1UDqUN/kSQW6hyaMoY9lZzTs5fZ
	dz3+2uiyQd4iPoQR6Lm/5ahnl274jejy5LdduoJv2RgfwHQzrFG8+d6DzAXmbAkV
	pyp52ZCO0w1WsYk9Sboh3lF3Dl12xNNKahwYOcnmaDkCeih5NVzfnP6wbF+ftTca
	UysG6XKo+rVLcl6YludvRrDi1BxP9jTTWXJ3J2iqsBEzT7L6o81gblS3HJ9KodSB
	D6q9ZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter008ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 10:35:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157de5360fso770958385a.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781519699; x=1782124499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVyefM75Zw370S/eMkrghTpPTfewflO0/F6QE0G56A0=;
        b=hcisMqynZRxwMHGUXMEjWxdlXr5d0I/hWK92VUipHqexp4gbZ5TfZQYVTwrBWKTwPV
         RVf9EB7lQ/eNjYFfNUdSQHr/S7pplLRElb8wYusamonAQvSwNdvy0pCVCDEVZ+E70HFz
         y+Q+aUQ1+GmQLhOWQmI1f0qE+jWHguwLSCe1NqBxHrgKr+k6ZLVlmcrOz/1DTO3HCqWR
         7i92S57ukNWrCwLP1YUc7Y4UhMLxpLDRBHGHqty64TXX9FR8ZZuLhGKGEsGBDEy2aC7M
         zM4sj1sqTrwSNnkvNsBg11bFtNmb1iKc1rpE5t6pX6QZ0oru9XSYOlIyShJUcHEkkxJt
         eDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781519699; x=1782124499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVyefM75Zw370S/eMkrghTpPTfewflO0/F6QE0G56A0=;
        b=ELDxzKGhKzXZZn3SnTeHsTW+hW5f4jRIRhMUUu8b/QtH6ve0qb5cTTcChkkOKXQn1+
         bHE4qroEOQbeAgWX70taTtRz+cS5wp/3CoCURJPvDv+r7n+jrm2GnejY3naEZlgClKGD
         2DvYYJi1FF/X3VewhTHWDrKFdXdAb2jzak8u0VKWItbyVH8HppToklt0nKDqO0gApum0
         65ADu95b9bAnDjAyIs7tSKY5UUKXD2sPknDvr+89gjTnpNL0D6KJQVPys5LKJXMxxEc0
         lXb6EilQXnKqML7mCNFKVNhmlI9nwwmjACs15w+JQ1QOcKrQdVUxhFUVuM3bBI9FwhLi
         yA/w==
X-Forwarded-Encrypted: i=1; AFNElJ8F9J7agX+mEAWow/RczDD8iQEDXOSytszwDp3KW3HPwicFuuTHQO2Mhz7S0m11wr/8kZ3H+Ewi3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyphPyyzAz+hjjULZ8EjzEruw7JSfv7gGkFkbaJQNbLoqreOv60
	13LPO8qCQVK7NzBe1cGvdKOYHarhfc5PLLoyK9cWjOqbWkDDLUIxKuT0ntdb9IpfDyvlXYon84q
	rQ145F+b7M8QnjQSWvvBNlvL5RlFiphnmKFEmmJbtrVwc1hFckYtpqxXVE8yp2w==
X-Gm-Gg: Acq92OE8WggNdGwR5szrr0SOVoI4zfY1imZca65yGSHJLSxqmE8ItONU9rjjrRcWWvE
	G16JooCV4BbG8Pz94T1Uvldf8kCRoLT1jEq1cfVbVD8lo8etromzDiKokbpRe/qm+dDW4N0k9Mh
	bNLi8V2SaTvxhK/O8u7ycOGTXl5doj0uN4l/6k9BHKfAYYI64MDpizjN0AXDjRugWlk8s6N9QI8
	XTTlQRVuUfpGUNrjMAaYTpTg5FevDucCBCpHHC6VFzHt7WpnVIe0tNKy+tEZ2usJxc7jH9+mQcA
	VWQ8TnNlACVWzQlTar72jL6D65A/tdQqeE4IDfizYen5XFZDqKpwjEXWJtQ7R6kfNMU6rA9AQn0
	4JB5EskNFWbyHbKoHuoNcMaHTjDMRD086aDfkDVgmGXSCFkeAsgE8RCO/wmjl3+xIJWzcvp2Cic
	bnGl+6voV4
X-Received: by 2002:a05:620a:2894:b0:914:bdfa:c782 with SMTP id af79cd13be357-91619f2bf0dmr1784333285a.29.1781519699024;
        Mon, 15 Jun 2026 03:34:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2894:b0:914:bdfa:c782 with SMTP id af79cd13be357-91619f2bf0dmr1784331785a.29.1781519698620;
        Mon, 15 Jun 2026 03:34:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:766f:2395:dbef:b08d? ([2a05:6e02:1041:c10:766f:2395:dbef:b08d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263923sm33671703f8f.2.2026.06.15.03.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 03:34:57 -0700 (PDT)
Message-ID: <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:34:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 040ODCsbY_BOjUJKOnpG1CHBzYG6UVoO
X-Proofpoint-GUID: 040ODCsbY_BOjUJKOnpG1CHBzYG6UVoO
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a2fd554 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=zPFEeeBhd_1xptEjU_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX4Q0P+Nee0adH
 EO71lgNWe8GxETXAx2NJoFp1BMLymfcY81Ej+8kLdcmNr1O38MR0EU/nP6pyluRS7qQRU+wliMf
 uijy8J/oHTJIR8UUVBqdzHWGgQWmdaJMxmacakzFd1Ju+w8MX6laMPb9a544mlB8+cErg5DXOpD
 rxVCCe1mb1PT9iN/o2jUq2DCQGMZ4ntfmfNyaxMgy/8BIuQ/dQhKtfH28J7RylvKtR47Y+V/WTz
 QwqHUrNA2b5gcgxURE71Aq8+d6juVGgw17oK4I6+QwIptTtlmGa4++RZmSHAix8bp6horsMmPNG
 lJiEux79ju99SxXIAi63VDeAxOGQmqkN0U97EZCvzSD1xfZCTLXojjoxyYLyeBGr7052mIMBm0i
 0TdtpndA2SGLHzn1bChZZSxfuZT5AcfeK3fgFDt8Tj3/rsFN38naw6e0x/1TT78L/RiaOmAcyhD
 11ziUCodpuk9O3dXvgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX3h/tXM5qLdVi
 aPMQlNkG0Mg9hQ4KXAwtNkP3UCgsu9SKoXPQFLZMZJiL0vE/8pCS3DI2F/gb64b0Y5drLEAhxBy
 m6R2RsCvejlJR36Hinpi/g/d1ka4crw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150111

On 6/13/26 13:05, Gaurav Kohli wrote:
> 
> 
> On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
>> On 12/06/2026 15:52, Gaurav Kohli wrote:
>>>
>>>
>>> On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
>>>> On 11/06/2026 13:12, Gaurav Kohli wrote:
>>>>>> Why? And where is this generic property defined? You cannot just
>>>>>> sprinkle generic properties in random bindings.
>>>>>>
>>>>>
>>>>> Ack, will add why part.
>>>>> These names are matched with the thermal mitigation device identifiers
>>>>> populated by remote firmware over QMI and define mitigation devices 
>>>>> are
>>>>> exposed as cooling devices.
>>>>
>>>> No, -names correspond to values passed via DT, not some remote 
>>>> firmware.
>>>> The remote firmware should give you interface which is explicit and 
>>>> does
>>>> not need such properties.
>>>
>>> thanks Krzysztof for review, We need tmd-names because of following 
>>> reasons:
>>>
>>> Following Daniel's series [1], the thermal framework supports
>>> mapping multiple cooling devices per remoteproc/device via indexed
>>> cooling-cells.
>>>
>>> 1) The thermal framework's cooling-maps reference
>>> cooling devices by index (for #cooling-cells = <3>). Without tmd-names,
>>> there's no way to know which index corresponds to which TMD, as firmware
>>> may return tmd-names in any order.
>>>
>>> below are the changes post new thermal mapping changes:
>>> DT: tmd-names = "cdsp_sw", "xyz";
>>> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
>>> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
>>
>> names property are not to instruct drivers to register or not to
>> register something.
>>
>> I don't understand the problem and explanation in the binding is
>> basically non-existing.
>>
>> Remember that all lists and indices ARE FIXED, so driver knows exactly
>> which index means what.
>>
> 
> thanks for review, shall i use driver data, which is basically pas data 
> structure like below:
> 
> static const struct qcom_pas_data {
>      .crash_reason_smem = 601,
>      .firmware_name = "cdsp.mdt",
>      .tmd_names = (const char *[]){"xyz", NULL},
>      .num_tmds = 1,
> 
> Is something like above acceptable? and this will also help to filter 
> tmd names as well?


How the thermal framework will bind the thermal zone with the TMD ? 
(node pointer, id) ?

