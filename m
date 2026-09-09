Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4253ED1D
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954737; cv=none; b=URGxhUl6bXGUGbV6M0arQRsSQ/+05o3lGo0T8LGdnohIXgIbbK1DSqRB0UrZNRVg+Gf1/+YoLCI2pr8cZ7K2ZJBHxxI6WiGxLaa/1W1FWBZcEbeImUZjwNZdV5F6AF/GtfI6j3KUaJwH8tX7jDeS7ZZgjlW1JZ8K6dR/GKO/mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954737; c=relaxed/simple;
	bh=wynWGA4fk1dSOZfkILyjQAZw/pninY0nN4ZGWNEnsL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InKDUfYkfgsxoVvxzJYXN60ft04aeINEnJN6m31GHaDw38Ft+nk9xBmoEYmNEwa4H8uTkZzp2G5WcAUUg9rV2G/qrTBZsS8Q9X+/ZWWN3NWUHP4KDr6jk5r0+FBAeLmUPcN2hR2QKunQLUb1y/bAglIDWxTqJBEPUdmIBQhmBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoB8j0+o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eKu7VbjV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoB8j0+o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eKu7VbjV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUBnU1843024
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 11:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWVC0il5ooJ5HqrOgC2T3F4oate1AqgFeCGJdC2H1M4=; b=GoB8j0+oNcLw46Wu
	W3PMSyrJBelM5vMugl7TFZcsdxIPc0fF9IkODtHREuycZBztaXUBw+XcqSiHXhbl
	30Ps9ie4Gk8EbMFgvDr2MXZGxe6Z2LOYGWW/w7qNjx0uAmDGETHSK6sbdvklYy97
	letFusq5wnhD2/hDhpl2+iSKNzJbYwHRy9E8MMVoe+D1TYG7coxggnbgZ6xX0PC/
	ccAcx4CJ2w4EETXuNvpAZCaF9t2LYdnLZ/wKkzSQzHnsRk6Rb1AGHEoR8cRIZ9aQ
	6kLlcVHiA/LVvd9W9lxm+Uvbb0Yc4uC5dvCc5tQvWaprGpFxaXXbKupbaI5TXeUX
	lFmPtA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqja364-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:52:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d7ef17031so8597911cf.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954734; x=1789559534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWVC0il5ooJ5HqrOgC2T3F4oate1AqgFeCGJdC2H1M4=;
        b=eKu7VbjVnt+HR9QTXtdqr7zyYR2TrDG373Z1p91JUQEVMDEomV76yr+XidghHG2pne
         QE68/0xP9X6lxRsdxz0Eor+YM7wqcz4BE58dZ1n899hwjnwGLw9Hbv3ja9xDKR6LXkHn
         69xllTkPqu4z0tAQXX3JKnz6AKLFaLL+EorPA3XWVhn4XrxUq9fwZxlPtV/wBWZYIT0N
         YJ4KY8qcrxbTptcIJKfTEhzpHxj5BFgVRbFZmMPY1qZK50ID2mXSMWLC2lq5lqjwHT/s
         9oLIXf/b3XBrziMyW5NFzRGKIzemFHp8ZF9M/B895hKd89txiXT7Zm2/oIg0LawU83Ks
         6vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954734; x=1789559534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWVC0il5ooJ5HqrOgC2T3F4oate1AqgFeCGJdC2H1M4=;
        b=L5wtPIdV7r6M8c0DJhJ4XeOmfuoacFNcyIFu7/46ohIJ3RjTC1IvErYYxRhF6YIoy/
         vwdPi21iGp12FHlIlEF2jRQYNe3VQ4Lld/+j6VPTaGWt0HTM39HjeXbZ1178q0stiZXq
         Kqx30c75uBQmQHCma9Z6YK0nuHHzzErLaehX23iJos/z4B1L75udjCqVML/uVo+pqRft
         p/ilY7XRWwCNs9em/DXdc84tJJSL9yNg1merJcXnyivwQj2DTnabKeRDdkgVVrCssnN3
         9yitBFxkYWQPthmIoHo6Q3WBCBJudYGI04rGkBs3Ke9vX8iZ+r85UBGlBF7ZSQLkGMUR
         fxGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyVwJaFKvATHpY6F3uKflEZh1m11ddwBNYSY/r4SZdl78rQN6Jj/7VFLGPogxZqEmTHariUTvjpw==@vger.kernel.org
X-Gm-Message-State: AFuF++n4RnFZvax1kOf+RwN2Wwv0Q/cx9ZEb8yyv5bu39oUdS8w44FjN
	MzxBazVKKRsKZ2/4KMX/81PCnuUlOn6P4UUGNQEO/m533FOuobH8fDvTnxsp+kIECQU4AOCJXQg
	r59UsDSEjsucoW+n470JCfTO7NtMUwfdoDwK8l7H8XwOZ3J/KmhmSeIa1+GO9IQ==
