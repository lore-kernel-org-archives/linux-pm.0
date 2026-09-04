Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58802222AA
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512477; cv=none; b=U7wRx4MAE4+jTF4oPpIn/59ltuw1nAq/3WLhBmh6vWole1jiadmhlevSOD8z1lBwLWTKRvaUHjwq36CpELkVxQ/O6KD6qMbkjhCDrDRVgKJDnEcQjRQTx+HpWiHVK/9FufaSR4MVn3CNP1hRajgT0QGRs7a5QWrYw5KLzNSHsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512477; c=relaxed/simple;
	bh=z8mUeY8jdDe+OPla++cCBqYJoVtldQxpArBHUi5E2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe/NbT2US7GurdJADT+ieFQ+05IB5o0FHPCJ8EBMFTfLCpIeEJk+8uVdbAJ/rhJu3E6S6n+ANpJPN/IxPY1dHIauIg0+U3hav9Pim/vKezyt0Hd6h5fddML7IbWz7g/o0mYdh8q7a6OarLRTVe49AX1k0Fnauo5muy+YEpFh/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdPDAK05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QwS/LRWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdPDAK05";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QwS/LRWe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mfDU2945685
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 09:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=; b=jdPDAK053fGQzOXD
	4cj+xPyScRRHFDeNL8zcHzs4mOeJur0khdg/RqOwN2LWNkaAIBRuQ66CDy9SNfUz
	cdjxEZOdcuoo5xTcBheqPhDXrE3G5fga5X8nlO191lDpsOMTqPXi6oWY2jljfKQV
	59dl4zlsOQKAGJaFwidGakLayrYMXJrPbLTGEjifEYBP7lgmaCOAlYeIx9GCaBDf
	M2HQZMn55+SmjevbfDJp9azLFpkl/eyqSfKf8dsWQyuZeGef6wUQhnewV2I6jRla
	FTBgBvCfz4S00/OEhRxPpzd4j/JAyFQY6vx5JFZwoS0qJnO2TdcU0HCQ3mRYVUjR
	lvuEAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd0qf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 09:01:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfd1772d8so1662751cf.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 02:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512474; x=1789117274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=QwS/LRWeEVIhjKgkJCqHF99IJ+vtzoMWQL8MzRkkZe92HrORwTi3paXWXqzLOMQQ4F
         7nw0p7zKMz8WCmKjkESHp1RYXFAZExzWqRs86+4U/FE6N79NJAVYO/bVb0NHbrOR4ly9
         MgChSKoITkdd/Q/wZ+GZLU3u987ShDMut1Z/h7nHeK/ej8mPb6xTdgjZJxXaDd8YDaWK
         iV9JojoH6K1Wta1/MkZlC0IZxjPzwReCpuZoFa8Swbc7gxjGIZNzhPQ/J9TstR5fGTV3
         SqsLxfn8wigxWqYYaA/aefTkc55Kaoh51cyM1k+b42OAj5Psq8nf0MGp3CHvaYK0CBqq
         yRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512474; x=1789117274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=J5/RyTS09sJPJ0iOcD/0mbEY7FOQShpmjmxz8yqxDN+lyuexqU5qKE8/zdErKuheln
         d12nRErvtZrOXTTp2NwEo1Jn47fNc/imIgo3v9Nfi7lNCWSlNrXXSE5eEIHbd71W5wkh
         UyYjl0NpKxl50MvQ7DVfrN/RaIFErLfDCTN/9jyzsn2n7WLvQ5kdX6UV9+ONLbMABTqA
         /psRv44lmVwSQucAfMNseb6IVC230oBKSQPnvYNn7yGUjKK0LneQEFY6/WtF/UApG+rK
         BhqAocV9Xxgtfvw9m6Vy8KVled9JK6eBnHmZSYdP+RizvDMig1BdiBnvOCu8ANnU6GWy
         Nk3A==
