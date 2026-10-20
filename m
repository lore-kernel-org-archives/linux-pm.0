Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500282;
	b=wykPs9WJm4izwakfMO4K8ZrIZpNoR64HtjUSPPe/SCzoToSxDT2kf7G3Q0jdT0QbtoMd
	 Gov6En7hYTsSeNT+ypeHljEurt6A4hdOizqhU6ma3dPAIAKPDg0WDdwjAnsjzXQyV682v
	 3yWQxt8KE1h4s+1ZJudGMZSy87bMIwwg6xe7sgf23W4Jy4RiBGCPf0+w+Pg8+tw4Zr4Cm
	 1vdid5fRvlqmlTeVmK/hQduDhGfhn3yKXN+rOh4GP8xtwnc+5XKSaeMU6TMW8rBVNaQUa
	 iix3QzSL+dCEwZ6maygNASQp1i0qFW9Huv3eRpMx7Py38fwagcwBlI2xpmsWHgRjYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500282;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VYAsIZfOfOOdrWKotexzjBSPJizPU25cltjgjHnE40g=;
	b=xRXNRj1IGKEN6LFxdntZDvAxQYxxPnegX4GIts74DvIRVu6DYo9SD4A0tpm9eAKoIfx6
	 01jb8hrmtZW453e04SM8Rw3TwF+jpskV6EXGiq5hIffUkCNT2CoTvLQMXLKT2zak5Oe1w
	 +iR9NZgLcMLpu0Bl16GgddbsW56OuhSe2qZKdOu0jr2NqHd8HXqlnyYzPKsWaUIFWBno/
	 RRkV0vXlsY7miS/ZpClDOOnkiRpd27O8YlBrcddniJQ8bm8XK/IxSQVE+Hp9waB5B9CQD
	 PDGseSi3Vvomrcp3yV4w58+IgGkbFw5YtiltREWt1qCIzCAZaxyPAl/H0IX0Hf2QiIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KPgguQ0w;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f8l4QBro;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE9606A31D
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEEE9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KPgguQ0w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f8l4QBro
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KCG2Wv1614901
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VYAsIZfOfOOdrWKotexzjBSPJizPU25cltjgjHnE40g=; b=KPgguQ0wbKjaowTM
	T2JqPto0HnRXnD2+amMCpJjuNJNdjRdi+dkg2CLG87xqKP0lO8malGNdtS11Q6nu
	MsMUlpsnXJLm4kRK9Sj6IYrAtKqLf/KR09qv+ZsE0b19TTWwBPZ6xvU3V/0rILoN
	AzKmRNsow9hWhZccvM3s26jcZjGgGmbk3bogUwQ7emfqFFzXJvdZ1QPVfeSweFOa
	SkBqpqhIpZXQTxQc68ZYXllq85H5B0q7/3gB0T3oiFZIsq0qIQilpIM23nTne6UL
	phh7/cN5/zTHFbZk71xbvOCVsklIKwLigvo6wNEpHSpwqfXoLgvpkX7nODnsKux0
	NFh16g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2g36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:44:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f13c143c8so597028885a.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500280; x=1793105080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYAsIZfOfOOdrWKotexzjBSPJizPU25cltjgjHnE40g=;
        b=f8l4QBrop16tq2Im7Jv/3cAsni/AHP0KBUFyXRuZwZHTehtWLYkxqLsg+kfV+EaU5A
         YifkD/QP4iuW4JpJiMgNG+F7Eo8oOFN4EnyKBUSnUWHIqEFX8yGrPDBD9Pkp03UjyCC/
         qc7srMSggETT9wxefXDXhU8OzING8pv3TygOoTmTUMQJCGOQGCIwbBgAALpuxQiWwp6X
         edNBisOvhxsMPgXxCd6NBbCcqlEtecPCSOc6NmyS3DO3HDaDEqoswSHXfIxRyyUnfInN
         uG25Dg70xJRK/JhnQyn0J5vbCSu+NgIZ9nR2P8RTnIbUxSOs4CPIOLtIu5w1GVf94/nh
         snhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500280; x=1793105080;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYAsIZfOfOOdrWKotexzjBSPJizPU25cltjgjHnE40g=;
        b=KZGnk2o8Nde0FRedQdzWIysXsZI7M26rGOkVt+GqIGkwPFhJzfVCVEvmB8UaLhx7vi
         AZYpvNOpvfnRcUUuB9pG7kgNgSiz68IirXWzhurClZnvZ8fo7iXILSVa7DwmrGXdWSjL
         LXAO5KRT7b0ZrUubpp8mxa9p84V5wpx0NnA34HcJpSwAY6MS4/riQsK0KZMc76abgdqK
         M+K9eR9XQqjnC6ugqdE3VI7tXzSFYVut98SntkiHLqUofTLi5DGcTh22boJM1XaJEG87
         vnDo3jq+fp5974MpfKN/0eljn0tR5DyROBk56wH1bgJSi3+flEzC4TdQVaSDSVLr3qlK
         LGwg==
