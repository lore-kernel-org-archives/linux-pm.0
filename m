Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605296;
	b=mTn8KV2/49+7SDtEHK+HWPZ5Bd3GBW3olJzb4FkfmrC3R7cLwt9CpcA/yA5MpxP72x8I
	 omjZcEGGRVn07L+uaDfvPPgmyRDIKhIU4W6dTOXFlyF45YCFWWUuzQYPZsyIcRxF6S95v
	 kyoeS9vABRtDbmKWM7d+XkHdZxHKUbu1YCcPoZf7iQ0rNDavsVB91FGOdY+JjyjNI9OmH
	 E7H7dNnfH+cR+ekDvpPpvO997SlP9p36JNDJVW1ElgrubZdJ8k5OZN9yYsNQMJ1GH2r4S
	 xW6wAxNy8Vno1I8pv6u2xfFVgsym/OqMgTlCPPq3tZRFx0iEu38DLDu/y4ISBy8iu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605296;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ikiKlfRi9berLfoPrc2k1052Co6X3F3qm6oP2ATaJ8s=;
	b=bK14v8B5jcnI8CYagcOEbiqQOeS0aJjF52v6oW3xYwDlftIc7O6yeaJQaBMSxiJAtElo
	 HUpGk/Pg4RVMbrvLKS+vRiDKaufq27OzE6AMxiCSMTAm6Swz4UCuLjCPkLJiWuzPv5Wmw
	 Sp2d6ygVg/9Z/XfSEDiW5LzJ7FotBgsGr3zAQ3s3fv0mCjzPdJFT5d4NbEMndV9o6eO9n
	 GbzFJy4y//h2TJKYcSD+O8P6uWbSfkdDSNafg/7wfoGPmGK0oBWQ9kSVdUf78NzkzLOWy
	 UdaedLZYg3N+E4wtWO4hVmOUepLXyQAm2lEHlV08hsNBc7PTaMt0Ke+7b3SxkF1v+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iw5L/c5L";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BongjRyo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A7606A327
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79A7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iw5L/c5L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BongjRyo
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9ml0k3611447
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ikiKlfRi9berLfoPrc2k1052Co6X3F3qm6oP2ATaJ8s=; b=iw5L/c5LEqMKQlxs
	Kt++vdZNGXxSwIk+/wLeTfFOIwc0MYXU5ybGhgbBclLOlG8ydyNqc8EvjixXRsOV
	WpGa9R8sZUzhlzi1oGAaGPDXR2ppX/ZYjYzhqE0pfhKbBf955eJlAMRYqbWKOexN
	AX7Zaj+BMsWQgBWDnnVpueAwL9oA6YbEQaq9AgMkMSL0kKqrGeMFqV7Zp6eZ02YV
	KIPf+s9h5i0qPEg4Wson5+ERDfvMRMVoq3ZmDjeZtQopukHgsRWbA359yuwJ+O0W
	9Be2NJLJXN8XKgQ8xIfzx0TemdYfwfgbTQqn2MMJt9hvoXuZBLTWnpHsXHUgw75S
	u2pU5g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsbay6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:14:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-943fffbc5dbso42196885a.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795605294; x=1796210094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikiKlfRi9berLfoPrc2k1052Co6X3F3qm6oP2ATaJ8s=;
        b=BongjRyoKMsyr9dR4Hw9a3/5kqY015TcMbMXkhCLD497R/v0oIKkLWBz4wakMU8fcc
         L/cerJEdtswQcsJafKbO7CBPKbnA4rRr5Hyk5GmdSPO9Qu8sGV+lLmQIoH/z2RXnjwGs
         laJn+b04uPrS1zVx6m9Lby5RRLO/r7np4vI75hUU7OFsZjheM+pXQRFhmrMSJRtR90at
         o9ApiRsZ/gXuWXFhrYN+AFt2FhoMRB1AwRlDldpVPlZOlKMC8ouIWhMW+pj9nmbB+tKn
         NFljZqLYma6IQhZ7fWO1Ly3Nzs/9awWFqf4UCGjQTtsS7NQPSUCusOSsQfIQy56F6/66
         ir6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605294; x=1796210094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikiKlfRi9berLfoPrc2k1052Co6X3F3qm6oP2ATaJ8s=;
        b=0d6HjfWHLV+XIAxF+VIqh/nSgYZVw49NrYPVIuyWUwiYoFj1RW228i/+M9Ch5UfSUU
         GsIitkLtei3iiQL4JFgPSroSVPOFTGe7kRJtAva/7+9cPyPvAtE4yRmitlw0q8phjV0T
         le9+u511KKDy0XcEcl/Xq5WwjgFJ3rFygMGp54dqbjsAkXDboGOrpMZJ+a1wQQUvazbN
         r7TrdWb09u0KYlRFZKKZAbQ9pxETNIRU3MjF+oMoZxTxR0mVTq4vIgoLUxtxdT9a6OUU
         1vOvIgjWysHiuwNYosGYSzMlpSl07PMR3LdGRDvYI8MJf2CHZcKnhHLZZjGQ9EAGxbFq
         xhHw==
