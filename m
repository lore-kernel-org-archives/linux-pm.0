Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6837755A
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026944; cv=none; b=Z1AqjHm/kKyYSat6AKUsPMlrtxCUKjsKy1wujr5HGVpE4pW4t19xa8BVfCeQOYunUai5psGRzpXnbJdJPpwSGcrWg5pFED8vqmHSGk3CYh/X0+V88lu9F9xsfCHKbd1NPi4aPQCBFAPoK2PzdZYwiNbbla2AsCCePuqteW/MGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026944; c=relaxed/simple;
	bh=DIrf8INolW2F+2EY2FY68YkfAk3E+jLt+E+lPX19R2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7rMp0dnn+gxrCzohGGMMhYGm04SWzY70trqZdjo0NIH6+FtKQNaDQQMnR2ah449+EpjcuHLm43pEXKu1CaZYqhPhZVxKoHwEX2Y5LEnKrdEUPhhzNFxWNIgpUk7oJnhJoDCBEVMZKfdFn06B9aZkI+kRdeIVkZsVBqSZUkEgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSyC2zMi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bHSn5hfS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSyC2zMi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bHSn5hfS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E77ANC3931641
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHur+87qTBpynYHDCoKBSnYC4fMssFH8+0I5cbzDkyY=; b=CSyC2zMi/fwOjGTJ
	ZwKQpPTFVGdu+pFwS5jc4yP0BxGMGZ/0qH2JvsfSE+QUQmXzXCcqMYwWlA6+ynYJ
	+TBphJjAE4qjbrKUaCd9le5Fjg0MCXHlB0lx4SsYtgOEMN3xY1Mh47YJOmnFc/Rp
	y+8qx6NuAkdTvuCNFGVVnQLhPSkJw3WTulqVHigbIHa/Mo+HvIeN5CvVMdcbzAwn
	/UnqicUX5TRxTGZoBBkyfS/XzaXewSUjynm7aTaCYJIMsDJ9UzfqaWX/RYBJBvdU
	EUDc0zVqoPAGD6kz4uDeRIgKWgNEqVJ6K04+xp4eeGXwveEnmAj2q2LXKsno9OWM
	sFjkCQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0uvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:02:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84885a4fcabso1199750b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784026939; x=1784631739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHur+87qTBpynYHDCoKBSnYC4fMssFH8+0I5cbzDkyY=;
        b=bHSn5hfSg4i9jlExicx5MR/kCXhrBQkmYbOYMCxfms2LDBfeWKZOrLtfTyGsprOE6V
         fV9ydds6VqnnXVIp0AoI6TTUpEvgPdcg2H5EFE53EBtkKpUv76dpa0sfU20LEamhB7ER
         7k58RYQHaNUxvBGaUE7lHxcAWYBlLTQTgksM9rZbJopMMofrKhyKJRKn+y6h5n+MQimT
         4tl27GAP6aWt62nxkWeJLy/PXDqvblLtiHkz7ytJ3jplgO/8rK2FMIWZRoYrxvkZdeEF
         l1XG2uOAMtRM4u0vAjxnXNwEpbeCS9tyYs7fmGYUUBmyPhcQuZfivoQOUE2v5U8yUEDD
         zfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784026939; x=1784631739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHur+87qTBpynYHDCoKBSnYC4fMssFH8+0I5cbzDkyY=;
        b=VhdS4bqkPk7hBDfFpBmyW5c2aW1S69Xxki8/95SRqEF0i0xuDYeVKEjF2PZYEtL0rt
         xPLfAWvjMqljJpZTiaMAYcTlGYuFKgbATHefTyVfycCA8XVxnyz5IE3J1BzRFmPtRJF6
         Gcc/Vp4OHrJ6HeB8AsHZfLt2/IgpwSZkkORW8zDxUA5LTtqTE3BYplObSjzVxEijaQX3
         cUeK+SzPPfZL/liTWiF5Fyjfgr3wl453gNo0Lgj9ikT1CKPi7PTOrfx6SJ6vlAoLP5Zn
         5cJlPFzLAIzRaIo6TT1uvtUB2AY6Bo9aVOpRHSBOauZXMTUyu0QbX6psXx/xo3OGY9Y0
         5QOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA0Odmyc7sVcPXttQX+xPFBUaYV7rXc93W2mm7o+fQPmjRZ/bllh/Tqj1EhL2k3buw0Z/WGeqBzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwutcNRaraabeDtIjfgkVrE67/BDQX6RqIb4xV5fxQK0caFELKB
	z/OLdn44rPttUiDQXM4bg8Ief/6F0mkxxh1EC5E+PmpjRdtdjdgaZ/gXIW/xQyXZJzhsSOdaBQm
	3KcrIy1yqgPPPS1TYMSdDbYovPShvk/0Xj1QzrQoCxhfjwlmRaz9HxDNbzsQu7w==
