Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772465;
	b=e6qC8c0+1xHBkMxXR1FlserNc4fUBov5XvB1lFqqWqCLDjcIT2XeoZIcT0RJVbmiora3
	 4IkK1qwf8vn38gmbjC4M01Q68XAqqMVPjpzwvqPemGJtiimcFB6aOc/mnKsz9k4bDMYNg
	 azGrP0ECaGSK6rlxYR/q24dxEDoYCJw/xhMZhvF6nLhisiDjDNkhxtCbR4f5nXT5NPPfy
	 mG0O+FlPPjcEze/36NUMbbGRy7zKPtsSm49rdr2NutZuSzX1jq0rftCrV38fyTPcCBEKp
	 zsXj1oquN0JPK5rMcve2X4xSXs673l+pRBVELRrP3A8Lvui9N1+GNA7t0+CfAh1qLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772465;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=o3HiB2vJRWEBxUo+fvEqRZTvriSNZji2BGGHNXkYQ8Y=;
	b=Rjd+SU0W3jTK9iPDTYK1+IevfFcDupnFq0rLOgdHzYCq1tQL0MsZZTX6HuQex8qk2nQW
	 7ZGgViQ/mm+r8iBiE9cr4sF4Z406kxZe3fhe6XBSA2Dz/Pmyz4ZXGqX1+rbaScjV5144r
	 3Jfs4NjT8OxxDskn5PC7mHArBmdk3tH7Fj+P9mxOc2+9KnB+VeavbhYHQ131rxn4cW6C+
	 dsFXN+sfrUBkx9NmdziWvkLwJ3dA0m9oTcY2mHPPCm2y27w8gpWcHmEFEaJVipdm6GrrE
	 QgFiaCoXBIK8TJ/T5cSH7xg4xuLOu5n7ySWHXmvYdPniLf9fDz8HEvK8a3TlLsczmJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="nLS/r6At";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VM1tADde;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3B606A32C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA3B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nLS/r6At;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VM1tADde
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GeYv1475095
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o3HiB2vJRWEBxUo+fvEqRZTvriSNZji2BGGHNXkYQ8Y=; b=nLS/r6AtWhGq+QJc
	J0oiuyH5JRdARl32y5qkdYINZB5cJduI03RlxB238VpnYDaLbmUG9iqZHj/d9Wxc
	wMKDw6zUmZ3+oO+MipcC7cjodcfGZPpgcmI/cJKf3TFEv9rrbj6araSwgGdz1mti
	JehdOnQCrB3zkDAmkV3IL6ZyGjFU97Oy3ndDIgiVHeVOQmoeXENzgjLluXfhOCyj
	2N9sL9a1kG+tJeYdlKl7BUW65s5aKLtOp4AWfV6qAyF4/OWNn2rCmSn6PhUV5mV+
	6QO74eWqv5MsmufPwwdX9AErpCf61T4+iRQCosmQx+TeFSRE5p/GehKrBH14SCKP
	MP0PKg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4htbx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:41:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f2f304414so4053826d6.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795772463; x=1796377263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3HiB2vJRWEBxUo+fvEqRZTvriSNZji2BGGHNXkYQ8Y=;
        b=VM1tADdeBkw1c0R9KqrypaBQeQ7Cv/fijFi4jqICKhCL6x1MejslvntqtilFoP9Naq
         z7E6w26AnHg7rbZLPv7DBSXxxnCzblUwFemOKy8w/7Vtb5I4Z6ZGWYapQ0SWqEixbe4l
         66UvTlkrMF6QtmszwysmRa4Iq7qDkQFJgGTQfU1vHybXTNZJNt7deBD2/1pLbzffH8KU
         h6s4Nmebm6yboLJ25929ERfZ+kG0Cddp7s0g0Vsjm3XPe24wdeWjeX8nHQMliXBoCvNg
         7nlbfPHLxKHVDjK4UdZ4X276sN2ZHNfRfmX93phcqoyoQQWlh3GGSCMftAbN49DXB3Sh
         EEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772463; x=1796377263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3HiB2vJRWEBxUo+fvEqRZTvriSNZji2BGGHNXkYQ8Y=;
        b=zuwjzZWpeJokDhoQKAubniYWnApQ3wDGHp93vfeOBrXnucjbRBg7hYZOox6kF1n544
         v47I+yqNrxmGFvta6L72beVPEX/v9qx7XrCW5UbAahhYOGQS9B5ALmzDw2xeVHqXpTVo
         81SxN1dDoLl4BWwNvbNMqH8kAIB9gTj9snULmVforRdEjToO8vl2BnbsqVEEZ7n5/oR3
         hEKILs2AEApK31WLeSFxhc6Nly3u2ojVLkS8IIr9mEWVCeUcp8SWy+XTT8ulfPP1nwOo
         6KBIhDMnmgbzDAxHzDrKbeLnhGmo2qF76U368QSbVgQFsEzr1p4bl3KWI6GizdNdU4CJ
         LPcw==
