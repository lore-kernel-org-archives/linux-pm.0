Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9341BA9D
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013535; cv=none; b=I6X0mm49Ig0wCc33BWyJmbt8X3zWNsP6UfQ9Kei/BoBnl5znuGu+eWBgzGv9GnJn3i9U/PZGJ5yHAt5xY3ONkULzlJ5FDLzGT1dIG5rj8j6EzSDqQpWd3XHQvPJZiuFYrAnUbqBFphfUadk77XQYUOD6jMsNDWLPp32W53LdFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013535; c=relaxed/simple;
	bh=pG3nTZWIqo0Akp9Sulb7iX4hmqwWP/CuYA0lfOGOYc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXRMbkcjGBFB7gVsRV7NT1V/97WxQEWrsU72HjVpuyVF7bTHiiFdRrFgIuV11//H9U63x3xiDo72CHeIDGpH2arTDzyeewXzaWQuv4gsGBIOIJiQwDN90B1IKXunuaZp1iFBcXmAhNJYeiqAmVj2+NCwkYHhZCEajAxOtb7fawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TN7C9A2G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S9YQjjG8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TN7C9A2G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S9YQjjG8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nej71533992
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 10:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=; b=TN7C9A2Gfdz2+qXl
	YoG1tIrU+lOBQY3+H34BKsB7wR2D1n8tHybk7U4lRC2t6s9yqRnk4GY/HVLuPyq8
	UsVUYd/A3vnAmBHXNNSVk8k6gyds0Bfys+zhEI5ClLyFT098E7HoNRghTqahrzTR
	O9IEJV+ZnAvjgZcohuklwFylucH0+G22L9K74dcCdYUYzTRSQgapVrzEXOezGLn5
	c0WSkOYvUrA+IGWLOvJAfHJzPTGASSXSUmjzfppxNoz3l0NtJr72ZAWyQipeP86a
	0J5OEHPEaKYlGTqzuC1hhResJKntqWC1f70P4dmbJynfjjiDbhNsCfZQdeU2hFaa
	lz4+zA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvn8ps1jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 10:52:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso52527475ad.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013531; x=1786618331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=;
        b=S9YQjjG8mPyECB4ltcJeZyHH8WgVTNLtm3QydenKOEopxatmlMYnM1hpwfIh09TnsG
         bH/vVcDGGgsm+msdJrByJFdIvDAlSRymGm+ee84Ci3yGfNv6gmtotDe1eCE4cNoNg97/
         KPSMYSlWBpoBh+4hbLnsjQ2YV6J+xROvlxyodOgyPDgRJM+ga/NndY923eR8FuGvV9QR
         6OXCXdDp3ZQr2sbhtV/qY8IvenwCjKz6xlh4D0tDBqcweg8+fiMakPY46ZGEVbcVJxVy
         iBK31pbM7daDlbkGrBzTeNbUUPmI5j9IAOFznfN+ugiQIZ+J6YLC1Wa8G0dU/Lqk46X5
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013531; x=1786618331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=;
        b=NuoPeL72Bsj1PWkwc8AkSa/wIoStAiOY3kRGCZNKhW78OSUe+7xsuoCSVVe6k8PynL
         iZ9aHj7chq3RMvRil92IjuL/LWlqju99JPtUi7lKCCg2fotkb7ibnmXq/0t7co/IJYF/
         sTRRm8xSNm3Jp/mnAORsb6M5GFG3ggj7A3FALAX0dRsoNQa6+n9WUr46sWtJ+V9pxlCN
         nX0xxrQ47cWOipV//O93Ft1L4kMdHviUdOoP5tm1uuH2am2Mwg0aj++cmzkbPjkktQqv
         FbZnBejaXsXa43QDHUxlNy9nsAdA30UbZjMOCScBwAGyfWhSoMlwFpTNNtsZyMzDU13/
         Q8Sg==
X-Forwarded-Encrypted: i=1; AHgh+RrENHI/QQjfSMffndjMLiAj684AcBVcpk7HFu1l/qvcEnHGbMVNoUfMZJgZyPFK5UvWJPpYvdLnyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGymYGoR7VcImsPbM+5uQhtuLV8W+TdKrEuKW0t8TElKCmWwSn
	4t4eFJkqiI0mc4Z2Rn19o4LLXs/dSwRfSeWt7rDhezDTilCn3g4k3buMpR+puVdJai1sXQug4nn
	294w8M2MbsBY13C1BC/qhzjqfgamlshjU17njDOcUjFpQtUBC8/Xga/xp98C/HA==
