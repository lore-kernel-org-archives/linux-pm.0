Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014F44BC88
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564275; cv=none; b=L5dMMZWRdP/yGpdsWCZv9QrjBVthXO/34WVSZ0fDdOg2X65toJkGJUPB6jTMGCmxPdL0BDTRRBvmh727Dn5GXkpw9wczcWbbnOYqyYL4mXPLMbnhe/vQQHQ+XDkoK47iJX3/p5kNjKh3Tqruyo9MUzEaGxI9p9IbjAn71KNrTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564275; c=relaxed/simple;
	bh=3hQgKR0g5jfMrI+q77PgcAXwQDpxg6YjEW9egm9jAd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLlaWT0RUh/27k6kHs2NlKaegIAgjGE86/yvCJi4OBGH+a2yb7kUl6ztzP0KuYCoH9jihY28/NCS92ebORh8FRFMsZd+iIXCsHdmgasB2rk53EugHB1KUXOTgLWjsErS/xEz6OnqiPjxccLzWnHaQd29XDIlbXWk89FeDhb/qyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZILPw7ZS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QuX8stYg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZILPw7ZS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QuX8stYg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UDMLsh3732413
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 15:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMY7fcF21Ezzzra23e7CLhxBaPs0P38IfMIcVh77jDI=; b=ZILPw7ZSkEal2Lau
	PG3ItfOQ6FrZe6KI4aoAyJKHDctxT8wrythccjAenJ/r0qDWpK+uI6v8iI79jQlC
	NzgQhK9k0KSIzOc++fIS2+MG3szrQbjeUucTtUHt00k84NLj+2d2HAf1RkXi6xzI
	JGpG9MmH9nGcLqCu0/4Lob0pJxNcFrNib00GXvMFK1wP3oIyfg9lFaa+sJxkqQJ1
	uMuu7xAkmJUK7XlkKnI8+c7HeafafrW3bxKJwPccd+5M98GiP92tquiksXFXQY+i
	8fP33S8uUPRT84dCPT6VDy+wBiJiKuVmBuvP8ulcsu8fgLCqAq7mHgQ0u5h8reEK
	m+x7sQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3xbkbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 15:51:13 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-60598e3f83fso81933137.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777564273; x=1778169073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMY7fcF21Ezzzra23e7CLhxBaPs0P38IfMIcVh77jDI=;
        b=QuX8stYg/SO6qFdiZVNGIMgPh/ua+OmBAIXUvHGRsGGyHzTwaonS5Ea1SV2nrVN8D9
         vOEkjUSggUFpwPIkkfTUQO6wXMotL3JVx0UOZNgGKZHxlq00tgwp5G5vsNZZu8UrI28j
         KPwSqXTVz4GJnFHdjhK7HvKU3OIvFCaN4CsMwS4tWbUaUwocEND84VUK1xg9y2tNe+iu
         lCfw7oLQZ6XrhMfHkBnCgf3eH3aMScRQ9mS1kXenK57V144r7jki3ksbiJOUb4i+pVRk
         UPN900u50WFoWHBIvWw5Z11PQHrdbc+LCqbHAor9tI40fRTxZeGRIAf781svyaeJTv7K
         ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564273; x=1778169073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMY7fcF21Ezzzra23e7CLhxBaPs0P38IfMIcVh77jDI=;
        b=Sxg2L4o4nIYg+itwNKLZ5HDWjDlpv4GYqFLgeK69drJnEh3DE+VAiV1qDxBkcawmCH
         g2nkPHiysMI8GIaJPW8UuNcJFIZ548UCEBF9EsMOI0dfvgcarr364yL3pJEKJMvVHAFl
         4N5GBVvyxAJHnxi3DZ3q8gdD5oDtjVxZRuT+UDAjMQtaT82f9NNvVqZZQD7wcd0xY2je
         eC/t2gz5gffMaFiB+FU2fCOe5hFy6+pdhJROAFyfr7iK1Ik0LTdR0tBscuwiCddQScVF
         ZudBtIwimjKErQgFB5xfKItTD9FWDBeuGIrYEyQcKAGHV+gGJsBySxfoc58ZQsUEj6SU
         4XFQ==
X-Gm-Message-State: AOJu0YyYmBDCGEH4h1yS7As5z5I2S6aEk66dmasfAWnRAdj7nKq4tnLf
	NWB2Hj3OQ2YnJpAv/sb66MYU8Je8Gbl5BVzCB8Zc2vAMFYAG5iEu/xuuyt19bQarGC5KRLp0V+4
	DUn51esdSlAahoXjhV1cDw1JLdaG8qLR7ZYyloJhIgRFzesxNUxElpK9FogT/yw==
