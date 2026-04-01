Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3B3B95FD
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032235; cv=none; b=jW8+9JOUXYmgPL6bYKrVNdHnC4614KWz8sWRrJmVkTgmDV0CBVwXTfeSJtFiEBTy9w8LFs7fY1OyKDSGdjlbYX0fSnHeBzALG7zzv0x4G2W1NmS+m9dZsbEc9w5vgt6P+VWRGAfMqy7bxO26zMlZiM4rtuHkgR37UqFGZuCZwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032235; c=relaxed/simple;
	bh=Kr6O6bswOhBHr+bJOVMjowWiawpJoVxb/WSEfqkgU1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1u0gdWh/Lhg6o+ZOV485mDKIsjm8PDg3LXrqMEJ8m1QEBY0FE+JwnCapi+CqBSjFT0UUbeRvDa305pQk8/WKgRP3RnuhcnaF4mjf/1Z5fMfGWug3nRDr8jAlIbq5O4Os1b0eKZ++UYsMjgYMmn+WpdsJdi0yVjpLowbfQ1PMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7o5tUIR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dRbC8XUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7o5tUIR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRbC8XUz"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314SIER3364203
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 08:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eeMOgOtlBiNDPKSt1z65z6B7HVy9VlGHw71ZyMGZGBE=; b=A7o5tUIRz4bVhDmo
	SgpS0zxM4ile5a6ISFA4KULizhyy9TMVuYpOu3cEeUSOmy+wxDODqBOBF0lf41Xn
	l7OkE5pHPAThwnQ0IgjiYgYFFVqA79gLY0GufYT3iTIUGtDrbG8uUa8AI0GVUXpM
	Z/x5ynsvm88KSlusl0CQkttUSq68OCYK3d9Gx2e7CX36bJe88ZoxBzPNXttbuIkH
	h2W082qgW1J/nL3QpAWrFQeg4p854PmsbUS7vaqzR9T81nHDey0akhL84Q281pc4
	VEC0/z0ru/9f1RRymsniHUlaYxItg36Nlqbj7PowSadshgQFpCZrLAjvrM4Y+t5H
	NHSZ/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddjep7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 08:30:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50943e69b08so23605131cf.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775032232; x=1775637032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeMOgOtlBiNDPKSt1z65z6B7HVy9VlGHw71ZyMGZGBE=;
        b=dRbC8XUzYJROoIWcSQb49eQnE3BOAt+DZDZWUqaHSXzzUYCwotO92JydlyDoP3xoit
         oZ9OD2HqxrlkMr3U97wLJksxBaFazP9XznbufeCrOlFXw1NuTT5nDGN6lhaMXK+uOrCI
         gfQEeaVqTDbq1f6s7YMQ7cgfPi46YtZa55CconS4+w+CsJpX3+nTS2eeX0BfUgAxKMck
         tl7iT3glfmvi8m1tDzzXa80U7xcvIw8I4kNgNo49Qhx7jTzNvQZMY6cWUqACKihT96n0
         bs5ssPdWoDa4tt9MlwECMcmHMrt7U6Xblt+JsbY02HyrSI5BlL5ttkC5EPXYxqpqYBz5
         rTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032232; x=1775637032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeMOgOtlBiNDPKSt1z65z6B7HVy9VlGHw71ZyMGZGBE=;
        b=klCMjeqrR/6MXo4xX9B5/0Tn5QmXyLnk8GL2F2GrOXs94UzgjFdwzZqWsOW9knW0I7
         MtQ2R66ubwpJCBqcRQLqg0GNakOwv62ebKHt5gV1TuKWHWM4i9/bPYerVhAlVgFr4Kvo
         Vuf4QzhRbtuJqNqia+LX4f6c+/J9oZe8C8J/D2FG7togxz0EotK6KBUdhpq6Fc1xtTTT
         OmRvXaEYlR7CLA0o58qu10SX+8lW47gO6FO/l8Vm8ZkMtKXaygsr9eTUf7KiF/21N7R5
         mpEwU5LR36Let59RwDTcTvZLYUymQQ5UUBjNQVh0uFCpiCFl7ch0cciucqKOh1P0sBOP
         2FjA==
X-Forwarded-Encrypted: i=1; AJvYcCUqCO/ykKuVxX/VUdMO+7x5tFUK+X/rOeE0Ekte4QDKtg/vPonjztyhioV274UpuYF9onPC6d6xpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywOXUyA4ROOCyZHeYLDlm0RzHH761bDJMlGG3IzYtyoTlDIIG0
	b+nMPIRkt9GK/9ehA9ZXxy3Jvo8arnjgNo4QRcEBkbUw+e0FVIJvy7bqLFY18RfBxwlQP164MIQ
	YJZt8dq/rZ+VZ1unYZHt/mz9bP8nQopgSwpq4XsSWfShEmG3GenadR4ACsvZvHw==
