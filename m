Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207312367D9
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127020; cv=none; b=OtxZkGl3hkSPxFzcTE1JNl1gReU62hljzy7wxRhwylpXV4cP2EQLqZuxUam53kAFk1vpYhS8IObN0uSva4yDmWcPKkOuRjkCGuR2KJ218RemSLc075bVpFkOqC9PfLgIcJIbscNdugfeqIrLU0FMrnhG2tDiqa4HbEAVXUQMdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127020; c=relaxed/simple;
	bh=hveTFc5TuR1bKQ6wXVEDZpt4zR1cJ5gHeLtBc3YT0EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dks3ybqKraSG1yYk11h2sapoRVWr+Kiay0H1/jp8BskkDhThiS3e7JU7MyNq5/W1WDS9FIKhmVVTYXmuFHI0dluMM5oZLITgW/9H56eBuPlLMkYGlqR6+d/Z8EqymJ4V7Ojy4FIbw/hX0pMDbjGh7b55W/ad8lVxDQtJ8iiKFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pz/vDsbV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AeaRGXvD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pz/vDsbV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AeaRGXvD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGWtpY2091147
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MIxIK0Wuilz+yl4PP/k27Iy80ZOIVvKw4mIo1azk82c=; b=pz/vDsbVtXDpaDLA
	RXb0yTPq+pa4kGzKlQgwRXaYiAwcvn1BL+ftJhNufpHGwfK4yh3SnxPA9dIpCmVr
	sknNhlY70m295zXJCEciJNfiZs4/DxxLciyh35IHH+ytoGbFfwAaLy5BwgCUbb+0
	kdZ8jagWJIx9rYTtbBBegG5gHkfs5PLGyt/wuP7kXluURzFbTn+beeLeB8jQ0ZAI
	hpeiDXtFcRoQquLguHhijUX4iTgG72Kf0L6h3+GxcSAchtwHMNNNbNjJjGLVTPxy
	NGbgoWHM7mdwrJo9MYyRG1Fnc5dW8J+6S/RjlCpI1XAygnQl/cqro8IiW0L+VWrw
	A6HXJA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rphupd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:56:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so82108051cf.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779127017; x=1779731817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIxIK0Wuilz+yl4PP/k27Iy80ZOIVvKw4mIo1azk82c=;
        b=AeaRGXvDUoe9n5WCN1UHlHX9aOZYW0A/Wt1V4M5nwVzae+6ezQ3cvKOtnYKdvl4V1B
         cAQoGzvEBwCUuNfBt4MbAPAxWMhu+HkE8z/L1Qo9S+pPtcZmx0CI0a//qdUNJtfMG9lL
         gDk7TwU6pxY/pJWY9SlgTEiiqmyUPwVmkQFrSJINSH3J/Ntd6CNpJRIlUsTt2sndW/2o
         7SW9qnl7vnMqtkxsnmOsbOSRGN3g+5fTHjipdFKLJkV5FykQdu6gXrQPN6tbVLHe1scO
         38K0grtuKTVy30Ub0iKcNfswKTKKKpqYtymP8M7k85z9bVixzpi+/I3yW1/yVnI+YqR3
         z3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127017; x=1779731817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIxIK0Wuilz+yl4PP/k27Iy80ZOIVvKw4mIo1azk82c=;
        b=fH5Ocjy4qqKk3tDYuHAEncmSvlHX6ZuYpcaOlGvzRSumhbKBNMqMXgw6DY3zhd1Ew4
         +jvqhIjj0R0Ds8dFuxhCt8VrZE8FYn6eSGgTgOanQqR8s0K2UPsX8CNNonlb5Rzh4Bd4
         Al/9nztGzprcPOYhBcGuZ5luOok8vc/h1k/IvisWSewTZIpas08kTwYj+2QowsV9oRrx
         aatz3pYpT/5w1P1KZLeVMUmagTG8AdJl4gHOkBqeO8i8ipAzxCCFp4NYRkMhAiOH2uTo
         bbToE/q9axeDOnwMYXVCj+K5EE6YNL8k/u0jrdE07Y734OoUYZ1hp+OBz0mTRVECpTFv
         2u9A==
