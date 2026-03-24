Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A13DE43A
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345243; cv=none; b=oFJk8mF3vLhDhlaRwzZR7OHM52iWkIPC5xohSnyleHVgq8Ev2r+/7wwloiSSRieQn9q8Yw4FUo538SDxfVK7HPzNHdg/y+xJrrZLlrmGAY1RvhyZLOd9TjxZqe4ymVOnA3oC666Z/3KZ5GKW17MNwlzSQ8/yF64JujcBJ+3xkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345243; c=relaxed/simple;
	bh=Q7kecj+H8UdwEC1erd4Fc8Hi+m8S6ZJDQiN1zTPLdI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBigqmuK0eNFXS90RQQhNHaub/qvk/A7JO74j/nhqv0zBhaepef+gT6OdAhcOFBMUynNPSBr5tRb2AK545ImqaAev7BkkpS/pmwmT4RL0kDkbJp/Z2ZJBcOy5s+iNPCgNIZOqvQp5O/zTuIqpVHrJKQUAaakOYGdOE49Mtnj5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyaXeBaJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7ZsUmIs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyaXeBaJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7ZsUmIs"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xhw42322926
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f4a38voHcmzVZ1xVQXEH00EB+JiuYUKbxJzeI96p6O8=; b=oyaXeBaJFoIvFF06
	2b9aW9ZdLtIgog+hB4H3WPpW9nzqd+LkEzcwL5j2xTPMtZftloXTshzPMaGe39uo
	G18aySG5kKf2floPgOHUsrmRlS9TYfz8l1F4P5jtMeVIESV6FiCOOdZp5Of72trp
	P971Gr9x9Wqf6kvdu38/SbRirDhPs/xaFzDhQjY9xhyYTdgMl3ppMiye+9BlK82Q
	k4HfpEdiUoGdiWHHnxmvw2CfX4nnK6eWjhgdzxJdCLhmoHxib9GfrDcEKF2K4hIS
	5zDMKQgI6PbedLvKKDlHFNjYrfg1bIdYfSW3WjXxeQa8lOdYPCszgQLzeaG3TjH7
	zucq8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qker5p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:40:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50943e69b08so41405361cf.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774345238; x=1774950038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4a38voHcmzVZ1xVQXEH00EB+JiuYUKbxJzeI96p6O8=;
        b=V7ZsUmIsF5+JWVOkxZysz7nFovd8/+JvU0s6YcRcsMAVcHd7i4m8/XJgCzbLbT0InC
         D8u+o+1LfEptd+bPQPkWHfp1vddykplnO+qzRVRfybNoHZVgPkR4BDHfvQzpC8nL2lv6
         XILNhlR2H8rupiltb6UGqIjACVxB7gUTvT+JiyzstdvOlx4F57iJlV0Ul6Cxpi5ZM3gU
         zkTswtmmm1jXFSn2UA4Vhp9EUiygDboi7YSG78KH48CDbdJ9VwbKAr0ZwnP84XC+sYrP
         sONKXL+0AkVKADs2Met/Xq+dUHDP5zr9atFWjFufCZ89UYqtII4PpPL/39kumZf47lV1
         aGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345238; x=1774950038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4a38voHcmzVZ1xVQXEH00EB+JiuYUKbxJzeI96p6O8=;
        b=dF6n+ufiWAYpX0/davYjbYuZzKKm61kMvlm/z5Mka3L2/YBguAc5cXevq9Q1y3xep5
         2/wIDX+mrxKsBRy1jcj+Z52aTnx+E1eUpFotjBQ3b5NiXZyZ71SNWSDDy9eaPeFSWvpI
         Rscxo6VEZ4axsYcrkUTcxyIuG5eLwMQ20pIdmD5vQvBJda5HZ0rxrzg7UvrupMV/20Cu
         jVbFnJzWHnUE0L+OvKUKWlU5AuIDpARYs891LbuTYr4x1DigKeZoG8Vlooc6hz1jvP4I
         WbQv02wI7ITokmx9KYNxX4eAbChcCGnUynbwc9ml8RJJqE0ikC7zlKbvAFAtWZ1KII0J
         wwkg==
