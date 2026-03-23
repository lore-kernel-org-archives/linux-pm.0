Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DC38C41B
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262200; cv=none; b=JvbUsonxbYIQO1Le6y5oS78q48D+7ja2DNZJcVObGjlGHhEKUbKAz9ZR7WMgb31Si4oVRpawyKGByYc3E1lq4XrLz5WzI5UgBPjmp7Y6D4RMIpoxMcSDsCaXzoj3ZkNBMDzGN+KDUbBtVZPxDos1X2nT5nI46urqEhg5JH5iEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262200; c=relaxed/simple;
	bh=qntGGfYTPatDR7BRqAfkoZdSaFO/huuLIiwXWRDHbWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=issV2CDStwsvYuZYL9+0Eq4AsrDhxjwE3QTpwuobY6kuU68xHGMWz4ZtzjPfZQIGizrs5DRv17YgegQKOWiGaShBbETqFPZOHJ1fsWg6Ko4WB2p0k/0W8NjWCfEanaIkafdgzsHMy+5Bf0xHNt63wDBREiQrn0FU41VLruKaTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X8dDE2zo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEdQCvSx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X8dDE2zo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEdQCvSx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N83wfC1364358
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlwHQJjOtdbVfaEECfF81aOlln6ZwpshefwMCiiKZ9o=; b=X8dDE2zoPImUp++N
	nZTZ1XUMV/7/k3hqVu+s3ZfOZuEJyWMp6+CU+ljpzYsjg3Rdkk4tDm/GJ3X2V71g
	rI2jWwwaItsbOkhuF2zHcObnOzEGDf/KhxkZHYtBU2b0AjOciqhsRFLMhJWlTMSk
	FInHVzbCrq86cCLyH5lgCMQBVyrs/tedY7OZx1awGQmV5vj34u+/F+sgpjKME8p/
	sJcN+DdQL36jrQNMFqOXrZ6lNxTqCbTgBuhbV+jXIB2GEdXlDgJqe/3Daa2gdun8
	THY1S+DMVnug4L2YouIYzK4awQRauMBdeCS+mSYpN9vL+5+/gZZ6BCaJOAdeo8J9
	k2SpuQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p78jrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50943e69b08so33916011cf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262196; x=1774866996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlwHQJjOtdbVfaEECfF81aOlln6ZwpshefwMCiiKZ9o=;
        b=GEdQCvSxPTI6aG/tI23yxIHjf7zNv6Hzu1JF6lSMof7ApE1tPK3Z24NyHfkXIzyZuJ
         Gn9yCMIgBA1gcnA3OsUPldrE7Dsak3om9S8Z/W1Ia7HsiWjEc6Heh03KyGWBeW5MA+Us
         k8BeVHN1jfLHneKcZmqiepjRqFhNWjwwAn8vcJP81pUd/kW4qF+xjPhdZvPwDMAO915z
         PnfKXIwBffnzdYp+Ooa21aKJjKnbsszzl+eQary2WcoVrcmxhAzbysEfLt2AcuQYbmjO
         JwYHRalL/eBrScmrjJJM/JgOviSxZxIajqv9GKj6KObKpnvEKawguQZ7CVdrUnSiPy6Z
         LgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262196; x=1774866996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlwHQJjOtdbVfaEECfF81aOlln6ZwpshefwMCiiKZ9o=;
        b=njtUJbN7e1J1ZUU9GzxYtnYjUOeP/iSazI0vywVkYMTZyL1WvqWDVNRWdJ9+RKIVFB
         hKwqXIS6flaInMI6blUxKpCpiZDWu6dswu8vSLEJQ5DFVaxdSHzKSefUGAH4jmdCySPS
         jKAQihMy92zVyGAuJ51aiCAecw6XRm+A9rPP19vV6Er+NbG7eND88+JkUULrc4F7GgLg
         V8zxs8EvFYkKg+63DwgSbo3NDiQorHuqXPbx+jBx/B1lQuIECobmaNUXMlr78O+C2rnf
         lhA/RE6FvFL7eCWdf+FHyVNcGZySpJwAHgQg+2v4aD08YBtzGKwehCSUhK8M8c+e1XfG
         qFOA==
