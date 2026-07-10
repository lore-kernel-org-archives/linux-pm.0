Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EF30BF4F
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696493; cv=none; b=UY/WdKuCk/U1V7Sd+MevtGBK5OPrgXqgq3PjUgYN82AKzqezK9SW+Ao/GHjEjgaAQEMPF46V7sTG3kTDEP00uOqJzIlDYC+pUrt2SS3WJAMpD59Xu9rVuRfhtMVxXEZqxq8szp2+zP5k/FxXJpA2N1UXB+attrDwwhcScV/O3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696493; c=relaxed/simple;
	bh=Q7SXo8DC/0xS/EZU1J22olGXiFpFxo8B5OX9/Vdb4xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGxVbnIwsu0psVlcieciaOGnWFXwUHYGafNMPkTa0AjU+VR0qKQDSv392PLozmMwLs7Jf/hE+3KTNwnYBkR7W0rldbe7kmADdabpSnwk4509RvkARdDbTOT6nxLccLVAC27AhtQguhKMHkQMdW1zx5tlkhRAVVjiNLgShohjd5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JbA4+60f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B23pOis2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbA4+60f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B23pOis2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEdAQr1030231
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 15:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0V8KZPgKxdhmBKZy9zTx1VsGb8GdWSYih1vACwJ2JM=; b=JbA4+60fvXE5wrgp
	fRoUWRMadr8xo23/8WiDX7RuIC4x39N0cwd0+jGNv9e0vD1i5ez8uamhaz1mUdWZ
	zSZEejERnLZxR5WqFspxxM0yI4L25gRA8NymVBBCNgseyCb1zLdLttA/BeFDjSda
	ITGRXlOuXClxHb3QawJx3+e4qR3CFuCwBoNi+6rSgtaPy+BT3fn37I6CTwMEqI4h
	dmD7iqk1CM0Tcyps5rtLwNF/o3a3fzI6ZfZrvnVgyodqQgksP4tD5fdvpV2z0yKR
	25beYSmh0RSpOyq1rougnAm8MK+oK7ooWpv6uQhubFRiyK9XGR/OAkVR3+ZpPunZ
	yLRDBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc86ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 15:14:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0408254aso26105471cf.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783696488; x=1784301288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0V8KZPgKxdhmBKZy9zTx1VsGb8GdWSYih1vACwJ2JM=;
        b=B23pOis2OVolexIwVNXVlhy0hxQBBTvgZ+dCl/t7DZPC1tJwK+wYToSlW7EFSjSeAe
         6AZOM9TA1ufUlqLtw7skC0fbMZ0XnfrwxkeqZHclEVvXqGOFhKiJD63SMPHy0tLsRApB
         V55pUUrLgfZzlTi/tfwUx0x4oJue58tAL6xqEi7Hpi10Wcy4vayMV1zInd7SqaY8JBUd
         fhBfPIbleDxa8bANr3xFI3WkBni5L13AeJ475hrpCT9FIC+4RD5BIp53Th6FDHI+iK8M
         VWWSzoyuZLT+KeEslT+SMQKyW63PJBFQbUy7W84AeoU8JtfSSi/gb9X0HqBUumdgi6r0
         lYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696488; x=1784301288;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0V8KZPgKxdhmBKZy9zTx1VsGb8GdWSYih1vACwJ2JM=;
        b=oDE8B7M2v+0zmCfA8wmCunIKLhhzdxV1NsKQPjtRnjlhPAlcvDXXUmWCFP8/0uTNw3
         dI3H7lVAvz4ySTIGVFiu2lz59xOLPKvAAFEYur1RNJQ3eDZdAX4WzrUxm3S9442CK2lM
         NMcogvgdIn0pytV/rPdTlWPYEG192RIqcc/16blfV5Y31oUB8tGzANOdoJeH8M/Fj/Kg
         MZHSSjR0fFFUWbbDH8QEuxw11Kfgbkn0jru9/uE+sE060Mpx5Iyp2Vy6IQ74mGJbh6OR
         SzaIqVcVgu335Ngs4nN2tlNA0kkz0oIw09K29i62frv0ADHWgbxdFVFVF7F2reHWAfWe
         Ggmw==
