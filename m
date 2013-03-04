From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 3/3] Thermal: kirkwood: Convert to devm_ioremap_resource()
Date: Tue, 5 Mar 2013 05:16:09 +0900
Message-ID: <CABMQnVJhLydOB2ciXXRXzhECD4cg3Fj-eD1FSrdTmVHXghkweA@mail.gmail.com>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
 <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org> <20130304070656.GG16261@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:62785 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab3CDUQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 15:16:41 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so5450743lab.30
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2013 12:16:40 -0800 (PST)
In-Reply-To: <20130304070656.GG16261@avionic-0098.mockup.avionic-design.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pm@vger.kernel.org, rui.zhang@intel.com

On Mon, Mar 4, 2013 at 4:06 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Mon, Mar 04, 2013 at 12:15:34PM +0530, Sachin Kamat wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> devm_ioremap_resource() provides its own error messages; so all explicit
>> error messages can be removed from the failure code paths.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>>  drivers/thermal/kirkwood_thermal.c |    8 +++-----
>>  1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
>> index 65cb4f0..e5500ed 100644
>> --- a/drivers/thermal/kirkwood_thermal.c
>> +++ b/drivers/thermal/kirkwood_thermal.c
>> @@ -85,11 +85,9 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
>>       if (!priv)
>>               return -ENOMEM;
>>
>> -     priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
>> -     if (!priv->sensor) {
>> -             dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
>> -             return -EADDRNOTAVAIL;
>> -     }
>> +     priv->sensor = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(priv->sensor))
>> +             return PTR_ERR(priv->sensor);
>>
>>       thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
>>                                              priv, &ops, NULL, 0, 0);
>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
