From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [RFC PATCH 2/5] power: generic-adc-battery: Parse more properties
 from DT
Date: Wed, 2 Aug 2017 13:57:31 +0200
Message-ID: <CAAfyv34Ur+0S+1498xNkmkbYE+uUepQd7u4UwAEXp=OgEGzNXA@mail.gmail.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com> <20170802115610.GC2765@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35603 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdHBL5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 07:57:33 -0400
In-Reply-To: <20170802115610.GC2765@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

Hi Pavel,

On Wed, Aug 2, 2017 at 1:56 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> +#ifdef CONFIG_OF
>> +static struct gab_platform_data *gab_dt_probe(struct platform_device *pdev)
>> +{
>> +     struct gab_platform_data *pdata;
>> +     struct device_node *np = pdev->dev.of_node;
>> +     const char *name;
>> +     u32 val;
>> +     int err;
>> +
>> +     pdata = devm_kzalloc(&pdev->dev,
>> +                     sizeof(struct gab_platform_data),
>> +                     GFP_KERNEL);
>> +     if (!pdata)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     pdata->gpio_charge_finished  = of_get_gpio(np, 0);
>> +
>> +     /* parse and fill power_supply_info struct */
>> +     err = of_property_read_u32(np, "technology", &val);
>> +     if (err) {
>> +             dev_info(&pdev->dev, "Battery technology unknown\n");
>> +             val = 0;
>> +     }
>> +     pdata->battery_info.technology = val;
>> +
>> +     err = of_property_read_string(np, "battery-name", &name);
>> +     if (err) {
>> +             dev_info(&pdev->dev, "Battery name empty, setting default\n");
>> +     }
>> +     pdata->battery_info.name = name;
>
> Actually ... looking at this once more. These are new properties,
> right?
>
> They'll need to be documented:
>
> pavel@duo:/data/l/linux$ grep -ri battery-name Documentation/devicetree/
>
> shows empty.
You're right. I'll add bindings documentation. Thanks.
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