X-Gm-Gg: AYBFou1J6KHHtL7u/v8lksePgDruKb0VEMyMvXu0kjRu+xkTyyzYP01qPihvldkxbzZ
	qFe4rJzM0p7YiN0KqMW+39fBOnJ8i8A2gBChv+gHu6e9DOGrYD7KrQUjVUXKCcQo/NGM1r/5JlU
	gDhZ15UCGVabCRQIgDegVgTtue75jj+7Q5x/kc4ZqwNUY4qxa3+uzhr3pwXhANxqR3h2p+aMuy0
	I9anUdlF1BHTHQ9wApbKvwuXSn0enlcCSTneBWRFgKK6Vzornsr1KUtYUSYykrM9A8JOlH9HFGb
	STOHqvwdPkiLiWsLrBEoNwGZ9eQf9vZvLtvaY1u0UzxUb9nIm5qU6+7yGcQ8eXcev/hMV4FOYua
	PO4hmCza263CMqzEnL7kJbw==
X-Received: by 2002:ad4:5fce:0:b0:90e:8d21:714 with SMTP id 6a1803df08f44-910476de413mr284196116d6.2.1788954734393;
        Wed, 09 Sep 2026 04:52:14 -0700 (PDT)
X-Received: by 2002:ad4:5fce:0:b0:90e:8d21:714 with SMTP id 6a1803df08f44-910476de413mr284195746d6.2.1788954733843;
        Wed, 09 Sep 2026 04:52:13 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d55b306sm756078766b.36.2026.09.09.04.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:52:12 -0700 (PDT)
Message-ID: <2b163290-d57c-4e84-99b1-d94fb5f45f79@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:52:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] power: reset: qcom-pon: Drop reason shift for PMK8350
To: Alexander Koskovich <akoskovich@pm.me>,
        Sebastian Reichel
 <sre@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260907-pon-pbs-v1-1-cff2f5810769@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260907-pon-pbs-v1-1-cff2f5810769@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: COA6-dwJS26R20HFNt1PmEQMSMOGl3SK
X-Proofpoint-GUID: COA6-dwJS26R20HFNt1PmEQMSMOGl3SK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX4KWZSrPt56K4
 hW7W7Z3nfeyKmlbA6fd3KGsgrPA7EUVBlqD6H7q37Yh73GX6c5qka5ukQjM7dnZSqDj4j3N9Ws0
 viK1MPZ6vFwWtWCFAjO/GEwuMEpK11izyYE4ZhFZkk89WkRtLg1ZRzDXdQSNYb8OZRB2HaiL1Ym
 nrs5I7fVhcTXmmtYvrVFjT1Dca5b72th69W7BSepFwYJZTr6fgJSQ0ufFiyxVdFZ8+QTYOeAKji
 0bzdAO69tHS40o5gxLUQQA6b2u8+T31OyuCaP4gRjvBpZlzYV7f7KKgM5AWYKr6XOtee6oRMpmv
 yceuI3o8t0n00NS1F0+EDIo4YIM2vR80uAxKPyz0PB7C8t0x9Q7aEJZ4RPEMhspW7USWjwVy8Xy
 mf9XCcbI7HNgG4W8L4FrrMS6HNVRhXD19pwtt32ORUwjcclHscJjVksK+j/cEYYAzIdFkRZgsNF
 PBGi6O2NggbJXhe5UOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX8k3U/ajUVluU
 DAn/6f75HjDG9Q0pX4QevbOoiLWlX5rDfqXm9WayupnnuetjXJbrfxTFhyqJ19shx+aQtbcAPEI
 efd/nfPUXYmDcvgko7Tvcy0dawYz3JY=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa1486f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=XjHw8PULWccToXi1muEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090132

On 9/7/26 6:44 PM, Alexander Koskovich wrote:
> On the PMK8350 the SOFT_RB_SPARE register does not exist, the reset
> reason is instead kept in SDAM and written through the reboot-reason
> nvmem cell.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
> Would like some feedback on this as I'm seeing conflicting results,
> SOFT_RB_SPARE does not exist on HLOS but it looks like the downstream
> qpnp-power-on driver writes to XVDD_RB_SPARE2 for GEN3, which is on PBS.
> 
> Though, targets like waipio don't seem to have access to write to PBS
> from HLOS? Get SPMI errors when I try. Didn't have an issue doing so on
> milos though.
> 
> Besides, the bindings doesn't allow reboot modes on PMK8350 so maybe
> setting no reason shift is correct regardless so it gets skipped?
> ---

Maybe +Kamal or +Fenglin would know more

Konrad

>  drivers/power/reset/qcom-pon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582..9cd55f5536b4 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -90,7 +90,7 @@ static const struct of_device_id qcom_pon_id_table[] = {
>  	{ .compatible = "qcom,pm8941-pon", .data = (void *)NO_REASON_SHIFT },
>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
> -	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)NO_REASON_SHIFT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_pon_id_table);
> 
> ---
> base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
> change-id: 20260907-pon-pbs-76b7ecaafe33
> 
> Best regards,
