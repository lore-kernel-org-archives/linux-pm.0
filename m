Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDE40912B
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616527; cv=none; b=dbidDwkKRE+aTt1BsQGISGX9pEe/S0VbPWwa47roeykkb7UXgBJRGdYiPlZ+E6sDKbLbKmhIVXhZjN4DYt7D1fi6OV95jeATX8tvglVj37hJXOvyTNQ13J3OdeQFv8x+RG2YozgZ5g1kAL5q/jJhg254S2kOKeW0XI56eSXbjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616527; c=relaxed/simple;
	bh=z+bkjq8XsnBjqfaHbLzS3rge7dPv6GGX6S9Z7FP/uck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxGh/RpjxsZPGuDKijoNKX0wFZd7RzSEcwMAimwR/owHSWfJuzwjn6gif3tjvLF0EDLzek+V8WX+Car8YzYmLKeoart8nHJy8aurabXugcU0tSYwwrjonLTuTdXlM4JYW+4exnC62fDQYkhIiUMjV1bv4mO5QJom0IBLEZk97ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPZO01kW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LrJb3ylC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPZO01kW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrJb3ylC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L2nDIl043322
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdMp5QIbHvBUMT7DRnUAlf+M7XjnZBgSQoeTMzQIRys=; b=WPZO01kW8hcpWvqy
	POAKaAD38+WQT6dYcD63KRfdRZlurtb2lGiKxgrmAEhDyd4TqiRuy0AwSYYJ3hfl
	sYCyj0ug7oMoyjYzip142j61MJzZLd2hmyk6J/WaTRx0VTwGeEmzFFMLopS3EC39
	numGkTcs1BZTx2VGi8zONM7VLjL+ixtfhaxQN6uKz4gYZUlTjUX6k4+9D8ls1Z4d
	ury0w8orS4ZO+IivmwfiDTBLaQ9TrdpJWhmONWlZ1JMCrkkiSX/wiQOkDT3pqJqK
	wMwCUoYfg2CpAGFeMK9jxB+On58b3XWcafip+ADZDLXJHL/qgvO6Or2f5rE0WwBm
	88WbLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as0w7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:48:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so169461495ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784616525; x=1785221325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdMp5QIbHvBUMT7DRnUAlf+M7XjnZBgSQoeTMzQIRys=;
        b=LrJb3ylCooaXmv/mhWVnY/hKa+bCx5uiX0AW3+0FUiMBJX6rHZi7tgRk8pBw3Q2jQN
         7Ps441SLwTCcDtwWTjG9v3lSrFaEmPTohB2PjfMChHjoG4Br+5RBBbFlj15Wws4d0y2M
         zweS1i/xPEoOcyGXT0C7AxBhzOoWQvKqFd0MLTn9aUkgFgV+L3ZecGOlAS+DQVyt/dWo
         2LEsNYoNhEgaf0B7jCtHEE5TKDzhkLrRXCPmt+r4PeBp1dAWYGOxk+d7VBN/GaFGmSjd
         enAMA+PE3Xktj1dfdYWgf/9qOL/DNzF/JY9U5GUPgZXM7k8sWN3g0wLq1HGziJhzbVA3
         YG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616525; x=1785221325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdMp5QIbHvBUMT7DRnUAlf+M7XjnZBgSQoeTMzQIRys=;
        b=RSL2sh1KvB0KHfwI3ZP4JHzrXq4kHHU0nUMx3FnKAyHUiT0KwxZwkQATKCZ8ozNySC
         NNa06LYUIzy2bI4J0We8koDdTiyraT2empanEFpYblfhkMt8tVzkEo/Qc1uSy+73VovA
         E4Ehfw/yRcg4kciwogfNFWaBoQmAkH/SEY+sUuek1PsUBHClyqBRaCdJmZP6gVCieqCe
         7ac5IbMsKK1E6hUygd0Snz5d6xPMJ36czfRlpR5J3Dhjbsqv079WHnxnk0v4GfTxFN3i
         Giu9g248fspVFVm5dfQQDyrPFpnst+GoEi7N82IK3kErLw3PoeDmeiuz0jeA2oU9BCq7
         AbEg==
X-Forwarded-Encrypted: i=1; AHgh+RrR67Pk/FziZHPw5e8z04iGop5p7rO1CnANXmGC4B1hHPG3Jz1EARO3qyEw6K/zDBoztzlWfaSBMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmkhr/XH1XVv6l1xXwa7KcLvpl7h60zgTxqRGBQ676tCVO1JIJ
	/YFU+9rF3h05ny0mGw4osT02JH8lsdSZmn+Or9ffuh86774dewLZFnSBtdhHPAmIz1xKJCrKvdZ
	vSoXXNTyerra3qo5Dzr3O6Dq7IQIeYESiT6taHI1/xqj/sjSF8FdloFJdZCukbg==
