Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FD2F290B
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766383; cv=none; b=IhmL+7OorljUQPvovxwi7w19sLUEMDZpZSQREAMcLfRvwUC5P2T8YI6gU7tbCnPvsDY5YazvWbLpiCsvOSIovhCnm+6j5T99x8MiQPJWEHSl8rntRiLLLoqQe2YPw8RSB5hVgmvD/GCyrk0+G4C/mAe5JDarsgdNgUKbUNBptW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766383; c=relaxed/simple;
	bh=VsA9lueNMHM48F0fD3xvnEuJPObZVOCK+bsvecXebxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn+/SM8SoHN2khfnBcHkvXuWzxXS4axbduDF+A2WZ1edyty5ShjF7N0kS2HP/5dMr0m4uKnunHQ6qubCWW8Sz2kPIq1Bj9JNcGSyjMAWjuAanObL2Pu8+4sgIhbknOIFiqbCOMY+5bz+3G1WN8+Ese2hRNRf3VzfPxlQDe9T5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elNFFXFl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vvamf/y2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elNFFXFl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vvamf/y2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeQFo3951585
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cug8KrkR2YvO8/2ON7zyAWQ10fFSToTK7cXF0zPI/zM=; b=elNFFXFlWruyOno7
	FNmut6yTawcSU1LqOR4jkhVWuoHyVzZDOyq6qWfS04oCX9QkukdOGZa0fdqpBA0d
	Ec0aF+SVex92CZE1PbNM9WHWbUY/GR/8RhpwPVHfJmatYgtqiTYRcti+V+HbYVGl
	bFvBSnBalkxxLmg1lmIU9zPz3gVkMlSmkWJIGJ1l1F1wuU2jkfA2zVQOrsyi4RhA
	JoS/+K6VLqvl4rjB1A6jDFeTdNwz+3GD/v/aFzaz3vpZAo/DciNdnU/I3W7hR6rZ
	qyKdx2ySvRlpRPVkrxhkAE5xuVZUSKH27B5fFGqV5coSOPpH0OHtA+kISKk1XQ8K
	OAtbTw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57kssrgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:46:15 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9589688edfdso205497241.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778766375; x=1779371175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cug8KrkR2YvO8/2ON7zyAWQ10fFSToTK7cXF0zPI/zM=;
        b=Vvamf/y2AJqwgpqD5x+hx3XQetk5CzBeuybCjx788P3EN1sgV/hE0mqyi58EFzI8jb
         a4QHwGXk7gLNlhvBEJjRp/r4mu5Q3ENwfzNASjn7xKkkAUNS8wRPBiFG4qR+LzSOH9LS
         dhphZGZLDfG+VFNMxgRb5Vo7XoknkVxm5jUG9hF8NPxvBjre/psKvNaygBZa8ZiG6zi1
         qkCfOVovAXvYvwvPiC+7GbMxMtNGQEe8PF/QjUTNG0nqUNzNenfnZR+LblDcNPRtwrWQ
         FSt//henq7suowuOww2rbez1Y1ya58pTe+sC4KEx1Kah+As9mOynqvlOl1BNai7VAN4o
         upig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766375; x=1779371175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cug8KrkR2YvO8/2ON7zyAWQ10fFSToTK7cXF0zPI/zM=;
        b=CxAVy02+g5yJusaJaHX1kbsLWfqnxxcb1rUO7n9lo9Xyd5Upjrij7gl9Yeel6K4mgD
         3hXI2zsr2BB4VIA3te0raSKQC1PpVJNEAy1KfAOnrOIE4JhkBC6Z17qeET3O69izYJti
         Z6kFYvI+nyr+P3iTQro+AiyFLzh4fzaw0hVNcyS75DMpm7eBF0KwCNBRZfC0qKb/3+XW
         rh8xQ6BJ16pc7UgpWWBlRcSRvgWHZQWDAgbx8nhw5yoBbq74DgydEel4RBW1Hl7HNTaQ
         y4IJZHtPIXeo06VMzoMQOrflhHb2skxu/5e8fO7nUk1xGt7/ltmJB0exbPwJAC0UBGCR
         AS5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+rjaU4vzsH+2rkXEHScB8HiGkSsZsycMabXMWkaWoR5/DKXT9ly/1dCTbm938TEtv6t6WGlMg1Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7Gd75rVeBIGR7kmFH1GqNJKW/CQeZ+BY5UIAIWOqpbJJWlrN
	1er/hcaiRFwRh6ZhSVDrNbnC63H8d23B7t7/EIHjFUzSmbMsEJnJvPREuY0QYCH4kbJxdzC16c5
	oMTe9BOdxndvlQG42yLKorxBfCFM4veUbZCOrYRL9DgYfY1Yx7xUBEYQjp9mP/w==
