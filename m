Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521F3D0919
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174566; cv=none; b=YudxEKiT2nWnEuEsg7l7C+J7IsXvG8dR3k5H1IKQvEY0RPTFKm3Dqj4Jxe6B3zqXclBViePvO7sHDL6FRJCfFfxgjY0j71GmUsK6krNwgjc04K8/jRFfu/NfGisHYppO5KMz88mnojx9FMnwrbBO/6AHEKtzXq65Pbkt8/MhM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174566; c=relaxed/simple;
	bh=3irpYURpHvlDGlXMS8YsN23hQkeOiLcyEiup5KSZVZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Parj3ZUXijv88GPaZ+5zIp8BhTazQuAgX7TkEE9Ctyd1u6LpQaBQX3xlzO0uQ2yE69wPk3L1qnvRTceiZtq7LxEXSs3uPBNcYH+KV9Aq7aG6iiO3L42ue43iluU35Be+ShlaKy4PjbxA8So5Dj99yjO3m6zo/sn6GZJe3coUhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+gmHJUj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iHFzvSY3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+gmHJUj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iHFzvSY3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9x5RC267495
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p0+L2V72WzgtpF7gLfUSB53qvMp8U3eQr2O+njubTH8=; b=I+gmHJUjKMSKvXiC
	hITTL/I7ktF1p9vJ+vtokObcyGZY8Q3MJaYdNJWfzcgKtWTrrlj+/x5k3PoXn/LL
	NrDcAwzzkSBFk0PNV/6jdzPGSY2VEuAqLdWaL+tQZIz9nY61ihVb3MTxPvfzaC8G
	TLvCBxMMYRffWyjxkSI+pVkH4hmgqNwD8Ilns+h4iSKKcu5zWVKreE2cOgQcSBWI
	syq6zXESddXyA9fS8wbllKSUvCT4aPyeok9pTB8J0mowY7Afm9k15wmw4Eg2ROfE
	Kpx5WsHDgR2K0ajRjPjDDQSSGxcVB70BxpHT6NpdxZzO5oGZaSwub9tpxABYUwNa
	qG64AQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u3080-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:42:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428419982eso6827090b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781174564; x=1781779364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0+L2V72WzgtpF7gLfUSB53qvMp8U3eQr2O+njubTH8=;
        b=iHFzvSY34FofdY4yA/asSZp0k+h65zqfG47+8m+hbz7RLRCrGNf9BAhc5Io1rPkEI3
         YKLLp5AOEN5tzAPMTGtL/qXhKakoVMedy/nhtaZ33JHmtb1jv1YDJvN+tzcYls7BxBXA
         GwW2HBqXcbBSqBRTDQ/MzOOUt6x66wBWEdeRAj56NGX9oiT1XIEDbP+hdlMzVjmAdP+d
         he88bWI3vzC7yivmmZEAl/ZmqPRO7nN3bhvVtoj8Lti34ovrk592YRCL5xA9mdf1UwYf
         yt+NGn/r1dBF+DFTt/jZVmXv6pXXgIlaciIaqY7I6dZp9kwHYzg8v/3S1hWU6gOwrU4V
         U19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174564; x=1781779364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0+L2V72WzgtpF7gLfUSB53qvMp8U3eQr2O+njubTH8=;
        b=IcbjWGOWLma6OdZ9rSgCD3smh0B0YP/FfvryjpldgKK4oWFmTvaPHmS/2DiQphPC1C
         jhzGCQ6aQcxkCoR8tVeDvc59IIvbEnPxAcm+P1ntlpGVdl3EMHBTdxz3OZywoZrv0bFD
         PcFbbkQoy8vfHxq2RigdAiOqi3/yXcjVDVnv0xVDgSkvtj7OdP/8fgtgrxfmJMdGzl7+
         4vTvXMoI3DYVfSt35FychWnEceCPbVkppOB54wOk4cy7pPmFI/hLEEEm01n/S9oO5SJY
         I2iR6bKdWPEj8aCz2YkpsCRgthZvnG62qCbPQEl8BZqZlU1RT1oIABeFjFeeCGzxVPI1
         Ji0w==
X-Forwarded-Encrypted: i=1; AFNElJ/USiIWCcwgF/OBW7vZwP7QmJLcvRZ/LnLBVW0PcunZ3P2DpeK3TYd+qjs5a4yCKQglHVzexz3xbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwR6hXnixVz10cQMje7WZ6CnenvnFH4HUEJSkucUq9pXRtsTI
	dg0Rj7P6NNMuCTnDKuXtWYW18kuY93FGf8rL5kAC/nBqFXQT7jqy1CbTfV7uLqLBIbaVRCTV7Kc
	+eQ8wTM+gHvUUG00Jp3/1RsB3amicDpJmK4Icy2neLn96I+slBvcZuNssv6O/3A==
