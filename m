Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460793;
	b=5AA+2luy13TnkOGUEv4mfS4ieIcBwnGPTYP6a9usW0lQ8FKByfLHNSTQcoGM3sRZ2cI8
	 dPvV1P0XgynKhgFFpY+2N/UXISQENnFPUeJTGuJHUsQcI7tu02qUNTdPn/RTvkr2FN0BX
	 38MeTmALRVt9v5/tPV3P/TlOSrcuGLip2EC22jGno1MXhwWOPmWgwAwOAVqnfySkabx/T
	 wOgX3tFVc0TwLMvuoX7mMuEsZaZh45TYGTtmhLILXzQyFn36SjK0giG/oU88lhpNTJMuk
	 UmhPOagK19twiY9wdxtUOvLC69y5oRTXxBKQLEI42zAJwF+vMRWceGwkUuJk5045yqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460793;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tOiEwd6kmNV7JIBwmJP7LBiUslyemiGc6RTx8IgEqZg=;
	b=Yr+FiOnUS/+o4BjIciL5gIFmoKruRTnfkThiX4G4zAewvzPi0Tlh5gtn06z81rVznxHj
	 eSB3wek3bodfmzeSzaX2VJ1LYu0xwKNKADWPVurnzzuR6pnIH5kSGtH9G2oz/MeNeIH1I
	 O83XsFvVjZFvvLgo0WUIR7sRpYlbuheQpJO+1HkzEEtO3ndwgGm49gXph9FvrPa7CrjwR
	 yaVYemXSOT7neStRQ4Q6SVEzjwIA2vAR6TmT/KepLt4gkaJdkV/zrurIGpALgLbu8gBsn
	 oJyx5yLDiYknz7Kwf3v2NDRkeBNwSTORwY6bvHNjJLB77C7pz9Rm9d64DTbN3jlXMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V2Ndm5ps;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlsspv7T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA8606A31F
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 19:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0BA8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V2Ndm5ps;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlsspv7T
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGp2O2769030
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 19:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tOiEwd6kmNV7JIBwmJP7LBiUslyemiGc6RTx8IgEqZg=; b=V2Ndm5pst2LttLdd
	m2l7dKji3WsB65MiKKrgjJi5XWBNT1IORbR5UcCrn8c8eDP4lw5+ToHAWveqUXy0
	923iq++6EIIRIFA7wcpqYjkGsJCqT7TDW/HLA9qUqCIOrJ49uwZN2FVju96mb+rL
	AIXjyZkyxLZFvWP/kXHZtesVtPfPKmATb0wtix74YW7lemI4ofh9QDVg6wxtSat8
	nop23RGxiP97gPh4l1nT8aO77dXsEFrSgThlUo4HXyulqXZAsjokaPaunJQo6FQj
	53phjBBd2Pz84kVSK+Mic7LBnAE/wrPw6GkxilHkjjnVqTYPjeVzm7aOhoiqBwWP
	npA7YQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1payqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 19:06:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ece1a3bf7fso129512e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795460790; x=1796065590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOiEwd6kmNV7JIBwmJP7LBiUslyemiGc6RTx8IgEqZg=;
        b=jlsspv7T/rnV6gJHWwM2AYbxAGAwKfPeYhFnWXxWXdATDKtm9HUgg6QkLNjMf5s31v
         Tv9HE8Ier3lqfhUSA9LJHyDjRNtHhtADMuAHhntVMEOzplIoLh6lYjVcnEoS4mnKSV5b
         mjQ6Sda403fd86OhqclG406qP3J9WsCkDLtuqs8Wsz4rU6x4Yst7QmVghALlzRapTWn4
         xIzI/zMxMp1P8YnZZFK2A9KZg0VdHrz+U0PqdvXgyjU+luoji0vsz152H91Pi+ba3nrV
         GLSLZlCW5S1VGz3iQLfVItw5q+0TbAeipCOj/rhpiyd0c2kWmubspMgWb558y314RAk+
         nShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460790; x=1796065590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOiEwd6kmNV7JIBwmJP7LBiUslyemiGc6RTx8IgEqZg=;
        b=NWchQqeMCVqlA1yLbhi+2SYVCsZceFjw1WRP0jO6y5HnvHcf3CMXijz/WKoxpFbUrn
         HYjokGF3EYv/cTq9t1gP27m7D/pe8ySxcMPcSSr7ofj+j4Jkj/Rc68GQq+yyaSlft9+i
         emPvnd0O6aKIJqqxRADprN+j7PcbmbFHWER3SfmJmlIhC3SGKhabpFv3OqYKNVhEsVgF
         5VL9mqmNh/9zjHFGKPEfodH7q2hcS3K97McMh6WwJc6WpldF0GbanAjAuuxgdGJtdWEn
         w8hVLyXcNEDdDyM8CkgtEuEQKLNtqQCrN25AMoCA11dpr2a2LbSO5AnEBRz0QApoY4PS
         vM8g==
