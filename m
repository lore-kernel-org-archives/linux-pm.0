Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540905;
	b=0FAJQt/9zUlGOd8CGxahvY6lcMwBsUkot3nVq9tlZZrztOfvZv36vcKiSlcBDCMiIong
	 nOp5I3bsOOnrLe/doWwvrct4HKq301I7nXYAAPTS00J0dg2GZ6LrCcnB4iD2IGr51Rj35
	 Pkt3Hi4shoOhEKoYkIvgILN6TGZbeQjPMq5om40Hd2zaNnYFJgW1+cBCWeHZb9V5nSYH+
	 X8sKGMcMouPO5PmcXVIrY/mjwKJR8/xIA8V4NEU0AwVNby7cDB2jHc/W1Tu9QOthomerG
	 DLozuNRF/SCpxENeO3fhGw1yGwdWDfJd5NQvDefMcq4P3gdXs2UOnQ3iqIQ5b17s6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
	b=zWm2f0fdSXHYJCbYdUY2o/dv+KpIHpN9w+8OizhR1oF61q72P1jtnKg9RFxy43tQ8OB/
	 Em47hfaqO5fvd9ZONy7DC7jS7H0BrtEjp9gSAiVVDHmmULyhhmaQvsDspS91QlBxIu5Qm
	 PGu28fibrEvLXwlJZSiEB7e8y+cCrho24C9u2+NMQthp3MVuZp03xmfR6zbCyBtchnrwy
	 rpiltJcQfiZKlaiSQmsbwFW7GfDI2cykGBjKUnQ07TSlV+TXe3lx15QTJDXlF2vrij7n+
	 eLrNOX5PYWEl6M6ff+otG1rauHB7mQu8/PluAJ8p2Qz0Moqypa9HhTjmcAObfxsDP7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRnXIVRB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTaLV2oO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C3606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 500C3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRnXIVRB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTaLV2oO
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2K2KK3273670
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 03:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=; b=gRnXIVRBJDeM8ySw
	aPNieEiH7Q31za35m7BrDXSXEwzVomjsjQmGkm4/SgoUxgWkcCtfB99OQ5Wlez8X
	p9Avu5YAaCgt5F/3mUxfJKrMz3MVgU3cglt6YLqxcYi4++JGPGeE1Y+eNB1RfbiF
	IldTPCGIsLsb0GZL+cK3UUv/y2gmhXNyhvVqhhvROtlbLIONAp/gGQOABiUI4+ly
	+eSxZJxnhnrFlgzT2lAyrrN7M8gC+r7K873liA/SHsrV+fN8oTsW70bHscT1jGgG
	Jav1fzcVOB5XlpJ6DVvZSPVnbZv+aDbbCyjNq3plOrf3KVAuTOtJFOQCjQQRstLe
	8ppyDA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufgh3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 03:35:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so356580a12.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794540903; x=1795145703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
        b=PTaLV2oOe3UKjSpdSc2iI73FcRNBDEWGiPqwIg+uPoJjTj9JmjbHf5BccxN3dpSgDK
         YRQYmJ3P9kZDUMYkZG/JBG6UB9Mg8M/B2qJGCP3PvORsfJOcPknJEn7hYwiTDYz00RS8
         GcBCrI/eGVqXgJa41vBvnvnrVqUdHHl5tdKQgO62tbZ7zaGjCXG8jRLY2KXpEg9Cafyi
         F3rRyqiIzDyJ7lXZmhRFwkkTFH1ZNEB2Fx26g9t7Z56eLx1hthODRXG69Ro6i97bEMCk
         TtXb9CZ1Vi+AD1Mj88XbivvmOrKeaVTVudNJpl9Cn8tEA7Zu66pEIXMWu/1+8VUyuAtr
         NWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540903; x=1795145703;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
        b=QBj8vH3b7ML0q1lveuuXw5N6yuivHQ43V74xitBf9twDXH1CdGRVYYy0IQpHmVE8v2
         WIVO8YvqyA9ehoop385ZdjLyK2lH9bQK1n8+R5rm7jczizxhBBsrhD50XrpsoUs1MJFi
         1UqLOgPJvzb80+x9o/3t6yPy60zZh02ui83Ln9OorqH3L4GiM+WiOIq17n7HATaV8P9+
         21J7wxKe+COmmUCMMM8HmI7+EMX6rWScscfSqbRR9kbm8t0hb38e0sYhOLvaDtpcsUC6
         CjUwqSmUnsoDZzH7jY5ps2a2VEzrrIdDPKDhxi2u0DDt760NpWvRfoSgftFC2sDi8bsv
         Wbaw==
