Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196912D6E58
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801156; cv=none; b=lg+kBMlDqFmy9uuAE/xOdkfrzsvD00QcwAT1BnPdf1MOKBwstbVZX9E4BQoYZfmeLCwaKI5WtzsFGzwLHS/Had6RWjvkU0V3vsiDsRGTKNGDGf5/DvrnmFhEbe3YbzkcEh9awoBDNiJNjCdnteZIiKhVJqa8/RBaOfpNwNrfVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801156; c=relaxed/simple;
	bh=VhU5lAS4LQFsAitWBLKALDCa2KGV/IuRNjV2ufL1+Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1Ul2ZIgvIyeDw6akKJIYjPzQZMJn5sx45HpbeMwkNQSMtTtcfy4OegGeoaYRCRiBYC0aKlidy0rRPn6hXjjqkedOfrx/zCRarTKQwjsS0cnpk9M4vWYQMDIU1okBKKtJ8C++53Udk8FhxAIkrCfHngaBQRlIOZziDOMQKwQsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLPvP3SW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+29IWrF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pLPvP3SW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+29IWrF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsYk42496664
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=; b=pLPvP3SWl7h1o8mM
	tOhqbnNrVM7bvHDo5Nxb4tCTfR/NEe6DsTx+sQiemiVOY7QT8yU+HLIl9L12Afnh
	TfN1i96lvlq5VThGo2TQmVgs3tgUWy5qxdVdys+xWhOZkrXQJp89dHeilGiLjNFt
	UfGjQkHiLw29M0/rthjODbl3CSffSQQ3BJ54YnFno6MFZ4IgUOO/G+BVFYMBtnM9
	0BmKjf8Zgb/fJyQoGazpgmhHk1vB2XRssXM1zTQcZHEjT9BFJFQZT93tdMEbIyTw
	EqfN9JARInHCTxtJ3sVTzW4uu7TMC8S54wIYPHEEBYjgAg9ClUiIMIsB7AH0F2+o
	b7fRnQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqmdhg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:12:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95ccfd9b58dso14552403241.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801153; x=1780405953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=;
        b=j+29IWrFNdDmAA0zInecWVQvuTOompcUepgdyqZ3zjOcx/fiWwigWhjDEG8SfvkRvu
         iB4bNntIAKI+vaXEyPZIZ9GMjwrAB0EDZOVFn4RXlhIdjz0Dp6llLQpNZFwrKHYoTIaw
         uWod0qtAim7nyU6BBR+dAtuVflMpwHshyMew9U4VJynXgqDzBK1BaJQOjLOgeOBZsGb+
         WrCYxlPKQRjNW9tuuabP7Sfum6fB8S6svURlEiqGY0HsOKPeVj8x/U3AeXawEZASZAFn
         Z8T9ZRqeoc1athDPKhVVvG1hUG5JICCnfcauY6Ghd/TAPxhHuYQ4UO6ILFasMvV1+TwJ
         Y5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801153; x=1780405953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=;
        b=k5F0HFZ/EkRa9IoY+Vt8mlf9kLzT4IOJjyvcHsGeDVtdIcYZ5NZS+q+yFVJKGZtsNp
         amCXQ76wu2zE4xndaw9/tBadPEOaiwIkJzu8Qx1+V+z0QP0VHpYyXBdroSWeF8s4xBE5
         Fv+Mejn0tzTalzH78wGuP+S+JcDdY7lwymor2MR+n+GeAnsUaVU/Vz4KyERBOIIMVb3T
         Qgsmfm2w5HEbUFSQ2mqj+Mo0ORDKCn6bsbunJ8I2zpVe/wUb1n6NSYmlVKMXRpWUpmM6
         WPpLoVRBBtcmBtUOqpMN4dyLV98u4IC0cKEXfqBIyMlG0E8IdshQDHFGpsP5I9X/nDfu
         e14g==
X-Forwarded-Encrypted: i=1; AFNElJ8n1TefFIWI8SV1Rv/4kA2DTfj64dDU33Mp4qm72jFCQCkzGvrdV66GkvdffZwlhjuyD4oEWydzeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSV0QxRenkzZSGUpqHSdOVmJnwMYucW+o7oR2HVXX1HxiGDO5
	ywAHNWUAMOWJG+ih+rFcWFR/uiKEAdi8chVUhDarACtUEfuMQhF4Qe4K7YT0ejMDZNQBD0jxxaP
	3GBNq44Ui0bp749UT2zIqlwGDfD3U/xLQctRCphwFTvKwYF2cU/8+t4Ok2ErCEg==
