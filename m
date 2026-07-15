Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF3381EB0
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080300; cv=none; b=HsvqwnrSqYwFCUIZL9kPXPeCyM3w7O8oEAN1GWH7qjNfY//6Zc7/mHqaKWtpUM1/RELuhWMMcg5eFrfhqaW2HgF8G7k99vV4c+KGrxPEJ/px3alDbTlAck9h8c05Ib1QdIgAmA3NV19dUlBELb7rv1uyPuer/F+/jHxwJjPzuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080300; c=relaxed/simple;
	bh=OkrrAHAlrssxjFhiWldKYAqb62cke08knMoI21r7UO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwBrUPktx6WFT/Nxk8rpul+DBj9qWtGuLnWRWyPJvW6M7P6HAsG9c0HjKyS1xj/ss1AD+ap+cBqliFWEfh9kUaVm60BMWdPRosN2TYINSk/CoHs4EZL7f1YS5zAZwHb0JsMkoMNnF7Lg8dCuKZkQYPEVs/xsnimUYaRCs4gTyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUuHnrUK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JSJyoxI/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUuHnrUK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JSJyoxI/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0IwlG2050050
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8P7yp7jCDHdFfFLTkLuS4zg1CQWFZg8vZdY/h1ViCM8=; b=DUuHnrUKvlqMlzcb
	i3U0PaJsW1jb3ndhXDjo7Jh2VHINsbNgJuUnMwjUJHtR9DiT+tS0L0m/Oyc2Gu+Z
	GYgWdOwNMCcvszHICKyOQ7yqaqylyI8sdVGe6XdjR4di0XJ4AiMcTilKrpoi0TWP
	mEWO4rThpCIgnu4RkIwuuMgc4HlVn21zfUgvEaSheUAjHJmu015LrpzF6W8fxhTK
	XK+QoEs5R9kYjQe4OEhBZBI1FvwcbgsfRTc0mSeJhiVGo+sUsgPJAvJBHU+rWUFo
	Q24Izrwa7TTH1TNxxBKsUNztOaPM06Rw+AwVwsfuZHcFA/Qa/MOQbwY2hFkV15Fl
	4BPYNQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdwk30knc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:51:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso1676519a91.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784080287; x=1784685087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8P7yp7jCDHdFfFLTkLuS4zg1CQWFZg8vZdY/h1ViCM8=;
        b=JSJyoxI/FsjFBmoIyZtscFQFfFNCHkwwSJ2o64o9j+4RXcLDe5ccrsYMjoD/XzYjvf
         T73TxxVUKORzEfh1cKmorFflC3x5iStxowguA4insgbOnYQmB66dgG68LtgakCwvCQu+
         nFQzztoxlqpAvPTIKWWqakokVO5nizg4j29gC959Z+Wl0XKlxvD2MfFq4QP0qc4Bxy4A
         +X9iYvezEpGJR1nhAdHPDuZvOVlTMVm/V6ma2VwT5WI8ODIN+Ymmhc91romfI1CrSR9p
         KF80Xg7ONK776ztdT/pS/jqan+PfPnlIOz65/RuqEM8BCgNop3yWUrLSfdx0Si4WLnnj
         KpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784080287; x=1784685087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8P7yp7jCDHdFfFLTkLuS4zg1CQWFZg8vZdY/h1ViCM8=;
        b=nKclbE688ZevnB9FohSCz1Ou3I6TYj6q3zRzwefFU/wY+37lp+6iPtMqFL0tKm6k6B
         Qv8bESnYZmrq+jRNK96mXLTyN0m3dXqQrsFpUXsjf/Ix1M4BRiDLRNCvG115ByzYc537
         20bbQzdRgK79s47uyVHNGJISR6Hw58WHFzq8w4hVECU1Iz4dYMuZziwTYYhx8mCVgU1c
         lnP325YrSTDtmM6vbAst7A8403962vO+U7FRrLULgNBwxdLpINoX4+ab6Pt536uzPjIX
         bLejEWTfWx4D5fP+AILkYA2e54UksWR8XEed75z2z1fF/0xWpQAMcBN7hhPVCxXfc8xW
         qRsw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3FPn9b5hOBYeqH0SvhLFb5jz4NzEsxCefkY2V0RIAxwpBgx3MEmaQprL/6RFi+YrQ62Y5QSDBSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cTjXN9rrpvojccW/B8bOrlQg+8D48EjHX2NrYRiaFvG7wa4f
	uCmUlB6XjYicpldn9nQru2gKkE1EYaSotHjX0kFtb9ypc6k+xFuWzHzvJ1ox35zye1t6ie0ATZK
	dYuKl9QbBuXLu6xLm0PVU9Cb8qzn/7jW+CMPYsbBQSlagop9Q1R7azpU2xZ4mGg==
