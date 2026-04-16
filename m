Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185F3C4544
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346369; cv=none; b=uLQzmhE9D7CDEBomX5pfmSA+hOmT3LfpkTbiblbQywrHnuyzduwAhze5mUVlzgaSPieeYwZ/wd2Ki9yR5ExQ3mJj95D8s+HRoVVtZDXGj+RhHX1cVSNZbGbYkvpjZlaaz+PwBjBbGqVaBY6wsKUiqjNIxIEE5+4aYkWAu45NpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346369; c=relaxed/simple;
	bh=YbI6rFfjkWl+Mm3gmZK5bZa2Hn3p2AU9i9zKbtIaCt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb1xWOwaP5ftXBj8bw4zu8zQHKUC+KdxVqxBRaZzIoOCCnbZnw1+0UpRpIVc7C/0rEIJAAXd5Mig38l7AGk4czayUkgbBWvcEAdMM/ij8hiW0ATBuLTFknwU2Ho+wjRtTbESM0Q6TBALqcWrZroeBoaZv1ahjXAezm38N+toCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iis2lPNo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i1jnQudL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iis2lPNo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i1jnQudL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G8CTV42576006
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o/hGSct5oVa9jDWzCwFN3rkowVabxT5N17wXLAEXtTo=; b=iis2lPNox+J4svGE
	TKUT6l+aX0J8F74bLMHNsAsxplhyroH9vRnS/Q9s/lckQjzUU8FmJTwMEL3gC/i7
	/KmrNfRAi12t0x6EuenQCoA9r7mg/sYv/aKQP412GyBHVFRhHNY77MpHXBT6oQpk
	L38vZP44eVqS9sj9guqTNeVMmHmiJYqrHqIutAB7+yBhk/ecY4KzLXyjvsmCxtNU
	oxC3cdJvkJcEdY3uenuHu4hCbrnHqgCABYNd4XMp0xkggGTK6RGS9NvTPAc7M6p8
	PCLjqyBZ5Lvk00rzhGl4grZVEUn3/iN79ZUtt5NZSz2SDvZj6THacV9CWFhit0Fr
	woaHIg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djv27h4f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:32:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-60feeae5dd3so304139137.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776346364; x=1776951164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/hGSct5oVa9jDWzCwFN3rkowVabxT5N17wXLAEXtTo=;
        b=i1jnQudL6yfQ3VapA0KtZtPS87mV7sR6koeNVStGuTKEQolRDux/A/FrOOlcJCxcmO
         mTrupm4k/odurZ9HzusRiG8TesFcUWxtZceN65uZH/rjs07qq1hQtwYGFejCcsy9Vt0e
         KAxVVlkt5Kakj9f5nenBHtL8xfUhwYuekav0AsEDe+b/lcfV/HIX5T1sbt7SrzQeOYCV
         XZF7S3WKEowd3sNBaj6eJ1bRKoFOvgr5qPQS8t+OjZpcE/f4Vlzkt0PR2riJbjDXGWVP
         hWUWnY7w2SrPbgvMUaNitzJxxfpoGybL/cff+ILFDmxGUa5e/GKb4bnIIGcfXneYuz3/
         65Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776346364; x=1776951164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/hGSct5oVa9jDWzCwFN3rkowVabxT5N17wXLAEXtTo=;
        b=Y5yCzMVvsEs9LhyBAHb51MX+awZP4VYslHcZFTlEQXka7SR8Fnw9ziegKouIdKraT8
         HBunNjug3RHNfib+3Sc632XheS7GglBrRSVzmVYL9jsnswJ7YEvLa1MqRQcHGyznZ7q9
         dhIbJuuqkIspMZ517fItOHxHV6Q60ORil5b4LTqvpiKwcfF1ZTmLqnFB2vbXPfmrsqLL
         eLmcLgl4OGNeXSDLbtj0z4iMqvJ9131RGn4XU5PZk6pjTI+wwRMLftgLqL4S+W7T9BmZ
         BmReazDFJSOszg0yuYHVyUTKCSKbY7KtRm9pR934WomYi+MSZj/EHmB1MOOawl/WNXjf
         fPLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oNAIddUAQH2RS6QoWFWaaLfry0y9vdzDsQcAc76zlIJafvtv8EjDWcKDSHGQnxz5FjKGpP7b0DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rkREcTnixzLsm1uyUjuL9fMVAN7/eb4UwJn355CgLOMhZkY+
	tt3X/plvNIKgj1BzurcJKz8ZQN/0mmMCpnQ8QzAONWEovSHQoiYIgPTbBo9uAkFTRIaiJIOn48V
	mEsdr564+3odZDQDlKr56jt8LIxzUwglM+injXpS+o+UFksiRhrgVtb7ZpI5zDw==
