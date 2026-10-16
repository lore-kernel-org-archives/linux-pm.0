Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC24D957E
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159984; cv=none; b=U1Qo2vlkwAuUCZusm2TKdIVLZCuhNo4yVzFhH+O7KMRtDk/bIFpW5Frnh8up4zcr91QtplaLdxZiGwEIaqUhfitjM4sp1x2DexmM5CVdlCMFCpU05md0nd4q61+plmhZkDBOyiuj15LGrDie6E83mwO/cZsKYwWkfy0a+wMyXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159984; c=relaxed/simple;
	bh=Lj9okW55cq/izswbCWi5maI/hYgwlh2oddbUEhyXCU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjqsNU0VJ70FkJgTfrQLeHw4ZDcOwLvQLUBk6z6WuB7Zz9Yp8XbPrrEZ5V4oxl1AfgWDMyPm3XQ7A5A5EWWSUXS4JJp/8Q3CLZENd5A0KXCXQ3b4NziHIULq3Nb0zGett6NcyvdWyXHGI8J9Uz5wQxugYM53gxvlJQQcHQ7y9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RIpDKy9K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRR8akGO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIpDKy9K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRR8akGO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5l1U2153759
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 14:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hi1p+Zr/AI/+p7WdYUaf3hbMm1zS/1PGSTeC4ULoTkg=; b=RIpDKy9KhJbvrrzr
	EgJTfCljkxaFQ+bmMM7o5slaDQonwaCkewjQrKjWU/xSa+SKu0HV9O13dRN0ij/8
	onGC+AVVVNZrIcu3Fuf+RK+6QlLAH+OFbvFtdrwUd67gs9kt7lq0WmFEgqow0gEb
	b8E7FN2+fqFGNTqWTlKxlmC+f+DtLC/eNYTmTV9ItrASTpngMV7/WZ8PtKR+JiaR
	skEM9A617L3FV0q89i05cuWk0F9NtrUcpGDQed14k1dP3Hr/fzj92v+VC/TExild
	BFUhnvXNhouW49jAR6pH5lyNpZmZcHI8sEf9f7wwVyax85v4h7doMo8E12dLmPMz
	X+GWtw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumrug3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 14:12:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c100f6f8ffso270507137.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792159978; x=1792764778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hi1p+Zr/AI/+p7WdYUaf3hbMm1zS/1PGSTeC4ULoTkg=;
        b=WRR8akGOAqJEasR1xj/nafdVwrugruY6GaiSSeqeoY0+2099M+EFRCLGlNwWoUUk82
         a7lD21UbLiQ8ee6RjFmiR6NVk5sHbwYx+MBbXLEoPh4HPNcoHq0LRHQUUIBXnfzDgLY6
         0vCmuTXdmcPcCQY8C8sHXYdP2IUNh/MNU8M1y61IbiTNt8JuNt9HkfCdOJkLismJA0eM
         0pchP+dNh2qyVp3tvMwSnPEgWGq1NSoMhtQ0oCumZXFGvtuSQ5mp+5XlXXNuMWn1+IbF
         WIfglUfkhtrdGzhfkzZAbtNr8KMrryXWDzpiWFIWu207L1ZkRqT4xhNGXBB26dUeUYYP
         pB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159978; x=1792764778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hi1p+Zr/AI/+p7WdYUaf3hbMm1zS/1PGSTeC4ULoTkg=;
        b=wgt3oNe4svdjFH0Mz6gzdAXbfSC7kFRxv09gTiW7s981PxVCmMjH1KpEkVFW/K4YSq
         8r8jJjnq99yv6Y4F4d96EnuWMr3FYlgABT7ORO2cSCwLzs9szhck6xSNDcITYCjBHCvd
         05CcBmoq1ODOjN9HUjtuT/abf3Y6cWpHyf2jEfLYHM+jDPEsA1WZORHPsAcF5PlVqS7U
         5GyhEwYlE3v6Dc6K9b+ObmEmpRDmB1Gi/rRlRhzK3Mq2Ho9iHukEFuG7c53mIVjLlnlm
         TxmGv6ba+ha1LYcWiwNwaQRltyjHturjFDxQ+72QibQCsZldVNivxrvPGBwTseep5lJm
         dz5g==
X-Gm-Message-State: AFq9FYIjKVSR4g/6WbF9Xar5hFsfAcMfRpuDCE/PxFvlYDZbhFo7KHRN
	O4NHz6o2A09j1qpHsOhWK06dUlpDwEOLlhlz2Y5MRR0hDWZq21Thqb5DTZCd/Z+cP/yV2fPcNp3
	o+KnpZo+rXIcX+H1fHdhqoBy2itX2SFeaNaKnG7qmFz1PwOISbGjK28AzgGUkkQ==
