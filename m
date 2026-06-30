Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B6404BF3
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824520; cv=none; b=spktrVMLjIsugjVwdGxIi/ESIzjIL5lQV7fX9WHTHd+Di/Ce5Ik919y5WFjKQ1gr/iZFY5hsV+jKUv88ZUfLd7FGuvE2onIsmKAiEMtXuHJw3TBcs0le0Z0r9EaBGvm0tsGwm3p3l/tGmHk2SO99r1mUA8Oj/RPRl3qlZ/+B7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824520; c=relaxed/simple;
	bh=XisiafNa8TNxUf6HIvVJOnurbDpa5s7FfbLbsSlbCQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEmJftVM5xVkxmpoyUGj5FJzujdPNzbutfb1V/81nzUBzttmu+p7ycW/9uFvtqN4jLRKy/Ot6q+rMXqEfPhHBPNN9eqG7e2GytZ/v0k3NyVPEtB4XQi0Snhz4Hjvl+Jgfnblbx9JX9DSQdrIAhYEnBivXlfe9NJFAmLK+ax/l5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3ipeDtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcdLOFS8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3ipeDtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcdLOFS8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mna91542036
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QkaC2ruG6J8fgfMzShDr6/Ismy8R8ymEnpnKKfiD4oM=; b=Z3ipeDtp/dzVm5g3
	Rc66h/oANnogMqvIAa5bDs8bzOV/Bt72zsDTgYTfA7IA5uuHFgU4RvJ7GpAwgR2G
	Dboqs40UBavLWrMi1eikLSTci0PPalFjXL57Ppjgo8IA5oLmhxd/4vS6sR15kd5x
	cLb7PIBF2A1NaRFS2LKy5vJ3KVGqDD5qZBvBJtTLmk9tzqG8YEus5wv1owfZyF+j
	GiqV7LM10sTHr6IkMV1LC9h3y4pUtyMn4vykzUAYwhwJ2AukP8v3i5aRnPQOgjHP
	IWiWq9Gye024+uleDmiu0Qptjryj+kxovx1t5Fn1LF+mbrbGgNwlPn/Pj2jr4atQ
	geWL4g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4jj9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:01:58 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737a6ec882fso104518137.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782824517; x=1783429317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkaC2ruG6J8fgfMzShDr6/Ismy8R8ymEnpnKKfiD4oM=;
        b=RcdLOFS8e4ytUgYqRT1Jp/oHt7E3Z64H6BVj6YcLALH5e57W/dz+fBzJuRBsjAyTPW
         BVNwh+7nVwrHAk6lJbuIW6pzrMSLeiv4ITNIXzhRm1pNOKlpxcVCZeEsg/g/lzoe2dSg
         S0/XH2XKEOSmXprY4AS0X0Py6w+MixZA9R3wRDe3nm8tYLYo7Gk8rmyzKHsDX/sdcJjL
         O0iU9F3nlKO/hd1jeWRyDm/qBMFaQuP2koKRnE25zP88oFO+KTa1HHOvqUzJedgnpf45
         9i6ecbtHifk4mi0a3gI1eLNtCx2XXn9cRLkxKuEsxhsdCvfQgL4ztmvCiFUosi/AN+AK
         3vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824517; x=1783429317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkaC2ruG6J8fgfMzShDr6/Ismy8R8ymEnpnKKfiD4oM=;
        b=Qo2piuM0ylk1jn2Za+QKUHrAJ5nXOb1See+IYqg6drE2UmtspzuIfxqnTdJmK9mTFE
         U8qg8idEZL4kPOmQl2sntRbULYVKdRBWXHspoDP1oOc1NojrPtRiE4tjk9HdcMZVjmAC
         0Z5a2B//PqJjiZtcXSaodPDBltVZ4DutllI/FvwlEk/uUH910jxFhej3ocFkrU5/o/Sd
         za2Vcqbm8vYb2KSd8KqPoao2CzwApy4DHh1rht6NIfCUqoLLu2tAK/sTCGn8m+xBrdy1
         PrPTfPcAZV+4TT6Vq/Dj1UUIKs6Owo3lukD9IUBL9sVE8bxjYlrNwOJswhwPSi7arx2h
         uFaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtK4sHtbSGewyaO2gaClMUwTJEfn/KxV39DlOxLhcLQmqqmAXC/J2bc1ETFASwa8YN8Po+Vre2Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXtv5CIRb0SOlcmOjrcHyUxcFVO8krsC0DOZfUsWAynHrj/Uz
	mvw7IJPe/hw5YzL18iJDl6Ns2DGKBDAoNfFuI1rFmIRplNP+qLvHel7RVbohX+2wzsP50Yichnx
	opmYbZVu+CDNdNE7R4c+1Y39A5PjN0UK6n7FnezqnTTRcF5Xw3RSjmcYVAqqw9Q==
