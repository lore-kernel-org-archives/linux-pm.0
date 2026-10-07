Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E63C0606
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373896; cv=none; b=bh05NskpukWt8VQ+pdw7daIALmiex4Z5Xy7XB+Hu2O/3YBbWThXQIyIH4AgJzp7P9YDKQXHJA0dac+e+Us5bwvV0eEWyVXDTVB6icCjckeWdRuEtuTUNFv70m7CRaFU4GVlScMOqGCcyfqS1qfiwLrv0F6Njv+3/ITsAS77ATSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373896; c=relaxed/simple;
	bh=LpFlYyMb2zB0aUYWDfn++RHM4Z40HNmIneYQrmoAcK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pO8irlbCZfDQ6EC6N91zBTAmNgtFUALlPS2a+ZJhDIPDF102B5qTJXu/oGuaDdY+7wmmjgMDsAK6vUPVQm1+s5pIaZDwPuWtjwWUPt9XaPGa8EAeuZ19gYiIZeENXrj3+or/lPyF7iCU+sj52mV0Kv8nTC1gJOo41p0Z0sYX1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCpXFkwV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RTH/dIE2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCpXFkwV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RTH/dIE2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BV6wg609856
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 11:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XtdNBtyuMYUvpdnC3AqmffuEoE7lo8mm8sw8bIFZvDA=; b=jCpXFkwVbJv22Gtp
	PfcOpQJynVnz4u4uXnFSYjyjYXDH4dvY8rsSKtmSqpqJbRHlKFclK0AmuRD6ECe7
	tN6Gmb9HUAl5YF3oKIsZZc0Blymr3e30s74AHayPsChoqSO/ezS1V95lI3DhR/j7
	7c9YGqTA0yO2aJ0DrhgOWDG6du7LQSnsap1K5KenZhGsh+81c4RiYnHP1/2TSn5y
	NGJ1l+e7VCkN5Zhg0t7WD+p0b2blnDUj8kVhY6d4O4HMibIkK3mPxXRJKgtPOZ0G
	Z4h7xe5nWDangcEAg62F5ChmHJlewNj6B7dw2G/41n4XTAK1sxCwpu06rx7Wj31l
	cUtI7A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5994q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 11:51:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91792488228so91379156d6.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791373879; x=1791978679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtdNBtyuMYUvpdnC3AqmffuEoE7lo8mm8sw8bIFZvDA=;
        b=RTH/dIE2cfH/+1SXj5Gkx6kL/rb2x8SgiOUMMqaFE3XAe6Zk71fyxX8O9WuWeo9iA6
         Mkz5fIEpnv9pRBNhqJIb7+88phWYjy9X13dtKRkHVJK8rMNtZBpYtE8f4+J5Bo6poty8
         an27anpEXKIJQCPhEMlFSpz0ITJ7k3T1rhX3pP2GZewhP7HWWVHj7YSSofP34qwMi2TL
         PMJOF62i9jaJ4KIZzzvxCtscPEGyQOs2uuvkwmCvWIb0+UmcOnXgg/0Wlzcmc2b3+CXO
         lVDf+5w58k4uysywOCYbhsC2Lhx2Gxiu98FuYtaFGl+o03PDUmrZnJsmbAhdeKD8WEFs
         vWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373879; x=1791978679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtdNBtyuMYUvpdnC3AqmffuEoE7lo8mm8sw8bIFZvDA=;
        b=ulSG9GUAnxDdkn2ihiz22nPL5eEmpNkHNCL2tKlqzGWkPrkfCkNkSKNowSufYvHMwS
         x8dBE5KFGb50nitKdCIVFp6qMZtrpPG5xPisg5/DsbDnU+gDDIRNeItQrw3XTMb/lv9Z
         y6cAem7/V2bxWp5b3Siy7U0coI3r1j52nIJMMfnGelPNDQ5uiiV8wzOmu5gqnykAp3pl
         7BW8WfbnyoaGdbWk1AFzv6rEUS/ipMzn580vUblN+Cy+SAG6UXe4/AbaEopxuIjZHX/9
         5FferR4ay69yTgXEmk6KENd2rXy2IwPcv6k4CHY0ECcONCRnC2RyDtG+syDC0XFWK08S
         2p9w==