X-Gm-Gg: Acq92OErWQo+YZshoDkPd4UysmudYCLobPO3ZHnKZ6azVUJXh+e13KwqVDwyamFLUdO
	iUmaDYaD6ndyDRjRECbIa6uuPcAUYeV5kUDX1eMY+ZDU0IzIF817VHRFGSdTBq+W12cxvcYFQ6m
	yYQjC1l7lbM3ZyzsBg5b4PCfoC0lFIvSQgp3eB3138B38OFX1gpvSIEzn5997cxUYyK/h/v9rCd
	Sfs28K2OyEyItlEihePIPxxW6cr8mAwOg0ri3/sJAnBxUv6k8PeSQnb136cxJvSCfGFcpm1t5BT
	5EboneSI2dLNYKgAm58+wbYKZ49dSpypFa1ha/gnnUiEVqUAuWQ/YgUZ6UWNYZIWWwVGj+Ys/Z+
	G4DJAtYNnbg81JqsUpd0ndzrx1dGIOICo1og24NixbTBHohSWFGRsioGxY43kxJ8e
X-Received: by 2002:a05:6a00:3309:b0:842:40f8:74d0 with SMTP id d2e1a72fcca58-843367db2b6mr2560437b3a.6.1781174563674;
        Thu, 11 Jun 2026 03:42:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:3309:b0:842:40f8:74d0 with SMTP id d2e1a72fcca58-843367db2b6mr2560399b3a.6.1781174563048;
        Thu, 11 Jun 2026 03:42:43 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338341c81sm1792229b3a.61.2026.06.11.03.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 03:42:42 -0700 (PDT)
Message-ID: <27631a0f-b5ba-4181-94f9-aa7726a4054b@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 16:12:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-2-702fbac919ac@oss.qualcomm.com>
 <20260527124220.39ac0b64@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260527124220.39ac0b64@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N-eBVym6KGFEEATy_hxJZgT6SFTzUFf0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX9Cemvc4pN1to
 PvTF2JxalQ40NjP+6NDIwN38c+jxi0dvnuv89B0RDoivNeLp07lpv+olqdABRCn4Zj3iv5xYBCD
 HLoSGuog61BqAdYOU5dqmQVsdD4xTfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX4ex+4O5cBFzC
 8vvq88PrnKZfA2D8IsbSn/jVcTB+nTqYuWPt0PFl5ejcxK+VQ9MzPCf6MzK++UPBOnRTP0dM4GX
 TQh85eeTgR14A8RX0wRO8IePpD8gFK8/5mNPSwqLlIlx66Epr8CyHDraTBAIRmtJAg1WaQGGuQF
 Q844qzoDCi8iooDOTu6tIeFR4Gc2s3xZH1G/NA2NPLYz+G7Q3+pyGfmpz0vQ/LpFK1pp7/WAMu/
 WE9Rh7qpouSZXNxSIvJncL7rQbiLenFyCrq6yBvS4inLk7qFRtahPjQ/sfL/fLOAb8DnpQjyFFT
 SvhmPLUiL54uKT+4uIqaf55ZsrnPc6Hv9q3IKngiHiNRzZ+lwpPhi/zIZ6Mu2EMDtzvA9ILdrOZ
 5jVKBWn+OvsArxP0heFVTVtPj2VZtU2KBQ31/ZklQKDd9PCL3qS3I5f0Yff5Rp9atZt4eoibnxR
 5BO/xuyhl2KVLgqviOA==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a9124 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cUESM1mfF5KkrS5jEksA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: N-eBVym6KGFEEATy_hxJZgT6SFTzUFf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110107

On 5/27/2026 5:12 PM, Jonathan Cameron wrote:
> On Tue, 26 May 2026 16:26:10 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> A couple of minor comments from me.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..633008f173a8
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> @@ -0,0 +1,437 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device/devres.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
> 
> Do you need kernel.h?  It's odd to see a driver (correctly)
> use the subheaders of device.h but still include the mega
> header kernel.h rather than more focused ones.
> 

Hi Jonathan,

I think this is not needed with the other headers included, I'll
remove it.


>> +#include <linux/module.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +#include <linux/unaligned.h>
> 
>> +
>> +static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> +	int ret, sdam_num;
>> +	u8 tm_status[2];
>> +	u8 status, val;
>> +
>> +	sdam_num = get_sdam_from_irq(adc_tm5, irq);
>> +	if (sdam_num < 0)
>> +		return IRQ_NONE;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
>> +			     &status, sizeof(status));
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
>> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
>> +		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
>> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
>> +			     tm_status, sizeof(tm_status));
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	if (tm_status[0] || tm_status[1])
>> +		return IRQ_WAKE_THREAD;
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>> +static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
>> +				     int sdam_index, u8 *tm_status, u8 *buf)
> 
> Might be worth an at_least marking for buf and maybe for tm_status as well
> so it is clear they are big enough for how they are used in here.
> Sooner or later compilers will check those.
> 