X-Forwarded-Encrypted: i=1; AL+hErHfg7PK4l+jNmK9n6yjVA03vt2G+GnJlJvzTfl9JeJ3+Pej0SZZArephUL2VyWa8UfdvJnqx0BOng==@vger.kernel.org
X-Gm-Message-State: APuU4Z8IAUZ4/k0zUND6QJxMEmaP9TrvreXpO7wlde7fsJXwzn2INKbT
	VhLYDrlGTEjT2oNUcoKrYYXjnbWMt1cZ526VQf5/7D2++URq0rv8mNTW+rR8PYbpUsU2mEA+3Dz
	fghcZ55W+JjSsGv9Wb2xIoWMqTDxFdcu6DPQEeALemwTcd9c2j2Eiq+lmakch2A==
X-Gm-Gg: AYBFou3n4d06MjPZgCpWgeyPqIrxkuEXgqWkZvS5URYm2xtX80wQ1nhkzHah7BnNb00
	sdgDz4mIjP21luNiM9nfU469jwOTMIo5BqFnq98YR23n6XWfc6Osg+dfGP3rzjowDD/2UmnqnYK
	BIYlZiHuimt3W3CJUqryMHqbGoE89yfPO43vGgcmwUEoPyo9z+Cie0Nz8vT2crYqcQmtTpy4sUG
	5gRBsZW0A7p1UYe5//PcJqyghG15Da9P1qkb0lE3Y2saGnqnkx3A35U3aBFQACv7CfzfBMkshBr
	lJIAFoJk19lgGJdRPtcR2kaAbfgyKwZMtU7FL/635ciKXl3Upv+HvSGD49844EMvKqSsPpXWDRl
	cpvnyXh3JoOOrC+6pnyIRT6nMAgFxSY12T4boZ2t9HB1UkbLsAvQjWoeauGLX0FWxq3yJ8w==
X-Received: by 2002:a17:902:e882:b0:2e8:3d48:4d88 with SMTP id d9443c01a7336-2ee0da31ea2mr13290165ad.7.1794540902710;
        Thu, 12 Nov 2026 19:35:02 -0800 (PST)
X-Received: by 2002:a17:902:e882:b0:2e8:3d48:4d88 with SMTP id d9443c01a7336-2ee0da31ea2mr13290065ad.7.1794540902273;
        Thu, 12 Nov 2026 19:35:02 -0800 (PST)
Received: from [10.235.8.108] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e4e47sm3464175ad.38.2026.11.12.19.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 19:35:01 -0800 (PST)
Message-ID: <15996045-3f5e-4680-95f9-925c97301ab0@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 11:34:53 +0800
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
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5210 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
 <20261111-qcom_ipq5210_nsscc-v2-1-7e2c1dda3ed2@oss.qualcomm.com>
 <20261112-wild-accurate-cockatrice-a80efa@quoll>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20261112-wild-accurate-cockatrice-a80efa@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: boIqpotbdgTAprpsd0zBRY3dvMznwn94
