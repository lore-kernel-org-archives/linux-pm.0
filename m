Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CE3F7AB7
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013547; cv=none; b=Ecj9DeSwnZkFFeeSVRSqT9GJHBA3BSsQW+gLZDXsRZZF3TCdkbLSVaWemHJG4i01Avum3d5Wd85f3nfFLBvsbJAt9BG+i4T7ORCOfLudwjCjU3B7L/bt9lxKDb/3vn4r7Z4HDPxMF5Z8lUyNg0BoIuNK0ed1iHJyedEsjcIkiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013547; c=relaxed/simple;
	bh=tlTja6nbTiauvKmBRC89RbOJfEA1QZo/psktct0Oh4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXfC2CyORd2YrMnathtmB0GbJQdA2tiEyxupQF8nHGJPBkucFgcyfChQ9Zo70SqzTspazH/ZIyhUHYyj4C6skwQaVcDDp6vVVNaDyD4AS6oUN/o79v0y1DRNEveXI/gekD1NsJSOozYS0vovbumEKzJzIE82oRi1bSWkvcbQA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dl+J8mHG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cYH9KR7d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dl+J8mHG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cYH9KR7d"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ntvk1579452
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+wLC3JrqPrga4mftfDdK7ZIOuX0Tj0HbnIJy7FTAR/o=; b=Dl+J8mHGVqFDuNNh
	S1U5wutZ432RAuGYiGIdX8n7RU0XrUSWmVr8noPgajWKO5i8eqc0ouZGcK4E4JuB
	md7oS4ky5MjJLDeZ20NH82dmicPHuGVI8sm1y91RpX4hktR0tX9rj3malX91ISwR
	VidU1XEZJ9akJ41etgLrOWEREpktdSHytTu59htI/zp+it6JBoZdwxtNc1Hi73Kc
	jdgMXilB57mpGp9o0aFK0MUuDSqo12RNt8DF29bPrWXwVaofEK9Z4WvxfQIckNJI
	n6NnZeNScElKaHeMdX9cJybF5pFDsOpcAsXN4qJWL8BG2YaYi5syLZp0XpyQJsm/
	AYhOuQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8hncf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 10:52:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so29946405ad.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013544; x=1786618344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wLC3JrqPrga4mftfDdK7ZIOuX0Tj0HbnIJy7FTAR/o=;
        b=cYH9KR7diWWHYEYD9PlWZycF0yj9vXYhEDgy45PVzHgxUXzG7lRTiQQKX2i37mMJSV
         dOne+8bLLxg5mlSZCQnNzZ3dea1AbwiNSW/suCPPFrn2dWUt3WGMLGhVI3kc9QYs1w+Y
         uyKkptPIKIZBbQ+KaMaX+TP7OOjHtMLhUnIfCkIziHZLL5IA8cnbeClqrFBc5pl998JS
         UCRXn8mP3KXIfplwyEBTMGOpDjdYnU3bPDN52wOYEqARelFgqKexsmAy2Y9KanVqj+Ze
         1O1fho1b09LrV0xTOFHwbv0K4NVPk/W1uWg6G8tLVHsbo3ssqYhOVuyLpmakWWdGgmt/
         oEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013544; x=1786618344;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wLC3JrqPrga4mftfDdK7ZIOuX0Tj0HbnIJy7FTAR/o=;
        b=qJpiLONCcDKZJ99wf5NwbYQdoeiUomjLo0HjpYsAKHFvR8btaZyEKIPmf1W4eycdjs
         CvSgJ3OcILDKkiRF5aC+1rHcti1/eM5dqsQBk5Oq4Y7AiDmDVWoLUIvRFFqdTMIJzoO1
         cvPF7s4Jzqo8J5T7hkCh7jFxqVDrPAfqugFJXeL5GHFXzDbqK+Mr+sJNiN+5iDD304g6
         vNKoevRI00qBp+iF2JMeZWuCpgdogRpohvMOLAKO0AfZTs1nYQ0L0z9wAxtON/9/4TaY
         7MbqE+RpkQGYIDP52wZ4xm7ZiXIycSN1RMA3kp+SbMcnLci4hH6fpSp8AO4NNbSSFhAY
         ngxA==
X-Forwarded-Encrypted: i=1; AHgh+RpDkkViYyhJLCnC7UCyfKKqC3XvhOX/5bxCalUpo5rTpSyX3Xzfvwr2bOB+MC/J4nOr5JZWSc67+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAWgcMsSg/l3nRVf1l0cKfu7zzHLglhxArVtz+CTVO0C31Lyy
	74+UhgrA8SADzkN5go9XypiMqKLxtAylle8N7UHp2dhjRP8eWxbPmrPZk2M2sxuM7tvPsXzZdPA
	kvIr+MyHrLyyzLyxWlKX3NML4X44KdinUEEpXiOVvEdOM4XH0aFK+Fjggnisx7A==