X-Forwarded-Encrypted: i=1; AJvYcCWNeuSF/DZ/h0v7pNi35BRsuSuSIq8Ly8/Enn1ugr3eMLRozVp+Bx4LveAwFkkORFGC9KXY8lOM6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RVLfPDOvDy2Rs7bK2CAVlqYhMo0i1Sx10CYQgDfO64qUOKpj
	FMF0JJX39SEI5z75QFFfxJB8s5xOD9dv5Tg9l+ChtBDXB0bfxVyHf4ia6njiwmbozeQ/NuCspR8
	yWy7bpNDvgz3ceArwPiWS96oj/NYVEZUglEHyZz0F0OM5kl2Taw8L66StCm6EOg==
X-Gm-Gg: ATEYQzwuU4yEZawrgrH3RF0TuFUfq4wvk6tMfA/Igy1HXqzSwP3Yru3+mBD15DaxVdq
	DoXMIrHmAYP02fc/7b/YSdQQ43gEvaFfE+m44Kxu2fcSpzB3g7fjmfujA5PALdBWntb4r99psnA
	/ZvI781S279Z8tOCbl8WCLDojdvIADGmdsiUCLjxjDPhN27/z3KkzGHsy3n0vGpnl5H7rEcQ2i+
	odiBm+qysT6VnsZ9vV55673QQusP1Y/7fHbGFbLjbPI5uobzg5XFqdLikEowqYiX02T1y4RioCJ
	2/DYuhgxKw4WHpKQttcsbnQXiwn8bgvde0SpKhrxWJrAOY43R0BbKuczYaN0ctbwPJzCSLuzsAU
	+avFulhs0Su0DLDaWGAVF82Ws7uM/U5RYLU4KTCVpuuOnD355H3deou8Kfe23lEEerhTS5b4eGi
	NWZgE=
X-Received: by 2002:a05:622a:46:b0:509:2a92:8088 with SMTP id d75a77b69052e-50b373d0bfbmr148047501cf.1.1774262196013;
        Mon, 23 Mar 2026 03:36:36 -0700 (PDT)
X-Received: by 2002:a05:622a:46:b0:509:2a92:8088 with SMTP id d75a77b69052e-50b373d0bfbmr148047201cf.1.1774262195624;
        Mon, 23 Mar 2026 03:36:35 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8da12sm479371066b.21.2026.03.23.03.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:36:34 -0700 (PDT)
Message-ID: <eba921cc-c63a-4c40-8c0f-f969da67509b@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] interconnect: qcom: let platforms declare their
 bugginess
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-6-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-6-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c117b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gOZSry-tN7A4fIUc0b8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: HXiJVkiTUEXbBslXf_7VetpoucX7vpDC
X-Proofpoint-GUID: HXiJVkiTUEXbBslXf_7VetpoucX7vpDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX9tFEF6o+Dcmv
 6gRlpekKVmkTyn3+RbpKl5Mex3zj3TSHYbzn4J8gQuAh4x9VMAgFyYcVTLVuV5CahDLYZyGIGCF
 3+Q/X2C+OWO+TQ5PS2RONBvtbajnZjf96jcK8rsdP/1AK4HAM33wovB+NAtfHz8GxtszVxjw56f
 vUU2hNv3uNOlUPPTfvMz0w47PLtoSu6013XW4sZdQCfHTFVvVV/h61mJ3m9HRkqXiesvukjMh02
 cC4RV2DDV8OuI4aGJJh6l3p1QsWYA8ttyNTupy3+ToEmQ/2fBMKcrxsd+VB02dU27k5U1KUVNgm
 DKJbeSAIN49Sz7JaLg1K6gTFNORt3eZl0pwQ6UHGAH7yEeCfW4bFPgkSeRWmWkglzQa3xVJSCe9
 XwIq0lR1upzPyIdJNQVo+bzZJ71qdG1qpi7R1YsJkEVcRD07j79FFogrfzsQIZjgUCaX4ByGB6J
 ooc/PkvBFzwKmiIuIEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> On MSM8974 programming some of the RPM resources results in the
> "resource does not exist" messages from the firmware. This occurs even
> with the downstream bus driver, which happily ignores the errors. My
> assumption is that these resources existed in the earlier firmware
> revisions but were later switched to be programmed differently (for the
> later platforms corresponding nodes use qos.ap_owned, which prevents
> those resources from being programmed.
> 
> In preparation for conversion of the MSM8974 driver (which doesn't have
> QoS code yet) to the main icc-rpm set of helpers, let the driver declare
> that those -ENXIO errors must be ignored (for now). Later, when the QoS
> programming is sorted out (and more interconnects are added to the DT),
> this quirk might be removed.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Not super happy about this, but since it's transitional:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
