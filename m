Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EB3F12C8
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585421; cv=none; b=Usn5GbXdg0UqsnB4k1wcqXD2woiXvfEqyrVX5Xf1Nz+BbWY9rmQtUpc2x1D2WTHC6pWryyUMH1PVCIYfoYHre1zVb0rEAxq6ITyH7RdfawHjiSh6U98z5PP+P4JUC3mc9125zBqTgMsoZCrt7sSAeVYYRKTJxEx1X5zgSTmgF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585421; c=relaxed/simple;
	bh=134ufy4mmxPCaUX9tTVJwnO59LWqPJlkTcKMtmq1QQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDXwIZOkXXj34uYrBVCvasqdo2E7fOLDTtdhQx9kLk7fBwvGGEIXngLgMydU16BoQSLUlMezHhpGzmD9IEIqwyBwOogZeT1laKW+H/WBfoSJMKQtr9gJCEMviAPhxhdIuuUepXUDLZYakBq5N93YDQ2wcT2obKn3n+LYYM5aOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5QQpBeM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqWWVSN6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5QQpBeM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqWWVSN6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66961AVk933399
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 08:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=; b=b5QQpBeM9t+6pFMc
	74J69gGJ5C6ePwsMhBgzHybMrF6+CZlYJeQCb+LIMdwOW89DvfzyKssSObFeTHZe
	iz9Pz36OJ2gW/iyD8sMnzXmXQKgZxmr1nDUuUUQIwy2qOqowYOl1dQGATRl8hFCn
	ECKAh8soYT2mLC6Crcs/ZvscSUVQiDgexHoXvKEjop5ov48ihHpLx0Tu7RLWFJXn
	kuzLy7Jgz8E3AXwo8HvHsaFDB/qX2tlYv1j+8cFXyUjRkbvHi/8qYJBz/fjITbMN
	B54rgKNi3NyLvsiKOFRISAcPd1CQbcpivJ/UM2ux/Kt/OPXLceeCH4c+AzN0z9Mq
	3ov5nA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6jpb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 08:23:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so8368881cf.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783585417; x=1784190217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=;
        b=dqWWVSN6qsAGtuU3wlOCYIlFhGGc3zigUpmOLFJy7rioZrxavvbAEy2//ZRG0/ykz5
         pRDKYe/7uNidxWzid2ZyFPdnubYAKLd/ERHBXuPS9ZFv4pgsA4JCDR/5CiEI5GsWu4Da
         AZgcQZXmvEMmYYMhRxWfpysIk9OAaFTtiw9JhCu26NqAY8tQcMRrmOI4iP76PZ288ewZ
         K4spfXJtyrRVHABJQbMJCiHtXRV/jVA4FgbwhLFJUMJ5uNbHRWHaqATeLHK/jslnfrsl
         M7G1CFYxCfPA9Q6RX1Za9YLJV3/hnZ0NYp31OA2a12d2CX6pmh7xlLfWH/sFS3RJLk09
         q9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585417; x=1784190217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=em6hRThTjmpK+umvlO1H6MSd9jDxUbf1zD7dWYPZFpQ=;
        b=It1HaJ2cLhSKIueqIVNL3vWxaH4zqhu34F4rryHU0kLeR1tZn3j8qNbx+UkXYh5h1v
         b2YOiIUJyQjZm/V1SGN6n/eHF51P8Tmeh7S+Q1tKYrcF6LYiidJ2z03xclyNPRobZ4jx
         VjVZRa6iD+AZX+VreHyfg8uj6BSQgvIfsNTBqSI5BColm/YHiQ4dTdw/jD8S/5bzKu7H
         +GqDUhDQ+J99PdyzD31Ul1lv5k/Lmjd/t3QaSOEWFAtzhOJKWEPXr+dGdWh/d3jLEFj7
         ElSbw2b87+e2383QVoKOcYN8MINbs+1fAUUfW0KvD+9qoYWgaltCh7DERqZ9HKFoOnKI
         1sMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6YDP1MIxbakPzth9hr1DzuVBrYcWYuYz6k9c2xnhLEoG6a2wNCJYIVI3XjZpUgU4jIwxkaBFwLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RjBsvwaVM76ZGRaqql2vb70JryB45DVv2zgh/sR67NOAqKyo
	LW5o5zG6O7aDQmy7jBHoH6tYq7+wKFKl/jehXB99az4LcPjPM6ulAcjO3h2/DclLvADNGjSvFAZ
	hAXVNMgNEejA727dqMw7gi36UI/aQ2zlIyWbancVdTpXOsh1vfLrk7rJ1GBxK2Q==