X-Gm-Gg: AeBDievuHFivzKWU+dWo/LebeAOnSRnvui4aGCI+QbMMQRgUCc3P8Chq3+mmg4G2zgr
	r6ghWWj0GCj5ycYXlwJDm/s9GUkWuiu/mjugggf2loq04pVYRul6S/pE6o2K0/1LQv6mtjquvl4
	B7IKwGIFvXOllodYV4STUPtmDATsDkpsdxBp/BmjBgCofWid8UQOB5H06lQ99OPqVJEweGmeVQA
	XbjvxJtzwz4aty8BU/fYXpeGh9Gpm1AD1sCP4bCBhYozAm1Rwu7J+mK6+M/38aHI/wX/bGjNB64
	+jEjCyWeDZ2ugrFX7QZDRI2CGSmgmL82QfT5g/YXqXf9DPhWflmbPZjMNxQnHmapAvtONgrWlgq
	r3Lnb2mQtY3Njt+7cnKrvZzNVi6Agf/WkAfQuUmqLRvLAMyey5W3BK2zdoIFiaUhenrHomNrURy
	XGrHcUpjaDghL+bg==
X-Received: by 2002:a05:6102:4a17:b0:606:2f5:7b49 with SMTP id ada2fe7eead31-62ad6327779mr749677137.7.1777564272660;
        Thu, 30 Apr 2026 08:51:12 -0700 (PDT)
X-Received: by 2002:a05:6102:4a17:b0:606:2f5:7b49 with SMTP id ada2fe7eead31-62ad6327779mr749669137.7.1777564272198;
        Thu, 30 Apr 2026 08:51:12 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d977b7esm12941866b.48.2026.04.30.08.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:51:11 -0700 (PDT)
Message-ID: <c369dcd6-eca0-4d01-89f5-d19a41fd1477@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 17:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2NCBTYWx0ZWRfX9QPxjpeqS+D7
 +PZiD8Y5W34pWVfcpvzKWmRQ3bupBzi8cS0p21337EZn/ZKDQQgTWfV3z/FUFj7oDA+qs7t6bOW
 x5A/CqmGl5pZFg7VT45ksTYVa+eC7yU7fpak+NRDx9lNFzKjI8av9VuITRAX59XEX39b3W8QtJ4
 UUvlm+Oxn4pl3wjmZpC2qwRSE/I11jlpKPzlXNYxzysz6sKAXSiTM0suK4LX+q9pAbxvCSwp1z/
 4/qlvdEgd0t1SO2lMUmlA9ABy+5Yv9uXd0kfaX65BiDq/grwnR/fBTiBaLAJMAiv5EJNW9ejPm4
 eHiKLbQZT8IbwbGvKzx5OxWeU9Dqo6dty5g4blb1tY+Hn+o76jb7SFeA7+Wov9Zs8dU1HpYCqMq
 jYwMjC4YQ/57+uyJO+QjTo9yWYmbyABWaC+AFA3ueumYfziBrYinSnboRvobYv4Fg6zeV6yUYKx
 aNRiuDwQSJYxCTzQGgw==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f37a71 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CBS10BAP3JayAQFiZAsA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: pgB4qpGZ-Q121DhRmjqsWHe6wzfcOpXn
X-Proofpoint-ORIG-GUID: pgB4qpGZ-Q121DhRmjqsWHe6wzfcOpXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300164

On 4/30/26 7:44 AM, Priyansh Jain wrote:
> The existing TSENS temperature read logic polls the valid bit and then
> reads the temperature register. When temperature reads are triggered
> at very short intervals, this can race with hardware updates and allow
> the temperature field to be read while it is still being updated.
> 
> In this case, the valid bit may already be asserted even though the
> temperature value is transitioning, resulting in an incorrect reading.
> 
> Hardware programming guidelines require the temperature value and the
> valid bit to be sampled atomically in the same read transaction. A
> reading is considered valid only if the valid bit is observed set in
> that same sample.
> 
> The guidelines further specify that software should attempt the
> temperature read up to three times to account for transient update
> windows. If none of the attempts observe a valid sample, a stable
> fallback value must be returned: if the first and second samples match,
> the second value is returned; otherwise, if the second and third
> samples match, the third value is returned.
> 
> Update the TSENS sensor read logic to implement atomic sampling along
> with the recommended retry-and-compare fallback behavior. This removes
> the race window and ensures deterministic temperature values in
> accordance with hardware requirements.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

[...]

>  static struct tsens_features tsens_v1_no_rpm_feat = {

This struct also needs the same adjustment

[...]

>  static struct tsens_features ipq8074_feat = {

And other structs in tsens-v2.c, but..

> @@ -125,8 +128,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	[WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
>  
>  	/* Sn_STATUS */
> -	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
> -	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
> +	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  21),

..this change feels rather odd - the existing regfields seem like a good
place to handle this register map difference

[...]

> +static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
> +{
> +	struct tsens_priv *priv = s->priv;
> +	int temp_val[3] = {0};
> +	unsigned int status = 0;
> +	int ret = 0, i;
> +	int max_retry = 3;
> +
> +	ret = regmap_field_read(priv->rf[field], &status);
> +	if (ret)
> +		return ret;
> +
> +	/* VER_0 doesn't have VALID bit */
> +	if (tsens_version(priv) == VER_0) {

Then, we can check for if (!priv->rf[field]) instead of checking the ver
explicitly

Konrad
