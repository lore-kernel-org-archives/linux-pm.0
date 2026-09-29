Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B11516176
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682245; cv=none; b=HT75zJxmgUDj6WlCaSA56vIZ9NMDWW6ZGXYenpm1WJ1HavME7e/EDFDnMl8utTGRaXqho/8A3U7xlaVnQH7pfKxjKfInil46zkVjW8cT/2rMD7DaqVYS+DA+dHhRB7sUsj9F986aEAj8XG3D5E6mDVsEhHm5tBYExq1pvYBW+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682245; c=relaxed/simple;
	bh=vqE74hSqpullA8LLZ475ZN4prtKm1cvbqlh6+zEdAYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYluIBv/srM9O2G1X5RHM4KPzjWMCwccGT6emr6/R2kjfaqQ/16E0kaJovNS4f3I4/x6HJbo146gFplf8rKrjxnxi7KGfZe4gwuKooavzPjRDw4llnzZzRwwY63pQLL33L4K8jAyFRuELjPxPSKbNWz178LPEvs2C8cjY/rmd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2a/30ZG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkKWnaQF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2a/30ZG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkKWnaQF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAilNG3561519
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+ukk1SWi8NzAbh3z6v2PaRAJT2YQzW/pe/nUUSijms=; b=W2a/30ZGjxUjRudd
	HL9zqrdJZ/JGZrpE9qhefBa4KGXfjdWghvRWSRJHB7/LgoBicLjGoO5Y7vAoAiXg
	13XoPgS0VtFIBvdwhfUAN5Rn+3tQ7nOCQmtSN96WH2AzdOBISWDfa9gbK3pU/iCE
	rfey8LqpAvN3LOIkvQ6raCtyAbNSM9OabjpEvlL6a8oBk3xKKSyuhH7Ia+RkP/2B
	1S+zzCOT1HU/zLZMtERCDN6MeAQZLcMl2cw8q+uUUEAG/jg+FJnlpUbXF4vSRtk2
	pvrpGM6MDbjCwp6nv5IK2ld2lyF2bTVHvatFdkdOPljt0wjd+TdyCH6taihMOJtq
	VJCr2g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v8f2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:44:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c614646e9so451309385a.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790682242; x=1791287042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+ukk1SWi8NzAbh3z6v2PaRAJT2YQzW/pe/nUUSijms=;
        b=MkKWnaQFw04Qo9Vi691c/10feQR90neXxbbl5X4WUsVC9Tf0XClnxgaxW8oInPorNd
         yEJ4OtdgUJInV2PEk0tE84MhdrpG5TtDLF8UYC3t6dHAwg6DiBT0W652cLhGlVH2UYpR
         b8lVfD7Db+kvbQHLGtNLriXoc4FVN9LaUcCZ9PduPWn86LO7WVt8C01fiIS12B+1WMZq
         5BL/15W6JHCWkC5nRGssgKQbHnCupXDI83+deTOqjGihSVy7OMVkw/ePOLzLUAzvsSXs
         jxHl6lrbceBcWpxc0mjyCq8VUGdHM2ayLPcPAduyMVZKVwsq5Pzyr+YWqENnVHyvfSCq
         EYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682242; x=1791287042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+ukk1SWi8NzAbh3z6v2PaRAJT2YQzW/pe/nUUSijms=;
        b=xK5NoqOd5oOhZLPhNHx9rWj9YCpan4H74d2aqkckEg1iv9xc+HY4r5iMWDSr3iT0IO
         dqI9k73NmEmEdGhEZZMUIAvmjt9kzHCCrnJ3TlrNtX9tJjVsgpu2bBbz1z3kYtcqqEAz
         Y3LIoFVf5x0pIp6r2v83MnyQuocAtsx4w0pHUsdrnlYWrKeML20PBmye6FC5nmy9OyoR
         gIzGhfvQaW1cdW1ZaFIH3uGdjtwun1pC87hfLjfWUakZOEv4MW6OjoGEnOfX1Ep4vqUQ
         cXDy6Ov+CAtecCTryXVxtWtooSvQqF4jfWjArt+JeOIl756VBFcD9px4yHfx4H4j8CvK
         NAoA==
X-Forwarded-Encrypted: i=1; AKwUvBzi5HGuGGLMd4x05rhNzRIiGkDL4EMZJq64vaccKJjj9e5VQHlfVV0lqXmRX5FLixT9/LUUrYVHsw==@vger.kernel.org
X-Gm-Message-State: AFuF++lIZigKmLDOCS0D1syV88yktiM1qbiSx8PKfYsK9uLoSBXuu/4m
	95x7dHrJfhyn6G5K1XmDMX9Aw27xpB79xuyeKkJRj8CVdkCOg7q4kURbh+SMrO4lLKS9KSTxD+L
	5+pi/5w28cy/fOkSy8GokLPCrBGdy7FTmro4y2SVTCQ+kY3hTWxMmyTdX5RDuVw==
X-Gm-Gg: AYBFou1mpyBqRRe88bdXvibd2nASDyhp54xpkN3Vnkg41mjrcq+6JT2Qebu9AwIIs0c
	qL1ylrp+69rruQayWM+mlz8GP3ozRc5513wUx299Xs82PYWWlUq5LjPRWSTLypQqh34K6UDFf9W
	SfdicZHsZe7V9iBWEhKtcKSKw613kGvXYyH8hBabLF1sxbpK9VUne0AuTXZjIhLBKJemVO+vQWN
	/7s1slJQM2nwOkHdJnxmh70aiPEkv4JuvYBVDTeBi0U4MmToX7ehg91pew9aCJK7vmckvpHVKVy
	Uoyq9/rQt8/8asYg2Fjim9qNZmy14VTFkKrYyUa5E3rvZZwj+HTF0K5vDID0ORAAMfYGSTrgReT
	8lxBm3jEVjXpgTQ26i7+bwG0kfKbR5l+s0SYgvIw=
