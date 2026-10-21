Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599226;
	b=SOKRWwbyma0F/G1COB99d7px74GXOHzEfNdugjxhyk9Y4MpUy3yjINdVSG28w6GvRV+e
	 6sT4RF05Zoqbf7qrwbRP0ii7lrgLZPSAQQ55rvM/xRItUGSSlHAPoJ+JQexj0Iw8gsP8S
	 csr3p/qTwl5Yxl5SgSJjC2ed9hAo6UBpihUqkdOEZxeqSWHDsxZpG0LotFR2B8ndl8DNL
	 tYgqdLJCGcAuINx1Jvy/sQyH3uehErpiBF95zZjU0+OmaaLMdfctc7xlR06lpBy2psbtJ
	 yZQ7+Hu5KsMIYaTkIuusUeN8MHt726oxAEjGj8+GeF3uginnBPyl17xZ5qagYQE9TYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599226;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MSdcI0cnwQnio07RIHd1iocjpv0ki/XQsjKsPjSVD6Q=;
	b=LdkqCOg9stWirSFcs0cHX+xI5u3sgORuS716p4TzvWLwBl43M9gbxi3Yyd95F0H9O22l
	 rlRIEF85UUzMIhEibMHvInYagj46KqyH1lYtn3ZaX4HO3+EJFml/6+zp2ZNHS/ROrpeXx
	 9JZ/H63wou7Bd/cosE3duytMTF+J7YE5P+9E3QmFznbIt6J5exdDQoMeKo46xGIlMo2fn
	 hnjVXQHaASxNd5dDKbo2Nv3VP6Bwn5YUDRMH0jowgck8gAyozCpBQpYRRrZXpbZiamocB
	 IRIZLcevFSFOBLjzMwjoBixP5+WwR2pXNMnB+FtMcuInoZuzMob3xxF68oBTXoviPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X49dvhdm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="dr1KX5/r";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4B8606A339
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C4B8606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X49dvhdm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dr1KX5/r
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU5nU992237
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MSdcI0cnwQnio07RIHd1iocjpv0ki/XQsjKsPjSVD6Q=; b=X49dvhdm1Xdk9Meg
	9iHEBDxw43T+t+syX6G+w9CK0ke9rlD2iuQJ7VKforUmMpp+3PKkuPZDHmRAdyxh
	G9YlvJy7Y8ouNQNSCYgJoBhc+QGKs4AaNZxMky2BvaZkfN5lh6UAc716uTroUOc6
	G6jnrHZlJMo0AeAJt1AVsgoC8jZvOTc7AYYfD0gAG/V8fCxEray2rbWCZvYlhBmv
	QgbM3ymx1r1yW43oNKf5TY6tiUQYzQiGEgvbeJO+GG4UOMfP9gRHPeCXJ/G9KCxe
	DTUAhyjp2tvAoqYDps53mEraBd17e7MTDhkNVbbECCwqOIeAYEsXLQO5+A/5S06A
	0RFFCg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3yep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:13:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd652c0385bso482647a12.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792599219; x=1793204019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSdcI0cnwQnio07RIHd1iocjpv0ki/XQsjKsPjSVD6Q=;
        b=dr1KX5/rRpnzD0AiYJyQtFsFn40szGv3RgP12tlvt+6y/gRTKkjavOiOsKf8l7QlKw
         Wea+NFd9zdOGVrtWxXqAv+MBlA1u9yxYTAqEnKfADg0OtUl49xDsviOnU4/LlGrm4jnG
         RUKNONj5SOBqVdb9CJn2VHbzrtbpLPR9806cXZLjTm3FrelNfMlwp1VkIy6wQYSoRFT1
         d6Vpg+nJ7Tlg/bwsv8wb5SyN1KCczGKV9Ta50TicPxkw/UdR+ltCkYRdelEqtqYGCamN
         frYpty3ezp8aZBM9I6j7wIXYGqvfvDZzg3Lt7EvKMxtp+gAYNX0htyKeGw74um9qmk54
         +58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599219; x=1793204019;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MSdcI0cnwQnio07RIHd1iocjpv0ki/XQsjKsPjSVD6Q=;
        b=K1yDFrnzQ8WZRoU+2g1subx48GdNlumug+RZtl3i7BfvApbAoQyIvVdI18lIMyYCn/
         wPlB2mYdCfrVLuibcnWHm0Gx5epyB6EW5MkOLz9/Q5A5FcFoo+AJGrG8UlACdkXOjDSU
         UYDLul1OWIjDOPuMLfnAJaQOEoT/5x+/441HRlk09mF/EbQ8OrpEVdjHbDPJzFwLQsNU
         +OwjCL277YQUvWwCtNbwRihQZ+wySopaUR3Dgt0yji89SOKqMKqtmPmPByruqhnxVi02
         pli4llKfZl17YmB10fSutDX5VdHDsZ53mjkp7Vd5GKHUh4bqdUMejyDcknDuttv8uHqn
         OBbA==
X-Gm-Message-State: AFq9FYIGrROxMw4HfIoQQy11PNn8XQCzJFulN3AFQOwRxxlj0PNOik0F
	/R4M0RQDEHtfoeHvFxn8rtIuhuI7Jn0Tko3g2l/KE9BpuhMp0r71TchSh+zKkzuNqBltwORQxVL
	fsUYFIeDvQ2fh3SmG6/+HJbcvqGwXFZ2wz7E/3ABefR0TgUEbwE08gbTHf1nm/0bI+eZ8Og==
