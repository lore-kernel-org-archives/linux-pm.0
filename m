Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5E47F79C
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277902; cv=none; b=mgioB3jiH454LkskaXNW228Z5jHVYwbO4WNZ+M3tg/E2QxIu7COnIfFrgTMdFeJBKx88GjFZXmi6ztCS2Ah8xSljo5fiJx0lSfmV5SJfVdHwKEtzq60vzA+eA3YIlUHgmUOv/LkSUO05SXsMX8vMUndnIJ9kjntL9HhSk6kY7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277902; c=relaxed/simple;
	bh=09he5egQgLt2FlGKJ+y9h7K5tiRzxN1RtLaZYsMsDzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bbod0LSRqVllFe7GvhnZClsrK9kjDckIqkMlvC26T6pimqPMU0QrY/HhO+nOPi9wygKLKGnvUYlxWqGQ4V6A6RcuzQk1qdWQ0cl0Zz8CnAphN1tTXYlHodXUnTKJlRkMa1NU8lR18SzDHBHRND3hJgOQ8t4I0urp/hKQ3PCN+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBsCKrdy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=THIAqL4e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBsCKrdy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="THIAqL4e"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8XSM2145830
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLXuthiikXhHO9knkRoRDESDV7G87cacEj+L5hg3O0A=; b=IBsCKrdyIOT2jJh5
	uttyGrbXTRm0UCmq8i9eD1TKAU1WOeAsHrZscqk5dOqB3fXxquXSeTdKTwKnpo+c
	ICEEqQ5yzwMm4ab3upzVwNDLVLFBcZKO3TnCcDx4KmXpHaJpfBhOU7B14Okwktcr
	JvhD/g17TzXNO+2yj1hMttje604egG4iDsQPC5wnUTOL86oZdnTdpV9RGMxEPou5
	8PTTN2czqg8JbbyW5MnlryTm/FEsCFTARNjvzfEzlTbnBoWz2hHcWd8+J1N7IP8T
	OAgNMbDX/QMvYo6UCWe+6gg6QnpKL6Q8YQMXJh0WEZbL06dhQZ8lcr9j50PmL7dU
	jhzj1Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8ujas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:51:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7570225606dso3310137.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277899; x=1788882699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLXuthiikXhHO9knkRoRDESDV7G87cacEj+L5hg3O0A=;
        b=THIAqL4eFv+ZgSIXoppF/WEkA9RdTJtMeYkxnBIiV48whQ6qVXnOhaInOG2pZC0kZ9
         l9EurRaq1qAvBUViAnz3IiKM4jD/fmuFDXhuN3AAaoLdRTTOs4F6Nsv4DYQ9uQ22N+Tx
         pnPIf2flv/AYzEEFAwDSmjpwKOMpatS+7/8b2fkuFKAPwjSWKC9s7pMUISsvkomcIzQw
         AVPD/c9N6HRdpGcFYiQJjSmeMCAKqMWtSCBGEQp8/ZxJowZGsbUPgLcqWIUdpZqX2Q6C
         ZjDPo9w6Vi5GfiCZzKnbkhmXo5yemnv1nMnuEpN7FPBeTxsDyfknXrHF5e9F2gNMtSFR
         5WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277899; x=1788882699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLXuthiikXhHO9knkRoRDESDV7G87cacEj+L5hg3O0A=;
        b=XMT6b4inj3iV9u7YM4t+oFcrtofI8GUPRrKfajc+SbU/iaPjzW4ijbk/u0ytrDAIPI
         MGy15OYxujmjNUCPbiDZpDq9QBjkf21XxNOVhi9wMbn/75v4hpZi1zaBO2hLlW8sTc2/
         gHJq+amNYM7PlAr5zaIfMpy47RSRANCIFX9XnoRbpJO7G41S9+8uvmu84U4gqYpmDPPa
         G+irUGcUz7GvHKa43QYji2gJfbQQ/4sjj/AxjRLxHa3k2Y7KV5gSPm2dWy8A8MdqbQ9v
         Bofg+jCq3QZ6Z4AbZse9QSjF1GZiCNuw7Az1hUYmCwtv0+SAugFr0yhxvlL47kkN/zMz
         TZ2w==
