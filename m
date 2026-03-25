Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422163C3456
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435965; cv=none; b=G2SS797x9iwI8nhoVnSBNxjcN0F4OFxyLh//BOo82n0cynDLhkyP98WGuuqbl4oMvky+GUinuXSgyvGQTcUq3IzaE2+MGF56BtD+u0nWad7c6y77PBJ7cYylRhERtRPLfKOtXw66jfxlm9tDH5Bb/heXyQn2ttsi1cjz3nYZqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435965; c=relaxed/simple;
	bh=wmuaaOg4CnipIOHEA8jDhmtHGu0mwlaisEtJOq8v8NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgIyvvpSlhkmPowNSyKp3edQ5uV19DtcZBtH1Hnw0AHuDKVgyGztWm+3IChWkuX8+vaQoJgQi2UWgRrk7vsEvXENsgxqubfxelZqakltDtxwjiXWpUO6KzKkMZA3znPnChIaxB0PCyMidx7VfnuAO6KfbQ/YfANewBkHwVoCz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMzm6wiL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KeLH0kb5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMzm6wiL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KeLH0kb5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAfe8N3110448
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 10:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ReUMwUL96j+Y3C2vukr2YAZoWKe15yppO5rPQ/p+//s=; b=AMzm6wiL8DM3Up0O
	qBvKg1SclfNHoaAw42n+6CIiEfrcO7OifTXUnvdYPxA2bbyQ7XQnJ9nzL4TAXmtH
	SwJLoQhgtGfF16vK62QTY44w1+TE1B91aQ9H46Ij7DmJLxz7zO9O1fwXBG7x/g/m
	tCrt4D4sGCxpce3yqAVaavvl0sm1desidvqrziOMLiwVRMZBGGRZhmG6bsv8C8xU
	txN7MpBR1uR+Bknn/Op9EZPQ5b3GX1HZ9nsXLIZnh24OVSah5LCZIAERtzYI0Kf8
	b7jb9bm996i1mjH7Z0hwh2TnZLw7kV6jVsR0XbodtQZu/BuR16DUhG+OqYELUbzx
	aAONrw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvv2q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 10:52:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b2d5e61f6so36289291cf.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774435962; x=1775040762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReUMwUL96j+Y3C2vukr2YAZoWKe15yppO5rPQ/p+//s=;
        b=KeLH0kb5F7b4ojksy5iZHlK75E+4MO4Xv9PznDSyJ64j5YAnIvt2KjO9JimdT1+KNF
         OVvNSjnl0PQDYK0riLUe0ESwXM5k09vDWIUNfn/Hoi/jzMDWqhtBbP/p8GgUEXf/ETZS
         wPe9nB0/wTippH+sLi9bH7bNEpRS17dDiYVtmMbeOaWaDaIfJE+3iq5+TsxVquMypeI7
         doCUShyjsoX3VCUCd0r53s7yMLHCJ3sJuxwffAMpA2UOuER4ZbMm4oUetzUwdJCOoBuL
         QBYOH7+KmijpNqaBwqtNZ5KqP3vlPyGSaFeJAD55HkP8kWOrHVO7mpzMq6Q3yiGjReJ1
         tOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435962; x=1775040762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReUMwUL96j+Y3C2vukr2YAZoWKe15yppO5rPQ/p+//s=;
        b=qQrKIiTDFROj7WXt+5EBQtEmW3PiZUomLGWVFZ9wCf27jzH0V+qiejheHwq4IkxSCI
         2m5pPMqN6nIoQ/QTGXTUn6wbodJJBeaX93+wdpoxYHj2MIkVSMxTfrzfYPITGiDV8Yt0
         NrGkRMeeMMQ5Djs/rnBVIbIp4IsTJoCnxQzDAsDRP9Pi2dmdqOvf7uPevfb+V4pmOlyD
         g28WG5yqSVrb/YqAHnO3ii2Tb7pARGO+qDYgGvIi0S7liaojr6Dn/5heMI003zaKugdy
         11HhMPefg669ZkjoniMLrES7n11r0qQcSYGygHiz8FFWvETFOneIZMDOD874oqltMuyZ
         fCUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJfjDwQl1vWJlHr3e0yO6gPoQ+peEyJCwUVorwsRp02c4eYX8GxotcBmCMjr+M03IdEQ4yHezOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0htR/moFci3XHcwthtU5yaohEq4C/2D23uM801Ph6BYTdvfT
	mVPlCPIySPTpeIc66FSliCZqlIxPp7dEC2Ynuw9dE8dTbeTYr97p5p/E3H273DlfbzVEUA9PMd5
	ycDhp1BXeTnyJ8Uo0050oNkAH52Q3Hf0ObHvAAzO2OpqUe5uRtd5cuVYnOv+riE1vAGSXyA==