X-Forwarded-Encrypted: i=1; AHgh+RoN8p8bOkcXO12TlgJ6Qamft0nUbmm0nEly5azfOGxhKIjhU58jRkWUOaxqZNvyIWbe00viAicWwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9p1XsvxiVSqquuTUt/wBEyut86bTOkmn0kIdrN8KFxqHp4Zxi
	wKXYNpCbnDX3ps6g5tJ5D1t1to3nTMQuW2sASCgjF6p2SW1dQnN5XUxF0+uAinbwCegkk6KVurR
	mLEugC4cltiCnCh37Yb38gqy66M5E65dOCRUhwEnkc/SCqhBl8YMVqsaJ3OXUcg==
X-Gm-Gg: AfdE7ckO7E8fJ7FMtUTmirGazKqUzOHAxF8MxhkcEutA8m6GjDAybCpVs72VFbWbW1A
	dS99ak3aC99adtuqBpQEJAXW0g8sVrzjvT+kLxAOkY+URG3mv806X3L7hPvXa7kNTUd1KlUDj0N
	sDqXBSFbeN2sPeefvzkIrJdjgCKHPqFsFMlrryR//vOCyWihA/C48vkvqUrBwn54cc9K6X3NFZg
	ouWKplZm9LJJVBiXhgNo71HR7yxW1klZtx/kX4+Fdw1e+bfintTGnGfJIxQFXEC3cmGPUdQI0k9
	wIimmPewAOsD5ym7+TgzszuzLgzPmdbpfiw8eF/AscMst277x2itffUM5u2Qx1R9rya8vauKiVi
	28P0kHUPI8i8pJSD1buqTBqBL586ljwpK4ztyZG3eNxvkJvh9ftksjqOTkkl8TFVr+PfxbvSgDQ
	==
X-Received: by 2002:ac8:7f8d:0:b0:51c:7aa7:e0f1 with SMTP id d75a77b69052e-51caa1a7e08mr41258441cf.44.1783696487909;
        Fri, 10 Jul 2026 08:14:47 -0700 (PDT)
