Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891A3E5ED8
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946205; cv=none; b=ZBqz2K1UBgtLHPUGyh649+yBni2g4irqcwQlaZ+jPbYrZRKmOkEo30qoeNg3MU4G8GBDNOfiPvpZ3xHnEznDP6Oc3VzbiR+n887GzIdtxEBE/tOcG5zv+HqRfOuSf8kCM1EfbNVvqoHWOOMPrySi9KekGI3o7YkGk+9w0df+OKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946205; c=relaxed/simple;
	bh=Tzn4VRzopSuLY/eoYIvxEYoK41fJhGH5jqXnCYCd0tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ASXWH6J20LdKZcULXIEpZrtEeVm28eGUgHW+2mMA591lMvFURtMLMDtPbQKRtY1+WyVbyBVaQig0RMWwvhxiZ7O5UQGa0XuThz8oEG0QDsL4qlPX4qzhSfmFVTBoSxaCBo+EXlJA0oQQqJ0FouMev56zzFWSv/sF6aQg8jmZDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ks9Qe/OJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0Uns+OY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ks9Qe/OJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0Uns+OY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V3lMPd842937
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vrL01xaUSIzKPS4c2wYmNeCwMrSWzd4P6qDbCr3mOA=; b=ks9Qe/OJZxwN/Emq
	9qKc2m/vR+CHrq79vY91fTo7HNIJMljI2VywFUTRNqpNJJNXDb74JLHugWu5HbIE
	yxZQN+JvCVBaPG6AeTqnJT07nij6DPC9ZK2TAL2Azzk+s3OUr+28Gl+xsf9vf6iv
	lTd1btQUvRM5abk0FVAM8h+k51X7qRt7JmpnisGGOcvMyrp9szQbUOuwQQrBE5lr
	P3CzXIan2ip43wwIB126DgayardGmtzYc9uS3gLBXuBR4dZbaWh7n++aTotd8rjO
	1qJ6V0sDDy8k7vM/mCso9XJ679xaA0O1kNjGh9A54XK8vlubiuumyUcUkFPU7qXL
	VLTW3A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d86nt93mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:36:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50947db2e97so14782551cf.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774946202; x=1775551002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vrL01xaUSIzKPS4c2wYmNeCwMrSWzd4P6qDbCr3mOA=;
        b=M0Uns+OYhmW0swu8YvguAEYd4ns6Kfe5pRwp1dAQyLcm5MXMi3ITiG+vbDwJFDX2JR
         anb0knzxqlGEAdCP5qv5GY4CiMdbkBHDqeGorZjzigP2u1w0Dzsxv0nt6kS+9gYPf6Bl
         ns55vrh+YG5TUkEsmE6GRP9FX1GUgTLWQEFt5oZJWaYrvqEWjXschisr8+byzZL5x0pR
         B9zOArI57dcwnzyJQQ4Boj0sA5pHv2aH1cdFEiE6cphstQbCl7cppaKQzAcYGQaaE0dV
         6IY9kIESDZEQcTBlgnrAK8ZCyCqts/0CkOb8kOeCQrEFSjfVP5AZ4MqA0NqJZXY5XIcc
         tQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946202; x=1775551002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vrL01xaUSIzKPS4c2wYmNeCwMrSWzd4P6qDbCr3mOA=;
        b=THTBQVy/nQMwXqIYg9SxzL/t/fwyhoRTpOPYw1xriv6AW9OY9W5aXbv32iECqcWa/1
         K6R9NK4/68yHt2TG2tWswfn6S8khg0Srzsb4knCblBd8AKu/3UCmItPa0A7rVtcPu5AQ
         ZoYdQHmtf0xo/dxThJ1LswLZgC0kS2tUA3e9llzq5Uq4P4jYhZR5epuCodm9H5c3HZWt
         B+2EIjQGe+hKOzxDADMgApVDdMaFN3AmQqkxnPwFU/ofF8p2HtdSKsFfI/GO9wNuZuum
         yx0VI3bql64YXlU1x9c27KIHuOLDU5pxpmzomtLdcaXKVRgqiLA7suXl6VrVHwEu25Wt
         jElg==
