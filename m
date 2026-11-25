Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601198;
	b=237mrSLFG55gLXULILfO6StCAYeclVns/5ziw6LLApFtlKm4J045joqoSSGZ/8jxUEN3
	 GMcbfhZiMOjGUJMS6xKDuDzwczSiszhc6wbyPISve8biaOhgpz6JxDBZhBRgygDlYnrM3
	 x1jyrdo9imKbDJUhIbC6lcV+7hTuz3LOSWbgeJjAuyM9hbLU3qcqKZ+LRspAhHmh6TrCQ
	 KYXwfz8G4rp/+sACREN1w67+cYm+8UtXUwAafTkWFBc9i3tbwiKrneB21NtrLZQvkdkZR
	 zqltlSPjfXx0OuEGYLAxfBJpoOUg+BT1p8cneysdW6rUflC4JtEU8r9cUqbL3MQlnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601198;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i+qX1LTo3z91ny//6ym+Y6Hu9qRNdKNFMdFVecYgBqw=;
	b=w3fjVVZeu/3ky1aPlyo0A6Z/mwZFZ0vek/feks1Wj+F+83QBTRPvR+046LZgkBcgrKb7
	 zJIPfMFEvQr0N7v/T88qe4JQdvGaDqdqj5tFYPJlnLaBbjccDQ9tAbZCIxj4oudt+H5Vw
	 jwyRSGcMB1MrmxJ6i70VAA7mKHfIChcXRYv8bsSfLe3xSxxMyZQsfYGU4cT1r5zycp5lR
	 FAA4mSSgWBFvWo8kr42QAXL7pOG0TkOPalPycglpvz9HQOCr3raa1vNizbiLqRzc6pRYj
	 0JGoEDaRzPINDcprROwt24aLKt1hGSkXS0pOi59oJCse00tnz9B2uUgSlXDK3rNdhnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtM8jcNu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q8ua5MlD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC2606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtM8jcNu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q8ua5MlD
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mPAT2121252
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+qX1LTo3z91ny//6ym+Y6Hu9qRNdKNFMdFVecYgBqw=; b=FtM8jcNuqXTceVBY
	NbLEGpJWJTPU6Hn/uqxdfp35oXWFXMArCvjCPYodx3ScBW/nqYS6nj9UmyPWusU0
	R72bY2/CvkcoBqlxxQ2Dm2h/+0okr36Q6EmSVAvMGLonhVF9OfErzXhm6l1XQ63C
	5bztMJIGJbzLo9HOeNweMRdindBxJzaIz8e2dYU8gjzCWpkgEMMqSd4z0jsnWtPJ
	K3ApGKCL/MyfMzuF0sg3+lTqzehGU+NLV2nq1uikczk86jZXA0LCNuIrPd3QEGjw
	zXCRti95MCb2fBaG3RZgOACiiqSfWQkz9lXJlZHEE8X+k6oE1DIR84Cmwti35E5d
	h8YZSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vukr922-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:06:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-945e8a244bfso59880585a.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795601196; x=1796205996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+qX1LTo3z91ny//6ym+Y6Hu9qRNdKNFMdFVecYgBqw=;
        b=Q8ua5MlDt604OTd6VeFhRkm+JtxTjgKYKi9IroxtzJA/+qnCzCKZ2Qk91BOCi3Dh93
         aTI05lHLbl4rljk+3X6p7Zjfa9Vv3pp5F7HXw23MPVjcvoJwPfJNe0/NVD5QM2gbOE8I
         rqQ9XU0Z8nwqfS/gcOq79WK989TOzX6BRVQC30NMAXZARGoJAZyhrAWqQqB0o2oYx8sK
         b3E0Tj9tueuYUXmGv69Okw8LKXWaI/ZMHFXr8rgil8PlltmjmP4FSYTWAO4dcrWNVETC
         nlpx2/tzGY0qkscv4CJMDv6sbZChfNBP+/cqWvV4LD7JqMwIm5NWPrv03uFqSsGjmigk
         HtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601196; x=1796205996;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+qX1LTo3z91ny//6ym+Y6Hu9qRNdKNFMdFVecYgBqw=;
        b=Z8b+sQPPNIIs472G59ULnHfGT8x8uaV6LgO5tP/VOjjEIrJCLd69P9Tw148BBC2CnV
         iZeWnKvNKsvSTxto8QVyhetVnDvTVXlvkdzxHZCYav4o/gb0aFECXuPKqWAYPXG5aRVw
         MZIL/tvqCVoK4nRe5biH7McD4/DSsZnD2bgBuU2yJM8AfVIIyIN4Vbgk3nkZ+0VqaSZ+
         pVXrfW5AsTEJhXN6Zc89ytgDdX6fhB4islhRyuKGkQLkP51u9qNrgCMFhYCucCppjGVw
         9PG8y7ldaB8s/DlDnmQUpV53m6oLIKI+ax2QHTmJIMi817WoiPH7qJHd74F4le801Q7j
         JWjw==
