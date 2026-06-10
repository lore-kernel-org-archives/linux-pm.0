Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E243FD96F
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094272; cv=none; b=YgrWDxin8mXdcmzgB0jENbyE5gBEktmaSCWEqgOpSiQuraOG5AqILk4fNpRlm+2kk09ESxqkcYIJzBgbXNg9Ir1bsOTcxsCFDk9qOPpM2pZDjKTkgIqzm0+dyAd5HE0FqJCvf753Gbn5sHSRXaqTg04ln4naJ4X6+ygL2xtoXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094272; c=relaxed/simple;
	bh=+58dkkhzFmFWzk9Gmvjn9HJUpCHLBYAvtBUgkR2/5SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIHfDDgfood8rUD63jrF3XVYqGY7ellnztzPQ3Nub/znXOMbCQ7i295Nyy6GaF/zxPBG/xtJwitSUFNPTp+5cx0k25pKd/L7emQkvv92iVqXtZq+T3Z6gpftzi5IRsJDpTLacYQKJfqJWtntbphTWsa/cpQEbij3iB+6RtH9Cps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+fp6481; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/H3wYMe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+fp6481";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/H3wYMe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACCLsV1554756
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amM/N+oRLG8mRewYc9VWMlxuVViY6WRo05rga5c5y5Q=; b=o+fp6481pY9Yq97z
	ndnZ9yRSQWJw6vgv/jFZq8G/xStfsajlao1nmP4FsdoAGFUbLw1qR52MM4IcO4Wp
	YlMOfsaopMCdDqyRDmGg9MMQpSsQte7TeAT8GAEHBslBasWGkN2nALGyjsDdGYkS
	FmqcpQ+wT+8wlN2ZkUpRUi2oQixGiy+8T+p6381tZZA6tyAFai/mBaBTaRNifcHy
	9ARB5c3KPs40JiUwfl9kr00SxgFs+64NmBoBTUmZRKHGCaIR2mW5MvmCfXjaPIXn
	uxkYR0Dz07zQcBoS+8ZEk16f27dOYM1k8Ep3l+SkBP0tjPcGzVlK1XGp1oeHJFEg
	5hOM4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnntdvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:24:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5178ac43d27so18515081cf.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781094270; x=1781699070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amM/N+oRLG8mRewYc9VWMlxuVViY6WRo05rga5c5y5Q=;
        b=G/H3wYMe1WuFRwcY/knPbvNCzCGoUomTNoHnOA104jdo1RHgusWuj0yo0HkMu6ey5h
         ydggDWcx/z1KVYG40Pqw4iLqJJOKb4vlZlbFCpO2lXA3aW9NkNV9V+lOjg2hHoVLBiG0
         2NlMZszxviGaqqnAc/GXdqOPfb0BMXTn1w2nvvVidMq6Dmy/3G7xrZpE43n0UomPey6K
         PKeCBF/yXkwtK7FkVLH8cOzZT2aDYVcOV8JHdFkCvELUxde/jNxJqw9HRdaZ1NE4hOZP
         PN2I7jDhxORn38Masgc/N9iVAJ1CUSBn0JjvTlkR7mySJhSZG+FNL6Ki5TrPWKLghVrA
         rTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094270; x=1781699070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amM/N+oRLG8mRewYc9VWMlxuVViY6WRo05rga5c5y5Q=;
        b=XeykxZJzhg/qXBoWwej0i6MKf9Okd2EgiruKR4mf/xFqrDWRh5Xv7oPPfBwekJhViS
         MFu1QhjlpzMk44nSw8GO7Qc0UHtHsar/vf5Y95+lEOCfRb0orQ+Zycts4dzveHtUHRo7
         bc35s5OS69+B43iaEQsPxais6HVS2cbkpNWXRlH7KzGMMZNPD0tCw2iM0gEFWPGirTUO
         kwGBsjGl7HwOkI/JIC/w9PZJK9Y9j/yGzbnpChL2TDokLETUKbPn6bFvkth7UjxqQM2n
         Gt1XhnhNo1jfb+G43sf4yMAicEcruY/O8V0yR8WZtFlPeyAaQFoyVZAVK+CW0yvvlQN6
         +YNw==
X-Forwarded-Encrypted: i=1; AFNElJ/BefWW5KGm4TYKc0qsa2q485fcmQbuCQSWrLOQ8OANpHYZZhKFKPxBetBpGB0m7vDRUClP1xflsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aRa8cmaeY2LIv280gb8tEsgXW1Z7mRvgiOtHfObOReYYzPyQ
	2rKazZ5705Rg+8ISHonrxnV26iB5mT1vQ1L/BzeUkk4EUmCyWFlwTwMPwqNyHhkTu11jAVINuFI
	sUjgCKk0nEud9PRMloMV0x+LjadV7PrEoGjp3Dw7veNLP0FsKmbs3Zjr8njrmEw==
