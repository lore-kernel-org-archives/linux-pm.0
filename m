Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598034;
	b=Yvy1C5MU8LdXrkdofk5uR/S+CU9ZLn+UpuFNdvFFEIEpObAfjJ6aImZB0cNpoovvgYY+
	 zm42YvAFXBttLvf/PxxDnVngGLucn3NV4Iz6psa+kP2mqzsQzf9/009i4wz2va042L7hR
	 7EDG1WNrKGCqYiR2SjD/5dfx0EefoPclh3d3TOhxKGvfBVU3lKHB6N2WmteJmySVGcHgD
	 oqUh58yYxi7NCpBiyr3EEFJsPk2cbJgmuGHgktBfihMgb7N6eWxAEL7Sql4NZ07rJSFmS
	 ITarKON8ZSOoYkx2hrFUs2q0xuksT/wKuD2AkanJIXyJJ9ZUV3/0g5ty4UurPS2aPZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MqL4DzRICL53185SZVEeOxlGViVzUt7GdDfgTKRAxOw=;
	b=EYeMl2taqbCkJOdABHfgP65eFzzLg8oFYf95CtjTmvtCR/OHzCn5LTN9QQksalLeQXAQ
	 ETn/E5+Lz9kLtdttDVS9Lb0fVdcDjG6791DlzWgZpni1jhrWbNJmr2TlDfcJQuOD40flI
	 p0ZNPinD3v0QafPaA9t8wciZBfBr3ffWKG2qwKwP0+sh2FgI14P6zq1c++dpW0mzOxkPl
	 EkrDrtqU+p9CZI67KsdG2x+EoUnlzaGHAMFWt7/m6PLsvhW2QjZgOlBo05BG/pW3ac6dC
	 +6oAwi7buT2abPwqU2vojuKjxzDBWvlpGZxtSCQQTE4ExNlU2SsrohfZdwfigal8wgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMgbQEQ7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dCyHkpKr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4F606A31D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMgbQEQ7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dCyHkpKr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU0nR682114
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqL4DzRICL53185SZVEeOxlGViVzUt7GdDfgTKRAxOw=; b=cMgbQEQ7VfS06ZuV
	BtEiyMgpVn/N5F8ms7jbbXwaqMgAMC3WP58dKYhowIdj3zPxCgf66HFt0ZE9dZmZ
	MxEQ13a5bmyK7eGoj/nn70Opst95clRXvvI2oUwD5bb9DJiP3MKZlji8MMDYwsLJ
	reApLjQF46W6eHReycSp0Zjq7kUbKP86SPTQZZIhV/iYkX1URRGEj2eBsZ/3oi92
	quwmglX5GoM87OuYqQ7rjVS1y0RAxtc9PuW3WLs2YlTkPywh9x529DXSQ/33w9wn
	irlIFGWzaLByOOZHZFSsiHZmfyqKm878uaaX1sgPwiT+MPnW4jEm2Do4MYWTmS7s
	TgS1Tg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrp54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:53:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-15c16792146so223782c88.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792598030; x=1793202830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqL4DzRICL53185SZVEeOxlGViVzUt7GdDfgTKRAxOw=;
        b=dCyHkpKrzlecjH9q1vhjhUL/j4PoPuvOk6m/EK0otIiAUBpIYTt//wz8ZDstaNWR2A
         tlN6vu+hknNgqkMl/WFl+N/9iNxjIsbXGBfKENlDhpivdT5aVIwoA0IGFJC1vIxYkHVS
         ekcg38qAqbedb42vE5qOuzkJHFlqzaZ0bxGhi2X+T/daWrnRZKbs+2bUbl5+P/aiMD/b
         Y52Vo7wM50HB3nhxlgD3dSngWycP0pHN2cJDIw4HKs4Dz7WzicZMmKqaiOu3t+ReW4MB
         UhA4EP4EhbjZmIaVZHtoeUaBRHorw1uEYJMZFp116elXK81xGCa7H724v0LoQUCGG3wE
         8T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598030; x=1793202830;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqL4DzRICL53185SZVEeOxlGViVzUt7GdDfgTKRAxOw=;
        b=kf8+uEQSx6VBZ9BX0xfmCA+Q7z1WVS8c224U3Hm6Na4wsvBMl6kUbPcnBmVp14uLoQ
         45GKsC9xVcrLDF1ope5O7KvIvCsSeoLyTrFbohNoEfwrR27wPBCXw9gGGD1pTfJYBkR4
         m6/9nljO1tkzvMBbtlFaakB9MmX0c43j+GEGi4+cL27XUduubqjuA4ES1UEopbGglBsg
         jfKihgtzZjw9FC3hWym8VTnVB/RMFIl27dn7geG9I1OwDltBDLvwGtwWNBU7FJwpQg+M
         u4pgqED9Pk455ilEiFVaNE/DXzGTzUVKTfLQttbJAgaL4fsLllyyMZB8nLddO9EnAZnE
         wjLg==
X-Gm-Message-State: AFq9FYLtl+6e9P0NZeE9TnecVVgR99AtnC4daQDWEmychqMT/WndnpGi
	LlXg26pago6VE3xEmxZQoobHbzh2mwj3KLVteUunhDLpC7t37vPbuX8cCD1sxXbsIrFFYKcORUo
	3liTTrpdzkVDT+ykMzpb9TEbO3taODtE6E57bpzg2XXIOYC+XVfLerTcxf8JmQA==