X-Received: by 2002:a05:620a:404d:b0:939:9f51:29a0 with SMTP id af79cd13be357-93c43ce6b41mr2573894185a.50.1790682242318;
        Tue, 29 Sep 2026 04:44:02 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:939:9f51:29a0 with SMTP id af79cd13be357-93c43ce6b41mr2573889185a.50.1790682241809;
        Tue, 29 Sep 2026 04:44:01 -0700 (PDT)
Received: from [192.168.1.31] ([85.196.172.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf2d973sm86145495e9.0.2026.09.29.04.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:44:01 -0700 (PDT)
Message-ID: <63cc2480-a8b7-460f-b89d-8526cb17db36@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:43:58 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add Qualcomm CAMNOC ICC provider
To: Bryan O'Donoghue <bod@kernel.org>,
        Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <w3u_oVZRxmZkAlC5RmxuB0v5k970jezsVHDZvryQ3oYkStqmsp79LjODiA0mYkNl1jkRya-7Ncvk8KGrE1vnUQ==@protonmail.internalid>
 <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <8df7fdb2-813c-402c-99c0-9de6b0dbcd0e@kernel.org>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <8df7fdb2-813c-402c-99c0-9de6b0dbcd0e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dIjITXrWOUZ7mVe2MDPfWW55WSMNTrU6
X-Proofpoint-GUID: dIjITXrWOUZ7mVe2MDPfWW55WSMNTrU6
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abba483 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Q/e3f29T3Hw2hnAEzBPF7w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=R6d1XtvNd3bo7WazfPwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX/yzpIJ06l2IK
 8KwNC1RTEKKxgaZSAlBerKPq1PPYAe5vwo56Hv3oJqP9hCsDQ0VR3Fki+4y/YgANGQhSznIH1OZ
 HMWc9+JsLtDnJCUVn2FEeRmE0vErps0syJSOuDFkfidP5ORx6cfkhurUB4GgvJ5PxJ5mDKzOWA1
 XDr61g7Gz8y5bKHQcb+GVemP2nSiLLAtVRE+l7/wdnq67383fPNFKEjnzw2xxcGwvg3XR2j8W6N
 gDkHZCob0T/uy0QDy65Xf8qFJ/nOYKCvia88Y/hUKjeE40qNXxmIiOGoNejkvpM2/hutg8gCZ9Y
 2sbQ+TPEbHwC96DHSJiqBjnR+D1/K5OlT/W7VaW5pOOCsX46zf8mGEak/eiF2xRTjDPLRY34YSV
 NeCAFRoOimLTIk+MW0Gs/JIHQn9KwdiFaH8M88NiWX5Jf6mOqzc9ZPvPDmnVSpFs6XZoU6IQc51
 tHyKIfiUdQpNqsPzj6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX6gnbF40r/Dk8
 /HDDl7XXd6X89nS3jSq7oaO/Ov4BE4qb+nUxQIZCUyscr57izR4M7W6jkxcab6OWFqtGqDI8Wf5
 Quh6V9xOzX1RnkIKUMYByznIVJZYajU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290046

Hi Bryan,

On 9/29/2026 11:39 AM, Bryan O'Donoghue wrote:
> On 19/08/2026 10:32, Atanas Filipov wrote:
>> This series adds a device tree binding and driver for the Qualcomm
>> Camera Network-on-Chip (CAMNOC) interconnect provider for SM8250.
>>
>> CAMNOC is the internal AXI interconnect within the camera subsystem.
>> Multiple camera sub-devices (IFE, JPEG, BPS, IPE, etc.) share
>> CAM_CC_CAMNOC_AXI_CLK. Direct clk_set_rate() calls from each consumer
>> cause a last-writer-wins race. This series introduces a lightweight ICC
>> provider that aggregates bandwidth votes from all consumers and applies
>> a single clk_set_rate() call.
>>
>> Changes since v1:
>> - dt-bindings: add all SM8250 CAMNOC master port IDs to qcom,camnoc.h
>>    (IFE 0/1, IFE Lite 0-4, BPS, IPE 0/1, JPEG, JPEG DMA, CDM, FD, SBI,
>>    ICP) with a short comment per group (Dmitry Baryshkov)
>> - dt-bindings: add IFE simple consumer example alongside the JPEG
>>    OPP-based example; clarify opp-hz and opp-peak-kBps semantics in
>>    comments; fix maintainer email; align provider node name with DTS
>> - driver: register all SM8250 CAMNOC master nodes
>>
>> Atanas Filipov (3):
>>    dt-bindings: interconnect: Add Qualcomm CAMNOC ICC binding
>>    interconnect: qcom: Add CAMNOC interconnect provider driver
>>    arm64: dts: qcom: sm8250: Add CAMNOC ICC provider node
>>
>>   .../bindings/interconnect/qcom,camnoc.yaml    | 124 ++++++++
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   8 +
>>   drivers/interconnect/qcom/Kconfig             |  10 +
>>   drivers/interconnect/qcom/Makefile            |   2 +
>>   drivers/interconnect/qcom/qcom-camnoc.c       | 279 ++++++++++++++++++
>>   .../dt-bindings/interconnect/qcom,camnoc.h    |  52 ++++
>>   6 files changed, 475 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>>   create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
>>   create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
>>
>>
>> base-commit: 9e970952a9503d6ab471a2fea4c10b6a2785406f
>> --
>> 2.34.1
>>
>>
> 
> I'd like to see the code for actually _using_ this in CAMSS, seems a bit 
> incomplete without that part.

Yes the next patchset will include the CAMSS part.

~Gjorgji

> 
> ---
> bod