X-Gm-Gg: AfdE7cnleaLaT8GBDcL0YASLDGTZ4g43I3IN9DK1+yguhEctdyDdggz2SPbWSKdom4A
	hxtImrY0Ook/WTzsS/9QDXur9YEHIPTso7FQxRurDoUGs4tMjNxhba8HNJXb8m9MibF/QlQdTf0
	k9LRNfbmIQ+35CcyIr143d3a8HRDs8+1/O9tE+XXw8ESAu7bO8E6H8Kxn4faLkW53osp+jm212X
	0qD/EtaETSrKG8y09B2hrWgFFLQdf8/TnN4UjJWABpPBeN5un4AzhmPt55ELLOaB5SWcQLM5yc4
	moJUXKXUyuMRPC3M0r6w419+6XaMps4kc2PHaKEp+uGK/fbnW719gkcJpVM6g5yoWqwsEci3ZSF
	B0YzT/449E6re+zLxvptO/en8+oczvlOGcwWqbVme
X-Received: by 2002:a05:6a00:4605:b0:848:6447:e0a6 with SMTP id d2e1a72fcca58-848895db193mr11759148b3a.9.1784026938871;
        Tue, 14 Jul 2026 04:02:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:4605:b0:848:6447:e0a6 with SMTP id d2e1a72fcca58-848895db193mr11759105b3a.9.1784026938182;
        Tue, 14 Jul 2026 04:02:18 -0700 (PDT)
Received: from [10.92.162.233] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f2389e8sm1310411b3a.8.2026.07.14.04.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:02:17 -0700 (PDT)
Message-ID: <c8229f48-4c48-426c-b461-eb3421b6699b@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 16:32:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: Add support for Qualcomm MBG
 thermal monitoring
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
 <20260706-spmi-mbg-driver-v2-2-f883ff1d8719@oss.qualcomm.com>
 <67b7d76b-f13f-4dee-9b99-d7a8215da504@oss.qualcomm.com>
Content-Language: en-US
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
In-Reply-To: <67b7d76b-f13f-4dee-9b99-d7a8215da504@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNCBTYWx0ZWRfX22kL7ovaCGpa
 eJ25pskf1Hd1fi6iXPKFjrE9nE6QX4x+C4W9ah8WsCaDV9OS6sqU2CYekgImE3KQgiSyX7+BxIB
 5h/NcxWNhd+YfJuYrRZC8ZdAm7JGX8duUVKq+qnQZ9gTdLonyRUdR+AqfJs/KUuHBy/tW0dGcC8
 Kx4MtgwuGWJSmbfLqTSlTSGioEiZV6jdmLwN6JtJkgH2Qf87k6W4T4iCimc1ryHqPfeZk4uODpd
 MFRsmqXElLf+bOI4tb5csB7y0Xgo/qznbc3LzneV2mgRSI8VmdlCB3Z9IEIsOI0mMsdcXgQsdOJ
 PLX+FzM0zBA3v6YK5cq/HMLqJ+hqK9/oD5jrqRUiuBciCKVfpmj4BgFg3PqaIyGiXjRQ1IHXouE
 e4Pri58/at1CUDjRL3JJNVdRZ9rCNUTWmHik9uZ2e/boawkqaRE6GrkNC+CgDXpbJlcEyYuWMkF
 9tKu3mTXDsjX9FDAb2Q==