X-Gm-Gg: AYBFou11MQBjcLEe0HUdZtZ9j0t8NtEH/KRGjGWtBE/Dusf/LR3EjwgT8oUBRnT00tg
	8kIBsWIYd4RuxIUjr5oyXoJP9fIErN/sbOotVBjgg6yw2hwH4Tg0QkNhS+bikM+bqGSt1zr6Emv
	U1Qh6TrPTG7y3UMf4ufNFdgExm5yZ/iEhw/EqZzC1ZukgAKdP+L2kbBb4J+Gh/IbzHY8Jskyf0y
	rwqAHlVJKjfdN/UsOF9oc8eAffbhajBGGGGJ4k0+Ew3oY/XWsJtHfSCghXzMvk4empiN4fwApCX
	7siWTdYsUKjEtB7EQfnsj2v8nfzkweAJenWWfEHiTk7iF3oK+BU7IvuxZpB5bXkrXUIK1J6WFE8
	TW4gWZkqWirzmYWwZmTTPRX4AEAwWGt86kRiCK1LwZJYq
X-Received: by 2002:a05:701b:230e:b0:176:a225:e364 with SMTP id a92af1059eb24-190a77580damr2971975c88.35.1792598029939;
        Wed, 21 Oct 2026 08:53:49 -0700 (PDT)
X-Received: by 2002:a05:701b:230e:b0:176:a225:e364 with SMTP id a92af1059eb24-190a77580damr2971949c88.35.1792598029355;
        Wed, 21 Oct 2026 08:53:49 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.81.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm11144550c88.5.2026.10.21.08.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:53:48 -0700 (PDT)
Message-ID: <b9924970-16f9-4c41-9b2a-a5d3b7958c95@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:23:41 +0530
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
Subject: Re: [PATCH 2/4] clk: qcom: clk-alpha-pll: Skip Zonda PLL
 configuration if already enabled
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
 <20261007-ipq9650_apss_clk-v1-2-fd4c2b3cbdea@oss.qualcomm.com>
 <3faeade1-1bd2-4e74-95ae-7396a1ef1ce4@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <3faeade1-1bd2-4e74-95ae-7396a1ef1ce4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QPh0brRCD_2xW-UVfF_h5OaMQD7RaawJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX2pPVdjfBi7RR
 cUY5m/0x8fC+QN7hGEhCi7b+9s5zAs/RhjKx8U4Ef9Ublpy0631OrQ+dGVF27rfAHTTsD4990sC
 3d99QCoH+L0KBkZNcIYU4zQYVDhPbik=
X-Proofpoint-GUID: QPh0brRCD_2xW-UVfF_h5OaMQD7RaawJ
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e00f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=rZLzW5DhxuwyX7/NBrPT8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aSm82yqHt_v6FYJ1XLwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfXyuQIs6C1GyL5
 gPDu+pTvtp+uZupXMFw5S35Jzy1ilJDtmgj1M4qGFUuxtKBeOsI2/ry6+flBuy5FcB6HZ8TysQF
 /2/Dcwt+0wXIP59BFcI2STZM8BR9B5kTYFqiUbTz6wJtOcInfuUHgEC/2xFMKYpBXp6RDjDpA+/
 ylUR7216a/N7/jUgHDh0MSinaPo7x+uJTUpshcRi/pSA4DgqgPkt6mqgc5wW1ZXwPeXFz5vLQW4
 d2kAFJM6ein3FuB7/dhsASysE03tFAeP2SVLrMXNeWOj16QZraChnia+cBWk/AJVxlGldLyulGI
 /Ke0bswgmk1u8qbU0/XI/Pw2LsPwkgRr4cE+9YRnhF/JwW5kIvXVr4frrGgkzkEqir/vPbase3Z
 1pv9pAglmgZ9EogjTQlNir/0tMHN/Lk6qJRW3eqhKPh+yxzKm0Jc2y+Z8WN+frxSGEaI5rd/gt2
 a5BjRNh9bURGdsGFCwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063


On 10/16/2026 7:20 PM, Konrad Dybcio wrote:
> On 10/7/26 8:50 AM, Kathiravan Thirumoorthy wrote:
>> On IPQ9650, the bootloader configures and enables the APSS Zonda PLL
>> that provide the clocks for the A55 CPU cores and L3 interconnect. When
>> the APSS clock driver probes, it attempts to reconfigure the already
>> running PLLs. As part of the reconfiguration sequence, the PLL output is
>> disabled and the PLL is placed into standby before being re-enabled.
>> Since the CPUs are actively clocked from these PLLs, removing the clock
>> during this window causes the system to hang.
>>
>> Avoid reconfiguring PLLs that are already enabled and return early,
>> similar to clk_trion_pll_configure().
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index 60173b076cc5..3641b2da92cd 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -2162,6 +2162,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
>>   void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   			     const struct alpha_pll_config *config)
>>   {
>> +	/* Check if PLL is already enabled */
>> +	if (trion_pll_is_enabled(pll, regmap))
>> +		return;
> Please add a debug print to match the other similar calls

Ack. I see in some places, debug prints are not available. Let me add 
that as a separate patch to make it consistent throughout the driver.

>
> with that:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
