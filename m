Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AA3C8714
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941445; cv=none; b=TxZKCHEbnhbkeWfgYCho8phqvOToaezlqHJ5A62++WddChJ9m2YhlEVvHTqxBpbiLe0Oq4fh8KrhSg0sz8zEr9EL3d8+cUZhSA4D44GqvW/ZRA3gAlV4d+8rrswzpDbqq8iSYLRbwMCm8yTB7lGVm35SofkQi26W/4RNvJ/Jl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941445; c=relaxed/simple;
	bh=nkOIIAnHM4RJg0tdASPd6fhmwrrhx4LjfS12wYZ/uJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJUuKt31gUcZqE/KjhUU6BsKlxjXcGYzL5mR2sKaaksYgAEkxOTv69wJC2euT2DVjdJ5+qg5QHvQz+4WywwBJEMxTKhxxZ9+nZHVOy7LIRkZcKDbsLgyEO6SGyP429XFuofYO60Z7n0MRcEO0677bLAEogTCHaWwfB0x8YsPZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShiLzXhS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cE8nQJ9I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShiLzXhS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cE8nQJ9I"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8u21R366195
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQkK1WwgrYNlSykIKJaV0buIA9BdQ6BgAacr+0tewkM=; b=ShiLzXhSI4Gyrmxu
	tkjRVjqE9lu+tnLs8YwEzxfMi616tYTl4Tcqa8DOndf0j3EBMYf3lFCjIDM+evFo
	GOzC8wYfaEiGKpQHGB/4G7qDq6LGm0PviG96G8QynbSdnRJOuxdc/tH4UkZlgf8K
	3x3vZrUlanSwCSeYCwY0yeHEJzr9w9rTASbQmGGcOLiuaNoXHSYGG7gsHfUEq9UR
	1o/74rt/xoemOPwijvhco5xXl+jED8BkHgXQb7FjxX6Zzs2/29/kLFvWJZHM3Lyq
	+Zm0rDjtniGXRMiRA3dZFLjWz39or66ZR15HP14dwGodHw/FcydwpLr/q1R6jX1I
	9gkOBg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rb32d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:50:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ee2dfd63beso35599785a.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776941442; x=1777546242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQkK1WwgrYNlSykIKJaV0buIA9BdQ6BgAacr+0tewkM=;
        b=cE8nQJ9Ihn4cHrJ9zSLb2f30EBjo1CuuIeiQPKCRUdDCNP4MEAPu0gqQMDMxdORpjX
         XPWhRE78VmSiPnrd6TGdx1MxF5SJdiVxBBOs5L+PUqJU6ZaxYJsJt4Eu0jguPpN4UUbR
         SCwbiWp+X4i2e/YCY2RdkGo4mv5f55uJ0xNlvGrUhslduqK97PsIvGj5n9LmYDhml7Wr
         oBlfZzSlXRNAobVPShNhpdFG+HgWE2HygYcU7feEvhJr1zn2fRvCxNWknbs4b5Dd6cNf
         +WFhSqp/zVkiixiLQ/68iMaSSt4Ooti5bTJn5IWHItDzOWvTfakDRWlGKhe1H7uO4e/C
         aRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941442; x=1777546242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQkK1WwgrYNlSykIKJaV0buIA9BdQ6BgAacr+0tewkM=;
        b=Qu/9CwRFo5VQG9lQp9d5GRP+p1sT5/im7tb40eGtFkFK4nWDE/jciCEhtGsAgGuVXJ
         6tckC76WEDktZsWPO6fK9+zx5uf1wSLqrBtXirxKys2dyCljWIPtpGEUHKZqEsK9y4VW
         Rhh1T7/pRbS9OMpTGQUvQISEivJK558pbvfnRQykPyL91d1tlksxI7k+0GUfcZ+wRxPy
         hnDg1XuFMT3O0eQT0ZQBq2Gz7lGxs1G7L+A1WjhUpg3mMdeB8rsAmkVc5tp/bNZUQGc5
         AUMpVYB8NjMIPLAHcnqbKaIkx5t+Z9xyItevXl80juPM875E1HgkOBVX2x4JswHWIN74
         2SmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9746LzJ18m22FnltLUPz3XjdkAdMrgCEoDLhuvAj9YGBQyxIU64tmYtzIk88BZly3Ep0HPOBp2jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQH1/3VxZvuycpg/00mgCHpUj1niCuVDqu64s+8/Ht/5NgS+D
	09D4oDHAnBH/cWsaBo1Zwu56gvSbDx6NuVkJP2xO0HWESqQ/Ll/uiIHcmuPadNCTsQWCLstL4M0
	w5qEbnK38nQTzha1mY0Tx4d7bHBrILAuG1Qa/R01D0Fl3cBokYU1/igtlqdSSXg==