X-Proofpoint-GUID: 5tO5zRN_2sHAN670mjAo2x122BWtEmcN
X-Proofpoint-ORIG-GUID: 5tO5zRN_2sHAN670mjAo2x122BWtEmcN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNCBTYWx0ZWRfX6F8diWIW3Qqn
 6r8MGXziZrxWKCR2FAsrDyTrFq9tm0dBrf/zCB8UNVhdW0EevL0IZoBaSLPheKi73GjXaTILGYr
 9iDaQ0KrKAkuMssV3pMigtwkpz5MhrA=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a56173c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cn55kr1cJAZV1iIenBkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140114



On 7/10/2026 8:44 PM, Daniel Lezcano wrote:
> 
> Hi Sachin,
> 
> On 7/6/26 10:14, Sachin Gupta wrote:
>> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>
>> Add driver for the Qualcomm MBG thermal monitoring device. It monitors
>> the
> 
> MBG ?
> 

MBG here stands for Master Bandgap will update more info in the next
patch.

>> die temperature, and when there is a level 1 upper threshold
>> violation, it
>> receives an interrupt over spmi. The driver reads the fault status
>> register and notifies thermal accordingly.
> 
> You are describing how works the thermal framework. Please explain how
> works the hardware so we can understand the submitted driver.
> 
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/Kconfig            |  11 ++
>>   drivers/thermal/qcom/Makefile           |   1 +
>>   drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 256 ++++++++++++++++++++++
>> ++++++++++
>>   3 files changed, 268 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index a6bb01082ec6..f2fc24a3096f 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
>>         Thermal client sets threshold temperature for both warm and
>> cool and
>>         gets updated when a threshold is reached.
>>   +config QCOM_SPMI_MBG_TM
>> +    tristate "Qualcomm SPMI PMIC MBG Temperature monitor"
>> +    depends on QCOM_SPMI_ADC5_GEN3
>> +    select REGMAP_SPMI
>> +    help
>> +      This enables a thermal driver for the MBG thermal monitoring
>> device.
>> +      It shows up in sysfs as a thermal sensor with single trip point.
>> +      It notifies the thermal framework when this trip is violated. The
>> +      temperature reported by the thermal sensor reflects the real
>> +      time die temperature through ADC channel.
> 
> Explain the hardware, all sensors are showing up in sysfs and notify the
> thermal framework about thermal events
> 

Sure will update in next patch.

