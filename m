Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE63E49DA
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153560; cv=none; b=IeLSD/CB3kErBwjMKj74rj3+sRlKv/to0jQtaX42WsC+eP1BZkxc5FCS9z+zbbDOZlBV0VNeZPtd2lVGx/ZmGHw2aDl+qlXs5CJfb0ZwZt9H+jJ7pbnh+X3aVOH+Q0brLesU6GXPievsHd/FgheObQv9ZsXeFxSTBw3LMTnC0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153560; c=relaxed/simple;
	bh=PLWW2hnEf6IevrdZ7b8dtjyCj2TTYWxcRo+NjhzeynE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdsxuFdSKxyvje7ABRfoR0kn3qGT+AZ569bn2vQZsnkF0Exqf1fUA/v+wBjyns/jFmA4EMVxbMr9YqR6ZHKCX4eGBSXwHK1w/HsTrFl3GJZjUlBTR/Kw97byWo+/HRp4igfvRDzrrt2eLVdg6Wkvv2RySJcmYDHGIPZ9PbPiJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1yXQXZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L/oEQip1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1yXQXZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L/oEQip1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JkKt2004333
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 08:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PLWW2hnEf6IevrdZ7b8dtjyCj2TTYWxcRo+NjhzeynE=; b=D1yXQXZWi905ULVL
	vPltoe3VMdIlemBudUlnlMJ5AztG22PkcN1QTcuLm9BZXiVVVzpmtEg8jy3IJkdy
	KK2gslkctFmg+sLnvKIr9nuOb56TuBdZoVwPzzN9LjQuXdYdawey3T32MMXa1NXh
	/jXKvPkXaYZil5YUQ8fufDYgbGP36eWwgvOifq+/UIKnsKxWtfEOukRyeHmFdfED
	RPTXw8g3qhsXtIw4OxPLjZ5VoSAFMMcePZH5kkVTkrsyrJUWpTAtl7nnKHA8cIRQ
	v/y7AiqNPvEc7m9alyr1gIdS7pR/YJNotK0i7MDWspxD1Bgg7w57/oI1kpxWSH+W
	AHerpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec4hcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 08:52:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93102454272so20930685a.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790153552; x=1790758352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLWW2hnEf6IevrdZ7b8dtjyCj2TTYWxcRo+NjhzeynE=;
        b=L/oEQip1IjS0u5oUWJpw7R7omKRCdXKys4Ij1zE5DZQXt4Mmx+8KvN04sf+nwveJai
         SltcnFJT3Q0I4tlzwkijdCGB6Qjdx4m2zw46EpK+orbN24Kpnqz0qk/OyRmrI5hNUEB3
         azRam49oJASiAE0wdNCHLtv6VBJchrqWwxBAu9d+DnIJfjbj0Tuw5tI/PoK4N0VkeXOP
         ffXe7xWxDBJd5NuG30euzqv1KnueP/2suOL+yE11m8cts6qb+zuZtMJsLP8uO2qybEzh
         FPTFu2vVzhvWagZOlHdEzp8LvL2wNK/lcWphRQstO7f55h+1Kp24s0lAuTw1UNF94lX3
         9xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153552; x=1790758352;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLWW2hnEf6IevrdZ7b8dtjyCj2TTYWxcRo+NjhzeynE=;
        b=ZDm7F8KDIHisMFZ6d9OkZIJ0GT+fsvDaGqgnaCaNwK1uayjRHn1Ce81dGTY635vvO1
         tjzD2XV2Pr4+Mkitmolo9mfIcx6Vcao+SzfO6IbC7F1TzfH3qgtidjE+q+sbUGleXvZ4
         ZSr7uUfTIAJ+c5mGoo8R9DE9P58YHFkrmGELKF66x8NZDbxdVnFNauD/HkbQ0U0w4S3J
         mM2lQ7ky78rzT/U2MT30iVrGqtWWXJ4wy18j1FS1GUXGRUIBCokwKaJQDZT2SutkEdhD
         Za2kIiLkMssoQbQ2Sx/SAM4bh479hFGObEVBhx3UMMy5SiguoYpLmXoFc9Al05rWpYpJ
         7fMA==
