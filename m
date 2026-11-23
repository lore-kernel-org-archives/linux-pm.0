Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447357;
	b=YLkHtNtyeulgpVOS22xVQv3sil6BrU2J3chDxtiMry5YdWaDv33gyj26FlbH8q2aJhYZ
	 wfOzyHNIVCCydfsYN9rC7KxYGTOTk0Az4LBMV6Qxe2WaDVNVuNpAbaBWHopUhi+Ob143T
	 aDDXTdvyImIXEFJdUlZUA/UTFOXUxldF1uFy/eDJMFQOVU2YVaZWv4wJsrDYCHn4TTC8A
	 COB/+EBgYdQ0RljV5IpDa8mJBPIPsduDXxn/dfKxe5vn+HaqXguRVCZ8wbocx+3alTH7G
	 np46Q4bRX2qSVQniJw4w3c8gOAJZZM3AfM8aQj8krKOKukVmoXG4p9UyBgAZBHKqGTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OJep1EZYgFGiWXkeo6ciUdVlkRDBN0EXmJY+ZapNUro=;
	b=cVAqT2kuaHRdQLmykxZuCqg1r3a2s6NVnApPuZGeYmUFasR7JeD/Ibkh4A6b05jbFu8m
	 6l2T1Xxk0jjUJKc7vCEB6RC0boOXFzhtdl/4brLO3RmZRa2BkpRmOONzdTOglmaK4FFT7
	 qgALwggameVd4EFA+PTyy6I3eN9F6Xb45xVoFqMvXk6s2fi/Ph6hzWTIyYQixF25NnT4V
	 0IgnLzqHiejZFXPSti2VQgLorZS+++tZerMf75jnPGM7m9Nmq0Q9VgZd5hWBwa8KaWDTq
	 R1JmC89dh04Xwu3Y7Km0C4OBJjjiwm6QbnkgD0tE7fwB81oEllNWdQyNA5tpQgvKL0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="hGlKNPG/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gs0Qpren;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21897606A32D
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21897606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hGlKNPG/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gs0Qpren
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKoMx2621948
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJep1EZYgFGiWXkeo6ciUdVlkRDBN0EXmJY+ZapNUro=; b=hGlKNPG/fxzm3rld
	gNryU850G1nqO933oknVTgPAvtA4pSrWcdSaZXW/reONdtMatxVdc+s/x9VNbi+W
	7NHeqx0AeA/hlEPBrScxqHg98CKOl63zCsTd2NUjjknfyy8iS3qTXpk9NbhdBrol
	c/m6r8pFhlMPxaPhiRKw1XwM/4fKyxfe0vMyc7WDZSkeaC0AT3SaJ/sJIxbK+lca
	OeNqvpHPTMwXSRkmrEBOnbciyKxDZiw/hEF6d8Ykkz1CGy2zfk1RcVf371SG4q+h
	NsgzTbs7/XiIsTwmz2Evn6XQUdcoFLfsdWnrM/3HyXEMI61nuwPA5Iv8Gc8YUSpL
	HlHhSA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pa22r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:22:36 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b4f7d6b98eso50162707b3.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795447355; x=1796052155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJep1EZYgFGiWXkeo6ciUdVlkRDBN0EXmJY+ZapNUro=;
        b=gs0Qpren4ffJsyB2nZppF82qZJzrUnjUzmbjW77wKv5psLmJTToUlwmuSC3XmE+C7l
         QGSxGSaxhSa1dm1gTVHHZErNIyqbLQrbPZNQGxXW2SLy8zyfGjxsTqpqn9+mYbOMD8Fy
         TWbDZIypyUERbDM+RIgH8doteHgQSgFD/0XE/0/Zi6lMac7QKAL9YVlO8+eRo/CDFMCI
         12zRzE564lYrOWVgcfOofurUA7Cuyu1zz+SXt7XxC382JNsbDNi5SPqeOSxB51zKvAVt
         dHCuv3fs/FmW0jc09eYapOIYkKzbEJHAiyHPHWg2DtIV9op614CtLZ4v7fR8/NrSbHpK
         ccFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447355; x=1796052155;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJep1EZYgFGiWXkeo6ciUdVlkRDBN0EXmJY+ZapNUro=;
        b=TUfXAC7jMvWda7fkXpxfduI9eKcTBL1yeIvSKHtk0xB1XHogciSofhyAlEzvLgKBC9
         hPJKPOTaDF7ObuM4tHqNDgdUktIRvaFkK7gEtT8/08f9pT+9Cl3mACXC6y0tIU9T2OdO
         f0loCL3HzLnt/d2m0MTSDbv7HYlyWXboE4FiXKVs6fhyatRwDN/udRYI9QBfLEEc7ZV/
         mfw6mW2BY0aTS+dxgTkyeNzcmJKRti8zgYPCPUEgMWIndAUjBC33Ihsn2nD1hdlTg94I
         y04MUkj+N46neYef5McwXjGEXXNzzF7xUoMvnCUgmty+DJHDCywJedNhZ6MyzUuGVFmv
         sUGQ==