Sure, hope it's sufficient if I update it like this:

static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
				int sdam_index, u8 tm_status[at_least 2],
				u8 buf[at_least 16])

> 
>> +{
>> +	int ret;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
>> +			     tm_status, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
>> +				     tm_status, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_CH_DATA0(0),
>> +			     buf, 16);
>> +	return ret;
> 
> 	return adc5...
> 
>> +}
>> +
>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> +	int sdam_index = -1;
>> +	u8 tm_status[2] = { };
>> +	u8 buf[16] = { };
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
>> +		int offset = chan_prop->tm_chan_index;
>> +		bool upper_set, lower_set;
>> +		int ret;
>> +
>> +		scoped_guard(adc5_gen3, adc_tm5) {
>> +			if (chan_prop->sdam_index != sdam_index) {
>> +				sdam_index = chan_prop->sdam_index;
>> +				ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
>> +								tm_status, buf);
> 
> I think the clear of other sdam interrupt status that sashiko was pointing out
> is here as somewhat unexpectedly a function called status_check clears as well.
> 

This is the full comment from Sashiko at this point:

> "Does the threaded handler clear statuses across all SDAMs indiscriminately?

> Since this thread loops over all channels and clears the high status on any
> SDAM with an active event, could it clear a pending event on a different SDAM
> than the one that triggered the IRQ?

> Because each SDAM has its own independent IRQ line, if the thread clears a
> pending event on SDAM 1 while servicing SDAM 0, couldn't SDAM 1's subsequent
> hardirq read a status of 0 and return IRQ_NONE? Could repeated IRQ_NONE
> returns cause the IRQ subsystem to shut down SDAM 1's interrupt line as a
> spurious interrupt storm?"

This sequence of events can happen, but it should not be an issue.

It is possible that the threaded handler is called for servicing an
interrupt on SDAM0, and in the loop there is a violation detected on
a TM channel on SDAM1, and the SDAM1 TM status is cleared. But in this
case, this violation would also be handled after we notify the thermal
framework at the end of the loop, by some threshold update or disablement.

Even if the subsequent hardirq fires for SDAM1 and it returns IRQ_NONE
as the TM status was cleared, the violation would have been handled
by some threshold update, so the interrupt would not keep getting
triggered afterwards for the same threshold's violation.


I also checked the conditions from note_interrupt() in kernel/irq/spurious.c,
for enough repeated IRQ_NONE returns to happen to cause a spurious interrupt
disablement. 
It looks like there needs to be more than one interrupts returning IRQ_NONE
within 0.1 second to increment the irqs_unhandled counter once, but there can be
at most one TM interrupt in one second since we set the time period of
recurring TM measurement as one second here in the probe:

		adc_tm5->chan_props[i].timer = MEAS_INT_1S;

So a spurious interrupt storm is not possible here.


> 
>> +				if (ret)
>> +					return IRQ_NONE;
>> +			}
>> +
>> +			upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
>> +			lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
>> +		}
>> +
>> +		if (!(upper_set || lower_set))
>> +			continue;
>> +
>> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
>> +				  int low_temp, int high_temp)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
>> +	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
>> +	u8 conv_req;
>> +	u16 adc_code;
>> +	int ret;
>> +
>> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, prop->sdam_index,
>> +			     ADC5_GEN3_SID, buf, sizeof(buf));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Write SID */
>> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
>> +
>> +	/* Select TM channel and indicate there is an actual conversion request */
>> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
>> +
>> +	buf[2] = prop->timer;
>> +
>> +	/* Digital param selection */
>> +	adc5_gen3_update_dig_param(&prop->common_props, &buf[3]);
>> +
>> +	/* Update fast average sample value */
>> +	buf[4] &= ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
> 
> Maybe use FIELD_MODIFY() for this as makes it obvious where the update is.
> 
>> +	buf[4] |= prop->common_props.avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
> 
> Looking at the field defines is this writing them all?  For other fields you don't
> seem to have been careful to preserve reserved values so why this one?

I think this was just overlooked earlier, preserving the reserved values
should not matter here either. I'll update it using FIELD_PREP() like
how it's done in the main driver.

I'll also address your remaining comments in the next patch series.

Thanks,
Jishnu

> 
>> +
>> +	/* Select ADC channel */
>> +	buf[5] = prop->common_props.channel;
>> +
>> +	/* Select HW settle delay for channel */
>> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
>> +			    prop->common_props.hw_settle_time_us);
>> +
>> +	/* High temperature corresponds to low voltage threshold */