X-Gm-Gg: Acq92OGuzCWJ4RIEpNwyXaxo6C4kHS0aLlejEnY8EohUOg3hR8/CVsruHM954/DTJxx
	Q68rt0wiO5kCo9QrNnkBmifHxWE+Qjx8tL6W49gSH//QAn5S30laEagyJAGluPCDtMUEmWjG7YV
	c/QrwmtedxUC1MiJ4LKYcNAYby5fKdVvmqSEAXRE2CZzlQLvhe8eoLW51LxKcPf+yg6yTyn+qh9
	KeMxG2EmqYpivp/+Wdvhh6PWrXdfn0F0cYsFe3pYoKzpcDNSrNy9lOHJpPPHOe/ppxZZQqin8uq
	zQacfSVq6FsK0dKaN91MUWX2Hsk1FVZQrpzxzX0f5qgjvixI5Akw3i2IrA1Q9VRcVMZ7WAXprvD
	H+Zk7Gp0jWiSwu/9qVvk6Qvx4PGooVTdEMvZkiEjRSzrKT2H3EoCfZVH2Gzqxns/Vn666plOey8
	109xVKbw==
X-Received: by 2002:a05:6102:2926:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-67c8d071383mr9240001137.22.1779801153479;
        Tue, 26 May 2026 06:12:33 -0700 (PDT)
X-Received: by 2002:a05:6102:2926:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-67c8d071383mr9239948137.22.1779801152945;
        Tue, 26 May 2026 06:12:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1? ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059cc9a91sm70577445e9.1.2026.05.26.06.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:12:32 -0700 (PDT)
Message-ID: <3584c4eb-1d9e-468f-bd30-9b5d91c865af@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a159c42 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=IW_paQoX8PhNCENOWI4A:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: ocB9pifvGTGJFvaG9P7frcep2R4wu5o9
X-Proofpoint-ORIG-GUID: ocB9pifvGTGJFvaG9P7frcep2R4wu5o9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX6NbGo0JWEP+Q
 ObsZnuFJhan1wNjAw8jyEtQcIwNeFwuryds/a8P8msE+NkJRItsKfxUA4+zMzgAqhz8uo8L06vm
 jvRFoKiSSAJsKNfEJPLaOFm4Uvw4GZreU3+N1vuvB1OTHXGznQ3tpAqgMsLr6G5c8/PqR0dq+P3
 htdpFz8RVzYobmKhu1OkG4V2aqN83jYSTki7IVzL+PbBfvcMWRQS78HJuD9UPNASlM33Ti5bbFl
 ++noAmgHNt8zpcaIfYY8PkTNh4lTXeE97Pi0QkPzXWpXQW+rcKaSoAKV27ibKjKLVTf7bMA9x0m
 L3R+Ine7Rx369BvfGc+Y6yWej+W4vLATnJ8AnchqSMEdIj7ftj2iXS/PN+DSVQcKXgO/brJP4wF
 8eOHrZ8tMEU6qag8OWJ6ckLFpjZFtbb5Fn/bzJ7yImZLV4hPJMGWZK6SCHX80uGB2yxYqOA33vZ
 q5pttvMrdMLFPVTGw+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114


Hi Andy, Johnathan,

On 5/26/26 12:56, Jishnu Prakash wrote:
> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
> immediate ADC reads done in this driver and for threshold violation events,
> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
> TM channels on the first SDAM.
> 
> At present, this interrupt is handled only in the ISR in the main ADC driver.
> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
> driver by calling a notifier callback exposed from it for this purpose.
> 
> To simplify the interrupt handling in both drivers, share the interrupt between
> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> the ADC_TM driver, so remove the notifier callback and all TM interrupt
> handling in the main ADC ISR.

Given the nature of these changes reworking how is handled the interrupt 
to share it properly with the TM sensor and the dependency of patch 2 on 
this one, I think it makes sense to merge these two patches through the 
thermal tree. Are you fine with that ?