X-Forwarded-Encrypted: i=1; AL+hErGLsgdyuupLNnvJKkslc/745KL3q2HtKgDTQfnPYJeN+X+krO+e7onHYgbhzg9mkycIqOrq5P+Cxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wXdzbkFTCI6Eioz2YNDcacMo7I/tVGqJdazA/oGDeUV+gu2mh
	9GyDMRdpiXWDgkqctpZdMn848OyjFPi2qCRm4DRmgaZKx5uH21Sofk5QtmGRJJeiXJI+kuQmNmx
	oKGTl5ozKwja/faxNwk7DJelFPaBYrv6vigC6fqWxAklv/5xnbkG84bY7BKXY2g==
X-Gm-Gg: AZFdTZe3fRQjJziz4n0NqabSm0vTOeAclKLhwqeAau2vc0eARWEnqPy/iQXxdjdLCTS
	ePGRKb8VWw13Li0C8Rba+67iKVjalUjc9DRsW4x61kCaYGsFJzk1ad1GCnl0I57FviAqfQcfSRa
	icU44pd+wFQ2yfGbwtWhUn1wENpZ/9mmnZ+DJlFcAhd4I1/FuVaMdU/rfAphdJeNHpi9gqz1yVM
	1aKrDcBO3txfSAUk+Svf3RTxONIRPc7QlBsbh/e5hzX8v/B4CXhVeWn70lpYrNaEf9MLqXC1+Nm
	PJu4/f2lLcnzMpP51kR4RK7/9W78vJpXXrZvmDg98dRSerRnXBZbkx0EoKFsvHm27cd91mpYEf/
	favjPTyUzithnSkjaVlylzQCk6pxLX9u2vCulVw1mC+WANb1iKd3ml7vFFuZbCovY3bnf5Mc=
X-Received: by 2002:a05:620a:a017:b0:949:7642:6de7 with SMTP id af79cd13be357-949ba85c0b3mr3334184785a.2.1795605293929;
        Wed, 25 Nov 2026 03:14:53 -0800 (PST)
X-Received: by 2002:a05:620a:a017:b0:949:7642:6de7 with SMTP id af79cd13be357-949ba85c0b3mr3334179885a.2.1795605293467;
        Wed, 25 Nov 2026 03:14:53 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8ce16sm617344866b.37.2026.11.25.03.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:14:52 -0800 (PST)
Message-ID: <ac7db1b5-ae9d-43c6-b553-ffeccc50e1b6@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:14:49 +0100
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
Subject: Re: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
 <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
 <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
 <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
 <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
 <403d0d8d-85f0-405a-a26a-54040272aeba@oss.qualcomm.com>
 <4276402c-9fa4-4bcb-99a2-4556ec59f3d2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4276402c-9fa4-4bcb-99a2-4556ec59f3d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2Bye87G6p4yiUic_ujoV9UBPGvycGu8P
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b06c32e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NWOE7OTWcffpa4NYhI8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX04DdpclLg4Bb
 qS2LI+vIlDtxtUBTIJ/ilBZe6MYq1BDOUwGYiDyevd+FwvlX0Tyt4dTFRrXU/Y3ESe6QS7mcsxb
 j/lpW/bHJ1vPIFOErT3WvVaixeeRn8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX+i5KNC8YkP/8
 74u6GpDAyaTD03Eo5uNuMo8QjCtP9tgnZvhDKyAMKUGA7xpAADGNOrgUc4Uicp2lVdAjr7q44+7
 SVJ7bVsTU8YmzQ1wrh7WvW0AWfadJZbZN82c718IKPgXu3ZrWgITRlpnTVnMJ0iSplTGW3u6wlR
 bOg+estUfctR3BxP5F1rD9wgNAXPwxq8R9XHPSY4ftzRw3O1e3bBTo7tULv78vIHyuH8XdKZmnb
 M5ZJLWcCfW08p7qSo+vHMcqqZJ7Rm45MbmK02T0w7l+KSkQXBmvEeqdsQBYPF3AKX+FMwsvVtv3
 /XqYFW4FeOAgibeFryYHeaDvF9FLfHcZ2nQ3pdGthZ1k+Pf6+/3cR6M0HZ9gW3DPIsCHLsPW118
 6vv6GguKVDeYU4osc0gTARm1i+NezEzavkPnjmGz3k1kIFMVIEtve6I2zqC+r/2MNoU2vfxOEfp
 znR69w22n0PhLPKmQhA==
X-Proofpoint-ORIG-GUID: 2Bye87G6p4yiUic_ujoV9UBPGvycGu8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On 11/25/26 12:05 PM, Krzysztof Kozlowski wrote:
> On 25/11/2026 12:03, Konrad Dybcio wrote:
>>>
>>> True, not ABI in meaning something agreed between DTS and driver, but
>>> the values are used by bootloader, DTS and the driver, so I would just
>>> leave them as is. I rather care about not growing this for newer platforms.
>>
>> Right, but they are compared against a hardware readout of a
>> well-defined value, not against made-up indices (i.e. these are
>> not bindings). I really don't like this ending up with 2 files
>> doing the same thing.
> 
> Not two files doing the same, but one for legacy and one for new.
> 
> OK, let's drop the bindings, but then what do you put into the drivers?
> Hard-coded values duplicating another hard-coded values from DTS header?

Or we can have the defines live in include/soc/?

Konrad