X-Gm-Gg: ATEYQzwM8EHhzLZ0PWfnk6fe/JWBAa2TYdEX8pE4rIoocs6aqSbiQlTEFTWe2Lg3vjC
	v6fZM4jPUz8AjAxXYgTVObuow/306TrngEpvUimOPsxCZWvvYHRQ4aajcjVI3G0kGK9VPElIb3g
	WZao9brG8YTu2FNFqWM+cvS+Q2Z3KrotnY5jLmmmk5SmbU5xeoA4BVCmFE6N6Of8ru3K+cCiStM
	OhUP6/qj8kubIrdqX6y3RP4Bnh5zzG9LBlqtXemrPWG6GVW1nwIVzjhocoLccXw0ixMUyrXFq5y
	UQ+lSv75lDJ96vojH4tH/Z2KrvjF5BjPzeCaTNE25RO2FZMV2yi12NXDOsuy3NQctLnlZ7mi1wT
	q6zEdtA9RQJhh4QRI8V+16LZM0aM5CGoa54SaBEjMxYqg/aR1aH7RgfpaSp4O4IiOaxp7qmXexp
	6CQms=
X-Received: by 2002:ac8:5f14:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-50d3bd92985mr28169831cf.8.1775032232571;
        Wed, 01 Apr 2026 01:30:32 -0700 (PDT)
X-Received: by 2002:ac8:5f14:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-50d3bd92985mr28169391cf.8.1775032232032;
        Wed, 01 Apr 2026 01:30:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c1b48050asm55285866b.28.2026.04.01.01.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 01:30:30 -0700 (PDT)
Message-ID: <e21212a2-4688-4450-94d4-0769ca45e252@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
To: Richard Acayan <mailingradian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260330165237.101045-1-mailingradian@gmail.com>
 <20260330165237.101045-2-mailingradian@gmail.com>
 <ca6c13c2-4e46-483c-bc22-0ebb6db704fc@oss.qualcomm.com>
 <acwH6N56W_ULNe2q@rdacayan>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <acwH6N56W_ULNe2q@rdacayan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccd7a9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rUcTYHlEmdXW-CG15zEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: jHic7-6qu6rs3IGoWxP0vdhVp_KIK4qu
X-Proofpoint-ORIG-GUID: jHic7-6qu6rs3IGoWxP0vdhVp_KIK4qu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3NiBTYWx0ZWRfX82aCUTjPZsgZ
 y8obpVDVnyVNP58mNEK6alCrGpvXJnHKveAnJq12PYyvLYkZnQ/FmsFmKSohOIOBOFVOZDjHDW1
 vmK4zQOw1xfJOoGKYat4lp2OYwYMD2I5M3RRgGdgF8CEDoP86GGLZJlD3rfr0HDk4F6HExi5vtz
 b1taoB3QrzXVchyq/BWQ2imcfBM2/lllMBnpanKZn1s5+u2pWVPygpBmd7S87b7PVdplpZpWugb
 QQhjbn9EdKPJB5yOO9ryskHLQWbclDCvWc7XsZw5WogCvMhsMpkDzVRY1CiP9n2DWkMoVKbqH4Y
 c7HTDBBJclILYUwZsv4TGQxDl0p2+eAONNFBIwNazWJ1FEpokipBkwnyKMpIgHBmIhoVb3KH27h
 /x3oa6vg7TrhQhi7CQ5jqe41pZ1GiCN2adQQKaaQ6oJoyw9+bZBKl72D1E7s7leOTAjTNw+tumf
 VzAxYLC3VOE/Q9fhm7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010076

On 3/31/26 7:44 PM, Richard Acayan wrote:
> On Tue, Mar 31, 2026 at 10:30:29AM +0200, Konrad Dybcio wrote:
>> On 3/30/26 6:52 PM, Richard Acayan wrote:
>>> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
>>> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
>>> the first 6 CPUs are in the little cluster and the next 2 are in the big
>>> cluster. Define the clusters in the match data and define the different
>>> cluster configuration for SDM670.
>>>
>>> Currently, this tolerates linking to any CPU in a given cluster.
>>>
>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>> ---
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> [...]
>>> +	if (cpu_id < 0) {
>>> +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
>>> +		return -EINVAL;
>>> +	}
>>
>> nit: try to use 'return dev_err_probe(dev, ret, "....") in the future
> 
> Does "in the future" apply to the inevitable next revision? This would
> be the first occurrence of dev_err_probe in this driver and the error
> path was just cut-and-paste.

Not necessarily, 'in the future' meaning 'in your future patches'

Konrad
