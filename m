Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445211;
	b=YnLnhTsJIR11SMlv87DY1MyZPMsXMRP8nWHaPkhCWANzOfxMDrrRK7Ym8rK9NvdrmCEJ
	 a08heTw/eWzI68PixnG7LS/TasUjj24UooayOwfzX79OfeO8j9zIZGpl18wLrS6a7CimV
	 a+OxIRKGNxbfGdkwsZs1cIROlTOR6XmolnTRMsXyH1jB+FDzmw+RSfLNR6qplvwle9gLZ
	 /N2J2HfAiN/6SUutvo2JxMvILRjStmxYJiY9C53MV8TsgnvGq9svJlOAiMWiHZykO08SG
	 RgRuXvM29SDPQkyNoKUFcX5+LTvSvtHgkZYq+DIpQ6na21Sai2zEC6HI+GG75I2nKPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445211;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8DmTwcKc4nkoNgUdfARWYceYuacA4C6+a1Ot2Qgdux8=;
	b=aVhtNnAYEs52IXCjUIeUApX3Z1g6fXdPOWgKQ/gpz1SaEWvxm+GmFl1xabOVRmOTHN78
	 s/0EdfTGUhKNKhR/AO0Cadspj8+Q8FqJc3W5RmtcIP0BWokFv6VtsChf1pe56bGm2Bl98
	 KVLfv/KtsOQHZAmL75PxAUjf397Vc8V4/PPlUFgkzUw3LdXLkv5FPSgxA4iapxrvAwrRa
	 yvc7m94ZwosQdzjrjPT5AccnXRdoSFirnvIYzIYucDNDk4HzR0mHGjFN/dzMRjUl/DYJr
	 K1Zcl21tMTD22n5myB3t2YVq8DbSTUIZax1wGz0ql14CbZr3lE/ZMj46JPjo8WgxG2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JHqS1AOW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TeeJAOCC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE0606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0DE0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JHqS1AOW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TeeJAOCC
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL0AW1974270
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8DmTwcKc4nkoNgUdfARWYceYuacA4C6+a1Ot2Qgdux8=; b=JHqS1AOW/M7g4kLz
	r9LtzAvd+WvjFL7+DOuS2KAtcj3wPGPY+DU+DEv5Hqd3QE0ee9vc7wspFJSMrMs+
	atCbCfnNLNygn6DEsfl5j99/8lFMdK+WSN4z9a/LN6f4GdK/1JsNzIJrlFIs+O0k
	JmzXF9FWQHFTn5OGNofiF+61ok2AyShz3JuV6PbsyaEOdi5hp6uE+IgckxZbMxVb
	HTh4GuJNHv+ZueCBcGqrpCzTc/YA96pK0X9HYoLZ622bFPEYXgelNz3a4b9qKg0O
	nCdICwbKHdcbW1E09DTIFwDOU6Jo5E68DcymSL0C1owZSq1CcPkKhUp/8+uB+vcL
	cgVhpg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7urtqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:46:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eab0ea26afso96181e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795445208; x=1796050008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DmTwcKc4nkoNgUdfARWYceYuacA4C6+a1Ot2Qgdux8=;
        b=TeeJAOCCuqkUkApD/YFx3zwO7h5fr9i191kWq++dRZmjDXs+VA7FjYxHfbrUpJdlCW
         4a/RfLxQj4omqLbyXY9wFpXshxI15HsLoHAP4VtWKmqSfCW3SpsokK/FJCjrXgslfQ3c
         48moujLLi1hq/WQrRNs80aWSNy0D4jXaqq0o9qZ+vku/7OaQty1mCIuJ0SKy3DNwUFJj
         PlNrjRCzrM5ynIZgPV8TihI5O7TQOc0FdIXCmoi93VjFCxWEUuuBCLQKOqrIxnVDpfYP
         GWKorzQ3lr52aykzKC3sc/4nYraZ5GUK8Dxg19kLEJvkpFXWNzGli1jYMf06I31QPmQB
         l7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445208; x=1796050008;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DmTwcKc4nkoNgUdfARWYceYuacA4C6+a1Ot2Qgdux8=;
        b=ZQ8nl+2ivaDLcO8aOC1TtX3QrXEV9LdaMLP800OPOeUWkuMbuUv7iarL9Ajtpty2TI
         mNRo7pQeG3+wVpwS0MOCIQOoyGlFx9XcvU867Tmg4yoBmMranl5vVUWNKMbfUiesClab
         lGllQYxYoaqMVbRf77cN39t+FwkznSp0qAUcRyBJGQQVpbfWXhiYSubGMMEzcOOxC88S
         CUAcLrBITxTNYlf62g1L5FXIC3+EgpMfYCsETh4mJJSbpAkFtrnUEWJsMeUPJZrINPDr
         +KowA+zchqOlH4aAvS0r0hUsXBrhYAJUK9bLFGYDaxsRQQgLXSthmXgWVjv6V5O/Ch4m
         Ocmw==
