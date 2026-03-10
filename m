Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D710356A3C
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142425; cv=none; b=r+EbXRVxDJrd63eeDvZs9wSBurlFwQsFQPTLonM7Pg3e+aIgfEjj3rGcfyEvDDQtsbIbr1V5+2eJy3Uq69wIs4+Ad/h9R5ePW9E+u4JCMJE5mBuADTY53FBzHE59kP6TU5tO2viO+ToRHlsz6fL0oMcPXo9ZgIj4sUH/wHtuZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142425; c=relaxed/simple;
	bh=QC16XlCaUsxkMWs4yZ/HI2iVDkC/ZMGHAzwn4f7iNqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4PVSIPIlf0cOPbbynsEvzCC/V5G8BmrLC6+eeulP0fnWnM9QGTBqylfRT2y6eoeEoBysGv05xg/Sb8vUpR7RXiYA+8etga3jg8ad7ksfC4WBBsR7h21PNhrf8QJSaxyAyQ7gp+eN1/Cv8G1Y1N1kdo5tGPaC0NXCbA+RrReLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hpywKhUu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=karuyxf+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpywKhUu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="karuyxf+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8h0oD2753873
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 11:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7Ah1jKABRHBnlYrdsXdLLaUeIdsfuVdUvKj1n5NM9s=; b=hpywKhUuIXoQpR7M
	vdKVwA+TLPNmnufFWBMvSd/iF1fCKHHZpzNX8EPTYh6uJM7YG4aXH1Pk8NGs9n5N
	T9+rd6cwaplnc6YhHy0ffjGIz+9/O+9HBm9bn8gBP3ZrwJHw1x9xhMjsAFuX/vHP
	iVkpfFJeEgbb6fCaGvPlNExuQ2bDKYFYnKq6i5/EPcanh9Sebq7We0dD87mZiiAS
	f3RhsGoXdJQkjhY8mVr4UoJIifkqMvrtC1AhYJFr8Dc/vbHA+KoGaS4I8hSBqTMK
	AP8T845KARoPH7vnHlLS0IIA4AbPPU9plfYLqICkfNIWph8jpA1moiUU80fMpG1r
	Omvdow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1mrnk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 11:33:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7ea0bb20so1412721085a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773142423; x=1773747223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7Ah1jKABRHBnlYrdsXdLLaUeIdsfuVdUvKj1n5NM9s=;
        b=karuyxf+xyngsJIWsna3eBsgtlj1dh5qLoKLbE57Asu/20qEFZLvZC/ijn5d87660I
         bwLZbRTC8KXQQYBdr1vKB7Kb3p1aDlUL1W+TuVmDicAEL/Rh2C62emepnr2F8KAwThMq
         rwNmSbn19cCKbCL3N1Mw3gypHxuYkKrpMC9u2XYi0cY2Yze13F6sU8oqdBbSBUpxidBG
         G0g/Ye72OMTI9xAoD5bI60BM3jrQC9RR2qNjB5QOxZiluJDKODDQmsWefRPP1X3kg64n
         VJjSeCs73MRGbTYmGhNKRzsF9gZKkdqE851Vkb01HP75ln7Xc76p2+bGaWVOPKO8S2iy
         zPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142423; x=1773747223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7Ah1jKABRHBnlYrdsXdLLaUeIdsfuVdUvKj1n5NM9s=;
        b=BQ14soklZBRBXc0uUm4nue7iVfJmmHBsGuJez1vR41rlFl7c2WHAx/d3p/2zEdbaW0
         1diHJu0OKQx8wFTQhfX0gqVwedfsgzxJzepyTRABPQbD1kJsIaTrHT897l9aHJFMw67E
         UsD2k811cDYiA0+/S0LeZixxAMM0sruKZcF71QSbV8BrjA0tDYVxzVx/FTG5aw+44id4
         rMzPT2z4SNa2qlVrEg+I93b8Luafjibah85e2gPTdOrdeWbXeRC1pAwFVBwmOpRRQT06
         o2J+lcW4NJJgl7hNW1B5PkiYRF1GRD2JtFjgNxNt5L3bxwlhGdECWr6wYw5p31q8vABH
         NO4A==