X-Gm-Gg: Acq92OF7dOOzTabEdsNIanhRUN9JsiSzifR8AwmNd16xbBC2YW0SNMBfgr3FzUGozXv
	tCAVo3+OayH0Sgv7EuNUk97mBITOKCeRxXoYc/46B1JkZqUsTQQeY7DP088nOAXQBP7BcLtg0/t
	1IsjrVcvcZ2U65x5VOWU4IHVYiaauQH9zkSXbSNnZTIyLjW9CP/Mea2FBofrl4D4kDzJjWhYMbN
	hmKzIUkTgM/VMoIioChhtIUbUj8oa7hUSdgJHUCYQ2SefzKflOIUBpzSAvU+tzD7vWWGe7OKeXJ
	bkEZY5m7qjzZKoe23IjQI29DHsLPo/spa9ZYBXPkbJKytkNPKgyDmp/+mDuamvpK5rzgFqnE1RF
	Bo3q0lLMR4mL0oYqF4ukwZ8dRFotGK/pjw1MKWlvZE5fpAPFw768fZdIYuPxCh3yvFzrBNHfiLr
	UpRSY=
X-Received: by 2002:a05:6102:3111:b0:636:c122:8583 with SMTP id ada2fe7eead31-6377615bd93mr1142080137.7.1778766374920;
        Thu, 14 May 2026 06:46:14 -0700 (PDT)
X-Received: by 2002:a05:6102:3111:b0:636:c122:8583 with SMTP id ada2fe7eead31-6377615bd93mr1142065137.7.1778766374512;
        Thu, 14 May 2026 06:46:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5497sm501819e87.57.2026.05.14.06.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 06:46:13 -0700 (PDT)
Message-ID: <4b3da6fe-a5ea-4629-8f60-a23e8cf6ab4a@oss.qualcomm.com>
Date: Thu, 14 May 2026 15:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: eliza: Add SDCC1 slave node
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Georgi Djakov
 <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
 <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-2-13c03bc890cb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-2-13c03bc890cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mDVUuDcks6cH-WbHVcXt6vZtHTKAkrWJ
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a05d227 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zvxfrTDFQEmcjWDhNOoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEzOSBTYWx0ZWRfX0n+u7WPRELbA
 twqcHN7YqcmlS0h/77TEGtPC8Hz/NYyA3W4Cw2H4WPERv6qQs5ms6jM5l+wh5NZOKXcufcmKuiX
 bRxInZUqxKXiQIUMGqYgBxe3nOFxHKBiTOVGO1YwTGdRYHfz1EA7pekbdw9KAIRS5jtal3XO4b9
 8E159TBuUBJOltArzFV3EfoAsIsrvDXdhj1PzLYpQWLCV34bRC0pP9vl4mFlkYby+k6NtLiiwQL
 7GYMuSfpMFdcIk3JxvyaFSfkEcB74TXW1RdPHqTPHO+F2wPHjQd/BiIjFHxI/D5v1/S9miw4Vlm
 rfRNIwNjBKQ55S3PE1+k8DwjzX8LWRSEGMGkQOzDspYqJlCAd72s3L6xrqnryT2CxxFovesEtN+
 kMXWqAwzIrUkfVV1jjaXRgI6NV1mCUf6UxJOD3bFBsWdQKDtsl0lHQ4fuo5sQHX4gWHXxwCh95x
 Is7kBqNupBuKeQdF0Ag==
X-Proofpoint-ORIG-GUID: mDVUuDcks6cH-WbHVcXt6vZtHTKAkrWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140139

On 5/14/26 3:36 PM, Abel Vesa wrote:
> The Eliza interconnect provider is missing the SDCC1 CNOC CFG slave
> node. Add qhs_sdc1 to the provider node table so SDCC1 interconnect
> paths can resolve to a provider node.
> 
> Hook qhs_sdc1 up to qsm_cfg and CN0, and bump the corresponding
> qsm_cfg.num_links and bcm_cn0.num_nodes counts.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