X-Proofpoint-ORIG-GUID: boIqpotbdgTAprpsd0zBRY3dvMznwn94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxNCBTYWx0ZWRfX5HM87XKl+9r6
 cM+D7g1BS5NSr9exDreLtGiqVFlhGy9dYYA0uCb0auHUIeWKT8guhVf0wO/y0jV3d+urA4ByKl9
 l6nNWHDOyJj0OJx7ISe+iuuqIejx7QUJeHGapPhasTrvw2F1YOPeLt8UVEOBG58de4FNYqFPTzL
 UqjbPdbHHslReiBC/zHEkNUXiPIo+RjPDR7LC4BsD7Sf9T8/4lXFzG1ItEM2ttnnxvTJzU7vPFH
 hF3c/SGbEPwfDklbh2b4K6TbuCGbUKcyOf2gs+5P8b4Mk3E8ScVtEbGbjOq1ltDcE3xHbm87UYA
 miszTP97zZbKbZ81+0A+0NJa6dGNXNj7m0xFZVjmy9qblEDAuLH045k381sfsZ0LssfXkB0AJR7
 7RVgCRgkbpr6iUJ94uZCJXSTfKe5Z1X8TI2kPpKWVa3RL/9xyB43o7ypLYDMMxODbu5NHXsZPiR
 k08YUvoeVJsGFVfXQMw==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af68567 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vjzNbMJ68Ufz2hOSJBcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxNCBTYWx0ZWRfX+aLndPaN8he3
 AKJI54prLbVzQu6Zae1mXs+WwGfUYomEi90FpNhTS7NN3PC+EoxlvatFFJfsjG89AoHPbafMRcn
 52XthHDh7waCPDEEe5YAq1mGvO0E9+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130014



On 11/12/2026 6:57 PM, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2026 at 02:00:55AM -0800, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the networking
>> blocks such as PPE (Packet Process Engine), UNIPHY (PCS) and EPHY on
>> IPQ5210 devices.
>>
>> Add support for the compatible string "qcom,ipq5210-nsscc" based on the
>> existing IPQ9574/IPQ5424 NSS clock controller Device Tree binding. IPQ5210
>> additionally exposes a pair of EPHY-RAW Rx/Tx clock sources used to derive
>> the clocks for its integrated 2.5G Ethernet PHY, so extend the clocks and
>> clock-names lists with "ephy_rx" and "ephy_tx".
>>
>> Also add master/slave ids for IPQ5210 networking interfaces, which are used
>> by the nsscc-ipq5210 driver for providing interconnect services using the
>> icc-clk framework.
>>
>> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
>> ---
>>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
>>  include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
>>  include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++
>>  include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |  60 ++++++++++++
>>  4 files changed, 228 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> index a35bbc7b1924..dc7d90a99dc7 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -4,24 +4,28 @@
>>  $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
>> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ SoCs
>>  
>>  maintainers:
>>    - Bjorn Andersson <andersson@kernel.org>
>> +  - Luo Jie <jie.luo@oss.qualcomm.com>
>>  
>>  description: |
>>    Qualcomm networking sub system clock control module provides the clocks,
>> -  resets on IPQ9574 and IPQ5424
>> +  resets on IPQ9574, IPQ5424 and IPQ5210
>>  
>>    See also:
>> +    include/dt-bindings/clock/qcom,ipq5210-nsscc.h
>>      include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>>      include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>> +    include/dt-bindings/reset/qcom,ipq5210-nsscc.h
>>      include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>>      include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>  
>>  properties:
>>    compatible:
>>      enum:
>> +      - qcom,ipq5210-nsscc
>>        - qcom,ipq5424-nsscc
>>        - qcom,ipq9574-nsscc
>>  
>> @@ -42,6 +46,9 @@ properties:
>>        - description: Uniphy2 NSS Rx clock source
>>        - description: Uniphy2 NSS Tx clock source
>>        - description: GCC NSSCC clock source
>> +      - description: CMN_PLL EPHY-RAW Rx clock source
>> +      - description: CMN_PLL EPHY-RAW Tx clock source
>> +    minItems: 11
> 
> Please place minItems at the beginning, before "items:".

Thanks, I will move minItems before "items:" in the next version.

> 
>>  
>>    '#interconnect-cells':
>>      const: 1
>> @@ -63,6 +70,9 @@ properties:
>>        - const: uniphy2_rx
>>        - const: uniphy2_tx
>>        - const: bus
>> +      - const: ephy_rx
>> +      - const: ephy_tx
>> +    minItems: 11
> 
> Same here

OK.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 