>>   config QCOM_SPMI_TEMP_ALARM
>>       tristate "Qualcomm SPMI PMIC Temperature Alarm"
>>       depends on OF && SPMI && IIO
>> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/
>> Makefile
>> index 0fa2512042e7..1bec2746b98d 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)    += qcom_tsens.o
>>   qcom_tsens-y            += tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>>                      tsens-8960.o
>>   obj-$(CONFIG_QCOM_SPMI_ADC_TM5)    += qcom-spmi-adc-tm5.o
>> +obj-$(CONFIG_QCOM_SPMI_MBG_TM) += qcom-spmi-mbg-tm.o
>>   obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)    += qcom-spmi-temp-alarm.o
>>   obj-$(CONFIG_QCOM_LMH)        += lmh.o
>> diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/
>> thermal/qcom/qcom-spmi-mbg-tm.c
>> new file mode 100644
>> index 000000000000..fa2f10002253
>> --- /dev/null
> 
> [ ... ]
> 
>> +static const struct mbg_map_table map_table[] = {
>> +    { -60000, 4337, 1967 },
>> +    { -40000, 4731, 1964 },
>> +    { -20000, 5124, 1957 },
>> +    { 0,      5515, 1949 },
>> +    { 20000,  5905, 1940 },
>> +    { 40000,  6293, 1930 },
>> +    { 60000,  6679, 1921 },
>> +    { 80000,  7064, 1910 },
>> +    { 100000, 7446, 1896 },
>> +    { 120000, 7825, 1878 },
>> +    { 140000, 8201, 1859 },
>> +};
>> +
>> +static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +    struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
>> +    int ret, milli_celsius;
>> +
>> +    scoped_guard(mutex, &chip->lock) {
>> +        if (chip->last_thres_crossed) {
>> +            dev_dbg(chip->dev, "last_temp: %d\n", chip->last_temp);
>> +            chip->last_thres_crossed = false;
>> +            *temp = chip->last_temp;
>> +            return 0;
>> +        }
>> +    }
>> +
>> +    ret = iio_read_channel_processed(chip->adc, &milli_celsius);
>> +    if (ret < 0) {
>> +        dev_err(chip->dev, "Failed to read iio channel with %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    *temp = milli_celsius;
>> +
>> +    return 0;
>> +}
>> +
>> +static int temp_to_vtemp_mv(int temp)
>> +{
>> +    int idx, vtemp, tc = 0, t0 = 0, vtemp0 = 0;
>> +
>> +    for (idx = 0; idx < ARRAY_SIZE(map_table); idx++)
>> +        if (temp >= map_table[idx].min_temp &&
>> +            temp < (map_table[idx].min_temp + 20000)) {
>> +            tc = map_table[idx].tc;
>> +            t0 = map_table[idx].min_temp;
>> +            vtemp0 = map_table[idx].vtemp0;
>> +            break;
>> +        }
>> +
>> +    /*
>> +     * Formula to calculate vtemp(mV) from a given temp
>> +     * vtemp = (temp - minT) * tc + vtemp0
>> +     * tc, t0 and vtemp0 values are mentioned in the map_table array.
>> +     */
>> +    vtemp = ((temp - t0) * tc + vtemp0 * 100000) / 1000000;
>> +
>> +    /* step size is 8mV */
>> +    return abs(vtemp - MBG_TEMP_DEFAULT_TEMP_MV) / MBG_TEMP_STEP_MV;
>> +}
>> +
>> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int
>> low_temp,
>> +                int temp)
>> +{
>> +    struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
>> +    int ret = 0;
>> +
>> +    guard(mutex)(&chip->lock);
>> +
>> +    /* The HW has a limitation that the trip set must be above 25C */
>> +    if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
>> +        ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
>> +                   temp_to_vtemp_mv(temp));
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        ret = regmap_set_bits(chip->map, chip->base +
>> MBG_TEMP_MON2_MISC_CFG,
>> +                      MON2_UP_THRESH_EN);
>> +        if (ret < 0)
>> +            return ret;
>> +    } else {
>> +        dev_err(chip->dev, "Set trip b/w 25C and 160C\n");
>> +        ret = regmap_clear_bits(chip->map, chip->base +
>> MBG_TEMP_MON2_MISC_CFG,
>> +                    MON2_UP_THRESH_EN);
>> +        return -ERANGE;
>> +    }
>> +
>> +    /*
>> +     * Configure the last_temp one degree higher, to ensure the
>> +     * violated temp is returned to thermal framework when it reads
>> +     * temperature for the first time after the violation happens.
>> +     * This is needed to account for the inaccuracy in the conversion
>> +     * formula used which leads to the thermal framework setting back
>> +     * the same thresholds in case the temperature it reads does not
>> +     * show violation.
>> +     */
>> +    chip->last_temp = temp + MBG_TEMP_CONSTANT;
> 
> It is because it is inaccurate or the temperature decreased a bit after
> the interrupt fired ?
>