X-Forwarded-Encrypted: i=1; AJvYcCX/M+PSkKmixpVjL9nmv+ltIgHK6FD0eiqDhW9vJ0gXXgFrsswl6VTzXtwvu9L4KwDfTBaYctOZnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7s8gqGY+irfL5a6Vujirr8U3DDGHXeBQW3Na2gviwi19NENDL
	UG8ucjIcrRqU173TOON+pEgVWxaVNj1xL9CsVEkrKwqmLNfkxVcJb48d2YpOLnWZWACPNThFn2V
	Whb9rVn4BvKEvBEV7qC7SQBo4DHKFbGR8qYu2QGYc22YizfJsV4RQIEiyCaIxCg==
X-Gm-Gg: ATEYQzwmG+a0qqkbULRbbQNIDf8j0GlY0qJKUvo+GlpOOqpa92IVlQOZYw5eY9ZNRdg
	W1GWLAmvf7+qtuhmOxlJ+ntQhL/YpE127QZrJJCBAQYd2jxgDuU5Xk7G7wej3xFeBGxEbMNuJxY
	EiAlhYtGlHqffQ0WGk16TaTDUg7EVUnA4fOdGYdgVynjQOYoQLdlUkjOJw/6cy6dDpwmb61f4Wb
	X7E8kMXkIxO3q8DnS+fbZtrH1V8JPamyMIbu9SjDObW9X2e2zONrR0HDKFf9iAK5tbLdHnlNu9P
	91uOX73A548aAiBNDI1GVGiCpFSL7Zkn5rgRAoomGyJVkSk7fxtKMjNDYZV8jXxHp2XZ7wCgQ5b
	+/ZUh/3OgQWMpP3PhplSlDOuZXRNK0Th+azLWCg3bVeG+HWcYvAEqE3Kn/No/avug033gjmkJo2
	qaJkg=
X-Received: by 2002:a05:622a:82:b0:509:38b0:c44b with SMTP id d75a77b69052e-50ba392edd2mr168451091cf.5.1774946201865;
        Tue, 31 Mar 2026 01:36:41 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:509:38b0:c44b with SMTP id d75a77b69052e-50ba392edd2mr168450861cf.5.1774946201344;
        Tue, 31 Mar 2026 01:36:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66beb39e725sm2053416a12.0.2026.03.31.01.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 01:36:39 -0700 (PDT)
Message-ID: <532f6709-601e-4aa6-aa5a-e4b294c979a1@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sdm670: add thermal zones and
 thermal devices
To: Richard Acayan <mailingradian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <20260330165237.101045-3-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260330165237.101045-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PFXCxCHZ6C36W3PMB-nizfVyOpNQtRr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4MSBTYWx0ZWRfX7tgCAdeIEbxN
 xtBAL5iiJpkqY4y1gnw+YfTvcCH3adCyS+Wiw/I04gNpOLw6SHEcsP8i/UISIl/QBOWTb5DUxfy
 Sa7hfE59cDkDzvd742FoMFPwrSMpNv1S3u8FDQbPJdd6gINCDvgmjB0lA9APP4cPp7YP0GK7Wk9
 wTLeAILOWSy/BcVo01ll4Go19Bc9QJeYDl42ow/2vvZTgT8lyrl2gpa5FoiYHpZ+9RqzyzKemO0
 QwHZG3qc7hGl58UDE9QQ2NWFdrZvU3Jcu1QivTYYxMdKGqUMT1+2MIS4c0fMGmPm5nJu0b0WyZy
 SPdE4qLN13epDTXLk3ozh16n6qwfGl/4bcebDYIonluv7cvZwDGQT07/IqZh2vDH9Nvn1iMJGlA
 ZON0x727eBlXvFqQc7V3y+CGMezB4W0e6M+zru7fMv79RzuA42z8C+eTOOG5vE3DdRj+MSwQRdO
 l53Rkqxv9TJsvgflwow==
X-Authority-Analysis: v=2.4 cv=IswTsb/g c=1 sm=1 tr=0 ts=69cb879a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=z4lLRvgsToTmZGyYO8MA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: PFXCxCHZ6C36W3PMB-nizfVyOpNQtRr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310081

On 3/30/26 6:52 PM, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures,
> along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

[...]

> +	thermal-zones {
> +		aoss0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;

You can drop all polling on TSENS thermal zones - we get interrupts
for when thresholds are crossed

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
