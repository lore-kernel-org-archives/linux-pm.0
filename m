Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299033438A3
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779648293; cv=none; b=PmsqnJwspLxeuJW9esKOvJpNGOgFkvRxyt9Au5YgIRTmgoVKJ2SqiSYQYO7rBRzuXDAh6u65sTo6mmhmN6G/bJJ/RBmz4iWBgI8V3jIh9MLG16rWpD4Mumc6zkOpKsiiTY+yeUaBd0zVTX7CKkkWLWKxfI6WZJSefkS1Vdzhg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779648293; c=relaxed/simple;
	bh=HfPJ6WVT2txT3snCLHytxgQt6a74/qAqmSTcEbxxwpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shStwGX8FuHp6ERmSDLN1/rsKSQnqkZsGgruIskCrQBDAdgrBPrNUgy7/8G2PfcqyogkyXr0SsOIj1xW0AQQeOp/yQKSIZciSxziU2E1pAq1gXWAmwOS2c/ul6h2a12VeikJbIQhPDbIiLLK56k7CsFtO10uGls5p1xwD30nJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKReN7M5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXwtot7O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKReN7M5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXwtot7O"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OEEMEf723934
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4DTHtE1JKwREv05zt0FTUjVFjlnvXiHherii1MzyhU=; b=HKReN7M5un+B4Gm1
	POzvedoR5K4EqGYImuq6A0IJDwFGDeBm0DZw5YeL3OZvk3+9D7EDtZH35BPEjj7G
	rVIzylQC9FYDys1Zpbg5wPWeXu1NctbYMz7CKDXgpBqj1Kn+aJ2XCoXqTPgRfiUy
	vvddPgkzG86GitwOaA726bUangkLmnuyquoWvZaIkM+RCGVXQMPJ2w2q8sEdd+rc
	8IsfsoWl/xsx5XLpFsmYgX55YkOrxEqkcwIGfS3Lkt2Kq4xBtPL0ndMVdzXLDizo
	Hyn5uGFKnRwtLGgVjpe5Bd6c8uzB/nIhKEU4fsl5hr6e8+OH4akyP4LLE1LNJW//
	AHAbsw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w3a0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:44:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9b8137828so89870995ad.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779648291; x=1780253091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4DTHtE1JKwREv05zt0FTUjVFjlnvXiHherii1MzyhU=;
        b=NXwtot7O7xp7BrVa9pm/4sFNw8CERuc1kLUdrPR7/BiPVMfZ4Hp9jcWF/MtcKA/NII
         Y7X5AoqOPpd4ffiDL4nwr9X1ZiOAUxTTIwSRo1Rn3/891VZSvz1mauiYjeSY/elgkHVi
         tNnW0YpmZ+H2iLKLiVRu5fqvG8bWhI+G9Udd9xItdHlUz32ucwQ5bMOkNTpnIeuRq+H6
         VdFMxT2yNozOZuR/kTUoG5EO95xaF9WwgSJ77+oiyyGpsE//JmGl7BqBae+mSd0dE/Vk
         RQIaQOiIrt+JsfrjjZIigfD9asrKeYOSYbJYwNI7ZE4Se7KUsZflB6I2n5KZ094YDiGu
         ljmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779648291; x=1780253091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4DTHtE1JKwREv05zt0FTUjVFjlnvXiHherii1MzyhU=;
        b=JGnM2uhvV9n7T1uQwLdG84V/6RWOjROigTvCAKHqK+T/s0nnQHHWzqsem5NSuA6bLo
         51KJXjK6Y6PQKPhBKdGfU+ohBtZsIFciUmcZrw9AiXdMnpUHjxUtzKFna3YFWDoCSyuz
         IhlWhZI5++ghZqUQz72/idk0yebCZBRlmaVSxgdyysAwJf4UntJB0+c1+TE5S6ZwAIcd
         mEve4h91gkL6lUGWF4RvGmwkWrFyeVw2kA8tca5IWkGl2jix+DcoQSukB9iFOukLnsNi
         GdEOgNkEMpQ5i3i9jXT34m11M52LAp++Rq5Gqey8W7fpiLOSBiQy1QfQKOajUOcFaRj2
         7a1g==
