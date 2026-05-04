Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CA2D8DDF
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881631; cv=none; b=OThNMxlO5vc0Re+Adkee38X2yHHdOsuvPn8A7ebHmROjnBKAYET2Y7hmgDtofIque6SwVaiu34Nojn2ocZO2ObvXQOPp2uZ37RA5jJpF6+CNDzIWJjRnC8vQzuHOM/+h0PO7WpsIxSYdApIIYfBMt5w9BXoshSEpR2O1lvFF9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881631; c=relaxed/simple;
	bh=XiDrAWYieOq20PsUIQWQPcsJrTUBHepknhKTiIUCdm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PHDgqGcOw2bhMkH9xCZkGbWW+TvZ8ZPiZViXml8EYX826jMvW3pmsDyvWYTMVZZ+viaNSD5Ztiy3fipfWDEekKDzrVNoRdAgmR8V/wPWZVbS0Opi7FDYsQRLHmH92xGZs9ODh01i9vfErr7JoO9/lce29+Hqci6QofBD9Vh0nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5lw6c+V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fVP0CuC+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5lw6c+V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVP0CuC+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DCJp098068
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 08:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XIR7fDQi7e+NMiYwH12EeBP6IQkj7IAZDunBXH9Fy/U=; b=T5lw6c+VnKOSFHV8
	PEedQP+D2vjc7hhvFco6rOl5lSD9UkLxAd44+/Aw2LzR2/Fb8BlKE6K1TzX0Z5zm
	UYsUgiy3Q4Sx77OOWswhrV+KNnVjFLiwBGw3LbEHD+Nu6ATiilwaUGsFWqu47sMH
	2tKIF8wBlB5+fa2qgZYndJy4eF2i3CulqHECb2GTd9l9OFUi11WYwz0FkL5nVlXs
	eqn/SPiQyKar5Xh8aftRfvjQ3Zpyfhr6mTCzhNTUpyclC38qipHUUpb53FmLZGBV
	T9oI57s79DUNU937/2aheIKWZWHJF7Q4hoM7DJdJ+JGjz87CZP8FcIMyvWhd19cm
	AN63kA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8kg4v7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 08:00:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f71af9dddso335720e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881628; x=1778486428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIR7fDQi7e+NMiYwH12EeBP6IQkj7IAZDunBXH9Fy/U=;
        b=fVP0CuC+C+yFLWHBEsp8DaiOiRGz1h/BWpops8dYAvm/ikMBbu3GoI63c8afF8+fra
         zDhKSMysH9Cwt3uuL82na7l4GPYZr9JU/9jcjyoLjgUYE7vrjgN5nuUfIS3gEYozKkj3
         iw1vcgYfHAYwuzDgt8WRlX/04gfeZIEPhXm1qv/BLtrnSQ43rWCBLjC2YC78e0ADzKhv
         2lX/WnJb4Fm25DAAnWNcAT1gSUo84CBEGqR67qRa+aTCmFm3dPrIHGFZZTPAEsGBdjeO
         6IbvpMxQAfJppF4CKeIv2b3p443tXRQ+JcMOmkc/dgtSLbninRF4Nlzn5SaxjDOXMv1D
         64wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881628; x=1778486428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIR7fDQi7e+NMiYwH12EeBP6IQkj7IAZDunBXH9Fy/U=;
        b=iD/EzFhEzxf47LNlz2jTVsfQG+zSd/fLtX1j1JJmV1mv2EyUMWEAEC6r7Yfg6AAaQC
         /1hXvHt5GF2rtzkLHno0JzQGt38mfP35vMCV9yljx2EYnf2mGBJJLYuTQXRCP4oEJsox
         JC6UZRqrfD8mqQID29QhOQ+0JgO3OvLOYISJ4oQz0ymZZT0TzQ6+kTKMN3soNii86bNe
         2G8gPZmvhJ0gRjFFTOaiwSU0a/cUzv/ztXXzQ+QgqGUkd38RVbKsos3qbXnCcmHnfp1V
         MohshCkmAfiBOFbpNFdj/kWQYSp1gPcMCDByErrrbIG0GQjl7aYmzwooo8ZT58s1FFkM
         Hhbw==
