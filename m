Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604763;
	b=uxbbk+DDMw8wzOQJvM6LmwnT1qB/IJ+DHx+zJYq+Qy1PWSdkRB/hxGMNF5dB5k03eNrI
	 WBRs0TsTc0fr4stzoLgEGnDYk3jP/DzseHIY0JhlzqtUQSVPhc/ZT6XlcUIqz5W2qdJ3N
	 73d7kqpT2jDDgcx/qyWRqMdSRtF9s4xCm6fUq1kZ3G6mmfIMt0PLmXLdyZHf1aTkHKUfy
	 BeujQw4N0eRP45Qxvvi2DPpWOlhe1isPiipFpRJgZICSXNbUfcqnW6lwGw0NzSgtP7dgO
	 SQ9fAa0Oz7sp01sr+6ABxd+m5W2eAgQeqHmy/jIxnBnr0h9RoLpqPxlYoGdq4ojeZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604763;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hDG5/daHdq5Qtkg2Awsfb6nndUgxxHZKbiFNsjxgBrI=;
	b=ytc4Zs4kcn5WuU4EqQyDr2oaDSUeidnYZoQWUPx8iIlbwMpRMeBfxDAwQC2zCry1ZZJc
	 RPjqVyS5nkF30OzD8mrQqXCB322jkmtlwoxeAb5REkjb5BILg+3I83ZOhwt9SYv3fUxC1
	 pxWyOq6bqmFl+tjysf3xMxAy5GGtAq+7G1sXfiZ++/DwooYtQuKHpSJ0oP8UTV9AWbT0Z
	 Nrbl7ySiFkj9JIEzz9qwEKMN8a53l23Om6P4MMa0F2Yqnjy3l+2rB4K8f7O428oB/5iyU
	 wTdf32Vf8ZduCx+9lkpr2OPjWXJ7cLe1yZES2dzqmWk+Tcw+28fCjFyu1C0iMZUlo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ekeko/cj";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klnj0VW0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BB606A32D
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40BB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ekeko/cj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klnj0VW0
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mNhB555516
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hDG5/daHdq5Qtkg2Awsfb6nndUgxxHZKbiFNsjxgBrI=; b=ekeko/cjanjWY19a
	XvNMHTsNGqGf995L7X604mFLYvlVA/6sOhOJ6mCN2wRzqwx8e+z5aIvZ3LopHqKR
	9+uzmpWVrYG7k/EccXbHcTzm2LMNNggptlCn2Xo0ldbAyHLfJhL2UIYPY0kBjrqz
	HkuENHlhAmEtmb0Qb/x8bHwFzOb7CRqnoj0WFuBdbCXby4ZQpPazRrA2fNl5H4V3
	0A/UZmAQI6NV22TvqyHbupTPu5Cnx0fPEN08wvL/AyzDb2cEsRtdhxA90yzA7nVw
	IoAoPCqrSwpOEXT5h5rwgYCWFEJKn9rhfdiXbLDzg+5bUeJP91WBV9RVZnNdA345
	sdJuMQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrft4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:06:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94961ed97d6so976340885a.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795604761; x=1796209561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDG5/daHdq5Qtkg2Awsfb6nndUgxxHZKbiFNsjxgBrI=;
        b=klnj0VW03QxU9pdee4N5qQFUSEsyPZTM32Qe3y9a/1SwOdUu68XPEFIGPsmT7un4RU
         4QW6EuBY2Y70u0vZj3FOPArvJ7yMiHN7j/liyEwF9RCf9WOkU9V3k2LwC0oQwO/Vq/jB
         NSu03ZDfaZ56s3VDSJTpiov+xbrH+aSEI99CwenoQXrdXwgaoOGw91nhevck7Rw0myGE
         PHJ1TtV0EmgBN/OA6NleV2WoBZbs6zXF4y84ULxn6WBko7gM9BT7I2JwHdlgnBNz0F4t
         T1YPysuhPW3bLgQHiKJRrbAUDVx1c7hsSJramRGc8t0TGjVseqOUx2mlgyWVeo0FOE1m
         VINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604761; x=1796209561;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDG5/daHdq5Qtkg2Awsfb6nndUgxxHZKbiFNsjxgBrI=;
        b=NEUNITFBgEV7CdHDiVieV3+IP4PDNEdPvb+4vfgXxpgpukaC/ipFBBKRkxDvq9Yvp5
         M/2/e19ok+u9tKxTy/A8poAN8Nb2kB+ruJDQq+w5nfDm9d2wi8S8km7jq91mhVqmr1Un
         26HD2xjwXjuvuz0aKn++3ZtAFUR7tpzovOpqzcjHcFtANrIgdwhnaZ679OQs4co7P1rs
         zFtf9/suJ3lxEEp4crMdvaVorTX2alQY2ONovjuvVUJCCeX6Apuyl/Tr6AE//HThDSfC
         gUJYQ0gda9tZzLhDQv8PZesQnR3a1DE9hvB3I/21QmXyXHBfWzFzGxohHOyOub2OymrA
         8TPQ==