X-Forwarded-Encrypted: i=1; AKwUvBy8o0t8HKhkjOY6QCIvbQhetw808qHD3yEtA6YmQ0PaM4HRlA/py3TTcLJhn9JmyfVCkTmRnfSTlw==@vger.kernel.org
X-Gm-Message-State: AFuF++nChCNODcqgxoeAd2ylQ6EfOLRUsF5yxVkxYSx5QBfwODqKOy1j
	22BhY9x2v6XR5vFqnwMo+LID39FUxCb4gxH1djZ5B4wgjBvItSwZVmiVkpbB6gzC8l9i5BMkiX3
	ul3hqZfgJ9YGtQKCBPIHUBX45+KKrifkKqZVwf/G+slE1jqU8Op7yhIFHSoP9Yg==
X-Gm-Gg: AYBFou1DMVVAuaWRYtO29w3JzYt9ZHUk4xgWqxBzkx3zDMzavQ9qOTlReFRE1k1kbBx
	l19DJbFHrUE/XYmJEFG043iul8gHTid+9TXxxQ045nIsF+PU+b3g2t2OW0QWCPOV/MG7kyPuk30
	ZoRuOd7LYbuhlerq2t6/Rg+d9JOKjbkxf60HYzhB0t75YMWOiqyDwzyfSk4l3nPxC4nm1eQuwOR
	7PIVDwRMgxeOjfaUVDZM8LOvuIzvXRHyJpvwfoxoI1w4pg36r/OtYhBghuVKi1Z5b8va6pJA5e2
	RH2rYCeSU/xMedYe5nnJWEg4EIQOVeqbOEAMV4xoMyA4a2VTLlxKgSDNjQoldZK5gUAriQI3DoM
	sDvS/S9rTYUXTfRiV8EvQRw==
X-Received: by 2002:a05:620a:8013:b0:93a:3e11:e2f9 with SMTP id af79cd13be357-93c2511c770mr256690585a.2.1790153552437;
        Wed, 23 Sep 2026 01:52:32 -0700 (PDT)
X-Received: by 2002:a05:620a:8013:b0:93a:3e11:e2f9 with SMTP id af79cd13be357-93c2511c770mr256688885a.2.1790153552106;
        Wed, 23 Sep 2026 01:52:32 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c604fsm73371366b.13.2026.09.23.01.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:52:31 -0700 (PDT)
Message-ID: <cacaa28b-28ef-4f69-b002-2757aac2a50b@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:52:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: fix endian annotations of BCM aux
 data
To: Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260922182711.25176-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260922182711.25176-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX8QYqmYXZjgMl
 /kRXxb7WW+LAGluvyd2EUv0SBHtLg2ANv7oYP0gF59xGhxLhLg4Lw3WwWFkCXR6haJn1q0RDf4B
 N7g+x24zfZuXescd7w2NNybcgK8CqwAdORIbjFgj8BfxX3BqLdV5h/WieeZr1QYlirz5EVTI9vi
 RcgdymldMdBvaXsuYWv96T3bYZahdwVDy37uzDJDbvSWk2JiNudT9wZwZGSbWQnYfOyFgblLzVA
 PwI6IqWOgwmdJv1aZuqr+ONvjh9x95C8P7d6/XlVfZECZfkRyK+EHMAXqzjQSULPpumUtX2IyFV
 PN/mNb/fEONNN21/SOH4RFIe1OeEJRaMOFizfBNniFySCtTjCA+FbFMQIsYu3aHs70KjtMhHzhl
 60vupwTlKVWqg36i8T3lJrS7/lGxO4F8ivnnqhU0558BEsie1ZdGau50iFXxhllJr72gI1DMN2g
 gJIz8aNGL7x3hEf2uuA==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab39351 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=kBXQb9JHnCtroGRzBYQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Mz5lRaMvReMQXyfzngstAkRAYyHO10hu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX6aE5dAmYBU7w
 kYO+2OrEJ1IgJ9qu/f3OOY4jko2hC+VlqBgCRYB4Ne8s7Ycl3FFECeBeBoCQn97g0RENKE/+O41
 nyXHLgb9p2nqnYdOE+ihB1Pu1JV32/w=
X-Proofpoint-ORIG-GUID: Mz5lRaMvReMQXyfzngstAkRAYyHO10hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

On 9/22/26 8:27 PM, Rosen Penev wrote:
> struct qcom_icc_bcm::aux_data stores the values parsed from the command
> db, converted to native byte order, but is typed as the raw little-endian
> struct bcm_db. Sparse therefore complains when the converted values are
> assigned to the __le32/__le16 fields and when those restricted fields
> are used in bandwidth calculations.

This should be fixed by using cpu_to_leXX()/leXX_to_cpu() when
accessing these fields instead

Konrad