X-Gm-Gg: AR+sD10C/HkWCI0wDgkL8KXbP7t53X3agymeFeDhd7uELNoFqt5MtWXdWnukTzvm7AJ
	olHrlFyitYr1UO4aU9HVWzWdLslwmEzNlc1CJpuRQjDyHywSW7dlGm+t42RrCUxFqopL0lC1rf+
	bkiHrhh0tzdjVih5NOXxVHNBIuPPlAErt4crvSxuSjUq43b6++z1jiE1dEgwN1CahdpyHIt4ZIs
	N8elZTpLMIH9afmADVZu+jvJ9R02vqY1h9M2QJ9HXIrwymLt615L63NGBDS6jrVtubnSybKOl1+
	SrBL8SDNPXGoCh9iOXtDgIh9RtH60svjOq9Y/K2/SRmV6mYRGyAARprpHPNFPDHZxUhb3lw639+
	y1NvlHb4FpaN6rE4cOcIya5/wUbwtRxU=
X-Received: by 2002:a17:903:166e:b0:2ca:ea56:7a58 with SMTP id d9443c01a7336-2cf34a49553mr189544495ad.37.1784616524754;
        Mon, 20 Jul 2026 23:48:44 -0700 (PDT)
X-Received: by 2002:a17:903:166e:b0:2ca:ea56:7a58 with SMTP id d9443c01a7336-2cf34a49553mr189544055ad.37.1784616524256;
        Mon, 20 Jul 2026 23:48:44 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34769bd6sm69948485ad.74.2026.07.20.23.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 23:48:42 -0700 (PDT)
Message-ID: <ffe1524e-6dfd-4394-a5e7-c9090dadc582@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:18:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2OSBTYWx0ZWRfX4OJbsJPA8Fkk
 X+fmRqBGw9wH2DTCwqQzUdXZc+S5hBhaU7j2vzU+lcR2BmL1BWkiSzM9HzQuj27HKf7O/8V/HCe
 45f7rGWrW9cGDNaBtC5qoMdBsOSDdwSQQhr7RCUpC8LnKj1JsWiLKUR0nGRvIIq1IY9yPN2FF51
 tfSQsoIr1EIIGBpyNL8N7DAjdPkjoH89uDzPD2xr5/hEC2okMj0UrqUwqLeyogMri2fO0GSSGKM
 p1B4IcJxAHXr3orZOpqDGsuN2HO7z0TxLDFcw+DBrphLzrI52RmnPpFDilye1avhJkS5OK1q6J5
 O/qplFl8lM0JSyzApEe2D0mydz+JsTTxy1Jal0wWVq/qFl8gnFr3LoBol30IHnX4mQLIIbm/xSm
 ItrOiWZA4B8WCwcwaKW5YgSYvANtZXBc/OueUOkkuJb7hsNQtFZUox57o9pQOnqOisJRm5SchF7
 4nz56zWZ5sJHPp3jz/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2OSBTYWx0ZWRfX0b7462uDk7o7
 T73DOPAXw0LHXjHUDS/TDjC+U10TBPjBvirOAiQLDpfmqYA3mVh2FJTT4npIYWwVMM9Ubfh9iKu
 I7H2DcN9AujkzwHmFPO8aTSdQb4oBW8=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f164d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=YHEYuCYylZzveZTXVIMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: GCVcpzBaXnJlW1TGv_g-eEX2HAV9nTWH
X-Proofpoint-ORIG-GUID: GCVcpzBaXnJlW1TGv_g-eEX2HAV9nTWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210069



