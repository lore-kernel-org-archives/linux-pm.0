Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8BA3783C4
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125510; cv=none; b=k+qg8U7x+jlr+UjLPk1p1CC7mELfOQEninW8yqLi5QJQTnOU75U7+61RgsnwcUKYQ92uGl1lM/oUbxYoS4qyp+WDMW1UNPdQwM7CRdtcZYCfXhqEGSVURCKkzJTAoJaFgrwcdKAjRzC3E809dak0UYIDMYFE5YS5J8xISsG2uMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125510; c=relaxed/simple;
	bh=VaTOs4+4dswaW+DNkYBuLLXmhZgxYKZKmrPqfCpTn9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv59ZDqCEfySc5ByHFR+SaeBgUzEUv7GgV48WY/8Tgcq/kPpWRaifKklMHeFUO3ygw8ch7W1oOamhArsxWbmZcp4kOM8Hrzsu0G7vCzm9WaFrhpTKs88ccKf/m4+ui2xKi1ZLAIZWpf/D/VBy4cJPf55jce+FJybwNTZEm6TLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e2FqgVmA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EPk7sFVe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e2FqgVmA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EPk7sFVe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MAnXho2063121
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRWuT4a/W1vHiP4VCpkpuuEyUOBb8v5GbViwADDHBes=; b=e2FqgVmA5bq24dvf
	+1jGU+x1GyYipkuo0cy56ZQ644oRopGsax8AyF29bFkeHBqE9w1+qlI2c0EmxZK0
	PFNapeE3iKIlKfi8wy/m9LZSE55jKci8vOo4R2rq+/TwtgkPxCyJ97J99xflP7WO
	m04BUSmmw5NR18F4xBFNZbljZNZZQvqEF2PGuZyTyEyRFRY5fPjCa1zjlUvswQQ7
	RgzgoCUyRy6PF1bx6AwSXj6+vbYs8KQp83trV9lDuvjIWneUczrKfvK8Aey4RPHQ
	0gQ98PWEkoHzIiJwSVk6hL7JXvMoT07aaWkLjYIbyrCeAxJ2Bn6ED2fktu936agE
	20lSCA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewk32x6x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:51:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8df7f21069bso6096706d6.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782125507; x=1782730307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRWuT4a/W1vHiP4VCpkpuuEyUOBb8v5GbViwADDHBes=;
        b=EPk7sFVenE21JOHxE9kIbBgea2IqH27PEu4DOVz6ijlJpOkpg86CSQochdmgaquyhF
         bU9mro5qlsGiqQ3H9U3Q0PBNxF9+qPHQnkdwaQUvX/66vQCtIVl8IWN9Ay0BePeAemwk
         HTwzM6WyF+IaSEV8P+rwtV6QMyM9ZDaB7Gxq2XYXoh/sZ59zgSm9artD7uRVmd49dyBK
         DWauiQ2HNd+ZlSQgB6r2Yphsk09dpu9WOdfquqBNEiiHFnywoWrlrw3xaPy1h57FMUqZ
         cWy54lCoSGKfcyg2tpBap5q3K0O6IGfOQaTke8EoaQUQmNszQfWbint7voH5hb3Sr2s0
         /IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782125507; x=1782730307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRWuT4a/W1vHiP4VCpkpuuEyUOBb8v5GbViwADDHBes=;
        b=OdRNiuDp6cIUNMNbQNvHkvs3cOOLyZPiagjjsyNrIRc577Ag/g8XeDhuW7gesYF2QJ
         2dYcGdIvjkqVSGtrog2nmSFKy0EyaX8i3qGtHwBHtbRt2gv4y1j2psgnNlFc20ZKOxtf
         JIZkrfAbb1qOpHbqsPKpIyg/wE0ZdKNk/v/a5CbW0QWoitPib/Ya5lpNkpAyk3m9PK/o
         RI6hL8i1VVsHnxDxrW10feCZVDrSoXynBhNHPeUR9iyOrNfWHwUvzn7U0Q5rQQ1zgqhJ
         o7B9GnmSwbLdVucBl+fFYm5YLBYyF3oAkTavcaE579epewc7wg1XJAQbTyAPMfoAjVVH
         BIow==