X-Gm-Gg: AfdE7cmeemHF+yWGo2bllH8YWSFDnX/KRqTtvUL4bI42Gg3oxkgBp1SIVZKbG4n++lG
	RHj50jYJxYn9Fq7bdi4VToMSYKnzztCAXGXpR+uo9kri+uDA9AnbnoJBf6u3Sq/eF94SY/lXvlo
	jqsbKTY5C1fa4cUXIusgw6TrznY7JuQNiKFrbq0mGN6yLIfeo3dXIa2hwd9jPX7yePRuGOssoqA
	JueIk1KD/sJ0x6wlcjzWW0iYMr7bJMsTPf1mrCLb9NO4PM5EFFzW7S9edq/p/LuwZvF/wxhob0l
	jjYjTw1u2QQuUiT5oo2TImLp30dHUJLG/QQHRgATvQpDFYkBFJxKCylUsBhqndVMwSSwkIIJ80g
	lCi+wNgQ3nPoGVi/LEZ6SJuzf3eKYPPrEqqU=
X-Received: by 2002:a05:6102:8016:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-73a363e173bmr562201137.1.1782824517194;
        Tue, 30 Jun 2026 06:01:57 -0700 (PDT)
X-Received: by 2002:a05:6102:8016:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-73a363e173bmr560994137.1.1782824509605;
        Tue, 30 Jun 2026 06:01:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f5215dsm118931066b.52.2026.06.30.06.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:01:48 -0700 (PDT)
Message-ID: <28bf1937-55d6-4ca5-a572-3bc7d0958608@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] remoteproc: qcom_q6v5_mss: Use mss as regulator for
 MSM8953
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
 <20260327-sdm632-rpmpd-v1-3-6098dc997d66@mainlining.org>
 <35e8f654-214d-4e8b-843f-87fa8cc1a782@oss.qualcomm.com>
 <C5AF7872-093B-4039-9F3A-72BF855BB3D1@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <C5AF7872-093B-4039-9F3A-72BF855BB3D1@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gYjUkADaelweP_na_RvLRxh-m_OBA93i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyMSBTYWx0ZWRfX5+i1HS38E7gV
 otxwoQ+S4EaYOmez51m6mt0kzFERvhl5l+2Ply7aFv5QyiuKujIEmbCMsB4nyP4cnED1xj4VW2k
 BjD6C8d9MGWFOpT/sD0nYA+DP51venw=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43be46 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8 a=2LMQYQElpYtautYIfiIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: gYjUkADaelweP_na_RvLRxh-m_OBA93i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyMSBTYWx0ZWRfX/aXDNjeLE63/
 9aUKQCGFfa9bKanIAoMtySRBHIT6pkfJsZMC6yobuKXwKRmYTUkbinEQGWiCxOS6tSsqqmHMdAg
 8NKWsJBujY6iBzrAZZtlvaNkujRefCpY+YCwTCF3VvmEsJ42KNgBKDwZFfF9R/ZFNO6HjVtXilj
 ttgKDbLRyQLNVzIqr6nligPYNKOyXVwHk6L5m5CngAyOMhW6Dahvi7u+P+ObbAcg2GT88ydheqa
 MhkOnt/Y6pRiKTHwa3ksgmVxFGthGahFhJFNRTlIAj4jM7goKcYXknaQr7nB+giOck+U2WtySw3
 dpE0Z09qZbbWLw+Z92NG8Gz87r/cxdcg2dqPGybM0fFoMdfueCaeJFWkWcuUr6FwbRDHGWs9oV5
 wAxNbNK+hyhJSFDPeWYw/Ls4CsJhnIsHBJ/8BzAa8F+CH3/X1ivC910jNTbWk6XnT8mprG4Y5A1
 dHz6y3462PBBbWlTLiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300121

On 6/4/26 2:33 PM, Barnabás Czémán wrote:
> 
> 
> On 16 April 2026 15:32:25 CEST, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 3/27/26 9:11 PM, Barnabás Czémán wrote:
>>> MSM8953 MSS is using mss-supply as regulator what is usually pm8953_s1.
>>>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>>  drivers/remoteproc/qcom_q6v5_mss.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>>> index 4e9eb5bd11fa..86edd826ede8 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>>> @@ -2705,6 +2705,14 @@ static const struct rproc_hexagon_res msm8953_mss = {
>>>  		},
>>>  		{}
>>>  	},
>>> +	.active_supply = (struct qcom_mss_reg_res[]) {
>>> +		{
>>> +			.supply = "mss",
>>> +			.uV = 1050000,
>>> +			.uA = 100000,
>>
>> I don't know if it's a typo, but msm8953-regulator.dtsi on msm-3.18
>> suggests one more zero
> I do not see any load values there only init-voltage what have six zeros.

Yes, you're right

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