X-Gm-Gg: AR+sD13bBSKRtJSJ4QyxTpj2ft3hAaqwvNZ/ihSZUp1tbBgNqCL29KperxhNcpeyH1U
	fHDrxavg/IM1pWcuiLw6+7cpVjAwmoqocmWeGGFAUBXHX5duqkoxcM8NfVwkU8zyb+3wdNPBjAk
	vQLxsU7Z4tbvMSYOnrG82bgodFQ2C8lrgiTJOg3iX6L1PLwXGmMlDoNSUe/+H1r3jx1x6SdyFDS
	Kk5/78inB+BPzGm8Q/gcaJx5fGBoHEh5dF2LIk+/EqKBBOvPbl9mytEO7ptKNR8TgZWFAuGBeGK
	EcqSpaGHLFZjcSoiyf/ZuVO8auHd8R1O3/6ybA9VzYlsDF9xBOK6HJL+WHAEE7og2Ce+O7oPVQZ
	ohow1IuGMyZLuLGl8OYmoj3ahSx8v2KgW
X-Received: by 2002:a17:902:d581:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d0ca75b37cmr176329805ad.11.1786013543838;
        Thu, 06 Aug 2026 03:52:23 -0700 (PDT)
X-Received: by 2002:a17:902:d581:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d0ca75b37cmr176329365ad.11.1786013543359;
        Thu, 06 Aug 2026 03:52:23 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4930e1sm29469905ad.41.2026.08.06.03.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:52:22 -0700 (PDT)
Message-ID: <a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:22:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
 <20260803011400.1fb6c93a@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260803011400.1fb6c93a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ssKemRJbkmBlL82PoFNlowYifPoPQE9N
X-Proofpoint-ORIG-GUID: ssKemRJbkmBlL82PoFNlowYifPoPQE9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX4h51SfUw10P1
 uewwtx0dWSUT92IS17xgqcsfDoQ3eWICs7OrFTyiPstH2tmR9xcFoZnZM53J4gEQwuYQcz05Wsh
 Yr72rervhwm9k4S9ZbtqW2Pdz1MWuJ84q8/ZOX5DlY8lTRvMATlmWZmwdk7yZxCXJsCo7wpNwOC
 9ndSx2ArBSMiHPEgFXWzOBPOB/Vhqj2BY24VAKYnFhQnzmM7T7E+bZ7qOI46lQeXSB+ZpXN1TjA
 H4bX6PZyQVnCTqJt0geSPHjGEv/Gnz03kziB3/t2WuLiC8/Sy9YhC0T6EWUnTN5YlxlKrAgsX1n
 oBZHxE1JagsA7uXY6oidanufyPI2BnPsN0wFdIUcmTRzoRYkmE545JL7cw4mTXnmt71pS1iqmkH
 oAIuJGButpSnfkiqaRt6t9TGkuJqUnTgZlraKq/TPc/aS1P60mMJ1/bifP6UXr7X+AezIAbKTts
 fHBiMdI2D/RSu/LcvFg==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a746768 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sIB6b2e8xc4MCbZFZ_AA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX1CpRoqjjoNZp
 dwo/ZCzJpb88mXlBsZ/F/CjyKPMnj42lv4yFnhJfJ8XS98MMYtiFzDnVkfTFZqc2Se9a4QIYW55
 V/AZQ0gHWSy0GWXhcrbJPzwvLHDljvU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085

Hi Jonathan,

On 8/3/2026 5:44 AM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 23:36:15 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>> for improved performance, mostly at the hardware level.
>>
>> One significant software change is that ratiometric conversion resolution
>> has been increased from 14 bits to 16 bits, so the maximum value of
>> these measurements needs to be updated for Gen4. Add a new scaling
>> function for thermistor channels which use this type of conversion.
>>
>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>> support communication between ADC on the master PMIC and ADCs on any
>> of the other PMICs, a field of width 2 bits is added for bus index
>> and the bits for SID are extended from 4 to 5 bits, in the SID
>> register. Add support for this.
>>
>> In addition, it is possible that the master PMIC has ADC of one generation
>> and it needs to communicate with another PMIC with ADC of a different
>> generation.
> 
> "Possible" sounds a bit hypothetical.  Can we state this actually happens
> on some devices?

Considering existing upstream platforms, this is applicable for SM8750. I'll
mention this in the next version of the series.