It is because temperature measurement in the threshold setting in MBG
peripheral is inaccurate as compared to the PMIC die temp channel whose
temperature is read in get_temp().
>> +    return ret;
>> +}
>> +
>> +static const struct thermal_zone_device_ops mbg_tm_ops = {
>> +    .get_temp = mbg_tm_get_temp,
>> +    .set_trips = mbg_tm_set_trip_temp,
>> +};
>> +
>> +static irqreturn_t mbg_tm_isr(int irq, void *data)
>> +{
>> +    struct mbg_tm_chip *chip = data;
>> +    int ret, val;
>> +
>> +    scoped_guard(mutex, &chip->lock) {
>> +        ret = regmap_read(chip->map, chip->base +
>> MBG_TEMP_MON2_FAULT_STATUS, &val);
>> +        if (ret < 0)
>> +            return IRQ_HANDLED;
>> +        if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
>> +            chip->last_thres_crossed = true;
>> +    }
>> +
>> +    if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR) {
>> +        dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
>> +        thermal_zone_device_update(chip->tz_dev, THERMAL_TRIP_VIOLATED);
>> +    } else {
>> +        dev_dbg(chip->dev, "Lvl1 upper threshold not violated,
>> ignoring interrupt\n");
> 
> What does it mean ? Spurious interrupt ?
> 

There are multiple hardware reasons for this irq can get triggered but
in software at present we are supporting interrupt handling only for
LVL1_UPR threshold.

Thanks,
Sachin

>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int mbg_tm_probe(struct platform_device *pdev)
>> +{
>> +    struct mbg_tm_chip *chip;
>> +    struct device_node *node = pdev->dev.of_node;
>> +    u32 res;
>> +    int ret;
>> +
>> +    chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +    if (!chip)
>> +        return -ENOMEM;
>> +
>> +    chip->dev = &pdev->dev;
>> +
>> +    mutex_init(&chip->lock);
>> +
>> +    chip->map = dev_get_regmap(pdev->dev.parent, NULL);
>> +    if (!chip->map)
>> +        return -ENXIO;
>> +
>> +    ret = device_property_read_u32(chip->dev, "reg", &res);
>> +    if (ret < 0)
>> +        return dev_err_probe(chip->dev, ret, "Couldn't read reg
>> property\n");
>> +
>> +    chip->base = res;
>> +
>> +    chip->irq = platform_get_irq(pdev, 0);
>> +    if (chip->irq < 0)
>> +        return dev_err_probe(chip->dev, chip->irq, "Failed to get
>> irq\n");
>> +
>> +    chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
>> +    if (IS_ERR(chip->adc))
>> +        return dev_err_probe(chip->dev, PTR_ERR(chip->adc), "Failed
>> to get adc channel\n");
>> +
>> +    chip->tz_dev = devm_thermal_of_zone_register(chip->dev, 0, chip,
>> &mbg_tm_ops);
>> +    if (IS_ERR(chip->tz_dev))
>> +        return dev_err_probe(chip->dev, PTR_ERR(chip->tz_dev),
>> +                     "Failed to register sensor\n");
>> +
>> +    return devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
>> mbg_tm_isr, IRQF_ONESHOT,
>> +                     node->name, chip);
>> +}
>> +
>> +static const struct of_device_id mbg_tm_match_table[] = {
>> +    { .compatible = "qcom,pm8775-mbg-tm" },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, mbg_tm_match_table);
>> +
>> +static struct platform_driver mbg_tm_driver = {
>> +    .driver = {
>> +        .name = "qcom-spmi-mbg-tm",
>> +        .of_match_table = mbg_tm_match_table,
>> +    },
>> +    .probe = mbg_tm_probe,
>> +};
>> +module_platform_driver(mbg_tm_driver);
>> +
>> +MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
>> +MODULE_LICENSE("GPL");
>>
> 