X-Gm-Message-State: AOJu0Yx44zRqMFvOZyBFmQ5jvCSyOtXW9a4RuCWZtua5OKGxMJ/ijItN
	BN9ThCBRPhr/KA0wc+orFVuc5uTTKNplyUnbkEyRZA6rE8odFJ50O02lFhEBt13X0XQ2WMNg4aN
	dsmzNSQCMdEqbd2P5PO1fnDpJkhR4VUBZBBY2aRvyZKlr1VEXCw6kXlajD5w2fQ==
X-Gm-Gg: ATEYQzzJO4EwDZiP85d4n66dHiy5Cy75T7OGix9L1lO4PDMuZwMFg+TgmPUytHEU/FF
	LEEmpx9a9Qa8QAXVevAll2HrbRx6NhvZzXnVi8fdcHIW1ZhOV6/3Wyf82Sa3HTo1sT7PKYyUkRM
	+EuxgX84j2cMU+SaTxuSR78h97YeQPCqWEI05eKrwryWKSiYbKfqDCobmHrLFq28Y/+CHSL6Qn8
	RXvlr5awpjev3PSO02bEzMVyG4d3662CwuRC/Z85dGbuP//kLhhbX0CdWSFnkmRwD6on332+TKG
	/ixfTet73wty/P+U9qQZSsuB8ao0RjDVRsS0Eq6KNNIaudk7k/GaW7VdcsB3UwuXMAyHq12Da0v
	K/rC7cYZZn+9kfuA06TSkfMdfKbe5Zwnd/94zbQF6/3cINufDUeCxksuZD8YlmEwDTZWI2YPLCX
	0K8mwWminr
X-Received: by 2002:a05:620a:4156:b0:8cd:942e:82d7 with SMTP id af79cd13be357-8cd942e85e0mr294001085a.24.1773142422798;
        Tue, 10 Mar 2026 04:33:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4156:b0:8cd:942e:82d7 with SMTP id af79cd13be357-8cd942e85e0mr293998385a.24.1773142422313;
        Tue, 10 Mar 2026 04:33:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470620dsm112758285e9.27.2026.03.10.04.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 04:33:41 -0700 (PDT)
Message-ID: <75b4dbdd-6fb4-4dc9-a791-8c8a0e8ef9cf@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 12:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal: sprd: Use min instead of clamp in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260310102523.201722-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260310102523.201722-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b00197 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=SRrdq9N9AAAA:8
 a=7CQSdrXTAAAA:8 a=z1V0bBGJbCNoM0m4n84A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: kvFjx09X_ntsH8iOm9EuaViGDgfnJOpW
X-Proofpoint-GUID: kvFjx09X_ntsH8iOm9EuaViGDgfnJOpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMCBTYWx0ZWRfXzh/ggMf5W39a
 kyCXcaCr/qYJFXRNUog+ejXiF9wr/pwLwA2W5RZ2inR6ztNFcOLuAXG6UotFGDFLv8slICb4CdR
 9zX6+lBqgW+YHIDY6IWK3T1N1c4Q2E/9raEhsAQ5CPeNnF1yYz2MPhLYK8tf+kW2XMXXxMroraN
 NCUtouuKGelEcpMs34H1RnQO6IBvM3WtzP42Co0FR6eAzG8ZPqwiQLCmdxZlcY/KzzKLbUOWLTf
 9vbsOsKKlqlUbklyTnvqKivvAsGRDe6xyBlNpycP4wkgHSXNghOlIb1zQzUCzUL5dlyFa2QXM4c
 oIffsNOaFJDA+mzu9i2U793ZGBrASG3qkKtt/k3NkOWPGGSlTWu+DB72Ox/sRutVmFzKpf8JuSS
 1cNrVrYU7/RMUOwuSJfihpJAUVXKYCEPBiKLgWOzoJKQE93WJlvZMUc+C40LpJnoANwghpqHeAG
 7hjL5gDdsg77xgg0muQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100100

On 3/10/26 11:25, Thorsten Blum wrote:
> Clamping 'val' to itself is unnecessary and the expression can be
> simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
> is also redundant and can be removed.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Applied, thanks
