Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3ED3A257C
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032770; cv=none; b=mVUzJHL6x2tUFxDc27U1CQkbOZ2E1joAuxilt7JwT+6Gp1LbTAW4b6mYKp+SlIjEk2GVLSzRhRTSvdXMhHLEH+OT+q29gBr4oRtFmMA8jCGoDWKATu8/gSq2u7sXH0ThGYRKXzulVb6V8xS0zggvlfa1QvUvqwsCdQuhiZ3831s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032770; c=relaxed/simple;
	bh=6bVEhxDPL/ZWx1/XX7ho824LJzK+ojKXWO7M3Xs0DvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqUaCvFBUgakO2/AcjcBQEGX1vK3jt2AAMCOqUnnKPNyivl5bIyn9dvi5pUFFfe0RL2NXAsGv5PqqqgY108cQ+CQJKWXnvq7XfDeT350se9sqaJGMv+S3582N/obtnPARf/+JksX2gHaY05Yzzt1f4X3g1MWe9Ezwqlf9Eq6kPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJKIkNls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lbj95eLp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJKIkNls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lbj95eLp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O7VEhi1823605
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kvrxBPxJ4spIKzdmAJY9KIZTEEqPiHPJFMwufdx8aqk=; b=YJKIkNlsV+6BbCK0
	njsoYlhr57NAcstghLD43m3zyCi+cS+uHT34wT3/dWlOmXGrgXy26Om28Xgi1VhQ
	MoJSMl6kawvgEOWAgJiAV78eBoB9ocivF8HTweOTCmir83k+ysEA9BrOBM1mURLv
	4B986ze67MLC6T1XyBWSJiOeCNY9K4ncvLXBjDdLcAup7h8JZvAY6zkAPkQXRLP+
	1mxLodqlGahJ+KicTaD379w9+2Nv6Z71RMxrV4q1e+uITO21QOFANXtm3l8f57Gz
	Uq7je0fHhwy6aMyvFTE7eEPYSqqvHH0XaanFtYQPxH41+ko0HZF7hr7nMyUHGLeG
	x54QWQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5rty87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:12:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94d6c5433a0so9658864241.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777032767; x=1777637567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvrxBPxJ4spIKzdmAJY9KIZTEEqPiHPJFMwufdx8aqk=;
        b=Lbj95eLpQpfjnFqghApC9pfLQN7XlPRZ/KZLFPT9wDSwNNRXVNBpmvFL884d+gF2Rx
         ZKOnoXFMMj4VvETYwfzuSIIkOWJ8ODIJcKlZkhIwUW0Fmzhr5KJcp0UAtXnqXPiyIK7+
         PKP0hr6VpocxssdZ3U7Lbpz5KRjHQYUdZv5N1Ce/JFusGigEb/y7VAPRZRhq3nSXQoBu
         IOXP3iZzqB40RcOrdBcJTIXLRArmlhPi15lnUUtbFxgfCSQzGEOjJh01M3yNj8gwILqd
         GcjCgke1R9KfkGLtfz4QzQmRFUWxWqkqBQWsq2CJ9BbqWnoAcKaoqSID8NQ28XRgQ+vD
         Tf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777032767; x=1777637567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvrxBPxJ4spIKzdmAJY9KIZTEEqPiHPJFMwufdx8aqk=;
        b=dq2cPa+xCeZSmOD1WZftNGuzpvbx406mXZlHZnebI+meOdMX50OSHViJZkWeHiBc0D
         EZUOW3JK1Rfxc9oicD1Z7D9gaLydUhBVePIPCDVviESfQMG+NRjfz1todovBTjknehGG
         ZbNyB20uO7oY1ENnhduAGSAeXYUsWsX5gLml+Qq6kb6IP1H7pp/dkkcouiKz6MtTJRjX
         zHHoRyTbwoU9clZERQT4PAvkSpdSly0ySFihaSpf6j/PkypMxufZPDJwxqMrvtGl2UhF
         nx2Lf113cXJHx+wp/4b4mKYzwljh3+6H66oWbwRn8MHem2HlKDAFVdppc4Et24QFqYBd
         NXfA==
