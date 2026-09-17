Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6114D5983
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644672; cv=none; b=OIwEFyRHYABYh2iO+OiO+Dc1xuwT0IMOLZdcVBs2YJTzvQfBYYnWLMdWysRxrKRXbjmkrYGbp7eVw8MMVHlf2h6BrxvZZzwICkq2Gxt8Z2PXHq7fGqg1KXqZtDrBFzKh1+2G8LLEO/tle6vzijeW4pGHzMZ9IKya0jBRAwb1GJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644672; c=relaxed/simple;
	bh=5asFxGk9bIrytuVDelb/mNGUDArT2gXkmHC1Br6tnfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViKaKQBkQVWEs00ml8nLYg2Q0tbg/b6ZUXaaOL6EX1xdDawRi1T9IhmAkN+RjrIqaAcEdl2VyP7Lz9AZuQDMCtBFrnzW0Z9mrLgLM7kDOsijfP3l0ePj15MAM20rNks8Q3Ao5giY8Axpd9pbf8PP5TZQH7TqBjgTKTHeKAM2NRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LG5RzhYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOe9HgK4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LG5RzhYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOe9HgK4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zn421258882
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJ5HNMt9qrsV8HyG1Lv6XxsHmRpvM8G3PirYoumGCwI=; b=LG5RzhYhPVRz7Pne
	mYl4S71fkLKWBFVRWdCtDHIrix1H7V7/OvyRE+PJqPiLlmalW+G4T1ohZyjOUjrj
	rjyEbwzAQdr9vGeHjjE6KwhhWjgiDBlsU0F9cNWQ3AwGBCmiy2u+DrQX/P74zOFa
	0Oxo7X0srud0DDdxs3MINQemVHaGxPi0COSsg2NZvpNTTmbT7rkw+b7u44BMv4uu
	qttKP0NOXDo1RcyvL70frGpqkVIphvWIvshykSQnDxm4i62MFrnR++u/oCpfOXvR
	FDxbXJltClxpFxGGz0yqkeT2vWcJgEehLEZ6ZcG3UKCQW4LLLb+JjHn4b/3sKXHt
	kdvtzg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grdftggyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:31:10 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bf9ff71075so28049e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789644669; x=1790249469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJ5HNMt9qrsV8HyG1Lv6XxsHmRpvM8G3PirYoumGCwI=;
        b=DOe9HgK4NFYxqtxtv1N05pSEUzYJnU0A6aicF7GYNhya9U8BkqD4DdPc7r0Z7yKRzq
         eYPVutfzGH7mFfPzySSriqGo0/3+lLztLp/gXs5A5BBqPa2HBYeC6IsP3YoaMxg9yNfy
         8dFzSak8HAvB8VK4rNKHxxniDiws6oArhDd7p7u2HLWC2NuCmpcsE17QrVD0SZCdf+pb
         nFmFM5t+ggs5fTRm+6+tDHZMORN0DfziREwH6DVxXjoQlHXQclQ1CK1FJ5rPmxjRSfvw
         qOPqFrp8u0l8VscxszwnhcZaK6zoQSqlL2jWzZeJDOIofEG0G07ne+8UfXmFez8YlIk9
         6KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644669; x=1790249469;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJ5HNMt9qrsV8HyG1Lv6XxsHmRpvM8G3PirYoumGCwI=;
        b=f/UOQGjtbxo72Z68qwKlyUgIh60mYq+aKhBupxHRUOF1GzF96z5HTuyR341TN4MM3Z
         eFEBpJvsRG5Hg7ws/5FaqpMqSIjXaJsAFpWB9e3+pU7FPmr4jvasR3MWKJQBVCzs/cJv
         JK2VnH4R7tHaw8MQflF6Wdcg/4vo0EOLQ5BMwHRFfFj/WN55WL+yli+HklAtH1bDD42A
         hAfrPlS64wCn0MefzYHTQNa5NLgYbCaeGg3YVtIvRU/qJ6XRcooqkIkjftqq+ghCHlQA
         wX6VBHedt6HlKOpKT8Lw1QOAkesrW0didxocGfFqdH8DIZTyneuMHA76UugVpiNoQ+QP
         7Ifg==
X-Forwarded-Encrypted: i=1; AKwUvByHaRKUwGvOEUQe8teki0ztXkXAQ6vzI/aLbKtT312XDGZuNJjNyqVW1uqrS8F9i6X4KQokGS1WAA==@vger.kernel.org
X-Gm-Message-State: AFuF++nkjrrmiUH0IBz+MB2V+lAU9VGrpkUevWQENOM/4PLlIYcG0vEh
	y5HtQ0fJKN92ut8+YR8vbtRh3ygEfqgCML/0DhW6t+ahp1vzu9Q3lsryccHhOxxXrJokcvgD77W
	iPnFrdPjOVhI8zzZ/IUZduIC/RNoxf7DtiXsh2O9HAOxyQmsF9wGhLzpcgwNIZA==
