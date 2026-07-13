Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874C3314B7
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961777; cv=none; b=B8GSvpbRhUKff/yz1BW/ENSXP9FA/wt9BMi9AENZhAPEbi+Yxaq2bPfnH/vsPe6CR60DjbKaPqouJTOaKd1wmObRhkoMiEqV/gwvZXkK4y0Yhe7VzDH9kQx8ya/kSiB5UKIToQHUYCqS/qnU3ApDCahDXob4G1WZBRKp31mGIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961777; c=relaxed/simple;
	bh=oVvyHkwRLo36ybY/LmG8sSxJU9a9lzLKNbwUsPqQIbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBeMmRLRWxwaUzGEGz+tKOYno6LnSr/TIq3NbHZuAieD30OCS7BpgSXVZTpAcA0c4eRUnpRrqXeXVFZP6tH0amG54740PmlLRFR/p+NNTsxbAF6uUa/M5phmvClwr8BHS9OEuB3527W9XJtvcMuLIUX5oG0+NLep5c+GnT+34Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rjrgq0W5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6ESEjIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rjrgq0W5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6ESEjIS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8AK31968322
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=; b=Rjrgq0W5NzrMQVqz
	gcBwMVMItVSJXxllv5/eHXXHBC6PKw/BLlL6SpG1uUXIUoGfsFBP24+RQY93ZUyY
	ODUBJoHz9zVenkYOu3Z7SFU3BZ+RiyfEuRtz/C2iyi8scHnSksF7tj3OCY2uu6Pz
	66jFAXCguty+C6+SG41IVYYVMiZ9qZWADDPqVB7vRYRtNktnf7MtVA3tRKtE8lDe
	W+q8F3lsITrYAqzSROjhuSepC8jknealT1aZDfI5la5H9yuCAs91S2PzN8tjNQaa
	1xmGyl5sPVURYB5dowtn3ZeFOvNZvBwfAp3iXUizNvJzFNGpkJgfO7Mq4k1BKYJl
	2vX7Dw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3bn55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88fc985a65so3901533a12.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961773; x=1784566573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=;
        b=W6ESEjISflrkKH5lE48X08d7GrgZEzGleopjXbhyx3zlGdh3P5Lle3IUDYaIG9rrhe
         UAyDiKApi8re0Jn+mwwhmmV9BYdaIBOQuq5B6np/OnloFsdH1gmHOjtIBQyylABKjJDm
         DU4Fss9qOhP0qQ+8vIyzffNL1LEpuI8cKHR/EERd3Op7DLQ9NhGzESDpvjJr59hCvDYL
         yl9Pg+DbBz5Vl/cBPqT+BiEMnmgLYdfmujCyyKShbksEvHEEEVLAOp8eq7NmXkE1knpd
         rnRg3FqH693inonL6qHqpCczq+CB3owyDndDXRrfS3mQGjt5jima3Kl9AM1mdpM7kjaI
         +VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961773; x=1784566573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=;
        b=Y86jTmEtEkMwZ2mO8J8cKYpmlM5E8nSLEQEhpnlbEN+gmiLEHg6JvdR/7Kah9GPoBk
         rZMJlgL5Gcg9qYs1Zo5k3/iLSHTp1h745cMrSLcyVViFG29fgQ/YbiTb4/nyz0Drm6/P
         BEwfkJ/iviGOudMYw/t746jANyPYPylgjT5GJkKWy0QfFLsm4tBqCWObkzBw+VaTqVcr
         Qp1O/UV2iM30ZSed0LFsGZY5YkAnffLQ+N0D2LlqwD9JKEt9QAsDC3X1V/h7hJ5b+NPU
         mNUbt+jJA7oVIO/uG2bGj/ViWkgcpzfXdw4k7+8W1Mg0uvlxgTaVax/hvKQO+nZvuQdD
         UCSA==
