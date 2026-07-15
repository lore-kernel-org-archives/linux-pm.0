Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B5437860
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111268; cv=none; b=P4uPuZtR3P8uh1dtigAWjzVRvF4rDIrBtgYSGIhhGX6N7CxE7LTbWGv+QviowMM9IaAyO6yQrYaCZUQQa8MYty53immqVIStWLq5sID5V774DtiVQoLxQEIxevv0JBNVXZMQBbbTs+toD63VbA3NUDSk9b9YB8CfKYxTVKWHKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111268; c=relaxed/simple;
	bh=F9j0xQ3mrNQ20w5XTBZ6u3V6/dJHSyjNscaZuGoSW/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fyfuh8fJgytc+G5PI4g41ATxyFWeP/d0G661WqJtDmKZFtvmJC5KSuOAf09lWUyCKRHFob2Voo6odWSX194QPnRng/wJUildp93nVblyCgU8Hcd0CaruBhejUPlXrnjumEHJii/k8QfV2m0+9T/jRLCvG9pOSwBggaIPl6k9T7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWCjg+gj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdI/apA2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWCjg+gj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdI/apA2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F7maeT3143188
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 10:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FqeWffSaD4dQlURL8TfYn7r46vLJtQDYSCX+eoewaBY=; b=KWCjg+gjcu6CWjMb
	3QQpD6/Dp2o4S1N/JPnG/LpoQKCwZq6/wSZcSBshBYshjyD43TQNyRvumDBI3N62
	cJTjwLIgc4ZTASmzpl+fH+HnS+6c7eVSbjNDDN79eMx4tlEdwPk7eBWBzhkswSsq
	Et1HjxwOG8vY//643EyhrDMHKOFl6WOfDeHewneAeLYDH/bHOVb2MXWrbW5oee/8
	C0IWlKUSmWaTsKvixA582spiQjO4mjNJGu0/KYQgb1Umqzorj1fA/fHVGt3yIw3j
	jNuUO4PHesWUGJATWyXolyQtEBAMX5s1WLXRXS8fnkEufxjU6kHrSpxyuDn8Pvsj
	aYMwnw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe6528kc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 10:27:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51cab6f7517so7799631cf.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784111264; x=1784716064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqeWffSaD4dQlURL8TfYn7r46vLJtQDYSCX+eoewaBY=;
        b=OdI/apA29vs+fhjpWNtERnxEPN0lB5yavgftg1YnADITBbA/GiJjzbd3DZBR7dprhq
         BAEOse1NAaQbN0BZmfaby9C4jGNJ+W5dqwaPW1y/wUar9S0WoJxTR+iirWMrnkvBOGuF
         q+soVoKw8uD/UXivvKJziZ34uXYgZKVY/1BMCQRP5+cJ2386AXGUGO6bFrrooO5QCPX3
         iFLXl5cORC9u8BE7Iew/01832+d7n08TQ8OqY4GyBglFm1gCXaWPUa45S2HealYWCn6L
         TJWZu5DNu+0kchxVUYA9uAOeemrqMPLi3QMOiZhelkDnu/k4EAmuIu3eA6E06L2G0XPW
         tOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111264; x=1784716064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqeWffSaD4dQlURL8TfYn7r46vLJtQDYSCX+eoewaBY=;
        b=OTiY6i8l1LHfHiNe9edVjNSRqR4cGyJll6ONez+At87ElvUtDlbdqVArusxMH4XAye
         BudFuU4XZ2jKWXpOjUpDyJd9N2STYyf9xIHdbdd6VUsQqTnnuTC5DsCc+mDp4nydg2h9
         MmJoXXn+2jtGKJ4C7VihQcTzqsPBO2DFL2ZZuo6fmP0iXuW0M/rjYEfF63N7KDnCW497
         BR1FZ9ID9suQGLNHgdsB64Y6yJnDFJpkl4wvHJEWBx6yc9F/BKJwGOi0yvg+FFL1UGg9
         IWbfpkPc5WwndKZO2DDAyX3FpSV8N2A5nNVeNVz5VoNDpw+QiCxtEv7m40VEEqRSpTlO
         QIfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpB3xMsiwuAVjvoZoXyhe6Y0a2iy+MfAaAXB2d1qIQsO3eV7sFW0Mh6AJmkBSHVmVRX0FZjUVrCBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrWB4IdJtq8QvzpLVri9hJjOr/VH0YB1KxH1iV0R2PdjUWwX4
	NvzpMtkmL/FPrOaPULve9Azdz7EBuKq+vKGWHyk1a/4xteMUPrKPL5u/TDqHLVjJ5N4Bv/RgzhY
	M81ghqWjqOZUMiIz/0o56wx0H/U+9urjhWhnS+QCL5JD2Iy17kcRGPB9NaKzKTQY+3T/qiA==
