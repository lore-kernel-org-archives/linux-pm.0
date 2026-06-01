Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED035B1EB
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277107; cv=none; b=s3XrH5Frelf82yn5Dn4ClpS/Y46DbtdKu7pbu3jlqgkdM6fKkgp8PNWuVpqKNYjoT0npHhQigu7vo9RuiwHzl2rQ89tu0BGa1MWNHbvGo+Jf2eiX+bGmAXaPmAjQxxuDe+5CUzLSVLAdy/oijIVMXj0VJlQyEn9Dwks+TyrRwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277107; c=relaxed/simple;
	bh=HB/H8kRdQnNVe+iI1fetIkgGU9UEJ/VrxvkBLPDfr2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JO7De19L14siFVpbUL334kawQMUzENpD0YWqKIVJWSrSDCuM+nDUwNHih6hg7w/hUpoUp0zxajewDOBoWgh/Zjb2XKMK4KbyB1o2LTs/g8y/jmApDu+gC4FrsxrqK+D7yBVxLVJLv6qsdoEHFsseWlHvors73qKABoDoukEeYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qpq3vd7Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PLJeDwRe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qpq3vd7Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PLJeDwRe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VMAPFR4045655
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 01:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8NIdcfqGLBBvLnTrYiE/G8uxoCpse5IEp9i9iU8fM0A=; b=Qpq3vd7ZF92EmwVz
	zDQjxNlThx5pv6e4zscdPDvLr2i4S82U0XrkekUyVoLk4JJmSbgu4GyJExgz5h9z
	u0XTi73u4ORYREkYWjsAfQ84pbMFywpRlNZU19kRADRhNoz/JQ5twbFrCnTrzRgw
	XKLsfvd1qREwzmKR5yooh+5ASLAvt+9nWEL4IOxZL2VRo8RCFY4DXiguoOmrt5H1
	oFSsNkzYfxeNjKUHnL/M98ymDXkPVLS8QVsvUEzdxvGg+tntiN+1h08vq/0YqoCG
	N9ps251a/IjEyxaPAdukrMWdBr85SDeAM53+zZlAhuAbIYrrBvKsUyHlrly4gokD
	sxktmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efrncd32v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 01:25:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso1251073a91.3
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780277105; x=1780881905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NIdcfqGLBBvLnTrYiE/G8uxoCpse5IEp9i9iU8fM0A=;
        b=PLJeDwRem+pP63lwgSn1Mis93QBLinl+NbYXewwUfNN8ocE0TwFeeb4kw0KB7/X9oh
         EiFTids6zMDKnJVSyrOC9kWYtVp1yBQfCkCNJR8b8RGLOtBY3ijRc3MjL8nK4l04ZIuB
         yfiP5hnhqjFXBVmmsGNBiOS74GEi1v8zSaqAVU0wmXsqnmaU+IRS8rQK9SkrAUrJIE+4
         pGHLkwA5DuBROfhMb2sfv+3TjicVau/QSpl4D0y2QHFIt25tUXfpzou5ZuEm4Ugdsu6x
         3rO9FUkC0k2xQwYdnPzjFTiNdmNScomqV5kk9MMD04uYMrUcUek0N/NwWLSNxlrToQa5
         zUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780277105; x=1780881905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NIdcfqGLBBvLnTrYiE/G8uxoCpse5IEp9i9iU8fM0A=;
        b=E3Ux6Usg6FqIkJ2NAWo1cNk5otem2l3bqpC/MKn3DtNNSiN/F0GyT+6UZjk9aJpUky
         Ww40thPT1rHhyGyt44LR90yqdWp2XFl9dbVv0qj/S2uJt7GHxwmNnORZi46FOnORykiE
         9xHqEEInvdxSV5QdvHeS6xMGTovPK4GVRj4Frjjac0j572l88rsr7Z7eQagh3l89RAR0
         RRiOB5aGIQJPdhSFqdTmeetC2Xugi1ow0TvEGX6wcRrdCDX9AWui1qKPqTqjhsYSl343
         v4tGme3AagDqljVGOR6sXyaKa+kpoeYSp055AG7T27VwBrHIMViIRIL/dHJJ+O5Hsyia
         KENQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oSUi7lN6x0LM6ioAVD4w+dQvCnfl6t/8X5tKgcb/JR+TviKo+mlHpBrevyacOINFl6wRIsRo/xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySXFmPSJHAtpC7+UoIcycZk36Hj4c4k34qZNt+9gXS76+RcTX+
	wRwL31ZrPMuILjJTrdWNWIpRWZX3+2f/BDYRZTDyRDTjG5jSLVMXyrzOm4nUA4cGAzPUF8tgTT5
	S/Z7ZZI7en3FbRcd4iyOHap48dD3R/F8bC6EMlBLWQJFJjyg3YHWdAjnWLVQGQw==