X-Forwarded-Encrypted: i=1; AKwUvBxHr53/BGw6+DxBEDIhjwoLyLxr9CjS9K7laYqU8q3oxf4tLMfXAm1hnLFdHWJnCESG/75CPdvv9A==@vger.kernel.org
X-Gm-Message-State: AFuF++kc/rQiNFYkSoyKfXpPI2k68q9vDOoGr7rIuqelPC7TCSf6aRdo
	TWF7u4UYM4korj+qdZoOSOX5TTBt7sWQe/CloY3tBeL4K26ZQMm8WSoxqJTTeqvKPi35US3h453
	6xuiqcGr+4LGLKZyC3xh2rHHcifPwAlLcolwzjQsMQYr1CSArxiN9fAn6DKqgOw==
X-Gm-Gg: AYBFou3AEPRJCEsiAArQckPr6+PYDw18/6IJYdqbPXNxJl7ioEIi5hfhtuibIKTRxZO
	mTJFrcb/hB8LPSGUXw7590fhjiXuhxgE3VVKvaa5EpyY0rk1Pz76JUh+1ViryChmbAxSRUXlLWJ
	PbhFAENZ0ejPUECojJbqRfYrZQsmA2kSo0vOlzi3VWrSCI1aWH8AeUWFrCzdlkqov2yS/JWq2Jm
	GLMq4IZy74upGyHssdBBTPf/cRnAtxV8EFYy1mlFmQSAC5NAeEgKq4CNmzNmh1pFHKfyX6RJfZj
	4mhSUgSC7x2sVWcmpDxktpKklV7E3WywHyFFXkvLAK5d941X9DUUfRjXettflvIEKrw3CrKOadS
	gWNcuGQkEEl2gJ9dIFwlt/ChtC2g1O6J3tZJ8ADXFGGMq
X-Received: by 2002:a05:620a:31a8:b0:93e:634a:99c8 with SMTP id af79cd13be357-93e9b71c00cmr339090985a.25.1791373878652;
        Wed, 07 Oct 2026 04:51:18 -0700 (PDT)
X-Received: by 2002:a05:620a:31a8:b0:93e:634a:99c8 with SMTP id af79cd13be357-93e9b71c00cmr339084385a.25.1791373877989;
        Wed, 07 Oct 2026 04:51:17 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2d563sm4984894f8f.41.2026.10.07.04.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 04:51:17 -0700 (PDT)
Message-ID: <7bb74631-6703-4a30-a7a7-424ce6340a03@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:51:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] thermal/drivers/mediatek/auxadc: Register per-sensor
 thermal zones
To: =?UTF-8?Q?Nils_B=C3=BCchner?= <nils@buechner.me>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20261006025410.506443-1-nils@buechner.me>
 <20261006025410.506443-2-nils@buechner.me>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261006025410.506443-2-nils@buechner.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX/JRMrepkdGtQ
 kWUCb/UJyQCTSluISYG0Vw8F0sLemTMT3Dp9spfjfM9P7ucRseUC0gsZDq16HrKQ5bGw9hnfo9F
 JFSKGttvqh4eOpp2uEW3V/JxXeLl1oY=
X-Proofpoint-GUID: hODmmW1zgXFFX4fhLgjAXKCf1to2uPxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX0P+10qcbBjJc
 trhmvzpe6+ShNBzsVYBtfe0ympfkBWagDPRt5wgmrGapXEaH9oH0eQrSv9VwfkEvaO6s/ra4upq
 8lHA/FuBDs9QQInF34Joe5tUUhjgDQDB0JnCk36kTmZj2q1BKnC/6RD92nPFkNUND/1DdzOGerD
 r/6PzkeFvoEX5gLcwF6nbtWFZFJA+NmVlc2ZjGR6cicnGZUCPgF2YS3xQS5ZpNh9hF8i+UmYJAu
 khd0Dr7ssjm/lTb3+sBC32iFboMcOR22qWDRmtTW13DVU8Ky57FpdXZf70CCSH1BSvjS4IADJxs
 ygn3XI/QIGgloUetYDyI732dQE7Wb9OJJD2oAkLublKyqm02AWzRhAi6f1KFwpKDUX54mZUyZzj
 6OZW4+30yjP73PbqMcvdIuRfU49NpjW9anX2WJHQJqgT87WBa8k3gK7J45BNmY5KqWWtc2Wmlbo
 Ckm6iArQi+c0A7ZqryQ==
X-Proofpoint-ORIG-GUID: hODmmW1zgXFFX4fhLgjAXKCf1to2uPxq
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac63237 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=twVTte8M8PIwAJgjBN8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070047