X-Gm-Message-State: APuU4Z8Ztxc/5T6/FoDka7lLikBNrDUEmYrKUNV0gCNkShYgaJu15M8Q
	5tona2LpaDbYbgOc7PPl9QENDw6+4yzvBSI4GCAldlMbIyVgBKvPSl9uVCRWdq3exbRNtxwSDUk
	UCWwLp9NH4NZygBbmXzXgZBqOGKM3+jUQL7dNy7SeMHb8zgvGX/uOeNZ5FWfzaw==
X-Gm-Gg: AZFdTZe53+kDbdPK2JNuVTEoUM80KK4sS8RXII6VEW0ErAY196fu9/TH8yOPR2sw3Ee
	6rmLu+yKTZGVrh2jc1bU1Ci/Np9OJmb/cfF4avMptgUBLWLfe+3ZN+1M9AwTvAIYRTaLGG1mv9Z
	vqF8EwsJmOPEfdVABylD9pmJxR5vVbVO5JA/yMLOMwckdMLPDh5xhgk+f0XH96Qc4sES8BrZ7ff
	+62snG6Uc304lLoIpDfD4sEKiDJ2CcdWTjyEBots8fh1jxKV0DcLDtVOvS0e396g7cWz+orsxi1
	ewC7cb/FKsQ6swbk25bG8QpRB3MDBKBk3M80wieaE9fOjEfCz9OjCGPcAgV47UYXNNdXpLO0r2w
	9cKeLQTZ3GWjMSS0+XrsCQwl1lVBRF4grxHGCbuNhOOQWRZKprP1azggF+5TTl/moWq+9kUc=
X-Received: by 2002:a05:6214:d85:b0:921:9965:89fd with SMTP id 6a1803df08f44-92199658a4fmr1859976d6.0.1795772462891;
        Fri, 27 Nov 2026 01:41:02 -0800 (PST)
X-Received: by 2002:a05:6214:d85:b0:921:9965:89fd with SMTP id 6a1803df08f44-92199658a4fmr1859526d6.0.1795772462429;
        Fri, 27 Nov 2026 01:41:02 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00232sm870424266b.12.2026.11.27.01.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:41:01 -0800 (PST)
Message-ID: <945486a0-ee72-4518-9537-72c4893a4bad@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 10:41:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Propagate BCM vote commit errors
To: getfeus@gmail.com, Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CA+m4KrCGfS46jvTdXiYorW=rFg4wOKJ=UHKDXq1a4qfN0r5x_g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CA+m4KrCGfS46jvTdXiYorW=rFg4wOKJ=UHKDXq1a4qfN0r5x_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX4MfPnNnRNWQM
 KT4t8FQJU05WQoImBwzt1V+WmKjfRxPIk+ehokCLAnBPl1P41lDidC/yDhZ9GFPssjLV/yMQyna
 YAwIipaDheLR0wrFRdhPiDfrlz3Y8Wc=
X-Proofpoint-GUID: zO8b0lcZUdwJju469EnbJpQqcTCwknS6
X-Proofpoint-ORIG-GUID: zO8b0lcZUdwJju469EnbJpQqcTCwknS6
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b09502f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oBFxeG9DB_Cd-dzy6WoA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX/gTzheDz7fS4
 j3/OZ/E+injsKlAr85ekRcQmAE/WTfvfTDN0LGEKzQOzxzSKFx9vcqnpVzRBV/5R+hWHyliuI4u
 QZ3dui2hQDDJAIYUm39eqQnSimrUxYESM5d+8MUrQ2kXPhH8nXMPAgIdZOoAAQFg8EHO7kAgDQV
 JWHd/Amx7enJZtSlKvpRwhN+gngO0KASn0oZN0lRMoXYpdPse5hE5CSGvvwjEqymaDoxJmNFNe3
 KL7RqNXPtzQHxjpCP0qbKfU/VIAJcN/UQaG2sP0VNpuqytqGPFBPItPs4xnQ94u2Z6Rt7FvWUVo
 xupSNTj3MSgH0gHlv3aRMZn0j0KPbhsKECemevMbOgyyKt56rB2ImaAZ5TEVNT5Hfa9YoyGsdA2
 Vl76v4eCE5YpsTFm5cX8lS6g+Nz7H+7YzRy9NB0HMYM9gRvGXi5blrm3lv0Idw+TJrJnqrx2Qro
 5QL5+FMWgPfoLvSIMww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270038

On 11/27/26 10:34 AM, getfeus@gmail.com wrote:
> qcom_icc_set() discards the return value from
> qcom_icc_bcm_voter_commit(). If the commit fails, icc_set_bw() sees
> success and skips its rollback of the previous bandwidth request.
> 
> Return the commit result so the interconnect core can restore the
> previous request, attempt to reapply it and report the original error.
> 
> Verified with a mocked commit failure through icc_set_bw() and on a
> Huawei MateBook E Go using a one-shot -ENOMEM injection in the BCM
> voter. The caller received -ENOMEM, and the previous bandwidth request
> was reapplied successfully. The ARM64 kernel and modules also build
> successfully.
> 
> Signed-off-by: Lee Youngjoon <getfeus@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