X-Forwarded-Encrypted: i=1; AFNElJ9r7ZHM0k0fZ2kjHGgEspRQhgXPdzQH4jimmssa1NCbaL1SeflIJv1JMSyKPBXojk921rc5dd1Yxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXk3CJQCmjAU1tSFbXtjJ5vHfexCCxjMiKorVzwtwQd1gHIgk
	wuGfBlK8wHUulNxKGqLtyz34dDYIQKMmh8E/+s3qHoCR00e+7xJze0PsIOrCh+blNQzypT/pu0K
	f/wGgpUleoKFWlOjGdM86eejhyphFcsLkXa5nojcTiseQ6SAJMcdVGJusU/rDbg==
X-Gm-Gg: AeBDieuVSd+T3t8iWA4cIlcPYROvYJ+rVeMoSakYzrhFzgBhfdVdyAcGjPIzUj7RhKa
	cZtXR+r8akT9X/+fahWqNNxzCuXKrCebPxbN7NGqfyITJsRNxk5gKiWEtWWS65cnHqE5O4HUyMR
	ihVBxwOMo8fL730G+Y7R0a3t8XKvfyHQqyh0p47mfmZr22935y7n5okgdYt0TsztvnFzY+Qo/YL
	T9S8OVe9aRrfU4Wd935CEYvwELVhu2CTJj2ClOl713K1QEaQNzHf4GZTU4z+W1+iYXtwuLlhAIj
	ymnW7ztVTanQSXuEkFDVog2YGXSz09MFEw5cxfdeHpgnb45PiaLaMjktVatUu7ytaRV0y9Y9Pva
	p/39AoMRDNLo24swwdDQYnFYbHIP7XEjtj9eXLBEET1iZa+YOQqZeRaDX7dOjqcGzy70O9nscJK
	lcIw+pzCycRAeRP6eY4W0=
X-Received: by 2002:a67:e718:0:b0:5ff:cd6e:85fe with SMTP id ada2fe7eead31-616f58ac93dmr16827055137.12.1777032767310;
        Fri, 24 Apr 2026 05:12:47 -0700 (PDT)
X-Received: by 2002:a67:e718:0:b0:5ff:cd6e:85fe with SMTP id ada2fe7eead31-616f58ac93dmr16827035137.12.1777032766920;
        Fri, 24 Apr 2026 05:12:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd? ([2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bba6276sm183047835e9.0.2026.04.24.05.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 05:12:46 -0700 (PDT)
Message-ID: <68723e33-53ca-4a66-8777-945cdcfce6fa@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 14:12:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
 <a4f6b7f5-6566-4c73-9c4f-e43c3cafa75a@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <a4f6b7f5-6566-4c73-9c4f-e43c3cafa75a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eb5e40 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=mK3fh9KgnU1kiJb0dKkA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: eS2aQ0BwGom8Uf5CgNopWofikbGhrtI5
X-Proofpoint-GUID: eS2aQ0BwGom8Uf5CgNopWofikbGhrtI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExNiBTYWx0ZWRfX0oy++ubfQlbq
 PYqiy/zihrD0EG22FZMyH8L5kPY2r7JTwnsE93eWN4O/1+NFlIKeEPFNdze38tpvx59P2iiRyg8
 tHl1EuqWoTQgIL554bu+nlCp04C7jVLPCyosnh3spgJ46OW/UdJHa4oETacZE4Eg8rHeGzzuoIb
 NjuwBZWphtt8kL2gN4c9BfhkMKVMw06ckmmjV3MA4hNPOJQ2BRu5jCk9j1dCAZoxI5M6Dlr44/3
 L63H2sTX0AFZBJAevTN1ssiZunwVfcX13AWtV4H6zc4Orvawg7vzqGT0OYJUrkcKbZswW1EIa1f
 H3+rjZz/zNWYzXztdJDBFFlGIrlrb6OxcLW5E5KtvzkXunnaGtreEolwgUNW5z5HjCaV3dwBZur
 LbQ+RaFI7c3bKvcrhxA1EWmmjPV/Abu8Uw7M0NINYfBBte+qrhD/V0CuerS5wHUXFma5CQHUdrI
 4tFFJ3Sls4vOlN/In6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240116

On 4/20/26 11:19, Pankaj Patil wrote:
> On 4/20/2026 12:24 PM, Shawn Guo wrote:
>> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
>>
>> Add compatible for Temperature Sensor (TSENS) of Nord SoC with
>> a fallback on qcom,tsens-v2.
>>
>> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
>> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> 
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> 
>> ---

Krzystof,

are you ok with this change ?
