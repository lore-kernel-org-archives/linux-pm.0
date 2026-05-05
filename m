Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2983815D8
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978588; cv=none; b=Y51yJMOW/2icYwIorAIGD9RCCp6E9bvDhqBCdyLkVzEEEySjhAcJK+l19iVKNM82B2DOlXsLEL51kZQF6S99omvKTrzmuJl4wOHFmzGS+/Kx5YJZIOFZjP1EDSqhYzCwKUwy8oLI20CheK9eENCd0RUVWTLHDHC1jkDuN18DSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978588; c=relaxed/simple;
	bh=pa+vF5TZqASsbMrR8W6ER/nESof9jcRO6PtmwJ1Rzcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eazoF6z0DnHGh06XnW8+cZpA3AF9m4vfNo1QCFaaTUofTKtNgkudU6CHrpbMmXBPPW4u4ttFGRUvaN+IWTJzR+vrILo8HzGk4Lk7LSsWVT6RVGIUE2dOOTd26qdl+T1ZmRu9uhXD4lXHTVgLh535CXKunENNZcXknkVyo+vSjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RnSTWNWs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bGPvvbfu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RnSTWNWs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGPvvbfu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lowt3187637
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 10:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0n/g4gZDYriruqMbsEfS/3tR8O7J3pmUA8YpZH+2SY=; b=RnSTWNWsIxZifLK0
	ktN0FYF9X+6hIsPxMBqYXFxJxAF2vP4BB6Sq0/inaYb1ZPBl+7bME9DE/ncORgYS
	N9hKS3BRjwjKaWlpqC1P+yTKQRyP2gveh1wRmDID48w3rHjpuIyRgDl83Pn2pj1P
	8sCf2lgGUYxyhNEH8cd92Xl9AH67FwfeHtB0UGuWs9RTlsbr+5bpgMcNpdBR5xrH
	YMRF2+yNw7kd9jicOj7qZHNKIdhhXLYkac3j0bbItHobrVjUH/wDUl7tYmbK3rQZ
	g7XEZnByYPCZhRkiHsMTZROa9NLMz88jWUb1GlNy7hQG+o8Zxuyop7Oe3Sg0H1nl
	loHR0Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk8xqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 10:56:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-573ac60fcc2so426761e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777978585; x=1778583385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0n/g4gZDYriruqMbsEfS/3tR8O7J3pmUA8YpZH+2SY=;
        b=bGPvvbfuIHfEXPIBBTcbB+xNKkZrznVY7MYF16DiJwA1HUA24MO19xtHa8L2XembMW
         vMhRj4SsxL/+B++MrKRJ4gCL9Zk1Hkhn2opvTvyW0uHvqvPy5IFIeLpFgmNRlHjm361t
         8hH2Uq8TznWlcCzpwyI4DsJTNvhhyPzBn7Wl7V+lw8Ey+wYwiitZIvrUQZTImatVk0tB
         eTGBoGl7zifTHbIEmSJ3m3CsfFNJ5H32BckvDHsoBPi7IP0VjruSxf0SRoBI1h/zXDFG
         X7jLevv4J4Wh0hq9H1w9wIfzH67bP6A3aQ+6F50CDGdRMaVEvAwP3m2X0b87XeVt/BPS
         CFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777978585; x=1778583385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0n/g4gZDYriruqMbsEfS/3tR8O7J3pmUA8YpZH+2SY=;
        b=M81G2AKdNnLioWOhIGrWIc6vZQ6Lhu2tEb4KcRsqfU5tz5LrycD9skgIAz85PbF0W+
         403DXcgBMHOloyGnXsEc2KufSS6VGjCd+yiVs05Lq5+GWMYH4T5unkdqLBtcoO1NIZRY
         GeqOZE3vezs4pAHNgDTXtUqb44rlWo1bIxm35SIiSmSI+/86Nxa4UFrp2QGEaaY2+qPh
         uhQu6iwXzb1Xx2BVRtYjuYzyfytEZhLgrDo4cLEYsApvkJDn/WfO71Vq20UEOTr1v3h5
         eunXqi5SwZmp3VhxhqzZB7sC1W2qyuagPhM/6S1+NwtfykJjfaxPuBY6rr8tUAhTiCWg
         PK8A==