X-Forwarded-Encrypted: i=1; AL+hErHjIiRFtTOvCEqrvG4EdonYFvQ/BgvEXOY6fTzL+EOdaQ6skwm4g+GdtdoYzRMl0H4BISH/dbH96A==@vger.kernel.org
X-Gm-Message-State: APuU4Z92AMh7r4By6uwF/WdIxwMIOvAPvzIc+PVAyS3tacQLmlOXXtcP
	SgBlDJFXWO+AmzbmYGM8FvLTk5F9BLF2BExW4uZ9SnCQeAVeZd947BHi+r9wWajvN4vwUY1Ch1w
	/EbeSHXWeREO0zKdozkqGvwNcW2OAMrr2t5h0KKkhXOlrSCuh7QxuWTNzEBwhTA==
X-Gm-Gg: AZFdTZdPP8ii/xMd/bhIAMZxxsGXgZfjNfA4NDGqIDEKnjh0kArpFLxTJybNM6D7RRb
	DuDfMqeW5VY/EbkNVQGi+flyD3b8V3jP1OrzJCu42+dswYLXH1XvbVGAaGit47vYNRdDCHxeR5w
	TIpFozW6jQAWvAyjFukm6AZiCdiLGVyCRY1eyhycevsqBoDVLvgwhFIBgqoHUXSlDNA+tDRf2N6
	Y9dlEW7voHxgmPigN/5lsHfxnGMS0//YjMtXwiGCD5YSG3WiQpMxdktUxYgD8aeec8tlMHF5Jts
	h2ty3uUGplmGMiFipWVve3U3oaKI134A57RBGw4VoUI4UTR0ULZBN7pOYd0NYdyEFi4MCQ2EBn+
	hsza27etcMXcs+tfnzEZNMHonf6EZPKIbxdV6Z7iW32CKEiS1oJK6aln3vahgyo9guHrb8vI=
X-Received: by 2002:a05:6122:4805:b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5ee8af179f3mr7041943e0c.3.1795460790124;
        Mon, 23 Nov 2026 11:06:30 -0800 (PST)
X-Received: by 2002:a05:6122:4805:b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5ee8af179f3mr7041913e0c.3.1795460789779;
        Mon, 23 Nov 2026 11:06:29 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba854bed08sm3651400a12.30.2026.11.23.11.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:06:29 -0800 (PST)
Message-ID: <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 20:06:26 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfX+pBsQ0OBWOhL
 BUISEqXTTm9iho3FHA5AS9i+0o/o8adGLUx0RWfOdHQajMV9RES4QiszHzUCNsCdofIItwFZ5mR
 PWqd5zvc7b79sRtNVvtCEJ1BXrMqL4YZ0aZ/tRFbQGkfaVS0xrTbVEh0OlKVAAIjO7YSLqCThl+
 1n7w1h6QpNR8y6VVxlLPK73QLbbrT2ZJrwnZFRbZQVjXIvdn10zT05etojEViXaguAoGitYWNdF
 QdofJ74EMX8KbZgX0qxipvbRwxIkSjCkRcRIQb9l7LAcdWmfxSfkJ5TV4dvSEjYbhroO91y3cX8
 XSu+td2rCNfoCdsE+VFa3L54kuGibBPRSf+/kngdceXXhKWfVxxyec7QBeAEfYIkDRuxwr/h1ie
 a1OVqx8gENjeWjYOIfEztXepWtKq238TL5PhAl26T3q+aKp9rC6PXnWNzGNH1mED4wqrorHCmDH
 MOI2yZRIqkeZF+0hhYw==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b048eb7 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=09P9ZdklQj12kDAbNyMA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 6hsYa50wE1W1ugzkAzMGXFgcBlVzcB32
X-Proofpoint-ORIG-GUID: 6hsYa50wE1W1ugzkAzMGXFgcBlVzcB32
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NiBTYWx0ZWRfXxFPdJydnFh+w
 tUgzEocp1MRf7qyloNrjgwdH01bbASm9lwk2wBApwkqbAOtJLFnzviGZHxmLD6X6sMYX4Wr/Ze/
 6U5b6pO2t0arZiIne7BkUVbSblNIYxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230076

On 11/23/26 4:22 PM, Krzysztof Kozlowski wrote:
> On 23/11/2026 16:17, Konrad Dybcio wrote:
>> On 11/22/26 6:46 PM, Krzysztof Kozlowski wrote:
>>> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
>>> currently used only in the socinfo.c driver.  There should no and there
>>> is no in-tree DTS user of these, so none of these constants are really
>>> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
>>> that part matches the concept behind DT bindings.
>>>
>>> Driver have local copy of these defines, thus these can be dropped.
>>> This has no impact on in-tree ABI, but any outside users would be
>>> affected.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---
>>
>> I think we can move it altogether, to prevent a situation where one has
> 
> We cannot move all, because some are actual ABI. I could try to leave
> these ones only, but that's a bit too much work, IMO, that's why I cut
> everything at ~450 value of ID.

If you mean ABI as in "used in DTS", I don't think that's quite ABI
(again, looking at the glymur-ipcc.h case)

Konrad