X-Forwarded-Encrypted: i=1; AHgh+RpwO/gjhsK0Ifg55mGyJIzPQPOdSV6fsfRBzAiapR7KZdpTi+Y3pOkqnPL9HlsewwRioYpY7VTh6w==@vger.kernel.org
X-Gm-Message-State: AFuF++mxcdH4uRGA2ruhLPdLQYRQCLIMOI0yOTR+zS27mTTF3ivSt8gV
	Wcp07wZ1rkVo+O2Dc9NOUQmtzU2Uv+n4H6egEBoMdjsn1FSsnkNvDWTIvB7RXkD3m/HpcXLrcek
	2ySghHUn/930Z5B0TQTNY1p22C/Yktofyg5nCMv+iVDOoKWWIjVK7N1aqggwaDA==
X-Gm-Gg: AR+sD10in+n2Fyg4zwrXHQuYV2Wyn0yu5lOHR2cZnbRnR/BZQaFPj+blBNEB8lFtLra
	d9Dx4UOB8SLWRyFnwcYGPpdoE8TURqtPVCho4DqHKvlfotpnSGAYVfdbkDByF7L3h2aC4y4evSn
	nnP8wTQnWVyEzPsAlC79QrXPwL4DkPGK+D7LIMm1kgqeOzOZS8sfnF4S39spl9mE/x+MwoBEwj4
	3p9FuJvqioZHui1zGC76TuIRRHwuB7+d9W5Mfl/gdYOnyo9cW74dEEFNsOty5+xlOULPFpTaV7X
	M9/whzfR0hpa/jzk7gQnTqetlV38ChYovQzXhUMneHQ4KaFeAWXb5qxM0pcTbwfWkxQbQj7L48M
	4lP1d+TjYpsYi9SRCpbGZ2g==
X-Received: by 2002:a05:6102:f84:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-78593425615mr4728011137.0.1788277898954;
        Tue, 01 Sep 2026 08:51:38 -0700 (PDT)
X-Received: by 2002:a05:6102:f84:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-78593425615mr4727991137.0.1788277898479;
        Tue, 01 Sep 2026 08:51:38 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b1fdasm630555566b.37.2026.09.01.08.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:51:37 -0700 (PDT)
Message-ID: <e7fd5417-19f9-4bbd-ad65-48230fb81c05@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] pinctrl: qcom: Add Kuno pinctrl driver
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-9-6d47636a8f09@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-9-6d47636a8f09@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96f48b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4tAzDn1lkwtfZF03VZIA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX/p1dbbjeAPd1
 1cF29QQmwS5BMZTSe1BPOhYb+0NsynbJm5Yjv/Qn76kX0Rx0AKLrPALsEHiV67mWaIpmuqxT31F
 8OeoewI/I1AqSl93TTvUp92oWsR6CyuJPKl7Q6e2L0U+L/hxKoJhx89TX7sIM8P/KToUnUP0B1o
 QoF4REk4b2akApVt+9sthKskFkZ+xkqF1EUNBbSwhOparoDpom2LOxj85ozLa5CYC2tBHYcEAVw
 2vv9W9l+X3Q4q/MudbFk6XFEQ+7AuBQ+/PmPLzIwoJC9q784Py9yibRpL+fb+yHm4Bgc68RlI/c
 q0eGXo7dTqWA0A53agwALjlLeUyeymM4D2GcXhiyd7a3RK//QKvQJoQCG8MvYNdGnTIdsBps3hX
 AW0+O3Sk+b2nJ8PN8iD4li03yh/Bu7raJ5mLrA/4U6/m7/HZZpEvPpPp7U0m+ZzaI66T5cJ/kYv
 6t2+KUiv1WTPWeiBhpw==
X-Proofpoint-ORIG-GUID: PnCTwwAnSagt4VPD-oqyz-KZ35ynhYsw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX5eBBEZ7/VrFV
 3E2BdYU+McBZoInAo+0FETONe1/l4WsvnEtSW1w55qbsB1QYd5DBLS8YzrEIlAEcDKt9bQ7lsHx
 5aUuFdib+CJhMZ8SqwaIMoA/A21tgwo=
X-Proofpoint-GUID: PnCTwwAnSagt4VPD-oqyz-KZ35ynhYsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010140

On 8/27/26 7:51 PM, Hardeep Sharma wrote:
> Add the TLMM pinctrl driver for the Qualcomm Kuno platform, supporting
> 110 GPIOs and their pin multiplexing, pin configuration and gpiolib
> interface through the common pinctrl-msm driver.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