X-Forwarded-Encrypted: i=1; AJvYcCWjxgFtQxjj7Wo9vv2aR1eZY2TvABIFc3s0iXHvuzzr+33+Om1ktsavTIc/JXO5KKBI7wCn8yL9Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9gBCVXHJHs6LQlfKSl7qKlYB8RMQNkk4pb688PIpJczIi2jS
	SGlY/JPsa3YgfAMPaoC/W1Fjnrtt/IK+FrWj0nHepkk0kTevxBbZkN1/g7j31xMjQx1XkvNJkSm
	ZZCCRb+DNRVzq6QysnOYESYBni9k1cdYQYOTvJxORFvhZmItQF0rB+kofZBLCpSqM8akLdQ==
X-Gm-Gg: ATEYQzy5KKEMK9yOp3bx+9SfID+YSC/tbcAZSXVouYa9SDNNtPvnpHrzej9+LuqQPWS
	zCBj779i17om9HWluAGPqhKD+q4psPIyC4pCBSb72wLRQJBi4+4BMff9MxEBHaJFaYrKInKWr7S
	sYnK1NowR/0mQuC4RU0sXmDojP31IVsRdTOufL9ZtAPX98Y3fHiSYRhEDu7S2NzDCShrQgkGdXv
	3FnqbUnwsRVpFnzuw2CpnMn2FI3/71tTN6bWxsKk5bnPypxl7R/b1lBY5PcYp/DJBEOfu1A/W2X
	21lTtn3OMeSeSPG4XvHq3BHNLIy4Pa//PMq3NP6liqPgrqoEakbqmuGe8aUe0NlTc/JBZ0EB685
	nu5pUV6nBB6i1W93Ca5hNYfpMOYWo80kEVamkkEw4fv49waThjbIDieR7x3eZzi52QzplseRVxE
	Os4GU=
X-Received: by 2002:a05:622a:65c7:b0:50b:51eb:c355 with SMTP id d75a77b69052e-50b51ebc824mr71180851cf.9.1774345238176;
        Tue, 24 Mar 2026 02:40:38 -0700 (PDT)
X-Received: by 2002:a05:622a:65c7:b0:50b:51eb:c355 with SMTP id d75a77b69052e-50b51ebc824mr71180551cf.9.1774345237637;
        Tue, 24 Mar 2026 02:40:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8c16csm615966566b.16.2026.03.24.02.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 02:40:36 -0700 (PDT)
Message-ID: <fcafa48d-3813-48d1-b8b0-11415e93aaf8@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] interconnect: qcom: drop unused is_on flag
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
 <20260324-msm8974-icc-v2-3-527280043ad8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-3-527280043ad8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZtJXNGip2JqPH45XtAZFbfTFQqTU1qMw
X-Proofpoint-ORIG-GUID: ZtJXNGip2JqPH45XtAZFbfTFQqTU1qMw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NiBTYWx0ZWRfX6wQX3OA7/MQu
 5FDbcLasnk4ynryH0GFrPA4g6n4D7kt14H9rHuNMitU8urvIM3A93rLP3qb5wxrMda4bYjBH401
 7p2EyWmj0dCXOAWJ7rc6YtN+XnZNzNe9x6j9xGaD8ceZooVHXIfqTUUQhE3VT+7qqua0jZbNLud
 X2tX5V4dQ0BvQ3K5J3x+OaqWjf0D529kQIIfSspySPGhAbs9qROHmMjAJ2ovnDt3c94V7BA+KoE
 SSKyRL6p+a4HyTZGAic6iCZiOu0cGZWmRHiQtRn6bnsjsB9f5CaFf7+MrKqhE5EPNIBAHMcyG5z
 sv0QKHSt9kVbAXrbeJwoLpW8bsItlP2Mrtfgl/ZW89Z2Kw3JKWRSIZEO3tgsxHF/yxknkTQy+X7
 h4evt2pjpKjy1e53mBTESgGueRnPC4/peopr9QLKcXBAl4izHYiydWQDiV88mCDIT2ed/BUn8ki
 /8zbV7vWsie0Ks+UMng==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c25c17 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=k-kk7C7g4wtHnpuv8VcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240076

On 3/24/26 1:10 AM, Dmitry Baryshkov wrote:
> The commit 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface
> clocks") has added the is_on flag to the qcom_icc_provider, but failed
> to actually utilize it. Drop the flag.
> 
> Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