X-Forwarded-Encrypted: i=1; AL+hErHIhWoGMecFXCvsja6xSBdqAanD+5KP4PI+V62mFA3YvnP40izCMzErKgaqVy34rr7IB8zCcMHyiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CgHb9KR1sD7VdEnC1eAwU6YwLasbUxZMfYZVQtO59MP+4fyUE
	1tGerG3q8ppBe8kjpYPLt//rTLUEeEL64KBTePratKJ2UbJkjWDDRUajdpWtc5iVrAwcrXRfeRq
	G3ZhfK7BpPIe28oHYoaKtwh7BszDWEPw44IkfZtZeoruW6Rxr8uy64YBIYC6JZQ==
X-Gm-Gg: AZFdTZeIgF63K0X20R0B9vP2AytS7B1uaW2uDW9jZ+l4/jf7mJJPEEm1Z7KIvecIZLU
	BIIjfKNfcES/s4ADXyz9WAMLo2R3uXUjTxiHVkmY+U3ATnHSIQ4x6+9JCywvebWtpEaD6QxhW71
	StCiqB/pZWNOz5hptZtqg0ROmtbkOESvsh4S2gNyLhrGQlnDJtQfzqOMegkL86zmotXQfigsUJP
	BYlo94G7BgEGTYM4c3Q7GzQRm4STQim3WuViHeDN4SXpyLgX9f6Y8UHduAEai1FhBPY4NSPRjS8
	KVQoI51PlEak9GR7avuMSHHH22Pj6aumARhkmDltfbO3EVMgsncse0cKQ/Ux4mb6u7pRg+JZ1S2
	++zXnFeo/eR7zJ6uDSKeuyTlxzdF+kyYF49dazq6bIHD22psE0JY1khULpUa8TwJnkrFAgLA=
X-Received: by 2002:a05:6122:6b86:20b0:5ea:b7b5:454 with SMTP id 71dfb90a1353d-5ee8adec997mr6775603e0c.1.1795445207942;
        Mon, 23 Nov 2026 06:46:47 -0800 (PST)
X-Received: by 2002:a05:6122:6b86:20b0:5ea:b7b5:454 with SMTP id 71dfb90a1353d-5ee8adec997mr6775575e0c.1.1795445207532;
        Mon, 23 Nov 2026 06:46:47 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109c58sm5341006a12.33.2026.11.23.06.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:46:46 -0800 (PST)
Message-ID: <ff6aa697-c57d-428e-9770-e16734f4fd96@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 15:46:45 +0100
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
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Consistently handle MSM8953,
 MSM8976 and others
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
 <20261123-b4-qcom-kconfig-unify-interconnect-v2-2-99b282e87d40@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261123-b4-qcom-kconfig-unify-interconnect-v2-2-99b282e87d40@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 51HBdf9gHJ9uV3aUgxU_oyhPzOMKQDWd
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b0451d9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=dPZdRYQqs3Y8WAFAmEEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: 51HBdf9gHJ9uV3aUgxU_oyhPzOMKQDWd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX4l8X/4chqbqP
 m8fL0yEeVjoou9BW1saLwT30XraV/6qs2iAVJxlOm08kAApmJbCun37Ajs1EwoOvp49FqcoOdeJ
 DM35I82PUvFmv2cSqplGubGoebJlrm0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX0OuadfOnnLgS
 IJEaXCQmVr/eqrl5OBObzYCRKFqRC0j1g9fL+R5WejntvJVM+lmmEsBqg48C6o30Taeu72y6qZl
 Sgefj2d2gv4S+PzixL3E+rGMN6DFSwNjAFJPznPPel0/3Y3E9obW7XMRHYsAYTyYaFeqvPVYvrp
 FTPmuVquLhsi7pHurSfsSwHnTZK7C8y/OnxbehV8h8JRPcIPTQUmtQehdzMs4/SURl0Axafu/nA
 bPB3PFPzqP1qMBzyYFf8MHv8svVnpbaBIf9wptFc6qlg0mSIWRLu1cOUEvOawW/8VcZGnDiS4Ip
 9bEGg3mhPQ+hKoRNq1ydbIWwXodQtGRCbUtffqrd+rAM4yLVisK6F0sDiCPkKzu92NRkKLSfIKd
 m+yiqlE3N6KBU9HNy2pdOD0tD6hqX853ZFptWlp1OPRG+EGOf5YdygOFMZQDd6KT6ay1CtpPIkT
 17Dolu5rqFcVIucYtZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230058

On 11/23/26 8:56 AM, Krzysztof Kozlowski wrote:
> Other critical drivers, like clock and pin controllers, for Qualcomm
> MSM8953, MSM8976, QCS404 and SDX75 are allowed for 32-bit ARM builds, so
> interconnect drivers should follow.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