X-Forwarded-Encrypted: i=1; AL+hErHj3QGLbTahn/MCvsl4MNZFHw3+cD/6wp9kM6yiDsUONpQ3Lq1vSmR2zIBPMsxOSFjTNwxRuAB8EA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2jLzE5TfcQFojmbKl4895H2/89aJe0MhOxZ6ruP4/+lVysF9l
	fQc1Z+rvfvQCkSm4Oxx68WImasPMvX44rlPaD2oUoOJYcc2r0ovqAuR2CDdyMFIqzGLNDD/N/N8
	G6x5ixVt1Fpya1LIFM8JYXfTN10sV9VcyQBA08JtRhHeKVaPkX9M36P8yiUWnTuQQJElGbA==
X-Gm-Gg: AZFdTZfhuJUWdU2l6OIUgfyqjJ6Ij+khy4VC08K/b1ZPxYmwdl6wHYcCTk8McX1uhp0
	5MoQHKRoQa33PtF0Z9KMmqbDydcHMcqUi19D5i2ln3LX2h1llhuZkl7JHB08j0MDNsd4eyMn6UO
	UzPkfPK5d5rky5OQbMMqrFyj1GnpR7+5m9d1urhGlC7z4X+Gp7PK6ELVuNhY7b+aqmyPnOVaMlr
	8IUgOEq7uKGn8IpvzSlteEiKwm2H8PEQOXDi9Us87DLtD3AzYAZyYLAQ0L5zzYBmXMqTwakQGzk
	JPR9Tttt37S9fqnHiJiPE2GH05h0zkoQwCy11YUcOouLloR/RltZxdT1oKqTGEZFKfReKcl0ckR
	Esi4vJl0sJmrJRPB1m5kkJIT339O8jas9YwwRVowqmrdUctoK/EgMyG+Xjicf6GgA52m+YJU=
X-Received: by 2002:a05:620a:5408:20b0:949:ae35:480 with SMTP id af79cd13be357-949bab50fdbmr3023307085a.6.1795601195924;
        Wed, 25 Nov 2026 02:06:35 -0800 (PST)
X-Received: by 2002:a05:620a:5408:20b0:949:ae35:480 with SMTP id af79cd13be357-949bab50fdbmr3023304885a.6.1795601195554;
        Wed, 25 Nov 2026 02:06:35 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6663esm621139466b.21.2026.11.25.02.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:06:34 -0800 (PST)
Message-ID: <4c1de002-0243-4948-a175-997ab9f4db59@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:06:33 +0100
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
Subject: Re: [PATCH] power: supply: qcom_battmgr: stop faking battery presence
 on Glymur & X1E80100
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20261121-batt-pres-fix-v1-1-2e8b2cc98a1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261121-batt-pres-fix-v1-1-2e8b2cc98a1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06b32c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ddAWxhUWpO-MbGeArb0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: YH9G5JnoPQPSwb8PxWUY5QPx-cD-6VWv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX0QVEu4enYeOO
 RcjZ16Lle6BoAIWV5IKVEAN3I07kUfdq6QE5UnrQ1pFaYIiOiLbd8EH75APHgn7+VUIpATev0TA
 XDAIv8xL6gSKtEeYIZDDl8aOXp0ZQgw=
X-Proofpoint-GUID: YH9G5JnoPQPSwb8PxWUY5QPx-cD-6VWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXydSz03HUOYzg
 yiStQiSd+xKRkeLsK7UGqTPuNq0UDbKJLTeBUlAvFPlvYqZWfFuezpFM8KVtR4zBXrFSHtRqV5e
 Ej9ZOkZy4ZMrDetF77IHWfID3T0Ixm6sykhL8DJ84epSNYFNB+omj8N4Z3vBDSl/MQ0J8PjPx7H
 oioipUWFIBztfsAwwGCEraxlcSSCM4zsevGRvDevtYJpdRfbCyxdkUp/Le3P8QOoJYO3ejeaZhU
 cs3ngrC/hkGJUns48f30PYiXVVVciWJaSHT+/fE9FWHAjFgj53CCHtBP1Hf/rwfFNABlAfbHf/Q
 VT2af4LAkflel25EudLHKAFfOayxL9NwXlEqBvSP6cRFus8KlFANdnjkIdwKgqjksiXj6LiqdFJ
 NWsqcFarZhsV0AU3gV/R5+F3rXIsfaiIfshGQPSHe+BZerZHQbybV19K8umYqJlbBZBVHYAfR4a
 iVafRaBPnRugd4wdCJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

On 11/20/26 10:32 PM, Kamal Wadhwa wrote:
> From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> 
> The qcom_battmgr driver unconditionally reports the battery as present for
> Glymur and X1E80100 variants, even if the battery is actually removed.
> 
> Fix this by fetching the BATT_PRESENT property via the
> BATTMGR_BAT_PROPERTY_GET opcode from battery firmware. While continue
> assuming the battery is present for SC8280XP platforms.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 69473ea753f6..a5262a7e8836 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -557,6 +557,7 @@ static int qcom_battmgr_bat_sc8280xp_update(struct qcom_battmgr *battmgr,
>  					    enum power_supply_property psp)
>  {
>  	int ret;
> +	unsigned int prop;

Please use reverse-Christmas-tree sorting for local variables

[...]

> -		battmgr->info.present = true;
> +		if (battmgr->variant != QCOM_BATTMGR_X1E80100)
> +			battmgr->info.present = true;

Let's make the condition more specific, i.e. "if sc8280xp"

Konrad