On 7/9/2026 1:53 PM, Daniel Lezcano wrote:
> 
> 
> Le 09/07/2026 à 09:58, Dmitry Baryshkov a écrit :
>> On Thu, Jul 09, 2026 at 09:42:04AM +0200, Daniel Lezcano wrote:
>>>
>>>
>>> Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
>>>> On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
>>>>>
>>>>>
>>>>> On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>>>>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>>>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal 
>>>>>>>>>>>>>>> Mitigation
>>>>>>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal 
>>>>>>>>>>>>>>> cooling devices.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Qualcomm remote processors expose thermal mitigation 
>>>>>>>>>>>>>>> endpoints
>>>>>>>>>>>>>>> through QMI. These endpoints can be registered with the 
>>>>>>>>>>>>>>> thermal
>>>>>>>>>>>>>>> framework via the `#cooling-cells` property on the 
>>>>>>>>>>>>>>> remoteproc node.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The QMI TMD protocol identifies devices using string 
>>>>>>>>>>>>>>> names (for example,
>>>>>>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling- 
>>>>>>>>>>>>>>> device binding with
>>>>>>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the 
>>>>>>>>>>>>>>> form:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>          <&phandle device_id min_state max_state>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Define common TMD device index constants shared across 
>>>>>>>>>>>>>>> currently
>>>>>>>>>>>>>>> supported platforms. If a future target requires a 
>>>>>>>>>>>>>>> different mapping,
>>>>>>>>>>>>>>> additional target-specific constants can be introduced 
>>>>>>>>>>>>>>> while preserving
>>>>>>>>>>>>>>> existing DT ABI.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>>>>
>>>>>>>>> [ ... ]
>>>>>>>>>
>>>>>>>>>>>> Why are you using only those TMD devices?
>>>>>>>>>>>>
>>>>>>>>>>>>> More constants can be added as needed.
>>>>>>>>>>>>
>>>>>>>>>>>> Kodiak is one of the supported platforms.
>>>>>>>>>>>
>>>>>>>>>>> What would be the benefit of having more than thirteen 
>>>>>>>>>>> cooling devices
>>>>>>>>>>> declared in the thermal framework and having only a couple of 
>>>>>>>>>>> them mapped in
>>>>>>>>>>> a thermal zone ?
>>>>>>>>>>>
>>>>>>>>>>> I agree there are more TMDs but if they are unused for the 
>>>>>>>>>>> moment, why do we
>>>>>>>>>>> need to add them ? Can we do that incrementally ?
>>>>>>>>>>
>>>>>>>>>> That's what I am trying to understand: why the implementation 
>>>>>>>>>> uses only
>>>>>>>>>> the selected two devices, if the modem on Kodiak supports 
>>>>>>>>>> others. How
>>>>>>>>>> can we find out, which TMDs to use on other devices.
>>>>>>>>>
>>>>>>>>> My understanding is that is an initial thermal setup. Gaurav 
>>>>>>>>> will add them
>>>>>>>>> step by step while setting up all the thermal zones instead of 
>>>>>>>>> sending a big
>>>>>>>>> patchset. And TBH, that will be much easier to review.
>>>>>>>>
>>>>>>>> In such a case it should be noted in the commit message and/or 
>>>>>>>> cover
>>>>>>>> letter.
>>>>>>>
>>>>>>> Thanks for the review/guidance. Not all TMD endpoints are 
>>>>>>> relevant for
>>>>>>> kernel thermal zone binding — some like BCL and cold temperature 
>>>>>>> are handled
>>>>>>> from userspace when needed. The constants here cover only
>>>>>>
>>>>>> What if there is no userspace? Or the userspace is different from 
>>>>>> what
>>>>>> you expect? I doubt we have TMD-speaking userspace yet.
>>>>>
>>>>> Thanks for mail, The TMD userspace implementation is available 
>>>>> upstream at
>>>>> https://github.com/qualcomm/qmi-framework.
>>>>
>>>> Is it?
>>>>
>>>> lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
>>>> lumag@rohan:/tmp/qmi-framework$
>>>>
>>>> I found no traces of TMD there. Moreover, I don't see why QMI framework
>>>> implementation would react to thermal events.
>>>>
>>>>>>> what is needed for modem and CDSP thermal zones on the currently 
>>>>>>> posted
>>>>>>> targets.
>>>>>>
>>>>>> Again, SLPI, ADSP?
>>>>>
>>>>> Sorry, I should have said "generic subsystems" rather than listing 
>>>>> specific
>>>>> ones. SLPI and ADSP do not require active thermal mitigation on these
>>>>> platforms.
>>>>
>>>> Could you please provide details, then. What is cpuv_restriction_cold
>>>> TMD?
>>>
>>> It warms up the zone when the temperature is too cold
>>
>> So, if we ever get back to supporting warming up, these TMDs would
>> become relevant. Am I right?
> Probably
> 
> Can we do some progress with these TMDs definition ?
> 
> Spending 95% of the effort to discuss 1% of the proposed changes, which 
> is always DT discussion, is quite frustrating :/
> 
> You want to add all defines for existing TMDs for all platforms ?
> 
> We are talking about numerical values right ? Why is it a problem to add 
> their define later ?

Sent a new version. Added a note in the cover letter clarifying that 
only kernel-managed TMDs are included in the DT binding. Please review.
> 