X-Gm-Gg: AYBFou3pXAtuJIz5wzfNJSUKvCSgl5AX5O18UF5I+VZ0ZrqtF9ZCnWbyWKhKYYPtTH1
	RrimtCfKPBXmaaa7rz/wmdTp7Vw6YtFLTRBww+1fH/S99KfaL4XXA8nK2pTsJEJHY1Va5o7xoSO
	pg8uszdLzaoRKtF04vIWlRrwdY0NwKhLRjfWAxPAuoEJSUgCgS9re0c3WL5NUNCNnNk2swLAGXW
	qMklAQ9YkvJMoEbf1rJ/BFoGaWXGRPqZ5MyN6QDP+AP/XWW7p6haplDmKJhbBFBoTR2EePQRpPD
	ycs+n6G36dbzVK8E1dLnW6s5GQfm8nJAAkYy5blgvo0/lQDk/qSCEGK/N96PnVSjSE5ZIpoY0mG
	D/rTZ1yppoz7HOjIbVMtVlQ==
X-Received: by 2002:a05:6123:5db:20b0:5c5:90ae:a8b8 with SMTP id 71dfb90a1353d-5c9af97cca4mr99430e0c.1.1789644669447;
        Thu, 17 Sep 2026 04:31:09 -0700 (PDT)
X-Received: by 2002:a05:6123:5db:20b0:5c5:90ae:a8b8 with SMTP id 71dfb90a1353d-5c9af97cca4mr99398e0c.1.1789644669018;
        Thu, 17 Sep 2026 04:31:09 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2b0899sm3438219a12.31.2026.09.17.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:31:08 -0700 (PDT)
Message-ID: <6b2c1fa6-5bf2-4c1c-8046-929576ddbc53@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:31:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to
 device-specific pmic-glink compatible
To: Stanislav Zaikin <zstaseg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260915084901.56622-1-zstaseg@gmail.com>
 <20260915084901.56622-4-zstaseg@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260915084901.56622-4-zstaseg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfX7Qofq4bh28oM
 s5SL6RMcOxNd4DGyXLVMzRvZz5R9l0fOAO+wouoFywvBmY2xKbkwszQC17xNxd346601QrLUVXu
 GwQj4Bo5w8jxqL0vyyt0gylEaFGWNHkSbD2PCVoomc6GTeskL53+AFgusH5KX4oW7dZ1E2nIvXW
 yV1HlwMIMaAYJPb3k6lnrcVjfHDKYrspvcAoY6Ceme0LEe9aRo9hXfR06AwVAW5xWyLT29XcaO8
 /uom2qN4XDoREDso5ozLE00gIfduh0Kq5FVNGNgwkmHaeVDPv3fjdZ4jwYiYpxn48XYzC5dL0cl
 58T1avFxlLN3/FdQ+6dBvpoNaKgwGAl3Pia5lQGTkXT3OaotdyprelNAoVLBdXxFyyVUH1+1tvL
 hKBSgmFNjGsngS2A1s7NjajVLRNA8cHopTzu1b/m4YWCFOohuVej4g5nHqKy9t6Ofs6uyPpo8+l
 0Kgkl4Jwj5+yzrzXeMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfX96bEshVTflBF
 mSMHmwwHUPiapxPY8ZKFEvqbHLyY3/EOAtW9eiIYmpiWjFIQ58UhLWPV6cLJlSkSWwEX2OR/j0m
 ZuEBG/tej2FHZQLkLmuRULTQT+6CSCc=
X-Proofpoint-GUID: WghSgzrZBccpteIQQK3-FWxyGiroH3iL
X-Proofpoint-ORIG-GUID: WghSgzrZBccpteIQQK3-FWxyGiroH3iL
X-Authority-Analysis: v=2.4 cv=K+W3jCWI c=1 sm=1 tr=0 ts=6aabcf7e cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=3RjLFqqlckgnW3q9yH0A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170160

On 9/15/26 10:49 AM, Stanislav Zaikin wrote:
> Switch taoyao to "xiaomi,taoyao-pmic-glink" compatible so
> qcom_battmgr can identify the device and apply its taoyao-specific
> battery property mapping, required because its firmware shifts
> battery property IDs relative to the generic sm7325-pmic-glink
> firmware.
> 
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
> index 6f8bc65bb99b..bc4dfa49ef38 100644
> --- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
> @@ -72,7 +72,7 @@ key-volume-up {
>  	};
>  
>  	pmic-glink {
> -		compatible = "qcom,sm7325-pmic-glink",
> +		compatible = "xiaomi,taoyao-pmic-glink",
>  			     "qcom,qcm6490-pmic-glink",
>  			     "qcom,pmic-glink";

As krzk points out, this should be a standalone single compatible,
because it's neither going to work with qcm6490-pmic-glink nor with
qcom,pmic-glink

Konrad