X-Gm-Gg: AfdE7cn+TajUJQp9VSylfo9feqvhEAJN7ABItgpB3OE6aZ3RRqjbVZlk/l84ZqKTWUg
	60lsmn5kh2yVVcB54wQWxGA0AWlLTJPmR1LmBgPPzjBfiFv5rt3kgDXSzRCBdNWrtzJwVD/6+Rl
	2x/lAYT7XAuPDJi4gL2i66AeqwNAjzu/Gh2NCCO1WXC9+/XPpCC6QTw2PFMGrGRBukF6TvDPe0n
	lxB/NPId3Db8D3CQAEtIXUYwr5etc47+fLEQ3Ssxn2GLFNRJ+nbPgpCZyxQp4Ve66MvDMApeD7r
	kyEk4jPgeVNshPafqpdvg6sWbQocizQozeeEF3yeLNp+4fxMBvRAm/+F/H5547QJADrz1R00gAR
	ueAEXsmjrnw51Z7tD+6iBd8Zc9Wm705i3imFVecdZL+Gp
X-Received: by 2002:a05:622a:2282:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c8b2df9a9mr62944431cf.31.1783585409816;
        Thu, 09 Jul 2026 01:23:29 -0700 (PDT)
X-Received: by 2002:a05:622a:2282:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c8b2df9a9mr62944101cf.31.1783585409169;
        Thu, 09 Jul 2026 01:23:29 -0700 (PDT)
Received: from [10.111.138.111] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c1470325sm288040366b.14.2026.07.09.01.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:23:28 -0700 (PDT)
Message-ID: <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 10:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
References: <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
 <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
 <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3OSBTYWx0ZWRfX1lylF6XRRxre
 bufPYYtseHJUZqNCljFkNBIj4BKWKp1i0l6Gy0U4cyRzgeNa0MYDi/pPvuzEP6hyUPtZ91fPgIJ
 Tb4mWvrme6bsW8RehA0OJtYvzHkGBIU=
X-Proofpoint-GUID: aQQ5acLPyhfxQlAS_rPu0f5vwXxFpeT1
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f5a89 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ftX-3Su0G3PhC2htbk0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: aQQ5acLPyhfxQlAS_rPu0f5vwXxFpeT1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3OSBTYWx0ZWRfX4h58KHfE2TsP
 PCl8dXVb3O+Jv73vH3wcWaupSsOBrYKZ6EdjjnGKOqLOvz7IIONWufR03+xhakodlzkSNu/NAfG
 dK5OcCvtyQ6c4gh8wf4otB7ilTzO8AlGkz9oGGmU2aG0Sp5YulMIYHKDESGjBijVrxm9QzRdT80
 QLXkdHOTjw3OkpcnVkPgVw1NSak5u3xca1CEPXL8Z0DpXp3VXzf5XzZqeXN+IHNpxzwzAmdK3PS
 6NCkGcfyj+FKmuj26NVR19H0dRcaWh/oX+oF2TxAjhcfYk3E7uqQmHXU8FUuZe89voLlfc0P+5g
 xw+XvPdpjzDZRGheOjqXKy+ermPenk//BMBRzc/A8JBILZ34IGntXP2XI8ceAj2PPnYiVuORAWd
 +ZpGbFOVc8QGGJ3qbHUWAJQ9dtM7mC/TNs7xzvRpmMsWs8RAMLOX6iuIeF09YsMjTrHNTjyOTTR
 ycQsCGtXfu2W0nGa/lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090079



