Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56A41F5C4
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693334; cv=none; b=jSlak/MMHmWfKmT/Ovv/h17Y45JxtMJUSmfVPXgeYGalE+fEsScGq5lxnRz6tkYahff21zDfZX0+oOMmumyrIgGhv71T2BzFCe27lOY4eYTXF+uPSpi+bZZTVe8vtnQPqsOcDsunOaewYV+EEB6OHI1gf2bY+jr+Z5V0yuEGyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693334; c=relaxed/simple;
	bh=XfQFoy92YAbJRszFj4tSxRJz3Ixlm75wjudJorUS+Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6k6Y4el+lBnXudJIdZoDXQJ9lKbfUybQmz8hp8px2b5nzIcbyNQssTquJCYSBN1O2JhF5PjyfVFtzyBm0gdPXHwJFUiE5UBkekQvuIYiLR3x5/WkLvPXAmHNBhdJg86kYL1jvBl9UVDdQ9mMFw080U+E6nXBWWlaiWMYqHndgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TLaB4z+Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KjPDmf8X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLaB4z+Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KjPDmf8X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fgeg1100181
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fW099fw0HL1cZfejGLVIWP2o3DrM5IlB72+z3ftYlz4=; b=TLaB4z+QZfXwOQGg
	Cbtnvbf3oBaDekR0RbQ3A7rx1B3bXGq09su8+IOCAkdrdv1bb0bqc7Qak76tqPib
	eJBFZiq1xDRINkol4ZA8CNUotxcy4fDX9nij1mcfSMRkfqTHQD8LyEMQBelPwjN5
	tILZZv1kCzgzlI4OEm6VoJhgekXBT4w4yT7xH+4XCZFDH3DnL8LP6wXTwcuKxWrZ
	G8GSEZGQ/X0vlWwhO+7nxnBkzXHxjhSGACrh0EkFt0SU6Dd5BEOTsVNGiGzDYMBI
	bGNiySqZUhEeAjFGTQAWIIIs9L8iXOOfrt+j1nyI5H1awzmuCqHqJ1HRqB5X5oJa
	CfaCCw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1uubdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:42:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so9759285ad.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786693320; x=1787298120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fW099fw0HL1cZfejGLVIWP2o3DrM5IlB72+z3ftYlz4=;
        b=KjPDmf8Xcxn5/UM9Eg1Duke4d8s5R0q3gJiNXCADNUrSyW21eG1M4jeYzhT+U1jmJS
         XJO83Xs8gyyzJlF2ZvGAUie8SWHY2yVQvHH4qr/guqtnDoyePzalHEmW+kJuiAObzIM0
         geJVZRLKU7lv+11abtQ3tQ/KAkgngh9jiBf6xJCCh/GYMxX7Z+oxfp0C2JX1Q8PitQTZ
         0o3oVeHalalGeCJ0ojde2qOqkJKuTLWK/0GBbMXcqvcvFLYZi014SOez59OLmLp+5Uny
         9FiknsFzs2tuc2pxkcV/KtQOb0pJ/rr4kfWbUFwOKHzfQvoSeNqesoG1hu6VzEQ7K3uU
         J4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693320; x=1787298120;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fW099fw0HL1cZfejGLVIWP2o3DrM5IlB72+z3ftYlz4=;
        b=nBtZHJnswq5ZbAsFwxzFDns28BnSTq0BB9Elx5x0UX+kblrySl6kqLJTB+fqRET3w/
         USgFMyQsRo1hVMRbzaQSVWtuhldsMmaz1yTQ8Gc1iXRF9vz2P6OvJVWyx+HSpQM7wrGa
         luys5S8J2opZXDlHhSxjYYv7/0FbW5ATfc0oG5elELi1SrrRUmlnN0BUTKeuABHOOd3T
         6UES/1EGg8wvbdR1CXIkWWzhEjzjYOhN710KpgBhnapLmVlSvBG+sDkeIc9VG/gq0kDj
         1Gq/Wt1QKntHAh31Cwp5qD8WkAWZsYQJBV5/d5im47XyPfphcRs+re12xZ46QZ/g5Yzs
         Jjag==