X-Forwarded-Encrypted: i=1; AKwUvBx+KQJmmy2MI+1h5UYBnZrzAV590keRoLbj91Kmzs+YaqByEmPrPcYClIJOLh8Bbc+dzeJonF/B3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lW8SDFxWibK9MYfEYfrp4CENTusDyWqVkTyhzUpDQ5vkw1quvi
	zbsPu5lqR1jYOT7QJNdUQRkIgIWX6JQ/eIop7IAwBUs2gNiXJaTn+AaQw1ptseQkGQf/T7tZL3M
	iqFD4OHpGHKpAJSM5QERAo+dEit336/1Jvjg+loGpHbJQlQda/dYmYCYDYAdb0w==
X-Gm-Gg: AYBFou0zRrW9ih3dMdloK6B32AowUBIX789tAhmhIIcIRa1Wwa0slKbPCfgDIMlHzPO
	buIODq4rgxrbDobaBiomacXihSqEOXYQzA8ObaKUPKqsXkGk6jIKW+xjd9o/lu9mVTz4r6+pgUO
	le6hVDiFvjNlyqvYbfD2Mnf3jPoyI475ma0GQUdjYt+J4k7ahnqc6w82LtYsxDCs8q+t1s32ZH6
	W7ZidHJ3ehnFWcml+a/m1oG5x6/FFLWXCW4CpNCXdFfgl7MecE46UoN91HF89oNYbTl1WS986k8
	qJxL997tpHkE21BFnLuBGWqLOMphi1giOW/yh9e/xUs0y+fawF13aaPcndb1j8sxhb1+DdzWlup
	AfZEt/ciq+sw7xl9c5eCCVQ==
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341378585a.1.1788512469165;
        Fri, 04 Sep 2026 02:01:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341372085a.1.1788512468661;
        Fri, 04 Sep 2026 02:01:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm76155866b.40.2026.09.04.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:01:07 -0700 (PDT)
Message-ID: <b245d6c2-825c-403e-ac73-d569820895e4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:01:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3ng32FOklwpb0on6Gf_Gl-qwQmjv9idE
X-Proofpoint-ORIG-GUID: 3ng32FOklwpb0on6Gf_Gl-qwQmjv9idE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX/tFuLsPwTaRK
 dZe9WEdE3Yi/PkujI/c9Ix4c7rZ4ZV01xf2SdysKO8D2JMtMaZkHLQJZ+lhtI8EXWf0a7lekE/3
 6vF4cAZsP8t4uN7g1jYxXquzEuHcMHo=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9a88da cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX6GNrkz+RIdOu
 hwEtXiesZRDpYStvoK1H2Qlc/AGgjE3gTxczrLRW53goIIhc1AVk4G9630L9ej2pyf3U4fuWSG3
 tgS7HPlTx9Ex2g3XIa1L5pwSnGM4KPpkL5LMUCUBELpjhuF5RLuT9VOwgvZd5p09JcDD1x1/kNr
 RTuFcYEud6Xty9yVd5KjFlVUWYk62drsy+GALHjoIy6R1V0zGz2d5WSaWiGQrlgfkheGJ1K3+R1
 7NQyO8xE8+LjtSRncWxnFsqcE3xOLy6ZB1LOBKIzn8ZHXvTmxoDOF3lDg57D0cYdOISfgSVgARV
 buH7gwXYBnJkxO+anrLV4IAhdu7PCfA2GGyXKdZjztn+P8R+tq9rRS/woRiubOaQsNpOP8T9OrN
 Y1XZruzeVtV7IJ5jYCXmlAbuDM6V7SBA9uSc9rf5PQV7bQt6LOmG8f7gJj+hha+D9/cJY1Q8fcs
 3hWr3f3Jnc2I1fspTpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040082

On 8/27/26 7:59 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]


> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;

For !se->has_opp, this silently does nothing, which presumably
may have bad consequences if the caller is unaware

Konrad