Le 09/07/2026 à 09:58, Dmitry Baryshkov a écrit :
> On Thu, Jul 09, 2026 at 09:42:04AM +0200, Daniel Lezcano wrote:
>>
>>
>> Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
>>> On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
>>>>
>>>>
>>>> On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>>>>>
>>>>>>
>>>>>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>>>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>>>>>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>>>>>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>          <&phandle device_id min_state max_state>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Define common TMD device index constants shared across currently
>>>>>>>>>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>>>>>>>>>> additional target-specific constants can be introduced while preserving
>>>>>>>>>>>>>> existing DT ABI.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> [ ... ]
>>>>>>>>
>>>>>>>>>>> Why are you using only those TMD devices?
>>>>>>>>>>>
>>>>>>>>>>>> More constants can be added as needed.
>>>>>>>>>>>
>>>>>>>>>>> Kodiak is one of the supported platforms.
>>>>>>>>>>
>>>>>>>>>> What would be the benefit of having more than thirteen cooling devices
>>>>>>>>>> declared in the thermal framework and having only a couple of them mapped in
>>>>>>>>>> a thermal zone ?
>>>>>>>>>>
>>>>>>>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>>>>>>>> need to add them ? Can we do that incrementally ?
>>>>>>>>>
>>>>>>>>> That's what I am trying to understand: why the implementation uses only
>>>>>>>>> the selected two devices, if the modem on Kodiak supports others. How
>>>>>>>>> can we find out, which TMDs to use on other devices.
>>>>>>>>
>>>>>>>> My understanding is that is an initial thermal setup. Gaurav will add them
>>>>>>>> step by step while setting up all the thermal zones instead of sending a big
>>>>>>>> patchset. And TBH, that will be much easier to review.
>>>>>>>
>>>>>>> In such a case it should be noted in the commit message and/or cover
>>>>>>> letter.
>>>>>>
>>>>>> Thanks for the review/guidance. Not all TMD endpoints are relevant for
>>>>>> kernel thermal zone binding — some like BCL and cold temperature are handled
>>>>>> from userspace when needed. The constants here cover only
>>>>>
>>>>> What if there is no userspace? Or the userspace is different from what
>>>>> you expect? I doubt we have TMD-speaking userspace yet.
>>>>
>>>> Thanks for mail, The TMD userspace implementation is available upstream at
>>>> https://github.com/qualcomm/qmi-framework.
>>>
>>> Is it?
>>>
>>> lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
>>> lumag@rohan:/tmp/qmi-framework$
>>>
>>> I found no traces of TMD there. Moreover, I don't see why QMI framework
>>> implementation would react to thermal events.
>>>
>>>>>> what is needed for modem and CDSP thermal zones on the currently posted
>>>>>> targets.
>>>>>
>>>>> Again, SLPI, ADSP?
>>>>
>>>> Sorry, I should have said "generic subsystems" rather than listing specific
>>>> ones. SLPI and ADSP do not require active thermal mitigation on these
>>>> platforms.
>>>
>>> Could you please provide details, then. What is cpuv_restriction_cold
>>> TMD?
>>
>> It warms up the zone when the temperature is too cold
> 
> So, if we ever get back to supporting warming up, these TMDs would
> become relevant. Am I right?
Probably

Can we do some progress with these TMDs definition ?

Spending 95% of the effort to discuss 1% of the proposed changes, which 
is always DT discussion, is quite frustrating :/

You want to add all defines for existing TMDs for all platforms ?

We are talking about numerical values right ? Why is it a problem to add 
their define later ?