X-Gm-Gg: AeBDietDEO1CeIVnCxvku46ARjUZMVpibBZvSugS/H+8x9NQsAOKBHuIiu4JMKbbmYv
	UafCwVV4Yj9E5a8SglxdI3sQ5gKGjD2C2/W+dup2/5Apf+NtGEG/T/TbisE9lG5sv83vUAVpAPA
	Jd0AzlFN1MegSFE29xPnF6qR5GUumyjy+0Wjyr152pn16f8qlDAzeXl7aWRBci1FUmcgVuNGWqB
	zU4idtHH+5963PH/NSSSVrt+PGkRiWj1eJLW6qnKetN7RTiLb82YHFBzcOpNB+BV0Zxd4ZzWC+Q
	yZgp+1dxYz9LoJOzszKudJAEWXRpwXwsUiLcoY2aBEqdx0cWU1JN52G/BYC/tzRzf+B9LNybWCG
	ea1Yhc8qkrmKcu2ahb18/TOQObGIIYVzDeYXE+bxJScGV6SgIr+9pL8h20TNNozENJhWa4hnAi/
	o0QCMcKUtKDG7fSQ==
X-Received: by 2002:ac8:57c9:0:b0:50e:5f36:1daf with SMTP id d75a77b69052e-50e5f362870mr173524591cf.8.1776941442537;
        Thu, 23 Apr 2026 03:50:42 -0700 (PDT)
X-Received: by 2002:ac8:57c9:0:b0:50e:5f36:1daf with SMTP id d75a77b69052e-50e5f362870mr173524401cf.8.1776941442124;
        Thu, 23 Apr 2026 03:50:42 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe874sm3614970a12.6.2026.04.23.03.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:50:40 -0700 (PDT)
Message-ID: <8ae4ef39-bd69-485d-a392-11bf188127c1@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:50:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-2-bcc2afe4cc78@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260422-x1e80100_qos-v1-2-bcc2afe4cc78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfXwQ4yTUgI7mBJ
 8rMOHub80OJtur7zDtHxerTOEoMEJc9qzaUI1SfK2Vc16FtGARMbh3+mIN7nBvGWeUddNTkPEez
 S3EDp50UoWIAF5P6WpLKr0ksidrcXQgfsxNLiBxssmm7dITWsqoO0+3JgaqNyPoNra408xVA/ND
 BxTMXBNZK0M3IHWeQTPWGkeQ05jj12grRkmXOZj5oF3IiNFIKvw7IKCQQQoUlr94aBwJbPKOHhk
 P8IMcBt91sjbJ85SjAwnWL9xDXBAO1uvVE5Nq8K1ocqzIxMPhBxoMHz/Xr5hy8qZ0FupO6texlH
 KhOWjVsz1Fg5AhGPn/ANA+wo6QsZN5JGGa/EuizojiBGGBJnXNTalOW87GLunA9LxIS+6fpT3yS
 hRiZgzqyBK6finS1pcc0TRHEgxVaOxiTZu0blJDeF2l/qeaxK2tqnYM90nvBBtxN1HU8Hhui0Mm
 1D942gaIagKkJJoMOJA==
X-Proofpoint-ORIG-GUID: WFbXr6UtenNupMtJ4u2cbCb6FjOcxka5
X-Proofpoint-GUID: WFbXr6UtenNupMtJ4u2cbCb6FjOcxka5
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69e9f983 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=MkUb1pzjx9tL84Tx2moA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230105

On 4/22/26 4:05 AM, Raviteja Laggyshetty wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