X-Gm-Gg: AeBDiesj/Pt10AnrnyuOqymoV4HllfoBco+X1oBlB6Y/imwehONjBLWLcHlHJOJi/x6
	IR4pi0D8K8Gs1veD/eUMVE3k0pnSNlHhwK+SfygiexR/Fji37hVFyoWWVpoXq6MZIxEtKbV8K/z
	nSSLj0mNQx4wIc1CK4bkFI73mYA6ZdOFv+vniNQ8Ytk980cpH8cTNQ64PVd3dNXYleqc9jaHuCw
	QiWSBXfF9T9eobnjr3LKLQXnV/YAl4i2tEnlY8XJ8/f9JJRIlqWmrwi54zgotzPqy3bc4dv+y3T
	j3bzabDRcPLOog297yyCO00tIJahQmmpmmIB+jOMl6I2x81wPcnosB6X/lFPQ8OiO3BBaDw3FJQ
	xBgTA7av1m7lZQh31hLMeHt37DRMJ/8Xqn5vXmKLkns8M6fNKlngt/Y9z7tFmoW+xVo0GtJRoyn
	yJg5NkjA7G+lDX7A==
X-Received: by 2002:a05:6102:224d:b0:604:f07b:efbd with SMTP id ada2fe7eead31-6141b35663emr353122137.2.1776346363840;
        Thu, 16 Apr 2026 06:32:43 -0700 (PDT)
X-Received: by 2002:a05:6102:224d:b0:604:f07b:efbd with SMTP id ada2fe7eead31-6141b35663emr353095137.2.1776346363330;
        Thu, 16 Apr 2026 06:32:43 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a309429sm1306333e87.84.2026.04.16.06.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:32:42 -0700 (PDT)
Message-ID: <7022fd85-5d8d-4835-9d7b-995583f2f8a1@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 15:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] remoteproc: qcom_q6v5_mss: Add SDM632 MSS
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <20260327-sdm632-rpmpd-v1-6-6098dc997d66@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-sdm632-rpmpd-v1-6-6098dc997d66@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJQ/P/qC c=1 sm=1 tr=0 ts=69e0e4fc cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: _9qnN2LWnpynOaqauFrwhvskKqbXZjwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyOSBTYWx0ZWRfXz0SmG+WbwKz3
 cwjcj7Yo/HgO5nDIB7R7IEV3ARV7y1CCDcKu0UXuGSifH3ohkml6tdmZNPi2bbnVKrsBbtDsits
 zE15ax7Wbt3Z6b1R1ebJ3vk8WBZMG5cs7JGRjz7b4s6rCIlclKV992Uwh52mzIKUfd5Z0TF4/WL
 lXPoGodpM2BOJ9icarFG4yEHUJmXNvxgU/XdJVYKLIpxgmOVvgT4LSJK/CzjQVBBmlhs8uwtAKy
 xvUEPXdKQafclTDIB5h2bYVAyAa05klezGfrM6nzMEBQqYPsp7n2sDrnWflh+DlwASrzUDtId9H
 Nb82Sdwf4pKK21xutHWbrKY/MRsCPk8uPl+dQblhhg7d0ATVG8SM3mNlZfC1urq3gAP2rpcQp6U
 Imhxc2BEsTfUvlowEnKOXCr82AkJ5BxmkiSyI9muzTZJjDGuwsncBVhthNzRH2Xj+ZDw5usKmpY
 Df9h4hu8aXUACWTfcwQ==
X-Proofpoint-ORIG-GUID: _9qnN2LWnpynOaqauFrwhvskKqbXZjwc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160129

On 3/27/26 9:11 PM, Barnabás Czémán wrote:
> Add support for SDM632 mss, it is very similar to MSM8953 mss only
> difference SDM632 is using mss-supply as pm domain.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