On 10/6/26 04:54, Nils Büchner wrote:
> The driver registers only thermal zone 0, which reports the hottest of
> all sensors. The MT8183 devicetree also describes a zone per sensor
> (soc, gpu, md1, cpu-little, cpu-big, abb as sensor ids 1-6), and
> mtk-svs looks up the "gpu-thermal" zone for its GPU banks. Without it
> SVS fails to probe on MT8183:
> 
>    SVSB_GPU: cannot get "gpu-thermal" thermal zone
>    mtk-svs 1100bc00.svs: error -ENODEV: svs bank resource setup fail
> 
> so the SoC never gets its calibrated, lower voltages.
> 
> Additionally register every sensor that has a devicetree zone, using
> sensor id = sensor number + 1, read from that sensor's own measurement
> register. Sensors without a zone are skipped, so SoCs whose devicetrees
> only describe zone 0 are unaffected.
> 
> Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
> 7.0-based kernel (the hardware is not set up to boot mainline);
> build-tested on mainline with W=1. On the device: all six
> sensor zones register and read plausible values (31-34 C idle, close
> to the board sensors), and mtk-svs finds gpu-thermal.
> 
> The change and this changelog were drafted with an AI coding assistant
> during a debugging session on the hardware; they were reviewed and
> tested by the submitter.
> 
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Nils Büchner <nils@buechner.me>
> ---
>   drivers/thermal/mediatek/auxadc_thermal.c | 80 ++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 9ee2e7283..59c8eaf87 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -308,6 +308,13 @@ struct mtk_thermal_bank {
>   	int id;
>   };
>   
> +/* A single sensor, exposed as its own thermal zone (DT sensor id = sensor + 1) */
> +struct mtk_thermal_sensor {
> +	struct mtk_thermal *mt;
> +	int bank;
> +	int index;
> +};
> +
>   struct mtk_thermal_data {
>   	s32 num_banks;
>   	s32 num_sensors;
> @@ -870,6 +877,77 @@ static const struct thermal_zone_device_ops mtk_thermal_ops = {
>   	.get_temp = mtk_read_temp,
>   };
>   
> +static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *temperature)
> +{
> +	struct mtk_thermal_sensor *sensor = thermal_zone_device_priv(tz);
> +	struct mtk_thermal *mt = sensor->mt;
> +	const struct mtk_thermal_data *conf = mt->conf;
> +	struct mtk_thermal_bank *bank = &mt->banks[sensor->bank];
> +	int temp;
> +	u32 raw;
> +
> +	mtk_thermal_get_bank(bank);
> +	raw = readl(mt->thermal_base + conf->msr[sensor->index]);
> +	temp = mt->raw_to_mcelsius(mt, conf->bank_data[sensor->bank].sensors[sensor->index],
> +				   raw);
> +	mtk_thermal_put_bank(bank);
> +
> +	if (!mtk_thermal_temp_is_valid(temp))
> +		return -EAGAIN;
> +
> +	*temperature = temp;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};
> +
> +/*
> + * Zone 0 reports the hottest sensor. Also register every individual sensor
> + * the devicetree describes (sensor id = sensor number + 1): MT8183 SVS looks
> + * up its GPU bank temperature through the "gpu-thermal" zone and cannot
> + * probe without it. Sensors without a devicetree zone are skipped.
> + */
> +static int mtk_thermal_register_sensors(struct mtk_thermal *mt)
> +{
> +	const struct mtk_thermal_data *conf = mt->conf;
> +	struct thermal_zone_device *tzdev;
> +	struct mtk_thermal_sensor *sensor;
> +	int id, b, i;
> +
> +	for (id = 1; id <= conf->num_sensors; id++) {
> +		sensor = NULL;
> +		for (b = 0; b < conf->num_banks && !sensor; b++) {
> +			for (i = 0; i < conf->bank_data[b].num_sensors; i++) {
> +				if (conf->bank_data[b].sensors[i] != id - 1)
> +					continue;
> +				sensor = devm_kzalloc(mt->dev, sizeof(*sensor), GFP_KERNEL);
> +				if (!sensor)
> +					return -ENOMEM;
> +				sensor->mt = mt;
> +				sensor->bank = b;
> +				sensor->index = i;
> +				break;
> +			}
> +		}
> +		if (!sensor)
> +			continue;

Please move routines into self-explanatory functions and make this 
initialization function simpler to understand

> +
> +		tzdev = devm_thermal_of_zone_register(mt->dev, id, sensor,
> +						      &mtk_thermal_sensor_ops);
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV)
> +				continue;
> +			return dev_err_probe(mt->dev, PTR_ERR(tzdev),
> +					     "failed to register sensor %d\n", id);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>   				  int ctrl_id)
> @@ -1294,7 +1372,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	if (ret)
>   		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
>   
> -	return 0;
> +	return mtk_thermal_register_sensors(mt);
>   }
>   
>   static struct platform_driver mtk_thermal_driver = {