X-Received: by 2002:ac8:7f8d:0:b0:51c:7aa7:e0f1 with SMTP id d75a77b69052e-51caa1a7e08mr41258081cf.44.1783696487295;
        Fri, 10 Jul 2026 08:14:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d86b:ddff:83a7:67da? ([2a05:6e02:1041:c10:d86b:ddff:83a7:67da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm4604990f8f.3.2026.07.10.08.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:14:46 -0700 (PDT)
Message-ID: <67b7d76b-f13f-4dee-9b99-d7a8215da504@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 17:14:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: Add support for Qualcomm MBG
 thermal monitoring
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260706-spmi-mbg-driver-v2-2-f883ff1d8719@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MiBTYWx0ZWRfXxjxsPMIq2vB9
 /ZHopN5K1z0MGcEJDfemh+0O2qIe8dd+NufW/QVPnJcAlc9KYhlTqckhY6JEx6rhLZwiTjIeP5d
 UXkBXjK2c7jXqRYZLo/+gjs5dLl8HXZ6A+YIOORvXyTFX39u/YUt6xmpbFEQnM/0Oyv1zO0zMec
 pvQhiqZD34dw4Xaq/XQr7P7les4+ZUR+5Bu9GY9FyaLaHhTyDu/JkBb1pW9EJkxBNAH/vsp6hyH
 6Sqq6nrxTNsR7JBFbb1swutjH/ASgy2x7QTvEkM6+jr7C4FgYtOm26HZEO6rJKUiMy1RIiO0qBW
 aXH3Y31ek1qcVLJhRS0rs6CGXO+UOlwTdzE5DqsrUjid//DUkuLYUUHdDQAUIaiJmso6nlEEPvP
 UfOchu0UnZYIZmaXWvjB+YOe+wooNjd2h/duwSQd7z3T2+uFjeYLF0N5xBJh1Xq63kQ6CPpzV4R
 JdHnj0JIwcY4FbM72Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MiBTYWx0ZWRfXw1tiZvOTfBSo
 pSQsEBqWg5zjgNZEtrsQbPsJHz9dVvvazqX8uSHOAFjNNSox+RBgDemGQgklkjZqWj1pWskUk6M
 u5+SJM2yeWux6eV9zuDnBW/gJ/f7rbw=
X-Proofpoint-ORIG-GUID: XNT-lTTTLxQUKuEwWNbj3lvhZ6hCLyO3
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a510c68 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ELNG7oYFuFGS01GaYMYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XNT-lTTTLxQUKuEwWNbj3lvhZ6hCLyO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100152


Hi Sachin,

On 7/6/26 10:14, Sachin Gupta wrote:
> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> 
> Add driver for the Qualcomm MBG thermal monitoring device. It monitors the

MBG ?

> die temperature, and when there is a level 1 upper threshold violation, it
> receives an interrupt over spmi. The driver reads the fault status
> register and notifies thermal accordingly.

You are describing how works the thermal framework. Please explain how 
works the hardware so we can understand the submitted driver.

> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---
>   drivers/thermal/qcom/Kconfig            |  11 ++
>   drivers/thermal/qcom/Makefile           |   1 +
>   drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 256 ++++++++++++++++++++++++++++++++
>   3 files changed, 268 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index a6bb01082ec6..f2fc24a3096f 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
>   	  Thermal client sets threshold temperature for both warm and cool and
>   	  gets updated when a threshold is reached.
>   
> +config QCOM_SPMI_MBG_TM
> +	tristate "Qualcomm SPMI PMIC MBG Temperature monitor"
> +	depends on QCOM_SPMI_ADC5_GEN3
> +	select REGMAP_SPMI
> +	help
> +	  This enables a thermal driver for the MBG thermal monitoring device.
> +	  It shows up in sysfs as a thermal sensor with single trip point.
> +	  It notifies the thermal framework when this trip is violated. The
> +	  temperature reported by the thermal sensor reflects the real
> +	  time die temperature through ADC channel.

Explain the hardware, all sensors are showing up in sysfs and notify the 
thermal framework about thermal events

>   config QCOM_SPMI_TEMP_ALARM
>   	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>   	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..1bec2746b98d 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>   qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>   				   tsens-8960.o
>   obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
> +obj-$(CONFIG_QCOM_SPMI_MBG_TM) += qcom-spmi-mbg-tm.o
>   obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>   obj-$(CONFIG_QCOM_LMH)		+= lmh.o
> diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> new file mode 100644
> index 000000000000..fa2f10002253
> --- /dev/null

[ ... ]

> +static const struct mbg_map_table map_table[] = {
> +	{ -60000, 4337, 1967 },
> +	{ -40000, 4731, 1964 },
> +	{ -20000, 5124, 1957 },
> +	{ 0,      5515, 1949 },
> +	{ 20000,  5905, 1940 },
> +	{ 40000,  6293, 1930 },
> +	{ 60000,  6679, 1921 },
> +	{ 80000,  7064, 1910 },
> +	{ 100000, 7446, 1896 },
> +	{ 120000, 7825, 1878 },
> +	{ 140000, 8201, 1859 },
> +};
> +
> +static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret, milli_celsius;
> +
> +	scoped_guard(mutex, &chip->lock) {
> +		if (chip->last_thres_crossed) {
> +			dev_dbg(chip->dev, "last_temp: %d\n", chip->last_temp);
> +			chip->last_thres_crossed = false;
> +			*temp = chip->last_temp;
> +			return 0;
> +		}
> +	}
> +
> +	ret = iio_read_channel_processed(chip->adc, &milli_celsius);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read iio channel with %d\n", ret);
> +		return ret;
> +	}
> +
> +	*temp = milli_celsius;
> +
> +	return 0;
> +}
> +
> +static int temp_to_vtemp_mv(int temp)
> +{
> +	int idx, vtemp, tc = 0, t0 = 0, vtemp0 = 0;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(map_table); idx++)
> +		if (temp >= map_table[idx].min_temp &&
> +		    temp < (map_table[idx].min_temp + 20000)) {
> +			tc = map_table[idx].tc;
> +			t0 = map_table[idx].min_temp;
> +			vtemp0 = map_table[idx].vtemp0;
> +			break;
> +		}
> +
> +	/*
> +	 * Formula to calculate vtemp(mV) from a given temp
> +	 * vtemp = (temp - minT) * tc + vtemp0
> +	 * tc, t0 and vtemp0 values are mentioned in the map_table array.
> +	 */
> +	vtemp = ((temp - t0) * tc + vtemp0 * 100000) / 1000000;
> +
> +	/* step size is 8mV */
> +	return abs(vtemp - MBG_TEMP_DEFAULT_TEMP_MV) / MBG_TEMP_STEP_MV;
> +}
> +
> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
> +				int temp)
> +{
> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret = 0;
> +
> +	guard(mutex)(&chip->lock);
> +
> +	/* The HW has a limitation that the trip set must be above 25C */
> +	if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
> +		ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
> +				   temp_to_vtemp_mv(temp));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_set_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
> +				      MON2_UP_THRESH_EN);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		dev_err(chip->dev, "Set trip b/w 25C and 160C\n");
> +		ret = regmap_clear_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
> +					MON2_UP_THRESH_EN);
> +		return -ERANGE;
> +	}
> +
> +	/*
> +	 * Configure the last_temp one degree higher, to ensure the
> +	 * violated temp is returned to thermal framework when it reads
> +	 * temperature for the first time after the violation happens.
> +	 * This is needed to account for the inaccuracy in the conversion
> +	 * formula used which leads to the thermal framework setting back
> +	 * the same thresholds in case the temperature it reads does not
> +	 * show violation.
> +	 */
> +	chip->last_temp = temp + MBG_TEMP_CONSTANT;

