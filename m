From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v1 1/5] thermal: rockchip: fix a trivial typo
Date: Mon, 30 Nov 2015 10:32:18 +0800
Message-ID: <565BB532.4010804@gmail.com>
References: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
 <1448592746-2129-2-git-send-email-wxt@rock-chips.com>
 <5259912.5mmETGszQg@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36833 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbK3CcY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 21:32:24 -0500
In-Reply-To: <5259912.5mmETGszQg@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hi Heiko,

Thanks to take your time to review that.

=E5=9C=A8 2015=E5=B9=B411=E6=9C=8827=E6=97=A5 17:49, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Hi Caesar,
>
> Am Freitag, 27. November 2015, 10:52:22 schrieb Caesar Wang:

[...]
>
>   /**
> -* The conversion table has the adc value and temperature.
> -* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
> -* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
> -*/
> + * The conversion table has the adc value and temperature.
> + * ADC_DECREMENT: the adc value is of diminishing.(e.g. v2_code_tabl=
e)
> + * ADC_INCREMENT: the adc value is incremental.(e.g. v3_code_table)
> + */
>   enum adc_sort_mode {
>   	ADC_DECREMENT =3D 0,
>   	ADC_INCREMENT,
> @@ -75,13 +75,13 @@ enum adc_sort_mode {
> You could simply move to documenting the fields in the header (like
> exynos_tmu.c for example) instead of inside the table. I think there =
are even
> tools that create documention from these comments, so I'd suggest:
>
> /*
>   * struct chip_tsadc_table: hold information about chip-specific dif=
ferences
>   * @id: conversion table
>   * @length: size of conversion table
>   * @data_mask: mask to apply on data inputs
>   * @mode: sort mode of this adc variant (incrementing or decrementin=
g)
>   */

That's a good idea for this.
=46ixed in next patch v2.

>>   struct chip_tsadc_table {
>>   	const struct tsadc_table *id;
>>
>> -	/* the array table size*/
>> +	/* The array table size */
>>   	unsigned int length;
>>
>> -	/* that analogic mask data */
>> +	/* That analogic mask data */
>>   	u32 data_mask;
>>
>> -	/* the sort mode is adc value that increment or decrement in table=
 */
>> +	/* The sort mode is adc value that increment or decrement in table=
 */
>>   	enum adc_sort_mode mode;
>>   };
>>
>> @@ -617,7 +617,7 @@ rockchip_thermal_register_sensor(struct platform=
_device
>> *pdev, return 0;
>>   }
>>
>> -/*
>> +/**
>>    * Reset TSADC Controller, reset all tsadc registers.
>>    */
>>   static void rockchip_thermal_reset_controller(struct reset_control=
 *reset)
>
>
>
>
> --=20
> Thanks,
> Caesar