X-Gm-Gg: Acq92OHTFj22VdIPTfihjR1wy2bN4Y5AZtoFnR92jExH9pIvmoGuOYnp664Jr73TkLI
	PCWzLzikX/r1iIeTnsDFlxT/k+gBDGPXhof2LSGdmO2pY1iWouXnNJrHKIFPnFIkVUWMlMLR+GO
	QAjbSFgzIAuyxET3NdYNtIBJsVwrguM84D0JwuclLrf7KLM754mJMLXLNGq3PEmWJb7gaGUqsSA
	+O8pw+hRL0KaFKt0saXRKEcu1vEoXZPjBhp/q94sHxV+xxZI/WeGq413jJ/hXg5LLrn5BoMux81
	AVBR4718B2NjntBxTGUNDP8kCg5pLt35MWU9AUxsGu7HpcRgpLzKm6ri4ef8qi4Hu2G0+uHH8PN
	o0Ezwx9uMZJFhPAh9RUyA6PlNJS6hYBsIt9YTC5IKAjWxJqtgNpxbXMnu8T1CS6AA0PS1Gsnsp9
	oornQTcm1sVjbzNsyT5TlmVZ8c
X-Received: by 2002:a17:90b:4d0f:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-36c501b8fbdmr8019905a91.16.1780277105410;
        Sun, 31 May 2026 18:25:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0f:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-36c501b8fbdmr8019878a91.16.1780277104956;
        Sun, 31 May 2026 18:25:04 -0700 (PDT)
Received: from [10.133.33.48] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm9412967a91.3.2026.05.31.18.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 18:25:04 -0700 (PDT)
Message-ID: <c24d1b5f-c066-4f16-b4d3-e50fc2d40c46@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:25:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com>
 <20260530-finicky-celadon-crab-2cb4b4@quoll>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20260530-finicky-celadon-crab-2cb4b4@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1th_MJdDYHmVUgHlfCnsxmk2DZGTfv6u
X-Proofpoint-ORIG-GUID: 1th_MJdDYHmVUgHlfCnsxmk2DZGTfv6u
X-Authority-Analysis: v=2.4 cv=FcIHAp+6 c=1 sm=1 tr=0 ts=6a1cdf72 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Vd5kcbO-RD4PiU99qyAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAxMSBTYWx0ZWRfX8DBgNfwmL0N6
 TnnklxkjljNs2IlHTmO1U9Zp8istsCF43/o8MXUWp4NiOLIZb05RTCSZredzKzJahv00OYpjDfP
 HhCUh/UvShScN4GagnaO/tCE/GatPBfiKy3/H+L0nvxsbxslsy7t9SfQWQFZxlm/Amjzs6AeNX2
 DyM7rciP0adxaPshuJiGbVa2ZvBozL+JX7zuYHgsw+rgmBrBI7OGt9lUryfV/V+51VUuOrzWJkz
 NNtKky3t2UrrJkkVHXOJcIZIN2JNBvSTnsOyxUheB7VMpTB2JuII+eeQMmCM6UDd9clfaMEpI2M
 5imS2bM56CIOhu6oUscvxckAHnV1amvtjXEoM3aRPEe0kzhY7EdwRjVm+DLHCiiLhEEig32Vf8f
 p+IoHiYydQEmlKDN/VB+tfB+dqYZXtBUjIAF6u/vIr+fJqOfzSmPaHUgV4NNMyh+uNtwiZvlmrL
 i3pr+bAnu1Ou64nnPkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010011



On 5/30/2026 7:20 PM, Krzysztof Kozlowski wrote:
> On Mon, May 25, 2026 at 02:19:53PM +0800, Yijie Yang wrote:
>> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
>> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
>> consistent with the existing pattern used by other recent SoCs such as
>> sm8750 and kaanapali.
>>
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> 
> All previous comments (from multiple patches) apply.

I will update.

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Yijie

