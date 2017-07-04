From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 4 Jul 2017 15:27:55 +0800
Message-ID: <CAMz4kuJroGf6xLdMXfgFtCkLE8Esg5eqbydBgnvm5ELN=2xFmQ@mail.gmail.com>
References: <cover.1499061617.git.baolin.wang@linaro.org> <dc4200357a69f0c0bca5404b9e1da8b486452731.1499061617.git.baolin.wang@linaro.org>
 <20170703085323.ph5drwiisjxmfhri@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36398 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdGDH15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 03:27:57 -0400
Received: by mail-oi0-f44.google.com with SMTP id x187so39959406oig.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 00:27:56 -0700 (PDT)
In-Reply-To: <20170703085323.ph5drwiisjxmfhri@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On 3 July 2017 at 16:53, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> On Mon, Jul 03, 2017 at 02:07:15PM +0800, Baolin Wang wrote:
>> Integrate with the newly added USB charger interface to limit the current
>> we draw from the USB input based on the input device configuration
>> identified by the USB stack, allowing us to charge more quickly from high
>> current inputs without drawing more current than specified from others.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
> <snip>
>>  /*********************************************************************
>>   *           Battery properties
>>   *********************************************************************/
>> @@ -607,6 +647,22 @@ static int wm831x_power_probe(struct platform_device *pdev)
>>               }
>>       }
>>
>> +     power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev,
>> +                                                  "usb-phy", 0);
>> +     if (IS_ERR(power->usb_phy)) {
>> +             ret = PTR_ERR(power->usb_phy);
>> +             dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
>> +             goto err_bat_irq;
>> +     }
>> +
>
> We should probably update the binding documentation for this as
> well: mfd/wm831x.txt

Yes, I will update the binding documentation.

>
> Also I am not sure this needs to be implemented now, but what is
> the plan regarding pdata systems? Generally the driver supports
> both and it would be nice to know there is a way forward for that
> even if we don't implement it yet.

OK, I'll modify this in next version. Thanks.

-- 
Baolin.wang
Best Regards
