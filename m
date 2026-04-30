Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C5358D32
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564845; cv=none; b=EpVxI+1cNjRrozGTWDdaVp3zWB0GoESrrLu5br0XctD5u7EJjn30ShLJZqZMm4u5BfibZzbmhggJxwOchcNDXlq9Tv4ZUNJSD+pORXynoeqiCsXG5P7ncijpE1wNcexpEKzZc9tZ2sO0zSryVxcC9JmNGk1o4hBRFZtn9n1NEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564845; c=relaxed/simple;
	bh=xDFMbAQ+d50N8pgekZjLKMPaEp6MjAtl9P7svWAapA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4tJp7OwKg36MhRmi9kjsNP4++P3vgXj7QPWhbinimYCKsH6G26LAEZtg01/Bl3pfNVj4NZl5DAJiQhjHN2117HkjPtpZPnm7QaqwIS84/KKkfRC4dTsZ49d42HASRyDxLi7278CfiV5muC8yTh2eE0SToan0dNNihAfp1XhQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdZSDabQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PgxBw6pA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdZSDabQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PgxBw6pA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UFsdLa2064911
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bo0XjYVyRoPqt/BSUYkXnHD+Dx9SB7n3/A/Bv4qMvAM=; b=JdZSDabQSVy2HSk4
	jA0PlWQN3BWTa+veoBngTSg7G7w6oleXdt3AQAmfWPbosTR8Ctqmgh9oNB/4QA9m
	KBu9L+O2El47HP8RN/Jszb48ukvPBdteA8c7fTS7lTNufK5RhE2mrK8zQPcMyVoX
	BO28UVgwsKqlh3c1f/j7277/Sa3INrJISGAAufVpNg2+XlgTILwxpgjMezO1UfFj
	qcZfZDKXVLwx44WGviebfOflDpBjW79wtlYyfxEZENj8k8ch3pgNBdAzTxLLBCP1
	8lV7DUxYwmGpzb6KIMIxVcIzqSBMpRO4XXUn5PY63CvYl/f6IBpNw66bPy4y3psq
	eQ8yZw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dva4wg10x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:00:43 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6238fcf1f9eso101928137.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777564842; x=1778169642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bo0XjYVyRoPqt/BSUYkXnHD+Dx9SB7n3/A/Bv4qMvAM=;
        b=PgxBw6pAof6RrpMqtXXkAkP8F5Sz+ETfMszR7nHi6hXMUyYUmoLfIzciXQpsxj1fBo
         yUxiO//kkomz3V7ax/CuzL0T2eAbYgEbV6bAmDxFKYtju9/rTwCiCTEUIB/aU/xDxmRJ
         RmBgR1e39QYUfHiphoDmhC9AB86SQv4tJFCfNhByQYnzDr0OTfxYqx005Nnago2I5fVk
         aqjeze/MTBg10GlReK+dsLXPy6BuPpL1v+66Uq790KU1pDlVS6EPXNYKksYeaB2t8SG+
         ZdzCu/PmIs9z+pWZgdcwsOW7i83fZ5hCbWTE4BzJL5KbifJTdomGVIWh3qtolsdk60yT
         ic8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564842; x=1778169642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bo0XjYVyRoPqt/BSUYkXnHD+Dx9SB7n3/A/Bv4qMvAM=;
        b=GXFy3S8xMYaczQtV32Wcz7cVB3g8PFLCoJdquEWIG8jlJit7FuNGhqTZUtTRLZdLaU
         p22+ntav9jCqWZZ51ZszTiOK5urvkEscNd0okHllqCrkO/u4EqtrltQZ7r9s/5q1K0E4
         4+zULh1rEItDSIFjKMV1coGunoWhbUpYRWM1xcztxNn5tJGK22BNIB6O8X3lWre06wom
         hA6fjT12Rifm+aQJ6KXSXyRtq6UNOf7wCAbhpysRlcaNmhuEPzDYz1Vzmlf8NpZ2Zsym
         Ks7Yv233sWrrHuLwAcT6+xye+gXw89hp5zWWdulqydHo5R/zD2VFMdD0GsbIaZBABXs0
         ncWQ==
X-Gm-Message-State: AOJu0YxSXSQbsAnnSaC5oU2+FYQvfWHcNpZpPKweNmPfINZsUENwacNO
	rsBgd5ag1EqPemymz9DWkmHPtqe5KY5eClLtvRrr+UFGLns8DXtOvwjaA41ewEiedMmCgK8Wl5O
	tjVd/NtDGqqh5DmZ/1AL0KEVlLUxRwqKxhlXtYvOOkdGglk3N5VvdXTL1JexZFA==