X-Gm-Gg: ATEYQzzgIO9j016VN/TWweuASy4ClcsKHdj3DVQF+tjzRGze/kRs7+Vt3yZkVaDghhZ
	LdzSJfr/bp6Y0tnyBWbjxDoYG50udQhd/ECu9KgmtOoCYfWhIAVYBGmwxnSeNx/F5HJzO3B7LZy
	heViRaBxScxLRgHpACPAluprCpgXKRN0z4b+0tWcDnPVbMI32DZOkC1lRyLMpKwz/EGjfqnmJMh
	wmox0tjNDNRXzSIAWP1iR0SCua26MzTqJlkzSVGGkN6qtrMwoote/grC8jPe6Q0EUorxhyx/L5y
	cfHjVku6/SN6YthFW7VCyqyD6ATjzPHCWfSLY3/FP9+2SICS/yTrwHHm5/+LjbCHQTc+mPeHD3k
	OuwW2w05B/KAPTTPMhsF5/i4aQJHfOLL4Yb+zdvO8kBYgNj4Lm45LIfhCRQ3+GEJMCiEHEeUsQ4
	4OJrY=
X-Received: by 2002:a05:622a:5287:b0:501:4767:a6f with SMTP id d75a77b69052e-50b80cdd452mr29777801cf.3.1774435962618;
        Wed, 25 Mar 2026 03:52:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5287:b0:501:4767:a6f with SMTP id d75a77b69052e-50b80cdd452mr29777441cf.3.1774435962183;
        Wed, 25 Mar 2026 03:52:42 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b133e0796sm56053666b.16.2026.03.25.03.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:52:41 -0700 (PDT)
Message-ID: <da741f9e-d5ff-45d2-9b1e-7f15f71352a8@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:52:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] interconnect: qcom: let platforms declare their
 bugginess
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
 <20260324-msm8974-icc-v2-6-527280043ad8@oss.qualcomm.com>
 <DHB05UJMTAVN.17X2QI6XGHB37@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DHB05UJMTAVN.17X2QI6XGHB37@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3NyBTYWx0ZWRfXz9rE/R8IC+Y2
 6Hlq4rRxZw+C35PwY2119MkAP+onC98YGuFYEm1hCxTr6kLCHgMKTtr0rRpAdwGcqjyeaFvsRuU
 wdEC8J5Q3y6anGUie9625QcA4YIOK1Q6UleK5rBUaWZpyGfnmdXhEFdSWMxzMmcSPIDhuMyuBMq
 xisNzKcVuKBi7v/35AicAF35kjjZcfAiEfCjzvZuugbxw3fwk5VIxJNl6BJvSmGxa+C2BgUNQCs
 qRH6WS62aNoe0ZivJfFY2KDJbnBwpNt2r93PVrw1qFl74iS+Qi6mSQJBF24qBl3ePk/oDZWpqq5
 NCPImfb2UxrcO0NCng+NhIKYtjLo2yn04cCBFE7i5SPk1soRTE6QaMqqeJBwLQLf3QK7V+NFSA9
 iCxN4zqHQDu5KwbHuTeJOMu/xlinMQJpTQQOfOxBj9kNTWgTZqK99GLdFRFM1jpvCbaCkqQtp2O
 oZEGJQHmUHJybyG4KhQ==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c3be7b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Oh2cFVv5AAAA:8 a=m7pxcdcc42vr7exHiogA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: 9Cl2JKlV8N7Qt0iR2xKuEyE4B3haEhrY
X-Proofpoint-GUID: 9Cl2JKlV8N7Qt0iR2xKuEyE4B3haEhrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250077

On 3/24/26 1:14 PM, Luca Weiss wrote:
> On Tue Mar 24, 2026 at 1:10 AM CET, Dmitry Baryshkov wrote:
>> On MSM8974 programming some of the RPM resources results in the
>> "resource does not exist" messages from the firmware. This occurs even
>> with the downstream bus driver, which happily ignores the errors. My
>> assumption is that these resources existed in the earlier firmware
>> revisions but were later switched to be programmed differently (for the
>> later platforms corresponding nodes use qos.ap_owned, which prevents
>> those resources from being programmed.
>>
>> In preparation for conversion of the MSM8974 driver (which doesn't have
>> QoS code yet) to the main icc-rpm set of helpers, let the driver declare
>> that those -ENXIO errors must be ignored (for now). Later, when the QoS
>> programming is sorted out (and more interconnects are added to the DT),
>> this quirk might be removed.
> 
> For reference, these are the errors I see on fairphone-fp2
> 
> [    5.534806] qcom_icc_rpm_smd_send mas 8 error -6
> [    5.535010] qcom_icc_rpm_smd_send mas 8 error -6
> [    5.535218] qcom_icc_rpm_smd_send slv 16 error -6
> [    5.535445] qcom_icc_rpm_smd_send slv 16 error -6

I only checked these two, but 8994 (basically largely reused design
thought) sets them as AP owned intentionally

https://android.googlesource.com/kernel/msm/+/android-msm-angler-3.10-nougat/arch/arm/boot/dts/qcom/msm8994-bus.dtsi

so I suppose the fix is to simply denote all of them as such and go on
with our life!

Konrad

