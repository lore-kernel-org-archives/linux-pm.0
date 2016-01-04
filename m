From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] drivers: qcom: spm: avoid module usage in non-modular
 SPM driver
Date: Mon, 4 Jan 2016 10:40:30 -0700
Message-ID: <20160104174030.GG3342@linaro.org>
References: <1451927725-7257-1-git-send-email-lina.iyer@linaro.org>
 <20160104173012.GM12458@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33986 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcADRke (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2016 12:40:34 -0500
Received: by mail-pf0-f176.google.com with SMTP id e65so152397053pfe.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2016 09:40:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160104173012.GM12458@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Mon, Jan 04 2016 at 10:30 -0700, Paul Gortmaker wrote:
>[[PATCH] drivers: qcom: spm: avoid module usage in non-modular SPM driver] On 04/01/2016 (Mon 10:15) Lina Iyer wrote:
>
>> SPM driver provides cpuidle support on some QC SoC's. The functionality
>> is non-modular and there is no need for module support. Convert module
>> platform init to builtin platform driver init. The driver functionality
>> is not affected by this change.
>>
>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>
>I have a similar patch locally that I'd not sent yet, the only
>difference is that I moved the description tag to the top of the file
>since there wasn't a description therei, i.e. this chunk:
>
>diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>index b04b05a0904e..9e06a241257f 100644
>--- a/drivers/soc/qcom/spm.c
>+++ b/drivers/soc/qcom/spm.c
>@@ -2,6 +2,8 @@
>  * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
>  * Copyright (c) 2014,2015, Linaro Ltd.
>  *
>+ * SAW power controller driver
>+ *
Makes sense.

I can add this to my patch and resend if thats OK with you?

-- Lina

>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 and
>  * only version 2 as published by the Free Software Foundation.
>
>
>Paul.
>--
>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/soc/qcom/spm.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>> index b04b05a..199c085 100644
>> --- a/drivers/soc/qcom/spm.c
>> +++ b/drivers/soc/qcom/spm.c
>> @@ -12,7 +12,6 @@
>>   * GNU General Public License for more details.
>>   */
>>
>> -#include <linux/module.h>
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> @@ -378,8 +377,4 @@ static struct platform_driver spm_driver = {
>>  		.of_match_table = spm_match_table,
>>  	},
>>  };
>> -module_platform_driver(spm_driver);
>> -
>> -MODULE_LICENSE("GPL v2");
>> -MODULE_DESCRIPTION("SAW power controller driver");
>> -MODULE_ALIAS("platform:saw");
>> +builtin_platform_driver(spm_driver);
>> --
>> 2.1.4
>>