X-Forwarded-Encrypted: i=1; AHgh+RrC2EIGGgzrgpTgX5BebGVzT/yLHhTeUokbsoGG6K7OHSXf9ieLpCLOT8M6Qt4bbgOfB7ljhAtTVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwqABrTppiMUSp/7ZvAPlZPDF2xNgimgsVBlZ6yIg9m4oRb2v
	FOWEKtNqVWzVDPwjb/Lf4y7avQRg3OqQa8nkLnOECqmMc5qb8be9IVWknf08UU3lx/GNHwYbNFZ
	DJY3IHcTb7N073MhBMwpKdtaMuL1YG8zKcIxEdlBbyb1gHvCCo5u1cDnHbaArzwytin74xw==
X-Gm-Gg: AfdE7ck9kGCjhERo6Km5velyaB3YfIhHjvHI+cp7WA3BIszrMXCcruk/F9/WeesaMpP
	UbtXUuoFQ1atlPy7zpoTnEEg5Dl3SnmEx8Oz0yV9Hzqgx/swviR5/kTYGsuL1c0kZLyXRCCp2Do
	lT+vryGnkSWt5XH8uf4z47rcw+bGjnyGNEp10GXrlaniIoaHCUYYdgs8QOL25i/POeIeyFI7DB/
	1qtL7GpsnNuTxFMcq2JvN+ksUDLuzWXRBQvbraQcOfHnOMh3E66qJS6dlXl6UcWwj3YWYENWvas
	rvIvDAwGwvTQhNfHMS2/jX8u+ssfLjETmDgyCmwbMSp+j2clCXvfYx1kxwgceDhsG9iIza8Cn80
	2APPrfOV649+VvSNWlzcUgZf8SBdtCQv2blfjP0yFh7EXNw==
X-Received: by 2002:a05:6a21:3992:b0:3b3:23a2:edff with SMTP id adf61e73a8af0-3c1102a15c4mr10772661637.28.1783961773424;
        Mon, 13 Jul 2026 09:56:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3992:b0:3b3:23a2:edff with SMTP id adf61e73a8af0-3c1102a15c4mr10772622637.28.1783961772810;
        Mon, 13 Jul 2026 09:56:12 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm23242316eec.13.2026.07.13.09.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:12 -0700 (PDT)
Message-ID: <f384adce-8954-4667-9e3b-0fc0eb223439@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
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
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <20260706005134.7add6bbe@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260706005134.7add6bbe@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX3q1Nt8m5kKyW
 o6IsnaDO0p4SGOyD0cQ3xbcDSToQPr23ukw2TA7kkbp+jbZfx53tEr1vUiw+c1q1MxqKQ8zrKvQ
 TDnbTDukhj4zoGgImDInzB+xLuLp+4z6yfnD81iFdq2yOUZDfZyeTVccbWZBZmEFJpptWJ9dWbu
 0yw+g/SUlPeDdLuExZ5a7Mok9QMZSDB8RFBYp7SOdByGM0CFkW879hmJoaIYBPym2dMZAQR52MD
 Xja1+oCwKz+Hq6a0NGu5bJx1IEznoUajYm0L6mGPTgYG2JHVyUor3pHUczBH01RgQ+9xyContIu
 UyU82gs9M0mWTuAS/qmuOzpHX1c2NSagc4ndm2breVTbgX8R9od+p1VN7pH/yf3Fs/T6JwUk7AF
 urnycEhy1Xr3eoQulHBsMX102Y6o2WrF3/j51d6HGrZL/kKoRUhePQWtr6pW6GVryxf+ZoTHtUR
 i1HRe7BjPY3OcOl8NnQ==
X-Proofpoint-ORIG-GUID: JOnaOHudqVXobwShpP4DvUnWKaxYdygv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX4GM2mEI0Rf05
 b74tpLKq3WXDL5dgdLM0nHpZQin8n3Jn8um87bYIXv6NVt77OcjDBebu69RbTULcKO5w7/khEe0
 fkBokKU5BMBUY3BR1XWkw3wN9R9vCdA=
X-Proofpoint-GUID: JOnaOHudqVXobwShpP4DvUnWKaxYdygv
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a5518ae cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Q30daxf-3pjc-4xqwVQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Jonathan,