X-Gm-Message-State: AOJu0Yw8SO2LHlaQzWta0gjGc4U/AfU+UCBjkLIh6lRTCQVwlZwuCBo0
	yj/I1ZjR0tviRkTweE9AmnYIEIOWZFzNhvagqkPBId/KOuruPwYL/JzQ9IKYWpZmSMB88SXoM1e
	IFNmUQM9WKUurcHuTjsMfWQljmS2/D7oK4Pr4hnTY6VmUG4umaa5JGEarMDnsdg==
X-Gm-Gg: Acq92OF2AB3YpcWp+bqrhL+5SwL6gG5YrTpraQjbiZ9TJu2ybn6/oQHJ1Ps77I4hGo2
	ha2tGvol7WoafmtS0V77KT80ZDUokCMij7NQQoafVEze2ZMfHNyFJw9463raGQL5GPb/6Nd8lfm
	LVABU3L7jfrjFKEXPD/HzUjzIhHTdPSxH5cWFnFWxkpLFEK0U4zevGeVVpeK8nYNfKKUytvMbVf
	XYxRtbxAoWvQzc9bLNf5GCjnfydmfMSYNfb8fb0KqtW9qMz0ApwCb9JX2giOiYta2BAC3WWOHKa
	wKWRg5ESd3Ur+JaawGFTwi4PkGxNco57dc2735NnF5QcxpgI5R5B8hDZLmwq8p9XYUUnpAmpBop
	F1ALSlzn62COA3yGnPj4h2pAAoYqC5jJkCUiWetTqn57fZm/bpEmun56sA6fNkS5G51z8bVxrtv
	ZaUmnvaitj
X-Received: by 2002:ac8:7f53:0:b0:50f:ae44:515b with SMTP id d75a77b69052e-5165a0df71dmr223765211cf.37.1779127017476;
        Mon, 18 May 2026 10:56:57 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:50f:ae44:515b with SMTP id d75a77b69052e-5165a0df71dmr223764831cf.37.1779127017114;
        Mon, 18 May 2026 10:56:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9? ([2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm299815105e9.11.2026.05.18.10.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 10:56:56 -0700 (PDT)
Message-ID: <1155ed3f-12d2-4a98-bbae-b3dc61846e75@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: imx: do not split quoted string across lines
To: Mayur Kumar <kmayur809@gmail.com>, rafael@kernel.org,
        daniel.lezcano@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
        rui.zhang@intel.com, lukasz.luba@arm.com, festevam@gmail.com
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20260511174255.215207-1-kmayur809@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260511174255.215207-1-kmayur809@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kxHMktJbko6g4luNPXCuhKVjZUuACDiZ
X-Proofpoint-ORIG-GUID: kxHMktJbko6g4luNPXCuhKVjZUuACDiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NyBTYWx0ZWRfXxYkv/UyGDnjp
 ivoR6Ah57Ngn0+K/OsYAKCw8HgO+C4FPkuwX3qen3O33NTScxLJK/2/M7tu+KEbwTTlR5MiVulV
 4FhCfjgcrWBhfUzr4MrbOQuzrDIi65zTqBmgeZxd94XWkc0fGhxgKDhgv5/ZVqypGYf76098tvO
 J1zDC0Ufn94ySEhMXH+rooWvDpmV+bCneWjhF+XwuhT6IgHaPo0vflBNg+fsvxxbyjanmYg/wkt
 aJQaJMiWnmDfhB4UnVE//CdcEj6pVQAX8hTlhjw85AUWXsvi7T3wre1RlKwhi287ak7wodd6ib8
 FLfW4LnBIC92o1N6SWxY81bjhcd+xUnSPNbT4H8236oFD7G4Pop+v0CAFTsgoE7tRebQjOC7g9z
 p1jUXFmCHLF+QRzhkmYgDOhuE6h5mVUPBKuJyTsx5/xK9gEPXXvLv38GZjUrVcKkfkmaszOr8Zy
 kwDvoMdPTWaM22lLQXQ==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0b52ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=fjfue5pgiGPxETPXDXYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180177

On 5/11/26 19:42, Mayur Kumar wrote:
> The checkpatch tool warns against splitting quoted strings across
> multiple lines. Join the dev_info message into a single line to
> improve the ability to grep for the message in the source.
> 
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---

Applied, thanks