X-Gm-Gg: AfdE7clCG93TPw1tpOV7i0dE29rssGklZvgqRux4K6EcSfY9u/RqF6xId1AnuHzImxR
	GywGgrMTXlz3TnjjuBefPfBekyjziAyRDm5ydFL+Cv4NE4FvoZrl0qjKep69PjFae5RzvVeMEXI
	84xMRDMFt8lzXQxLxIV5xN1eEf+pL8rLYnmoABdxPxogIce3WNKbjvXXLbJFiMV86FppwWQPl4j
	jyG0UJhfokt9gmBYd/G7RV2sidLQ6uRqYnwT6dttAz1wBqXy0UeLfVOmV4De/d68J+fLvqZso2O
	kXb8ThfHVM19xLanef02uWJfag/TgjxwexQSH1+3nTPgcyjvucw69BWRZjJthcC9EcR5roCBLHX
	YVsNSf3N6Mr8W9hNv4Tgip9VE+l/O8SMMVGE=
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51cbf289286mr138516541cf.9.1784111264319;
        Wed, 15 Jul 2026 03:27:44 -0700 (PDT)
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51cbf289286mr138516331cf.9.1784111263944;
        Wed, 15 Jul 2026 03:27:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15cfac0f76sm1117074266b.33.2026.07.15.03.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 03:27:42 -0700 (PDT)
Message-ID: <986da1da-db2e-4d4a-b9d0-70482adaf4bd@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 12:27:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
 <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
 <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEwMSBTYWx0ZWRfX5e65oj3USGRb
 HBav9hLygLDtumY79OQn6dq/TIAa1O6OxJPEYJjtBfCrrR6EOI6HoKf86XKMbsO4Rh1Vxl0HcIm
 xXzvKSBWv5rGjM9rqokuCuXEtqIAalnBpBqHxIy4c1PCvs4wBbQKpMU7qXEn5zQWaSxH+INJHAL
 WKhKcpr8XHJhvPFy/jOohm/usOFKgJl4STPc835nCbDR/C1egpXvl3hW44e+7mPuRWbWPRZxUjm
 sNk076J/Vc3Dg+QR2gJalZVn8SBLYuJrzIyVvKZJ6qFZS9gGztV5buQ2VjMwd6F73KW++KKAgD2
 tc8YvswWh8bKbEaxm0CBNuLipwfUuJ3iE4jkn4fr62L4fTvBcM6XRpZtODbkUC1ktvT4dqQU3wF
 CCOIzE5t2efbyiKkVZW6oL65ZjVY7LFH+4Hj87FTivwsmvzovMCXSm0JxIbZ57x+oqK4IL4+Abg
 1Qfvx49TU2IpVvAwDOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEwMSBTYWx0ZWRfXwzWgesOIlXcb
 1Nf00HHfjlGc6C7aAq3xr4PNvNHhCWebXZrT2g6b0qmThiDHPMapc3FuxO5WkM5n2nUvC+Ln/PQ
 gPVjpvQTVaFjRsrt2Erx3NDXF6AKwew=
X-Authority-Analysis: v=2.4 cv=bKcm5v+Z c=1 sm=1 tr=0 ts=6a5760a1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bddrti4C3Ac78WpyR4IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: I27OUsTe2M_vOY05mkFqLmi6g9A9LQ6S
X-Proofpoint-GUID: I27OUsTe2M_vOY05mkFqLmi6g9A9LQ6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150101

On 7/7/26 6:36 PM, Komal Bajaj wrote:
> On 7/2/2026 4:25 PM, Konrad Dybcio wrote:
>> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>>> Add gpio-reserved-ranges property to the tlmm node for all three
>>> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
>>> SoC internally and not available for general use.
>> These are generally added to prevent non-secure access upon TLMM
>> probe, i.e. the board won't boot if some of them are not protected.
>>
>> I assume the proposed set contains both ones that are _absolutely
>> forbidden_ for Linux to touch, but also ones that are dedicated to
>> some specific purpose that Linux _shouldn't_ touch.
> 
> Yes, some GPIOs are reserved for secure-world use and are therefore not accessible from the non-secure world.
> I will update the commit message accordingly.

I'm not sure how to read your response. In other words - is this
patch boot-critical?

Konrad