X-Gm-Gg: AeBDieuBSIDRpWSrdkPaJS7KynpH9bIgn6ovEp+4JqZ7HJ+2T9jMed9K7DLJp2fk2PI
	6+dAD9snKDSmOHi5OzpbUorECBFvnQQqCv/9OPK6YolAL//GeBJN2TA/iHhw5J8MKnE9MhbQdyX
	SYyorotRxCA8Gfbkalrf8PS9poXEfNPqU/nzGdOjRMKQbhWmtU/9NdD3LDbhrMf3tx4V2Poep48
	JFOOHP8gul3PDMbRc1VNDJ8rYNKJIKwCMOjJmPABp4JCbesmPFXvTY6VmWxpcWPo2fd0HFjIKIJ
	FTndHUdSpcTTp2SI9SiDrcmi+H6GopG/sXVztrY1WHAsB3yrH19SghC3OZyv+mXxQPpRhq+LKLk
	NIm4eekfNXJX+zNFhGvy/XJqBUIhu/i5OuD/5DfXZk+78bwhQe+DA1sAHeF4stL0rGRWr8YfNZt
	UxZYHa1h+P7x7KmQ==
X-Received: by 2002:a05:6102:3a09:b0:610:2c3b:7d99 with SMTP id ada2fe7eead31-62ad52ccd30mr926071137.6.1777564842117;
        Thu, 30 Apr 2026 09:00:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3a09:b0:610:2c3b:7d99 with SMTP id ada2fe7eead31-62ad52ccd30mr926058137.6.1777564841500;
        Thu, 30 Apr 2026 09:00:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6d641sm13842966b.13.2026.04.30.09.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:00:40 -0700 (PDT)
Message-ID: <c6c7c9a5-3051-4add-86a5-722fed426a78@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 18:00:38 +0200
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
X-Proofpoint-GUID: n2XLEthmjS0lUwxPbp-BqAg_ICu8QTy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2NiBTYWx0ZWRfX9yUGdKUTuKXB
 0fn5g/57NCDpsNciu1IoIflgI2j7o+WY2V0WN+IotR2wd12ORd4Y+6QdvN7IOObnvSRfQOGWeBb
 aWQeVGU4iYbWtS949DbZBQQVezhVkzAe0RAA61ZxEpd1ocOBKkP0WioeQTCpNlAfm+nUHnkjfwf
 VVkhHH1VbPxw9EtzgsxYZLSZ6vjkD1/Cqt7Tp2m9autsiEtmnM7qv1Kdj2G9MuQrUkXNyV5EXnk
 IvreryFGEUwhjmUyFoRER3QEnz+xAn++T768HdAyVLFSSURSxYr7CQazVcfkFUTG5z5cvfFktYw
 1ae8c3+zumT1KMMTCt18QDH8jrhrFAbgh5T+ft3/0wyvS922/DxifgT9zSLhsNozwh49r/CPs8E
 W3y4vwNd9iPhChICvIQ3yd8dBjEs/MCnYYgVU/fC5enBgIWE8CUJ9J5PF38ItiCXgJtK6QDZi1H
 1n2Y4/qhC8sQWC793Xg==
X-Proofpoint-ORIG-GUID: n2XLEthmjS0lUwxPbp-BqAg_ICu8QTy6
X-Authority-Analysis: v=2.4 cv=Rtv16imK c=1 sm=1 tr=0 ts=69f37cab cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bdp5ZZDYhz2jdzQ5nI4A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300166

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

> +/**
> + * tsens_read_temp - To read temperature from hw in deciCelsius.

"Retrieve temperature readings from the hardware"

> + * @s:     Pointer to sensor struct
> + * @field: Index into regmap_field array pointing to temperature data
> + * @temp: temperature in deciCelsius to be read from hardware
> + *
> + * This function handles temperature returned in ADC code or deciCelsius
> + * depending on IP version.
> + *
> + * Return: 0 on success, a negative errno will be returned in error cases
> + */
> +static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
> +{
> +	struct tsens_priv *priv = s->priv;
> +	int temp_val[3] = {0};
> +	unsigned int status = 0;

This should be a u32 to reflect this is a known-size register

> +	int ret = 0, i;

You can declare the iterator inside the loop

'ret' doesn't need to be initialized, as it's immediately overwritten

> +	int max_retry = 3;

This should be a constant, perhaps a #defined one, reused for the size
of temp_val

> +
> +	ret = regmap_field_read(priv->rf[field], &status);
> +	if (ret)
> +		return ret;
> +
> +	/* VER_0 doesn't have VALID bit */
> +	if (tsens_version(priv) == VER_0) {
> +		*temp = status;
> +		return ret;

Ret will always be a '0' here (and in below cases)

> +	}
> +
> +	for (i = 0; i < max_retry; i++) {
> +		temp_val[i] = status & priv->feat->last_temp_mask;
> +		if (status & priv->feat->valid_bit) {
> +			*temp = temp_val[i];
> +			return ret;
> +		}
> +		ret = regmap_field_read(priv->rf[field], &status);

Please add a \n above for readability> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (temp_val[0] == temp_val[1])
> +		*temp = temp_val[1];
> +	else if (temp_val[1] == temp_val[2])
> +		*temp = temp_val[2];
> +	else
> +		return -EAGAIN;

This deserves a comment. Your description in the commit message is good,
but the reasoning behind this logic is not obvious and will get lost in
time, as 'git blame' will be bloated by cleanups

Konrad