X-Forwarded-Encrypted: i=1; AFNElJ86S2VcG8BEL2n7sl5WsrlgLzOP/UmzlGMMjHYghJk2ws10602jxpn+gvaneu206iopPrhEbQD99w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkbYVEiheXUKErcPX1twTVpqpPnYdO6jg9zM310XGW/DyKTab
	DCfhn371rh6iFBCta6sv7t7Mc25O4JaEMxkfqyFLrtiQx24F+tQ1hB583CPv9uESTBiu2SlzbCo
	i1ZltotlUhuqUcydv7zfXldkBiEQ2Bc1vf7U8ZoRFPE8T5e1h4VZ5mbYyN5rBUg==
X-Gm-Gg: Acq92OGH3Gt+VRTSp1GpVmr/PkMZnXQfhZ9sc3v3s3l9t2rKvSsvg6cXDbJ2Vw/Aydy
	qkVr7EPPpVULDC1X4wOBUzKi9yjr3++Y+5TCiB4ySMg4VZYDkPMkapcA5bzT/Mpm/mwc2TaH/SX
	s+7ocSsZshYlZoV5mqbQnzeSdYGU2+Bhpv187xKPN31jT42iAYh/ffhd8r1G1hu36ulWwsx3+Ak
	Jlugvw9xzeSrVNUiTiXVfxY1D/gzT3agXCbtZZ4PD40JbdoJxw7d7/A4GskRUpta+/bjAY+7ham
	tIQEElM6RRdh0I0vL+aq98QzQI3PnfaTdDzORxePcs65Zc6AqN0O2Q/8s/TkdWiH03oBcmE9ske
	FRLGEHBNWjZ2iYZo1tQ6OVSUOM0lihP+gTvpSBgWs9VNp39ZqiSKTDeiltTWrAhvy5/sZZwibdw
	==
X-Received: by 2002:a17:903:3c0c:b0:2bd:612b:912d with SMTP id d9443c01a7336-2beb05e2d23mr121490645ad.14.1779648290701;
        Sun, 24 May 2026 11:44:50 -0700 (PDT)
X-Received: by 2002:a17:903:3c0c:b0:2bd:612b:912d with SMTP id d9443c01a7336-2beb05e2d23mr121490445ad.14.1779648290191;
        Sun, 24 May 2026 11:44:50 -0700 (PDT)