It is because it is inaccurate or the temperature decreased a bit after 
the interrupt fired ?

> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops mbg_tm_ops = {
> +	.get_temp = mbg_tm_get_temp,
> +	.set_trips = mbg_tm_set_trip_temp,
> +};
> +
> +static irqreturn_t mbg_tm_isr(int irq, void *data)
> +{
> +	struct mbg_tm_chip *chip = data;
> +	int ret, val;
> +
> +	scoped_guard(mutex, &chip->lock) {
> +		ret = regmap_read(chip->map, chip->base + MBG_TEMP_MON2_FAULT_STATUS, &val);
> +		if (ret < 0)
> +			return IRQ_HANDLED;
> +		if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
> +			chip->last_thres_crossed = true;
> +	}
> +
> +	if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR) {
> +		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
> +		thermal_zone_device_update(chip->tz_dev, THERMAL_TRIP_VIOLATED);
> +	} else {
> +		dev_dbg(chip->dev, "Lvl1 upper threshold not violated, ignoring interrupt\n");

What does it mean ? Spurious interrupt ?

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mbg_tm_probe(struct platform_device *pdev)
> +{
> +	struct mbg_tm_chip *chip;
> +	struct device_node *node = pdev->dev.of_node;
> +	u32 res;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +
> +	mutex_init(&chip->lock);
> +
> +	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chip->map)
> +		return -ENXIO;
> +
> +	ret = device_property_read_u32(chip->dev, "reg", &res);
> +	if (ret < 0)
> +		return dev_err_probe(chip->dev, ret, "Couldn't read reg property\n");
> +
> +	chip->base = res;
> +
> +	chip->irq = platform_get_irq(pdev, 0);
> +	if (chip->irq < 0)
> +		return dev_err_probe(chip->dev, chip->irq, "Failed to get irq\n");
> +
> +	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
> +	if (IS_ERR(chip->adc))
> +		return dev_err_probe(chip->dev, PTR_ERR(chip->adc), "Failed to get adc channel\n");
> +
> +	chip->tz_dev = devm_thermal_of_zone_register(chip->dev, 0, chip, &mbg_tm_ops);
> +	if (IS_ERR(chip->tz_dev))
> +		return dev_err_probe(chip->dev, PTR_ERR(chip->tz_dev),
> +				     "Failed to register sensor\n");
> +
> +	return devm_request_threaded_irq(&pdev->dev, chip->irq, NULL, mbg_tm_isr, IRQF_ONESHOT,
> +					 node->name, chip);
> +}
> +
> +static const struct of_device_id mbg_tm_match_table[] = {
> +	{ .compatible = "qcom,pm8775-mbg-tm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mbg_tm_match_table);
> +
> +static struct platform_driver mbg_tm_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-mbg-tm",
> +		.of_match_table = mbg_tm_match_table,
> +	},
> +	.probe = mbg_tm_probe,
> +};
> +module_platform_driver(mbg_tm_driver);
> +
> +MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
> +MODULE_LICENSE("GPL");
> 