X-Gm-Gg: AYBFou3ZC7UUEsdp3eDmqwoVr0cEqW7F2S4148UxkfgBnl4lFakU1DP+5h3QlRiF3rI
	dSc74zh6DFwV3AW8U2c+kCOBnxb1qFeEYRRTcsh2Vvpp/gc/dcPkuqDvl6eESIWOs0tqKDY8P7t
	NaYJLqI6pwJFjZXbSOhkPcrEZyY+rh/uxfXETtPGcj/fM0gouFkxHMF1VQ+U0N/AGcYQEUl35FB
	zcH8A7bBDA7gZxD412cLktMuK0aMeCTO9CFzRO5MM/mu3QLC/0TdmpKdpxjUIEvKdcfe/iOvX0L
	v6y606dINQaHvHQifiId8Pdpty03orFHkPtoMkLomVmGdL1YJ13uskgDGxn+M06bS5bGxHcaalv
	1JnO0/ND8fDwtNzZv80/PyA==
X-Received: by 2002:a05:6123:553:10b0:5c9:6766:5353 with SMTP id 71dfb90a1353d-5eaaa404abbmr55047e0c.3.1792159978424;
        Fri, 16 Oct 2026 07:12:58 -0700 (PDT)
X-Received: by 2002:a05:6123:553:10b0:5c9:6766:5353 with SMTP id 71dfb90a1353d-5eaaa404abbmr55033e0c.3.1792159977897;
        Fri, 16 Oct 2026 07:12:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb256csm74841166b.78.2026.10.16.07.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 07:12:57 -0700 (PDT)
Message-ID: <21a95133-eba9-4655-95b4-9aa947c081f9@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] interconnect: icc-clk: support N:1 master-to-slave
 topology
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261007-ipq9650_apss_clk-v1-1-fd4c2b3cbdea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX3jt6RkufBp2G
 8Cs3HRJiSrUL0OZMa7CYaKb1YZmLRttCH4yO7PG6jLCjiVtwwl5NdCGngwPxgURGX3tKZkfOOV4
 SEzx4zGb44iIHlu/w8iFHDh3n1PlNYo=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad230eb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=DPFxZCFM3FP1ELaAjbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: QBaX0wDF5LbRBQTFvVUk6YXd1UoZ_q0Q
X-Proofpoint-ORIG-GUID: QBaX0wDF5LbRBQTFvVUk6YXd1UoZ_q0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX9A4xACYxeiFb
 reek7NRx0dIu1mCVneTUhu3XmFsjHxXzhwiouwihTrEz07TvAus2eB2lMsfBp2OvwBKEXmXH6ZC
 FU+DUElNTXkP8ZY43fmc7rmBD7jsnT4mMzz4dd/6VR7aWATbEQ+hstDI9g8yLFbRrMNKrb+Z5h+
 8amnSFTwUDrF74hYHi2TAGkNwZSNGnix9ZcogKke9OcpXSJjR206xz1mrFOnHTBJ8nRHxd7S5xT
 b3vVIWxribKfHdHSaPyXS36tL0jjqwqt8rwj8xmd0B8eFSCsgDluDIkWJ3zzpGjPXzskZv2iMit
 rhweolR2Z4bHopfn11BvNBi24kp2Rx1ONi0pvtoIDRP721cduTeTdHIlbv+mw9blxtWdasYWfBH
 sVVBGSGESJDvwht9fKcBsPpQjOoKILPo0GxTQus9E7fJ6C8HFrxIJobSWrNo5EgF6W1hayEIZ66
 7l1QdwuFVOvtlAxQV6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160056

On 10/7/26 8:50 AM, Kathiravan Thirumoorthy wrote:
> icc_clk_register() assumes each icc_clk_data entry describes a unique
> master/slave pair and creates both nodes for every entry. When several
> masters share the same slave_id, the shared slave node is created and
> added again on each later entry. icc_node_create() returns the existing
> node, so icc_node_add() hits WARN_ON(node->provider):

[...]

> -	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
> +	/*
> +	 * Multiple master nodes can share the same underlying clock (N:1
> +	 * topology, e.g. several CPU clusters voting on one L3 clock).
> +	 * Aggregate the peak bandwidth across all of them before setting
> +	 * the rate, otherwise the last caller wins and can undervote what
> +	 * another master already asked for.
> +	 */
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		struct icc_clk_node *n = node->data;
> +
> +		if (n && clk_is_match(n->clk, qn->clk))
> +			rate = max(rate, icc_units_to_bps(node->peak_bw));
> +	}

GPT has the following concern:

[P2] Recompute the shared clock rate when a master drops its vote  
drivers/interconnect/icc-clk.c:36-42

The zero-bandwidth path returns before the new shared-clock aggregation.
If one master had set the shared clock to a high rate and then drops its
vote while another master still votes, the clock remains at the old,
higher rate: the remaining master’s icc_clk_set() is not necessarily
called. Recompute the maximum vote from all nodes sharing the clock on
this path, and apply that rate when other masters still have votes.

Konrad