X-Forwarded-Encrypted: i=1; AL+hErHi9+l24mmIMx6OrShOl10O2JHaQzWb/sXfmPltrqSLfq/m3m9Ozc0ioayccZGGJ1Y34badqu4ndw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/u0qnjRaQQ1qaFL3QUU9uQJm7rD8Mm+25CG2EbVoLfaFonrf1T
	MExvR+Old6OD5WxienmK8+VjdcPFVin9SHXJu2A0Q7YMdb7DSeg1TQAiizdC7/6GH5ktqhSPT3b
	UqKO1R5knicIZI0OjBmhAbv3fqq/rC+pe2b33AGLCz7WO5/4jAB5lQZn9pUaUeA==
X-Gm-Gg: AZFdTZfaLzEfCaR7/DOzXEe19jJq/aiJUIVXe3eN/5w4YkzdLWSgFmfSrRV5j2Rkey/
	Y5+EXosB+bp6xckFvRVS6SFlt2jTidEZrIsOVT7RDffjUc9XYDw/0P6L2iW8NKyUXbE7Rt2kejq
	aclkz6Cd+zttFGzXEDlveDxXXCuYiL04tHS3mGM0tJzraqwwyApNSxkNNZU9PV/75MoaNIpNYj1
	Hjbghqs0ls2GR1JYgHgIpaH9EyMpXvNAZDMUmw44OzpRS6Te7A2vdVEo7F6gXJuJh8mkmRA4ZO7
	VAPqulwF8NEVoSi/+CDa5ZLK0qlP9VBtxHqGjqP/r8eY5UdyM+6UTWUBYC0rW2ZlUa0eKZCD9Q4
	ce3NYyYYmWLxAZ92t5jVc4ZHTD7Ic/Dedlpcp/8A9KYKARiTTyfitk4qnFdDa0QO4ZIsRtluPug
	dgWoJuU3oiOLxcQ7KUxLHmA5Ed3/aguRAOyQotMGw=
X-Received: by 2002:a05:620a:1727:b0:949:8109:67e7 with SMTP id af79cd13be357-949b3815a51mr3260298885a.36.1795604760350;
        Wed, 25 Nov 2026 03:06:00 -0800 (PST)
X-Received: by 2002:a05:620a:1727:b0:949:8109:67e7 with SMTP id af79cd13be357-949b3815a51mr3260293185a.36.1795604759812;
        Wed, 25 Nov 2026 03:05:59 -0800 (PST)
Received: from [192.168.1.27] (83.31.98.241.ipv4.supernova.orange.pl. [83.31.98.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm273412905e9.3.2026.11.25.03.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:05:58 -0800 (PST)
Message-ID: <4276402c-9fa4-4bcb-99a2-4556ec59f3d2@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:05:55 +0100
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
 <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
 <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
 <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
 <403d0d8d-85f0-405a-a26a-54040272aeba@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <403d0d8d-85f0-405a-a26a-54040272aeba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX+91g34Sc4F9y
 DzuLZ87ymNxv9FiWEJisy9iIcxhVpzZ2nEIqft3pnMZxRfaHCFDe7tmhkls+RicM81LiS8iPJlp
 LPaeiZSRhDA3AdLXEw4b+6VBw8U04+F6+REjhTJhToVSSHUg0ruetcKfLLubjm9GprhOIHl3Qtz
 lNdLhHsozPLsaIVyHMoagkinoooWdMMR3L2zTC6Eh3BiF/KGSozn/1IlP1U56A55scLWmcRy3wJ
 iO/ocnFiSA3YMB94frbxjDYwyamVxFW8QgGv8vfFh6AlNNMm9KhLzSbrou6WGQc4N7lUJv3QiHz
 5y3/ESTh5cDVB7s17vWJMq85Pv120JQRRqC0fzwMHttI//wj/YtVk5cWXgY5topSNKqDIiTiwL3
 6kMoG+k9y6I9WKnLue6OHvKqbUYoOcD9Gtf9kVZ4gIxJS5j8dIfCP+zPa9uVXFB8WdfWOXEYNX1
 EI7J0oWQ1uMG6++9hlQ==
X-Proofpoint-ORIG-GUID: YJMg60uwvNNM8OJKfif6ApZ-uEXmiwB6
X-Proofpoint-GUID: YJMg60uwvNNM8OJKfif6ApZ-uEXmiwB6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX7cJ4kR8nUyse
 TmQegv/u4kFoZO+g2YZ4bKG3IeAGVpI6rqKHDmWgikwM7silgUYsWxDJEMVdnkb3msaK0hSXeNc
 aNCS5qIGmDdllByWFvWuOGtS9LxpEok=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06c119 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ivW4MigAevuCEqTxTIunpQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KmKYLJ3ZcJ8E6AZ2J58A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On 25/11/2026 12:03, Konrad Dybcio wrote:
>>
>> True, not ABI in meaning something agreed between DTS and driver, but
>> the values are used by bootloader, DTS and the driver, so I would just
>> leave them as is. I rather care about not growing this for newer platforms.
> 
> Right, but they are compared against a hardware readout of a
> well-defined value, not against made-up indices (i.e. these are
> not bindings). I really don't like this ending up with 2 files
> doing the same thing.

Not two files doing the same, but one for legacy and one for new.

OK, let's drop the bindings, but then what do you put into the drivers?
Hard-coded values duplicating another hard-coded values from DTS header?

Best regards,
Krzysztof