X-Forwarded-Encrypted: i=1; AFNElJ8aTfXgYWhiPMhrbn6ohUeotKQvMw0IDfYHJM1HywK+oxf0mTDmLEccv2HPQRGtMyQcJKw1CepUlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXD1A3z/nLBNJLvVq85YuF9rbb7NJenwvvKHxLX4ebc/RrpAp
	XaNeqDr2DX7Zskh1S3dD7XqhycJhOZkKEgUDFAfOKfgvldh08mj0t/awP1/mlD2G6gopp0SiOfq
	a1xcxudglf0j7bfNgxRDu8YEt1n1UgPWEfKC2F6ezdpJGFnom4k2m0j/a0xWNBg==
X-Gm-Gg: AeBDiev/9zBv++KXKZmOuEpuNH3/45qiEn5b2enQTAPyF+RZKUlGV90YRbJjdt8DyaP
	rg6E4sIBqzeH+udPYS3lGwRK1x4fdnmupq+mJPyXEMffS4aSYFBWcfJEb1di+Ro+sNhM5hNoxO3
	h0aScyIDuKjGULDe20vxC5i4sTIJTjPPAg+L7638d1UPjL98Enn0R/9sdSLG5MDLnuvYxRGHRr4
	g6epxJyxptkRpu1Cy4dUZuujRraCAtvjsWHQtAAAJkdMJOcjtF6PyvfOsNZrWU5b8UZKG2S+3O0
	go8RqoTm4hcP8Spcp8NwU5/hBC/2K9OemjEEuQswuBKLeR/wzDUKpHM5oyQueu5wH89WF7IcHrO
	vvDSpN5qIcLlJ+/0hqHmwm/GJJXc/EncuokVGNLqDKZ7KNYVKQQ2HJhoi5vKmeQEBdYoqUXONwm
	fspySdiJvJ5KAblA==
X-Received: by 2002:a05:6122:a16:b0:575:1f1f:758d with SMTP id 71dfb90a1353d-5751f1f7dcemr2119107e0c.0.1777978585424;
        Tue, 05 May 2026 03:56:25 -0700 (PDT)
X-Received: by 2002:a05:6122:a16:b0:575:1f1f:758d with SMTP id 71dfb90a1353d-5751f1f7dcemr2119098e0c.0.1777978585007;
        Tue, 05 May 2026 03:56:25 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d66c90dsm483320766b.43.2026.05.05.03.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:56:24 -0700 (PDT)
Message-ID: <32e6d6dd-0448-4097-879e-6649df0f2594@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: Move MODULE_DEVICE_TABLE next to the table
 itself
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260505102854.186925-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260505102854.186925-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMiBTYWx0ZWRfX33TJM7h1UXJl
 XSsFB104hJntUjNFb/mOzHLuUQ8sOiD51Npk6tPr41lrCZehwSYT7lr8zdq3mM2jpX8o11hg2ah
 uKnsd69sh3mhKMdKwjS2gfDQm0Rhn/9KLPp7APXAwy9Nlxs1YMYsNGVUOwPVJZe+6iGFxuH9yLB
 542gNkIBUEEn+27yJ19nvdCkFULN9spjAndgYFkrgkniTZa4KctvRJchCxao3V1kOiRbV2kTAdi
 Y8kehmX8J1F7Wv0jkPNeI60owJGt6MkD7BLCBQY6P+DBmDdYtN/tt+GAPz9VgbnMQiSb0K1Ok70
 nIO3/V6JwtMFIb8Wyx49PFROYboRHmwqrLSaXTIJ70Jx0TK/8n5Rmy0L80ItWKhQ9rPZ5IOk9Ez
 NLNZ9tZtlTEC/h9eqF4hiHZmF6ZseVXv4KxFZwiQLfymbDkFQd9L5+zb0ckFnSNCtCO+/2zefEk
 tiI/2bVYRgSaqkAGuyA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9ccda cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kQAhAZ4d5FSSWymYSLQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: vC_wwUywG1wE6Zelf84FrGNel5F-930M
X-Proofpoint-ORIG-GUID: vC_wwUywG1wE6Zelf84FrGNel5F-930M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050102

On 5/5/26 12:28 PM, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
