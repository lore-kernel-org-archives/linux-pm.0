Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5C32BF44
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345235; cv=none; b=hZlgD1tZo6E9TTdlDhJlLASu8M4R0MdRs2Nh/An66VD+vmwq0g4bq7kSOAEQbu9a1CMWcgs67qDu+nGKi9YcAkNxdYRLq/YJonmzMWn5FGmt6j1FYm2OJurxwjE50eFBKhSgNcaaPZo4DlOCdV27pkY+ToqLD1QaL4jPsX5IPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345235; c=relaxed/simple;
	bh=65+84FKK55nWe7pFtqs85t3HhlQue1yLXCBU5vFyvII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cD2ksGTiBaqp0u3CH2aqX/cci1pOr+9aC77xOQOjUU0G3E02BXL2t8xMgbAppeOQqQ90I4Ckmm0YUAs9O6vinYAAR4kc3SNVegtIeC8yoc4WQuBfd5w3ugmG9NTHmVIhBwF5drS2gGGTM9uajuddOEFEtry2F4OZ4ywgJxnFIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ya4/iyvf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6DW52jb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ya4/iyvf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6DW52jb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3WYIk3904064
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKZ/0jdHWPOzXjhGz03vG7vP8pzgEzFlOIlA4ymjKmE=; b=Ya4/iyvfq4eqdjgA
	K+AQq+gbsXd9/wQZy/yYI+qU0P2v7HC3+7OLjWxVqvZTUM50aOySZydTbpOCjhmR
	elWiWERKOGDdKlrmxy43Mo5DNc/v89xD2A2d0acvEYKddfaCczYXCL9PEJ0J4qPY
	80GXkbPFdoKhsdbjNmy1H4QNprNND0iNbmi4/qdZXZAP6r5n1V402Cey2ofGvnAi
	30IGp7PjXQY1TIwJdX0yDwky8L47zzv/cWCp0F+Z+nCVVhllbwb7M3y7ZY778tJN
	aDKJzoMbl7+aWpTuNzmy79zCz/x5yjVzgaD2pOvBGbSzZeps90OPxDwfkljvO/R6
	/jClZA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0h86a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89c5014e220so39227576d6.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774345232; x=1774950032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKZ/0jdHWPOzXjhGz03vG7vP8pzgEzFlOIlA4ymjKmE=;
        b=G6DW52jbXz994xP4onNoMOio9wbJZsxdV+qQSozrUWaup06hSJA7kbNt13pVeNfvQ2
         VdWw+OkoDcui4lK/AiJVQtcW1EFE/eAyxKe2sKLvj3lN1D+u5XPxNFF4TJcqM9HjNqjy
         dSJLf+LjdwO3r9Z4mumsrwqVSuHPcMTdNRMwTfy8NPYnABTwbcN+A4j+KbWtcqPgQ7AE
         T2AI6qqWZqD/Al+x3JwZB0aye8U0eEhHvUYKTuP3Fw9/ChKpzKVVu2VV4G8TCgxcsx1D
         p/BxQV0KoqwpncbZs4En6+HU0hCk1vBs3toNlse47EZQD/s0/ZZSknFlosYb0tbzbsmV
         6HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345232; x=1774950032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKZ/0jdHWPOzXjhGz03vG7vP8pzgEzFlOIlA4ymjKmE=;
        b=bysr8SfTFctY00lzrqJXtWS8BLQ3Kb30AWU4YvaMekir+EgECYQ1JCHLYRRVWfKm2f
         QzfwlqH6kofgWUxiWubPn5GZJCLvtvk7wsLScHc1KH30vaNVQP+9VSFLOq3VvYRgbkL0
         a3Z5/GKBLeOLvpuJ0ZtNjlkLUiGdvJs1sUSVUFisVVPxyVKJmZwg5AY50vZPFwHAZE8J
         vgQ2h13kOPFcKfKv8P1ZzEQKAcwyeKOjv/mhNybKO5CecVJvycz4eSMbxcDFvTfJVCov
         SWTWdrTxC9s80plskzYT5S7cHR5v8dnMDBBSPijEDQ8UgHaRn89hAeCNXXd7R6rjAfBg
         u8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUb2dM8yVszPIBsk47R4JPtNWULniRQvpSew0njBp7brN+DKE+ugNd9x2c0WR0r65tOqPvp/ETtug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzncqPoaiNdrprvtmVP8XeS5l6HbcjAbwvkpxpkPGJBIg/VHC6q
	heaMJ+P55dBrCQpuMhhSfRANzcagRzmtLKHKdsH39aY/H+Wj1osuDUVsvMRJepVlQVAC9c/VnXX
	T5y7IpTgFEQzkWXPW1dofS3p5Ryv5EW92tcFk8lLyKLaaO+qYoLWBySz1OzHqYA==