Received: from [192.168.29.125] ([49.43.232.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56e090fsm80802325ad.34.2026.05.24.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 11:44:49 -0700 (PDT)
Message-ID: <07a55b72-eeac-4a38-b226-df8836faa145@oss.qualcomm.com>
Date: Mon, 25 May 2026 00:14:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh: add
 clocks property to enable QoS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-1-bcc2afe4cc78@oss.qualcomm.com>
 <20260423-thick-beneficial-capuchin-e4aaad@quoll>
 <99830e85-5837-4ed5-8f89-fea5d3e632f8@kernel.org>
 <c583a03f-381d-4af9-acb0-ac47a1e35b47@kernel.org>
 <7oador7jxw443astffc6hjuf3gots64fqmvsjdsshfhhonc2l7@2unu723p2orx>
 <12e149c4-60f9-4ffb-b066-7611bdd15786@kernel.org>
 <nr62mvz6qrpb6moqyasniqcqtfltsx4qtr3lteeixwutindqri@5joujdvn4r3q>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <nr62mvz6qrpb6moqyasniqcqtfltsx4qtr3lteeixwutindqri@5joujdvn4r3q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a134723 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Np7tGMHckr7TqWT9mUvMjQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Qe6B47XUAAAA:8 a=EUspDBNiAAAA:8 a=9WfpK7l04UvUAjPDmO8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=QWPKR-PWjQKaio0naagv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE4OCBTYWx0ZWRfX2l5CFtMHeA5n
 vgRJ4Zw2D57LE6YqO74NxdE8Pic4XDtvXAvPFv/6cVW+/ePz0y12eT/CvXQxcAZZ+6FB051KhvL
 zsDSlq6oJmO7+StoqsKryv/+imrIW1lBBLMqiwivSxvXlyb5SrqUP5Zz3rUv/1fUbKsEwkxIL/6
 u9cNbBP/iFBmFFOFdb7vGDK4ap9ajNAtyFKEMB1bz7Q7QxUQkhncq0/LbV3eeaDCDURYtSbkgjH
 yor+OdwVdg4cWFAhAx9hH9/3HJIHecIxQSXbFTJihDqDaN60gr4hiDGSNPJXSfan7W3ZgGGjTey
 Tov1UDZ/oDDW3Rx6jsYLA608k1AYutT70W54fm7x5ILRQ9RiOPS2zagYXTXCfwqQoBzwBmJTki9
 6e+nsY/4duNCxQxtD85jZoNRYjSDQvDVNpRvGV86yFwkzDFkvu/ZXnEZC1gKEGi2nPgQIzn1+Ly
 pGFvyASa9am/Xk5vzRw==
X-Proofpoint-ORIG-GUID: 2m9CoUgrYtpHWnUfU3AKBee9Tp05LSIT
X-Proofpoint-GUID: 2m9CoUgrYtpHWnUfU3AKBee9Tp05LSIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240188



On 5/21/2026 5:26 AM, Dmitry Baryshkov wrote:
> On Wed, May 20, 2026 at 09:33:52PM +0200, Krzysztof Kozlowski wrote:
>> On 20/05/2026 21:27, Dmitry Baryshkov wrote:
>>> On Wed, May 20, 2026 at 10:11:47PM +0300, Georgi Djakov wrote:
>>>> On 5/20/26 9:51 PM, Krzysztof Kozlowski wrote:
>>>>> On 23/04/2026 10:38, Krzysztof Kozlowski wrote:
>>>>>> On Wed, Apr 22, 2026 at 02:05:11AM +0000, Raviteja Laggyshetty wrote:
>>>>>>> Some interconnect nodes on X1E80100 have QoS registers located inside
>>>>>>> a block whose interface is clock-gated. For those nodes, driver
>>>>>>> must enable the corresponding clock(s) before accessing the
>>>>>>> registers. Add the 'clocks' property so the driver can obtain
>>>>>>> and enable the required clock(s).
>>>>>>>
>>>>>>> Only interconnects that have clock-gated QoS register interface
>>>>>>> use this property; it is not applicable to all interconnect nodes.
>>>>>>>
>>>>>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>   .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 62 ++++++++++++++++++++++
>>>>>>>   1 file changed, 62 insertions(+)
>>>>>>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>>
>>>>> And unreviewed as it breaks users:
>>>>> https://krzk.eu/#/builders/102/builds/70/steps/23/logs/warnings__3_
>>>>>
>>>>
>>>> I will just drop these patches for now, i have put them in a separate branch anyway.
>>>
>>> I think, dropping 'required' clause would be the easiest fix. Or just
>>> wait for Bjorn to pick up the DT changes.
>>
>> Could be, initially I thought this is actual impact on users, but indeed
>> now I recall that driver prints "info" message and continues. So the
>> binding is not correct.
> 
> I'd say, the binding was not correct: the hardware has the clocks and
> the requires them to function completely correctly. I think, the problem
> is that we allowed incomplete drivers and incomplete bindings (Without
> QoS support).
> 

Thanks for pointing this out, and sorry for the breakage caused.

This is one of the earlier targets where interconnect support was
upstreamed without QoS support. Making the `clocks` property required broke
existing DTs for that target, if the corresponding DT changes are not 
picked.

For newer targets, this should not be an issue as QoS support is introduced
along with interconnect.

I will respin the patch following commit  
e07f3b8c9e1c ("dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks 
property to enable QoS"),  
keeping the QoS-related clocks optional to maintain backward compatibility.

Thanks,
Raviteja.