X-Forwarded-Encrypted: i=1; AHgh+RryNA/XNsbwV92L36iZLqzOM7I9zocSdL4RpikeofwmKatucOtIArRSPdC8y39OUYrGc6MYATCSaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KAwWUgyBgHSKPAPHU8TVHfWQTR90F2eCduP2BM/i7c3xKwfR
	Rlq9xZiyzDEAKEb+oCZZp9vdolc644H0b34bDfAAWNWIekZ0qq7F1PcsKbGm+l/I5+RtiJ01oIw
	4d2v0pHS3koiLKgWVfIJhhTTFhUC0mNBjkOrjuwEy/dlVm6ulAxgd/xQHyNZHoQ==
X-Gm-Gg: AR+sD127jSdIJ/Mi5STLlhCvPskfACqPmZbSbQig2yki/2XXW8sHy62X19AFT/k1fYT
	FUdGfITQporWt/LMszdcDmj6IsSL6dF0WXLeU5Fgzq2bZuq4zwv1fyzBUWxcB0eAAFFmSvOMbfq
	b+Okp19vDSFvUz20xS7S7og6/VLC6aOtbfHjCJtSlMZC5iv5yiO8Zo6iw/IFiXzB3LtlpLcNG58
	FyyT/t8bwAXisr1EwQsol8UAa01oSt3Omu9K6/GafZef5erpmkHUrCso1ICvCyXhaGFQlrkyMaP
	NzxhzqZnvVAlF1vicTcTVsEHMFsh57sEU35VlLoH936hh9cMo2vr71fMGAXrtpZ07J6M0Sj+Lix
	x3CZNr80ughUZJD8j4C3WIYEsySUmcZiHDx7zq+mDCnAvPfij0KPNoPWraRUGKx2EKCY2VMwgUd
	gIqBOH2goZT6C1YI/dNCE=
X-Received: by 2002:a17:90b:3c8c:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3933b91661emr4197323a91.11.1786693319743;
        Fri, 14 Aug 2026 00:41:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8c:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3933b91661emr4197268a91.11.1786693319213;
        Fri, 14 Aug 2026 00:41:59 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea9a1301sm1542712a91.7.2026.08.14.00.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:41:58 -0700 (PDT)
Message-ID: <554fc371-f3cb-4c03-bb78-9fb5a06c2bc3@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:11:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
 <anmbi_gXKslOw0bP@monoceros>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <anmbi_gXKslOw0bP@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NDGi9BQLzYo5ohHPYcv5BOUe3E05KYQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX2FM8TrQLa1tv
 C7/Q0SMFN5uk74vze4VoNeFB3ExZdMBfw550GhdGDzRs42S11NTnWNtWY485eE4rG0S6+t7qXBu
 BqgSj/xLtvyTDYtk/vU42LJaGv9Qkia7jxq5/FvS672qm4AI6rRdT3Uk1xcqvVnK7xYyLK38uQ/
 ZNTuf06rwK1CDWoKoVseqWeWrS1Zjvmw8WHbxceFGfm4cB3eMgYa4CtxxqGYqH5aLQ3Hj2hsl41
 hGzU0idr3A5e1aIwu4Zix8dYHPUVa/0pIYSw80N68nV4NYxTAbdIgWitMgBCxSNN5AAn3y0L3An
 1UoTMSMCphubZtrAGxvpKTRF59F2a6pGARUNsl6piymbFWmLXzgXao7qg+3nXuLiZujR8ATB47r
 7HvIUowGRrmdsDYbnt09+Na6Zs3npwG09vI5o+DgO5hDlWyS2TCj+ELaHy3Gen0CeE8VY8IVGOX
 fNUAMzV3fdfOCTtmWoQ==
X-Proofpoint-ORIG-GUID: NDGi9BQLzYo5ohHPYcv5BOUe3E05KYQn
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7ec6c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qjwxEvNmO9gX62DwepMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX/4E1BLvCtGJw
 Zd5fiNtZEm7/Ppas+CMwdDotxmEYAzqosryE6hzuuLfQotL+yb4aMBIIuBW2AtnVoLY2per2a2Y
 DhJlB+2hfxaLWZV/9hEDnt+g4i5fkOQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140059


On 8/10/2026 3:07 PM, Uwe Kleine-König wrote:
> Hello,
>
> On Sun, Aug 09, 2026 at 12:57:06PM +0530, Hardeep Sharma wrote:
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
> Please rely on <linux/platform_device.h> to provide a definition for
> struct device_id and drop <linux/mod_devicetable.h>. The latter will go
> away soon.
>
> Best regards
> Uwe

Thanks for review.

Done in v2 : 
https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Best Wishes
Hardeep Sharma