> 
>> Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
>> to distinguish Gen3 channels under a Gen4 master and Gen4 channels
>> under a Gen3 master respectively, to ensure that their conversions are handled
> 
> This line got a bit long. Wrap at 75 chars for commit message.
> 
>> correctly.
>>
>> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 165 +++++++++++++++++++-------
>>  drivers/iio/adc/qcom-vadc-common.c            |  32 +++++
>>  include/linux/iio/adc/qcom-adc5-gen3-common.h |  44 ++++++-
>>  include/linux/iio/adc/qcom-vadc-common.h      |   4 +
>>  4 files changed, 195 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> index c68c6c5f6aca..810d25b665b1 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> @@ -86,7 +86,9 @@ int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");
>>  
>> -static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
>> +				       struct adc5_channel_common_prop *prop,
>> +				       u16 *data)
>>  {
>>  	u8 rslt[2];
>>  	int ret;
>> @@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>>  	*data = get_unaligned_le16(rslt);
>>  
>>  	if (*data == ADC5_USR_DATA_CHECK) {
> This feels backwards.   We first check for the top bit being
> set then check whether we care if it is set or not.  I think
> checking if we should look at it first makes more sense.  Also
> shorter max line length:
> 
> 	if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
> 		if (*data == ADC5_USR_DATA_CHECK) {
> 	...	

I thought it was more efficient to have the check like this because
there may be several channels satisfying the longer if() check for Gen4
ratiometric channels, but the chance of *data being exactly equal to
the error value ADC5_USR_DATA_CHECK is lower generally. So if I reverse
the checks as you suggested, the outer if() check would pass for every
read done on a channel which is not both Gen4 and ratiometric, which
seems inefficient for an error check.

What do you think, should I make any changes here?


> 
>>  
>> +static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
>> +	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
> 
> Probably just go long on these lines and I'm not sure there is enough benefit to
> forcing the alignment though if you really want to it will be more useful with
> them on a single line.

Sure, I'll keep these on single lines.

> 
> 	[ADC5_GEN4_OFFSET_REF] = ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
> ...
> 
> 	[ADC5_GEN4_AMUX5_GPIO_100K_PU] = ADC5_CHAN_TEMP(0, SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> 
> Obviously it has been there a while, but having the comma inside ADC_CHAN() macro
> ends up making this look a little odd.
> 
> 
>> +	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
> 
>> +
>> +static const struct of_device_id adc5_match_table[] = {
>> +	{
>> +		.compatible = "qcom,spmi-adc5-gen3",
>> +		.data = &adc5_gen3_data_pmic,
>> +	},
>> +	{
>> +		.compatible = "qcom,spmi-adc5-gen4",
>> +		.data = &adc5_gen4_data_pmic,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, adc5_match_table);
> 
> Why has this moved?  I'm not seeing any new references to adc5_match_table
> before where it was before.

I think I moved it with the adc5_data structs by mistake, I'll
move it back.

> 
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index b03cf584b165..cb23d0d178c7 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
> 
>> @@ -341,6 +345,8 @@ static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
>>  					qcom_vadc7_scale_hw_calib_die_temp},
>>  	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
>>  	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
>> +	[SCALE_HW_CALIB_THERM_100K_PU_GEN4] = {
>> +					qcom_adc5_gen4_scale_hw_calib_therm},
> 
> I don't mind if you want to go a little past 80 chars to avoid doing this sort
> of line break that just makes things harder to read.
> 
>>  };
>>  
>>  static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>> @@ -556,6 +562,32 @@ static int qcom_vadc7_scale_hw_calib_therm(
>>  	return 0;
>>  }
>>  
>> +static int qcom_adc5_gen4_scale_hw_calib_therm(
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_mdec)
>> +{
>> +	s64 resistance = adc_code;
>> +	int ret, result;
>> +
>> +	if (adc_code >= RATIO_MAX_ADC5_GEN4)
>> +		return -EINVAL;
>> +
>> +	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
>> +	resistance *= R_PU_100K;
>> +	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);
>> +
>> +	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
>> +					 ARRAY_SIZE(adcmap7_100k),
>> +					 resistance, &result);
> 
> 	ret = qcom_vadc_map_voltage_temp(adcmap7_100k, ARRAY_SIZE(adcmap7_100k),
> 					 resistance, &result);
> 
> is under 80 chars anyway. 
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	*result_mdec = result;
>> +
>> +	return 0;
>> +}
>> +
>>  static int qcom_vadc_scale_hw_calib_volt(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> index 39cbfcbdb101..5d8e38350827 100644
>> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> @@ -40,7 +40,8 @@
>>  
>> +enum adc_generation {
>> +	ADC5_GEN3 = 0,
> 
> Does the value matter anywhere?  If not just leave it unspecified.
> If it does matter because it actually gets written to hardware somewhere
> I'm missing then set GEN4 as well.

It looks like the value does not really matter, I'll
leave it unspecified.

I'll also address your other comments in the next patch series.

Thanks,
Jishnu


> 
>> +	ADC5_GEN4,
>> +};
>> +
> 
> Thanks,
> 
> Jonathan