X-Gm-Gg: AR+sD13z1sueCinp47nQEl2o2Dyp2sBOVCs3ljpWnuFhe6IUyfiBjLfclf0h0ahapBd
	6dhJpGvSKw4azmK4EJywYVCijOEyUzSkJtmwxqUalhlNArbi7a7AALvdcLzOINKWTISKJSkjuPf
	BSirHsIAyCm1NYDn3G/7sWg4VAa6i8QZSdBPILCq71aXKKzl4A8yWd3CUN4Pv0AILuidJkPZs1A
	tyaaF+o/FPvc0eyV0pn+PDAG1uQv9Yk5rsgUYvpnSXrRDyAkhZmDgjCuchs/ekW7QkS8+jGVCr2
	CgJdmh8FPzNYfc1Ml3ngyXBtmt9RCrCKrvx8ARJXwP2z+c3w+aQHk4ynt30f7Jy/DRW2LpfUMFH
	yGr3ACEGdCloaw9AD1LWrBu+C6e+P7lsa
X-Received: by 2002:a17:902:f546:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2d0ca77ece3mr148064435ad.14.1786013531421;
        Thu, 06 Aug 2026 03:52:11 -0700 (PDT)
X-Received: by 2002:a17:902:f546:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2d0ca77ece3mr148064125ad.14.1786013530978;
        Thu, 06 Aug 2026 03:52:10 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4930e1sm29469905ad.41.2026.08.06.03.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:52:10 -0700 (PDT)
Message-ID: <bc1096de-94c8-4713-88cb-5b9e96b5419b@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:22:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
 <20260803004940.0277c0ac@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260803004940.0277c0ac@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX1GUPCi2nWVkY
 6B+v6aiGEqEQzZHJRxtZkaPMM6jytda9nsAK+t2Pa8gTWdwNS4cccJZSTqbfYoDwA60glBg9MlG
 fuovU3rur3O2rJtLxHmB52uM1VDqGY4=
X-Authority-Analysis: v=2.4 cv=RPeD2Yi+ c=1 sm=1 tr=0 ts=6a74675c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IlOKGWYkYrl9SAkidhAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: VlfoJY0U6860JhBir5gKvNPnY2WtwqN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX4X+koD4SI2P1
 PmZCwUcLjkfcj93c0Pe3DIROHuwB0m06bsvYvI3K2+yvOqNw/blK0x8u1yo96iyu64CDPZFYHjE
 Dv4AG+HaVdiTrOLfq3mxTYu2eanz4Rmz7JbmT//9mFzP2OarXKgjrxzsbpe00UWhu+aGxdslHJt
 CuyXxhiNdNV4sN0xUFsvsT3eu2g5VIvV7tJgPLYSlgG+K/wvSiWc2pRE+GmgNdMlBbUXFk+/Wh9
 XASN8veuYc1lvtsEz8KDgH+nfMueNQL3PZIhTl6jtbV76qHwxQEMIogysGvy3WiP//oJ7qZTLjU
 OLibbzOuadoDvWerkR6CiZ4fbVw9oNK06/zLmuFIgQH8rpVhwCDDCBg9qksxWNfw6+ooXzpwWPi
 jpIPpnftfLrfJr/entyzKXBVQKplJmu6Wctmslphc3xM0vW5obC7Et4uAn/12GC0NYAH8ftIhSW
 7xZGC0Gqtd28RMduXgg==
X-Proofpoint-ORIG-GUID: VlfoJY0U6860JhBir5gKvNPnY2WtwqN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085

Hi Jonathan,

On 8/3/2026 5:19 AM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 23:36:14 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
>> improved performance, mostly at the hardware level. The main differences are
>> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
>> increased bit field width for PMIC SID (to allow communication with an
>> increased number of PMICs, supported on latest SoCs).
> 
> Hi Jishnu,
> 
> The mixed case is enough of a surprise (to me least) that I'd expect
> there to either be more discussion here or for it to be handled first
> as a dt binding patch to allow for v4 channels on v3 hardware.
> 

If I understand your comment correctly, you mean I should either add a
description of the mixed cases in the commit message, or split the
patch - one patch to add the new compatible and one to add the new
channel properties ?

I think it's slightly better to add details in the commit message
and keep the changes in a single patch. What do you think ?

Thanks,
Jishnu


> That would provide a place for a description of why that is necessary and
> then the following gen4 dt-bindings patch with gen3 channels would seem
> like a natural extension.
> 
> Other than that this seems fine to me.
> 
> Jonathan
> 
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