X-Forwarded-Encrypted: i=1; AL+hErFaYOgOB+VfCF4mnO2/Qdj67QE7HuhE7MYqjCFHhcO/CRDS+xfMICVesNPT2XBzgMwDPgnJmHfWbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/THxvdAopgAB/29cuhHtP2S13tcXMPOcTCDz1e5bosvVo3a8kp
	4IcbNFYi//FJWE3wFmLXU7mlXWrEzN8HZZboBEGQ71qZRuB9YssYPEEXjAFrAHQios7c6oOAkqJ
	cb+6Ecv1DwgnubWreuKsuYaKlPOjhzgbWs9vIbzSjSeccVL70gv4uWOaoLRwntw==
X-Gm-Gg: AZFdTZeD1TzxIwfz6GY1tbHXqjUF370VhMhM+nY+SGwGa6tLa7FBlXvbs/7S0Xe/KBm
	SeuqTzh+BBexWFnSdiwPRYOM8xR35g7wfPBhDYCvc1q2yQ7LaJsfyTkEFrKMQLs5DttXhYfAD/s
	zUefqgeVUOCGkLD06ayE22FPLpt5Il6I92lpYgZY/RGfsk4dgahuuqDNmFVFvZ25xhVF/qdxNYO
	f+9QOGglKHjIiqrkphOCkXofNDS5FDGbBwRdjKH0UIVU0WpQpNvxotYdNfSh4o0xkDGyahHNBW5
	WjQ33vQv7AIIBXCzdd6qXezGuvL0u7BXEypZMbL29mdDOqz4yrZ93X4ltmiBcl/Y9MkXOxxr3nI
	WNFCHo7TqfSq0/wfh5YAEb1G/oxoGg9ofPGPiy/f7yIdcyNAfqCPTN9fe/yCqzSp5TvckkeKc/G
	M=
X-Received: by 2002:a05:690c:38b:b0:8b4:f6be:d2b7 with SMTP id 00721157ae682-8b518e8aa37mr47795427b3.6.1795447355050;
        Mon, 23 Nov 2026 07:22:35 -0800 (PST)
X-Received: by 2002:a05:690c:38b:b0:8b4:f6be:d2b7 with SMTP id 00721157ae682-8b518e8aa37mr47795207b3.6.1795447354440;
        Mon, 23 Nov 2026 07:22:34 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989b3sm22927144f8f.51.2026.11.23.07.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:22:33 -0800 (PST)
Message-ID: <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:22:31 +0100
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
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vwXuwlebWOwLNSj0sceMsWbRlaBmM6vq
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b045a3c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SaS78iIXIhQ6CdhXs3EA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfXzjpM/r4ZBZZA
 1R/MzydTw/gAS9qyNI+twLwyyVqXrD6S2s8VYJoJPvzCoIK7ZbO5ZntwBCW9CAkHmb1PBD8bWVv
 h31D3co325wuWKbdp9GJkxFYsPLhVPQ=
X-Proofpoint-ORIG-GUID: vwXuwlebWOwLNSj0sceMsWbRlaBmM6vq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfXxI9bJ1N1EEKy
 xOiyOp7PZJEbstqlic6kFgpmVEIqVPazPsTAFeW2t0IHJ+QqxG5ee3kq/+AulBwPHj0+BeXmun3
 dE4Z5wCYWSL11ymY9KQscZR5t462O4dDWaDj8okefLjeMv4KV1SIOBWmAp+Qg7vPnBe7DOufxFD
 3L6BBWHnVh4Oa4w1KdebE1Tu0lWZPMAC9g5rH0QXI4IS4Y/5Siuq3LMtzaJXrxZRlrW8t1ZfTIv
 jCs7mXlaQcEhLOTfRO2HLUvpqeWP6+d0k1oGLC/BxIamCD/Y88kwooZUMxVJ+gJqaa6rfk80U4H
 LLE1Vb6z8mtIEmrj1UugIB08d0w0li5PHAgyteP2Pr10LSMQ1wZ9R7TlySoVdHhlw5LRfjaZpj5
 kxcc9+MiMppeidRKMZQ/OknrauaOSJHtCxtT9KbU1KV1urkCHiCPEab2psQsYu9VvUwaVXX/bFK
 1+X8S6+0CZBSE4G8Fzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230061

On 23/11/2026 16:17, Konrad Dybcio wrote:
> On 11/22/26 6:46 PM, Krzysztof Kozlowski wrote:
>> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
>> currently used only in the socinfo.c driver.  There should no and there
>> is no in-tree DTS user of these, so none of these constants are really
>> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
>> that part matches the concept behind DT bindings.
>>
>> Driver have local copy of these defines, thus these can be dropped.
>> This has no impact on in-tree ABI, but any outside users would be
>> affected.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
> 
> I think we can move it altogether, to prevent a situation where one has

We cannot move all, because some are actual ABI. I could try to leave
these ones only, but that's a bit too much work, IMO, that's why I cut
everything at ~450 value of ID.


> to take time out of their day to analyze which one of these is right..
> 
> To me, this is the same case as e.g. glymur-ipcc.h where the values are
> some foreign constants that are specifically NOT bindings



Best regards,
Krzysztof
