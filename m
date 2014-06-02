From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] thermal: ti-soc-thermal: ti-bandgap.c: Cleaning up memory leak
Date: Mon, 2 Jun 2014 23:13:36 +0200
Message-ID: <CAFo99gbVBgQWaJtzT_RT-M4yqxfua162qxCKVmazJY7th2KY0w@mail.gmail.com>
References: <1401622431-13554-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<20140602170800.GA5198@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44358 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaFBVNh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 17:13:37 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so5295644oag.30
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2014 14:13:37 -0700 (PDT)
In-Reply-To: <20140602170800.GA5198@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi

Okay, then I make a new patch with only the if() part of the code.


Best regards
Rickard Strandqvist


2014-06-02 19:08 GMT+02:00 Eduardo Valentin <edubezval@gmail.com>:
> On Sun, Jun 01, 2014 at 01:33:51PM +0200, Rickard Strandqvist wrote:
>> There is a risk for memory leak in when something unexpected happens
>> and the function returns.
>
> I don't think there is a risk of memory leak, but wrong address access,
> in this case.
>
>>
>> This was largely found by using a static code analysis program called cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> index 3ab12ee..8401d2e 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> @@ -1155,8 +1155,9 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
>>       /* register shadow for context save and restore */
>>       bgp->regval = devm_kzalloc(&pdev->dev, sizeof(*bgp->regval) *
>>                                  bgp->conf->sensor_count, GFP_KERNEL);
>> -     if (!bgp) {
>> +     if (!bgp->regval) {
>
> I agree with this fix.
>
>>               dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
>> +             devm_kfree(&pdev->dev, bgp);
>
> But I think this is unnecessary, as it has been managed allocated.
>
> Cheers,
>
> Eduardo
>
>>               return ERR_PTR(-ENOMEM);
>>       }
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