X-Gm-Gg: AfdE7cnuMU2v8HJGnrSXGTMarpzP4lMWXKvp9KrUGSci7cVm0VY7EtwOSj+t4u/zAo0
	BGQbx3m+XkSIHaca3SdAWxC9gZLskB6lj0j3yW2pzDmuy+uEcwUqKJOdLNQ69xF+URjxnrPDc54
	eQ54Atshg5j8BK99e62M6s3R3823Na5myqdW7NxVUB/1jJjC7HZmFpgTR2jjvTKahQfB3oqh/yw
	ORxDHQuzhv0MtDNB2iak0TKzYozzpH2nv5aHiwSYgvrHtpNkqrB3NaJbZioRzEPrfV1auAn5/Pz
	7BqB+T/IH8OfWmCH1IWOgr2TeASkZa5vit4QUIewsGRzxyHnIZW8rRnsu9pj3jCe5zv/q1taPFs
	uzAQ8Z1BxTjb9NPegc/uDm7i+yw0eKCn2RYGcWHW/CJtOPfBzgpx0gka69b4k3KFejsYRxCoVe1
	0tF/QA
X-Received: by 2002:a17:90b:3e87:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-38dc7b3f855mr14847671a91.22.1784080287410;
        Tue, 14 Jul 2026 18:51:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3e87:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-38dc7b3f855mr14847651a91.22.1784080286863;
        Tue, 14 Jul 2026 18:51:26 -0700 (PDT)
Received: from [10.133.33.197] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e174442f6sm2278319a91.10.2026.07.14.18.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 18:51:26 -0700 (PDT)
Message-ID: <74e3d32a-0b5f-47a5-97ac-388404602869@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:51:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yc6NIQRf c=1 sm=1 tr=0 ts=6a56e7a2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=x1iS9OEPbFcJzOgkp3wA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: iS5efdm2fIcs48fDA3XkNRn24wFaLUpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxNSBTYWx0ZWRfX94OSMfGpmzUj
 Y5tBYlEjrgcUuCd2Ox04MAMtBuPno/djX1kA4glsHKNj6wjgr/5/NewJFt2zkehIgPdV0IoRiY6
 3eLj7OHl3S3Iys70QVQN9oUZUqYxi4UCEjdVIOzXPofO1O6lCxN6/8KcUexiRXr14z+WKE/5ypK
 WyxLwzQ5KA2IXkPRV7zqIjBHvy5aZkbWVF6Xg2jjq0wQISZtmOyNB8JPpjFkq3yPKKmsnu734KJ
 koQFM+Ebh6FoHf3GTrR1v/urvYKe7iH36uuSpFh9V7wAcjZpmzYt+1KdhuvDnS8dG+Ga3cxyM1D
 YCRWYH0dxyzlGbGkqpR3JBUtxmW08m83Pa380nAPrsdFBJeVsthaPxdBvplTrcw6tQKk6jD2sqo
 O6ppMXacwzbUSAajh29+LpXNGq7POJC5m7jXT8zpvZPh51R887J9dOVzQZyF1JFumk1H2odTZQc
 4izIx+c2FR4ZJF6tKZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxNSBTYWx0ZWRfX9Q5hLpLJhfkZ
 VnUpP6jjCeOtUv82QJhAzlejyhSPuDslu7ZRHmoKQuObwO81vHe8ayuIRAxREEQBtUq3UdNUxdS
 m1OiAp0xR+L05b8/JSLN3czEuaGeFeM=
X-Proofpoint-GUID: iS5efdm2fIcs48fDA3XkNRn24wFaLUpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150015



On 6/2/2026 2:54 PM, Yijie Yang wrote:
> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
> consistent with the existing pattern used by other recent SoCs such as
> sm8750 and kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop Assisted-by tag; no functional change.
> - Link to v1: https://patch.msgid.link/20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com
> ---
>   Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 82b1d94d3010..7989db1aa774 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -28,6 +28,7 @@ properties:
>                 - qcom,glymur-cpu-bwmon
>                 - qcom,hawi-cpu-bwmon
>                 - qcom,kaanapali-cpu-bwmon
> +              - qcom,maili-cpu-bwmon
>                 - qcom,qcm2290-cpu-bwmon
>                 - qcom,qcs615-cpu-bwmon
>                 - qcom,qcs8300-cpu-bwmon
> 
> ---
> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
> change-id: 20260512-bwmon-ecb43fda63c9
> 
> Best regards,
> --
> Yijie Yang <yijie.yang@oss.qualcomm.com>

Gentle ping: could you please applying this patch?

> 

-- 
Best Regards,
Yijie