X-Forwarded-Encrypted: i=1; AFNElJ/8kHObo0iNaVzFohexqIF4FEr4hevffvLip7UwqyH7rXiuSUmOU846hP5TVflEnvg+CpAbhagqig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35r1DyhmOyIxbnUVERNeh2XuOwsuFNdmUtBYsZl3TYqiRAqZs
	NWQdxriZWr2bTKL/Vt8Ff4GvTVhw/CfxjwLb83hSx1MQ1kzdlDFP7e5li99uD7mXyJlmUKnri2K
	ez4yhGM2z6sGOzfi0i+6p9l08VUwSPLXC+dbhf2T0HdhdGX/MBP6bG5t2t/ZBoA==
X-Gm-Gg: AeBDiev1jHiu3Mu8zvsoPe877GSOP4NZf/P0ay3eaMOmqUVT+sAREPEsxRo7dEL/d++
	DS4HCOGSoKD7g0DkNtjRCyT4XvUcPVRcmVzH6kIn8K2bmIvmmlPlpok8vi1LlGXMkQCCUsvNbJs
	3Dv28yIq6U0YHsUo1BuN5RTUHQ3BulKB79EqbkZaMGfkld3hM+rTsXSnQhaHI7wRBLwJiB1Y1v3
	tke7sKri6/sZA72RplxEtU3eq1RhC5y9OYTN04Kt44IqkKtVAvN5OO+meGiN8Yz9TN11ZL6UlyA
	4/90Oax3i6zJfLsPVt4ZOCG95DpGejM8Nl6V55aNuEPNWNiQC1VnNGpSfXfiyETbA8Wo/GHQhtC
	C/oGMi2B185akFOcP0MPp/ZoZ9wqlr5+EejVZw+ShbIDFblCs/KiaojG6/YiTIAo/ujVsqY9Skk
	pzppA9zAMnEkPbuw==
X-Received: by 2002:ac5:cca9:0:b0:56f:4a47:6c9e with SMTP id 71dfb90a1353d-5750c63c2ecmr1241768e0c.2.1777881628569;
        Mon, 04 May 2026 01:00:28 -0700 (PDT)
X-Received: by 2002:ac5:cca9:0:b0:56f:4a47:6c9e with SMTP id 71dfb90a1353d-5750c63c2ecmr1241761e0c.2.1777881628038;
        Mon, 04 May 2026 01:00:28 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc20825b337sm94736066b.23.2026.05.04.01.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 01:00:27 -0700 (PDT)
Message-ID: <e562ba79-3b97-4c4c-b3fe-56d950ede0e1@oss.qualcomm.com>
Date: Mon, 4 May 2026 10:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: interconnect: qcom,sm6115: Restrict
 children and clocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260503161653.60785-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260503161653.60785-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P8sKQCAu c=1 sm=1 tr=0 ts=69f8521d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=om1VwnBSGygLgw2Sl-4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 4YdrTcxwjsoCELkU-Rvc34KV0mOiFRgJ
X-Proofpoint-ORIG-GUID: 4YdrTcxwjsoCELkU-Rvc34KV0mOiFRgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NSBTYWx0ZWRfXwNb77ZN9qEoy
 HqH38KriIBbb2fh/gSF4+sBl4AQjbBjm93XZq4DbTG+6vfIWn7vyHGwEWIAogxaxZSh0tqIE61S
 uKD6T+QulQXtbyZrwchqKz+W14HwlmeBLIrYrUcTF870Z0E12MNOxVi2UTpWaAaLttmOCjTtxs5
 cYuZj3TucP2ZzMDvXOwKSD8vUEkq06hxI2rOuSISOnXZHouIeSQiBeJAEfYO2aYkLIbT7u/PJW2
 4gyP+wBwi3aWY+WjF8Y42SJqfSlCVs4jTdfAMhW/jubvbT2ANbe+EmavZiQf+SHKcbkY/upQf83
 Mxb2x7voDFj1Em78FXeAE0HYuyDyMXBn7q3mvBYUdQDRGnGhPKzgb3GYHkMYuiZKpBeU0n51zF/
 Oy0Y8ulMCGbCDA4T4Uf41G90r+qlEY+86Ij3OZg8jZc5HdSQ0DcYydD0bBS8EBSGevAl8HsSfIo
 h/aYAgDCHoyoD0zORhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040085

On 5/3/26 6:16 PM, Krzysztof Kozlowski wrote:
> Some interconnect devices described in the binding have children and
> some have clocks.  The devices which do not have them, should have this
> restricted (disallowed).
> 
> qcom,sm6115-cnoc has a clock, thus also extend the example to be
> complete for this device.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