On 7/6/2026 5:21 AM, Jonathan Cameron wrote:
> On Sun, 05 Jul 2026 22:23:35 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu,
> 
> I took a quick look at this. A few really minor suggestions inline.
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..5a82c4d8a37e
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
> 
>> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
>> +{
>> +	struct thermal_zone_device *tzd;
>> +	unsigned int channel;
>> +	int ret;
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>> +		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
>> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
>> +						    &adc_tm5->chan_props[i],
>> +						    &adc_tm_ops);
>> +		if (IS_ERR(tzd)) {
>> +			if (PTR_ERR(tzd) == -ENODEV) {
>> +				dev_info(adc_tm5->dev,
>> +					 "thermal sensor on channel %d is not used\n",
> 
> That seems noisy.  Maybe dev_dbg() appropriate if this is an expected
> board dependent condition?
> 
>> +					 channel);
>> +				continue;
>> +			}
>> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
>> +					     "Error registering TZ zone:%ld for channel:%d\n",
>> +					     PTR_ERR(tzd), channel);
>> +		}
>> +		adc_tm5->chan_props[i].tzd = tzd;
>> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
> 
> 
>> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
>> +			 const struct auxiliary_device_id *id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5;
>> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
>> +	struct device *dev = &aux_dev->dev;
>> +	u32 irq_flags;
>> +	int ret;
>> +
>> +	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
>> +	if (!adc_tm5)
>> +		return -ENOMEM;
>> +
>> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper, aux_dev);
>> +
>> +	adc_tm5->dev = dev;
>> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
>> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
>> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
>> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
>> +	if (!adc_tm5->chan_props)
>> +		return -ENOMEM;
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
>> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
>> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
>> +		adc_tm5->chan_props[i].chip = adc_tm5;
>> +	}
>> +
>> +	/* This is to disable all ADC_TM channels in case of probe failure. */
> 
> Perhaps indicate who turned them on?  On from reset or something hidden
> somewhere else?

In the probe, ADC_TM channels are only enabled in the loop in adc_tm5_register_tzd(),
when they have the set_trips API called during thermal zone registration. I'll
update the comment to mention this.

> 
>> +	ret = devm_add_action(dev, adc5_gen3_disable, adc_tm5);
>> +	if (ret)
>> +		return ret;
> 
> ...
> 
>> +	/*
>> +	 * First SDAM's interrupt is shared between main ADC driver
>> +	 * and auxiliary TM driver, so its flags must include
>> +	 * IRQF_SHARED. This is not needed for other SDAMs as they
>> +	 * will be used only for TM functionality.
> 
> If indent of this doesn't change, rewrap to 80 chars.
> 
>> +	 */
>> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
>> +	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
>> +		ret = devm_request_threaded_irq(dev,
>> +						adc_tm5->dev_data->base[i].irq,
>> +						adctm5_gen3_isr, adctm5_gen3_isr_thread,
>> +						irq_flags, adc_tm5->dev_data->base[i].irq_name,
>> +						adc_tm5);
>> +		if (ret < 0)
>> +			return ret;
>> +		irq_flags = IRQF_ONESHOT;
> Whilst this code works, I'd be tempted to make it less ordering dependent.  E.g.
> 	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> 		u32 irq_flags = IRQF_ONESHOT;
> 
> 		/*
> 		 * First SDAM's interrupt is shared between main ADC driver
> 		 * and auxiliary TM driver, so its flags must include
> 		 * IRQF_SHARED. This is not needed for other SDAMs as they
> 		 * will be used only for TM functionality.
> 		 */
> 		if (i == 0)
> 			irq_flags |= IRQF_SHARED;

Sure, I'll update the function this way and also address your other comments.

Thanks,
Jishnu

> 
> 		ret = devm_request_threaded_irq(dev,
>> +						adc_tm5->dev_data->base[i].irq,
>> +						adctm5_gen3_isr, adctm5_gen3_isr_thread,
>> +						irq_flags, adc_tm5->dev_data->base[i].irq_name,
>> +						adc_tm5);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> 