X-Forwarded-Encrypted: i=1; AHgh+RpwSrnQrcblqDipMPnAbJVm0luYRyDyy/+jZZ/7VutqixXjemfyla0MpwRU/xaUEIZDhyh0RhQEJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvbPbPXXEyHYanA9y3UCR6N6fMTOyuK4yQjImw1ER8X3FHv4T
	8hoIiVWGhWeU4D22MYjW75zSTWIDPB5VSbKY7LRCVO1VzcssOuWXAq8bfOIZ/NiPchHATmPDrsI
	X5JNsYQCh0ydV6m2WPT16ZJ1U7VxsFXhIWQTpaH1XVhlpjHuqmFs+wm/G3Mathw==
X-Gm-Gg: AfdE7cnJqKA/g7+zgjaDgWY/PPh6irbMIO7Xik/DFLOUdyvvH9r6TdDsIq86Q5uzqAq
	qocVqpP2nLy76adaFqDxu+wP+n8jyF0y6Ml0UNISz+JT8EemsmokZYXbWtnHfWrvEq6EzcwIRtZ
	bEpQ/VlLAnfxcr6+Oyk4f6onOF4fTlKPYTFYa6jHWi8ym9qdsEh1qgNBG1pf2rd3X0yLhk+X4D2
	z0vkKi2FvT9+LRpGYYisQNPXPTXLOsxrb0rKjTJy1mCnJi0ZWAm/YHBAL9ZsTCTEl1BGc0si0ts
	Tj5CfI+aMU8dTfHmhBBHYfQEUMhMBClys8Qu/zZNspFWQNp/h1cUZLsLPCG3WD3GQRM5lXDUiS6
	SsftY7QTbzYDKZ+DIaQfALKinne6I6LC3SeU=
X-Received: by 2002:a05:6214:390d:b0:8ce:ddd7:39a8 with SMTP id 6a1803df08f44-8df4837bc2emr116348306d6.5.1782125507671;
        Mon, 22 Jun 2026 03:51:47 -0700 (PDT)
X-Received: by 2002:a05:6214:390d:b0:8ce:ddd7:39a8 with SMTP id 6a1803df08f44-8df4837bc2emr116348116d6.5.1782125507321;
        Mon, 22 Jun 2026 03:51:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be31c73sm3009575a12.17.2026.06.22.03.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:51:45 -0700 (PDT)
Message-ID: <6300a2c1-fe20-4573-b65e-cb1ecf3d09b9@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 12:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add Maili interconnect
 provider driver
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260622-maili_icc-v2-0-18b5ac08c04f@oss.qualcomm.com>
 <20260622-maili_icc-v2-2-18b5ac08c04f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-maili_icc-v2-2-18b5ac08c04f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1LVNPXRQEkrDKUMOvwGHkMeGVW8kGir5
X-Proofpoint-ORIG-GUID: 1LVNPXRQEkrDKUMOvwGHkMeGVW8kGir5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEwNyBTYWx0ZWRfX2ATpoE627OjF
 isL6OWynmSqnfRv8Ex2oWJW3n4cxYKo/qVfgUh5ibI7iyNql6pjiTZXk3/fLidIDf9rR9cky8pM
 xjzEjysvwHaossLbyw8l8+7BTyv3ckU=
X-Authority-Analysis: v=2.4 cv=NovhtcdJ c=1 sm=1 tr=0 ts=6a3913c4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=C4gMAf1nVfw50XILYHAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEwNyBTYWx0ZWRfX2/u2AaNHo7s/
 xtuP7kTKPA6KTx66lAjacXRTY2AhkAHJpCqHmgRD0sY9a5UlzdZ9P2xYXQrvpNH3bo3VRbcLCai
 9qUx7UFf56zOLtl/x/SsllNqTG9E6UiHXsiT6U7/MbLA+MzsqNl/ZYdfJWzxNKdZNYe9+Hu8VSM
 iEgFzunBcI/cwqTJIUY44aAF3lXe9he/lOqXMTxSmJv3pWDxdfFOkCw7OboDhrKJiftDDKjJdmd
 Ueiaz3302ua80nymu2KangFhJoOjHjMkuYHffL3KESw7HcDNZrBrYKp5t8fXwR6L4IU4sPPtwGK
 T9cXl8zJHgA5jnZPLi0CGyUu3L0042i2IbSjSH+r6rBhSbOUJdPNdGympJDq3fEImki/jEWj/Vd
 n0dkcywYDZ9AAABem5a5gxoaFDbg0tCG+lY91IxPP5k3awKG8yr0rcbzlWMEJnRhUMsWdBQkN4v
 l3rBzhkdaeq2xGz6xyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220107

On 6/22/26 8:34 AM, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in Maili
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