X-Gm-Gg: ATEYQzzeXw28/AxjHTkc8WcZLR0VX2cQAeVnWjH3h82lysQRYOc8iUudEGy9Y5oow64
	yMQhLyuO9c67aq/1U0Ak55zRB6dUbtxxib8KMV0H3SYpCOy+ra6bsJ56dEMd6LU7H6+4UgKaUgX
	15U6VoXHZseZgj2NYkA8oXooOp0njyg5Hnmy0OZl5wyGWA24P7QIsfyh549SXYdcdr9IwV8VNgK
	1pC6GdGxIvzUOvEhNfwhO0GcVu3PAsWK+ys3ZPXyi98Gk3XXik3dO5aboL7yvOpLD+jwpJDaNbK
	480OUPwncFGsZdfbhi8ZnBwqKvosgblPRC9i8n3DZAkAIIVgJPot5oV+jEYn5VW9Ys3upUB1Rqt
	6rqoG9RuSAIR6DZ2Hk/Sx4gG6HYu4WZjHXEjja58XCsO/QlEAv+k5tqNcXCkZO2BCJh8yZdsXG7
	iqkfQ=
X-Received: by 2002:ad4:5968:0:b0:89a:4994:fa01 with SMTP id 6a1803df08f44-89c859b9d95mr194750096d6.2.1774345232450;
        Tue, 24 Mar 2026 02:40:32 -0700 (PDT)
X-Received: by 2002:ad4:5968:0:b0:89a:4994:fa01 with SMTP id 6a1803df08f44-89c859b9d95mr194749886d6.2.1774345232026;
        Tue, 24 Mar 2026 02:40:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8c16csm615966566b.16.2026.03.24.02.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 02:40:30 -0700 (PDT)
Message-ID: <351c4550-ebde-44e0-aa55-6405f248bef9@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ARM: dts: qcom: msm8974: Drop RPM bus clocks
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
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
 <20260324-msm8974-icc-v2-9-527280043ad8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-9-527280043ad8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JEEAtA2lEFCB0lkbiiVN49IUbWSlzo8_
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c25c11 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YlbZtE3MOUeJh5SSYQYA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: JEEAtA2lEFCB0lkbiiVN49IUbWSlzo8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NiBTYWx0ZWRfX1wXyaQcuKHEz
 w6kDDQx0Lo2Gtw6F1fDIL+DpszB2FLcsmewmyFKm43X6vtZxXs4nlR4036+qRZMcac1x42Y+NGs
 M7hyEe7rNdMadHvh3jJcxeYbvQwvZGRw9f6jFLsI9Vl/R5dRnvF17Q9YgvCGS0nK5fktDhSGliY
 f/NoqoDi4qcHtozg96rA+lIFalEg1KTQd7vB7A/MKCoN8m/oYQ6T82WAxJZBOGH6JN5t8XrjdCC
 XfxhMMteNyXgXunFtOty4EHZ0KeMhStegAGD9ocB662PlF6VIwsH3KUrFMFWDRngIg6qiBwuyKx
 0Knlp0jG1locClPARO5AdsuihwK5bQ70zitBSooKpmdX10Zw/lqf5ilYTWv0Oa30cuuTPPlYoyi
 94/Vimk+N2uovlfQqotwRtZv6P5b/Z8wQcmOV6mdN0Li08/AzTWd5hcTaXit0R/O3EQiV3nbPLt
 ate3UEszePuk5dUtI+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240076

On 3/24/26 1:10 AM, Dmitry Baryshkov wrote:
> Some nodes are abusingly referencing some of the internal bus clocks,
> that were recently removed in Linux (because the original implementation
> did not make much sense), managing them as if they were the only devices
> on an NoC bus.
> 
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