X-Gm-Gg: AYBFou35kZgaDcJhrN5oFQ1fAlu3YWuNG6qtWdi6iZMkPHPzsf9gh2ZuhPjQE2zRXZh
	ZArC1wb0m1pUv0/nnPWpae2CM1gXcjDMAia3X9mJ//qh6UjgBCgz7K7WF8e3lT+Tu4eLOm9w4xm
	womPJeROcMt/3Y5eJQ79zdHyihi3KzMu5quuMaKkAh05l7eHD6XiNXc00zv4UepChAhqcWxIsxH
	QTeAa+CT27fUPLquQXanl6pcF3mjJxZxIHPqu/gnUVoq32voddEdBtGgKtx4EoNuNyW8lvARzcu
	6l6PJQIItZI4AUNCc4XeR+O2vsHEjaGKZKJxCHzwEJZfZuWDFtEtbXuEQscz0511MbiopPhBxIF
	AxmkFoasBQWa1MBZlPQty8bC3GSkXeTOvi+p/IEyhn8mh
X-Received: by 2002:a05:6a20:9150:b0:3e2:1a24:fb7e with SMTP id adf61e73a8af0-3e287e21a6bmr2249889637.40.1792599219118;
        Wed, 21 Oct 2026 09:13:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:9150:b0:3e2:1a24:fb7e with SMTP id adf61e73a8af0-3e287e21a6bmr2249869637.40.1792599218635;
        Wed, 21 Oct 2026 09:13:38 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.81.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm1131642b3a.41.2026.10.21.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:13:37 -0700 (PDT)
Message-ID: <4dff1a97-8c44-449c-86a5-5eac047ab909@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:43:30 +0530
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
Subject: Re: [PATCH 1/4] interconnect: icc-clk: support N:1 master-to-slave
 topology
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-1-fd4c2b3cbdea@oss.qualcomm.com>
 <21a95133-eba9-4655-95b4-9aa947c081f9@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <21a95133-eba9-4655-95b4-9aa947c081f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e4b4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=rZLzW5DhxuwyX7/NBrPT8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=L14mbm2-ywthVrTR10cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: xbAMexZbn2BVIMj6cWruUmjxRTbZpTAR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXyAzrFdtpl+zj
 2twUBAgYNousV9oY9lLgtOdN/0CBcXetEW7SDv3Jjt7DcgEmFFJJzL06ZT7a6p83ZcXeWDeRZub
 Jcla91r65YxpyQSANhN05UGiMD23g+8D4cSMHbVj1gM99rbbW5hd/bXVk9uD2wDb/eABwuXuh5S
 SBj3FMMrFqvmP1/fczwgSTiLM4NpvV/3fg+/8Z7QzcOHa0c0DNDm2k16/pWbp/dwa8HW0ikFEpm
 hr8znJDv6mvXH0r1LBsMfOdgjxHfg8joCBYZ4krPDlyONyak5OSXCUjcqbdb/QiYRdsa2G8M+4n
 5T6jJEKfxwiIGq+A5VZWEv7dyCotA1ZPI4aQKWNCdh9/7jeRFnmVdyEi5G9VxkvHeeEM3KogQ1U
 aEX82tQbw4Fh4FhHwAnegC1DhzNADo06ymFWXx6u2VS/vPXdYAIy8NWQ89mGOA4UDY4/gnYI+Vf
 bK1XgeShrWlvnGmJfvw==
X-Proofpoint-GUID: xbAMexZbn2BVIMj6cWruUmjxRTbZpTAR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXxn+1DUmNuijs
 /gq8efCY+ziVcqlylAiBvE3gGkOZKAP2Dc4qbcKh6ZA7B3AeS+MyMG4SdqoecIy4WSBdBIuPOXp
 iQI0+3HDWKc1jQtkRiX91PSM6fOZQcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064


On 10/16/2026 7:42 PM, Konrad Dybcio wrote:
> On 10/7/26 8:50 AM, Kathiravan Thirumoorthy wrote:
>> icc_clk_register() assumes each icc_clk_data entry describes a unique
>> master/slave pair and creates both nodes for every entry. When several
>> masters share the same slave_id, the shared slave node is created and
>> added again on each later entry. icc_node_create() returns the existing
>> node, so icc_node_add() hits WARN_ON(node->provider):
> [...]
>
>> -	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
>> +	/*
>> +	 * Multiple master nodes can share the same underlying clock (N:1
>> +	 * topology, e.g. several CPU clusters voting on one L3 clock).
>> +	 * Aggregate the peak bandwidth across all of them before setting
>> +	 * the rate, otherwise the last caller wins and can undervote what
>> +	 * another master already asked for.
>> +	 */
>> +	list_for_each_entry(node, &provider->nodes, node_list) {
>> +		struct icc_clk_node *n = node->data;
>> +
>> +		if (n && clk_is_match(n->clk, qn->clk))
>> +			rate = max(rate, icc_units_to_bps(node->peak_bw));
>> +	}
> GPT has the following concern:
>
> [P2] Recompute the shared clock rate when a master drops its vote
> drivers/interconnect/icc-clk.c:36-42
>
> The zero-bandwidth path returns before the new shared-clock aggregation.
> If one master had set the shared clock to a high rate and then drops its
> vote while another master still votes, the clock remains at the old,
> higher rate: the remaining master’s icc_clk_set() is not necessarily
> called. Recompute the maximum vote from all nodes sharing the clock on
> this path, and apply that rate when other masters still have votes.

Let me review this and get back.

>
> Konrad