X-Gm-Gg: Acq92OFCbIEu+mK+1iJUnkremQrcJZfetg8fF++h7zA1eVi7QlC2D4/+UqmdyX0wiHW
	L/GYqjcj5mNTdlfXlw8B3jo0FnWXRbdMgBDc9SyeJcv0nlFbNh1Kc4V3O2lz0YEJ2l0xBjJv1Fx
	62miTSso1w8fyRiB0dkjuMv3rgozETss4YFfO8rheR4XU1ng3fxhZIAHC2VFpfeWEZpxJmWZodJ
	DU4LEZmGZL4BzWJz/tdBB96Z1ew0pl8fZMahvcx8+aTvRN4MpI1NhI5pNGblZUUlYe4ucGQbQGL
	EPv8MN7mwcaiH73w0P6x5/Y9h9phz81vN00+XmA9DczF9bPgPjEaM2U5xZGyj8ZYiFiRNwQUKqe
	qEIDC4h62V8rzQ7esJ2eHpsDmxP6FEnjQ5j96+D8oMbO74CA+DP0KmFrh
X-Received: by 2002:a05:622a:2612:b0:50f:b9a6:82ae with SMTP id d75a77b69052e-517ca3313e8mr66925431cf.2.1781094269983;
        Wed, 10 Jun 2026 05:24:29 -0700 (PDT)
X-Received: by 2002:a05:622a:2612:b0:50f:b9a6:82ae with SMTP id d75a77b69052e-517ca3313e8mr66924761cf.2.1781094269455;
        Wed, 10 Jun 2026 05:24:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm9858893a12.0.2026.06.10.05.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:24:28 -0700 (PDT)
Message-ID: <5eaea87f-5fed-4869-93e5-55c9da5ced84@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sm8250: sort out Iris power
 domains
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
 <20260604-iris-venus-fix-sm8250-v7-1-7bd2f0e5bae8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260604-iris-venus-fix-sm8250-v7-1-7bd2f0e5bae8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iG-pE7rT9wl42rt5SICYqW5csg2JokLh
X-Proofpoint-ORIG-GUID: iG-pE7rT9wl42rt5SICYqW5csg2JokLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExOCBTYWx0ZWRfX3kgp6I897bLA
 1sY0hb73MoAC66TxvTTJlFeazeXi8zX+yHFL1A/DqftHZJSppmcHWiQ5Sq74dNceBhA/eQjnwRf
 yKdalcKn68kTd5cUaoZnxtxYXrTQtAAQHzWh80d0JpHex1APV2fUzux+4y1g/zSMwku92RpvRQ3
 dFuBo0xA/TXB/4woMkn29AuSpes5Yo0RHlmb1j+5cLSwpahvYPmnkbAucIh+f+/EqTLNptXTn5v
 laTqjb4fYVsYcv0OJd9jXZnbQ+fdmzozh34b4YhDffsCaGU0wEeFvEOYE4whj19VRFjE9cQrjIm
 RakT4oMHDdsjd+l43WXuCi/7k4mStIyDg+mUfiRC7R4Yu/FXmcJCmdOxXs0f1rqLmtyR47gKz+W
 BVxMOTixBeBRb+Z9IGXeyjh4k02qDAr11zvCKAb7lAs9EnpQ6RucqjMLttSutW1IyK7EaC4mN7p
 ZvvLJSfKG5p10H3HwIA==
X-Authority-Analysis: v=2.4 cv=epLvCIpX c=1 sm=1 tr=0 ts=6a29577e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=G7F_0OPF8zoUQoNe8PQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100118

On 6/4/26 6:22 PM, Dmitry Baryshkov wrote:
> On SM8250 Iris core requires two power rails to function, MX (for PLLs)
> and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
> qcom: sm8250: Add venus DT node") added only MX power rail, but omitted
> MMCX voltage levels.
> 
> Add MMCX domain to the Iris device node.
> 
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

>  				opp-720000000 {
>  					opp-hz = /bits/ 64 <720000000>;
> -					required-opps = <&rpmhpd_opp_low_svs>;
> +					required-opps = <&rpmhpd_opp_svs>,
> +							<&rpmhpd_opp_low_svs>;

So the computer tells me low_svs would be enough for PLL0 to generate 720MHz

Is there some transient dependency that bumps this to svs?

Your changelog mentions you altered this in v6, but I don't see any related
discussion

Konrad