X-Forwarded-Encrypted: i=1; AKwUvBybJeRSnKVE/8iI9L6t6EIw5IQ7qlQ0BOzDvidhO6zr0V2AwspD1xOje5jm7ObWG3GZ/OKXtN2N3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQhIpK29O+jRfsPuEqBGTZMaBDQY0WCFVw5tMIG4quQEVBXjMy
	AOC533/5OJoV/OsDsd7rwDaP1zuNLgbrR3OHLT8G+BNVg5rJT/JDlTYLRiIOFO8qr0WKe+L4uai
	82PqWh5Vk9p+Jz7VMfK+IPtfNwz7BaUY1hAlVF3PiK/w182cbmKtw2NoXz6QFJQ==
X-Gm-Gg: AYBFou1qM/j5SmTZNU/Mv+3U7+bJsjdL178Uq/WbMvYCpglXhwgRhDjRkUNwaunIf0v
	ystX5OMgjEm/fw+uTkiXh14+I0KhgIA7uo9vWB3rBmpMUTkNTM2+2Cg50rJjMA/6phK73Q7o4zK
	z73WVzbv6fzuFIuqNiiDRmHFlqDUa4MQ27JIeFQVTaRSumq4ccUE4AuwKRaVf3IPxVkjzQPO+5X
	dzxnQCsb2B2RfdMGDh9kxC/N5qmCZWjLOufiIN8Qpm0+G+wRvFzi8z31G6mlgf/5eOoHcNTR+ZB
	iS3hdoFAc4oWkJo75lR1hZhMoDj7a5MgNICUQKOUJccJ38ZJiAinJYgL0qKSPTS/YGj7SOOxogj
	0Ub3FYLvzeiIJGaDAFnH6HUh7A9Q7Wpk=
X-Received: by 2002:a05:620a:31a7:b0:93a:1048:7d2f with SMTP id af79cd13be357-93f29d307e5mr1871424185a.41.1792500278788;
        Tue, 20 Oct 2026 05:44:38 -0700 (PDT)
X-Received: by 2002:a05:620a:31a7:b0:93a:1048:7d2f with SMTP id af79cd13be357-93f29d307e5mr1871420285a.41.1792500278289;
        Tue, 20 Oct 2026 05:44:38 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82dec7sm5868592f8f.46.2026.10.20.05.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:44:37 -0700 (PDT)
Message-ID: <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 15:44:34 +0300
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
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
Content-Language: en-US
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
In-Reply-To: <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YTiNB3s2sq1MJoJSqrrRNVfSd5MbAdEf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX9ofn59GF9agL
 1NgPsEX/oRjH35xU7tRIn4jReHEW/ORTd9bmTEa4Achkt08CT9GOEPOZ4D5mHGU9Q171TZqdwI+
 S8J02wbb8OG0GS4iOSJt6UPVp14Qv9E=
X-Proofpoint-ORIG-GUID: YTiNB3s2sq1MJoJSqrrRNVfSd5MbAdEf
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad76238 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=YZ1k_EG-GQ4t5jaSdRAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfXxst75FLvWxT+
 4ZE+pb1/ykP6ttAdZzxH/Do93Yant1OFWCuZyMQsDNkyR0RVv6onE7W4fe2EQJvOwz7UnzzIMJE
 3p8fQEuwnEXTGLPuqpTWCA3aoFf6ri1XBFezcPqdPgKSk2EXf+zw/q9/OyN+bd0jy1R/ack3pNm
 S3s5jC0tBe0gU92iwnh+L5w/D2afdNxDIzIda72e2w36OiBY36eh9dtxWGGT4PKHzSYAK4WCmgg
 aqj5p1sUmx3zqt/urqby9ZQjd3Z8hC3ooDL63kaiim6NzgJey+aoDj7qKTGAsfjh/C+pRE4daVk
 LhQ8y+QSixLhOr5LJ7VKDX6e3SR5tiy5j4N19yhttbG9LSmdNdgYGLB6id5UGbdc9iAmb1bVZ63
 AhfQB4frVR879H4koz0J+9w8rx6gFYz935iMfyKrvb9aL6LXxbJY/3slTlLXAKEs7Zx9BFTK/4A
 nyA4OSjZihhZeVxZOiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200050

On 10/20/2026 10:12 AM, Krzysztof Kozlowski wrote:
> On Fri, Oct 16, 2026 at 08:06:59PM +0300, Atanas Filipov wrote:
>> CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its
> 
> Clock is not an interconnect, although AXI suggests this could be
> something with bus, but it seems you solve driver problem with
> interconnect description.
> 
Agreed, the problem is in the drivers. Today each CAMSS VFE calls
clk_set_rate() on camnoc_axi based on its own load only. The last
caller wins, and the rate is never lowered after streaming stops.

> If you only need to solve "last writer" problem, why not fixing the
> clock framework to accept the votes? Otherwise this should have
> description why it is an interconnect.
> 
> Best regards,
> Krzysztof

I checked clk_set_min_rate() and clk_set_rate_range(). The clock core
takes the highest minimum of all users, but when a user drops its
request, the core only clamps the last requested rate to the new
range. The RCG keeps that rate and does not go to the lowest allowed
one, so the clock stays high. Fixing this needs a change in the clock
core.

icc-clk already does this: the interconnect core aggregates the
requests and icc-clk is the only one that sets the clock rate. The
camnoc AXI clock drives the camera NoC, the bus between the camera
blocks and the MMSS NoC, so a bandwidth request matches the hardware.
gcc-ipq9574 uses icc-clk for its NoC clocks in the same way.

Which direction do you prefer? If icc-clk stays, I will add this
explanation to the commit message in v4.

Best regards,
Atanas


