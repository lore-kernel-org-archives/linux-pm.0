From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [bug report] thermal: add brcmstb AVS TMON driver
Date: Wed, 6 Sep 2017 11:08:59 -0700
Message-ID: <e0d20842-4ab2-e889-0434-9ca12f192777@gmail.com>
References: <20170906071522.7wyvtyznp2mdqmd7@mwanda>
 <20170906170021.GA119185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37799 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdIFSJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 14:09:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id h21so4353498qth.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Sep 2017 11:09:05 -0700 (PDT)
In-Reply-To: <20170906170021.GA119185@google.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org, Doug Berger <opendmb@gmail.com>, colin.king@canonical.com

On 09/06/2017 10:00 AM, Brian Norris wrote:
> On Wed, Sep 06, 2017 at 11:22:42AM +0300, Dan Carpenter wrote:
>> Hello Brian Norris,
> 
> Hi Dan! Or Dan's robots.
> 
>> The patch 1e21c74eda83: "thermal: add brcmstb AVS TMON driver" from
> 
> I'll blame Doug or Florian :)
> 
> Actually, I'm pretty sure 'low' and 'high' were 'unsigned long' in the
> tree where I first wrote this driver (before 'set_trips' was even merged
> upstream). We can probably simplify this now.

That is exactly what happened yes :) and Colin already sent a fix for that:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1483884.html

> 
> But I'll leave that to Doug.
> 
> Brian
> 
>> Aug 9, 2017, leads to the following static checker warning:
>>
>> 	drivers/thermal/broadcom/brcmstb_thermal.c:281 brcmstb_set_trips()
>> 	warn: impossible condition '(low > ((~0 >> 1))) => (s32min-s32max > s32max)'
>>
>> 	drivers/thermal/broadcom/brcmstb_thermal.c:290 brcmstb_set_trips()
>> 	warn: impossible condition '(high > ((~0 >> 1))) => (s32min-s32max > s32max)'
>>
>> drivers/thermal/broadcom/brcmstb_thermal.c
>>    274  static int brcmstb_set_trips(void *data, int low, int high)
>>    275  {
>>    276          struct brcmstb_thermal_priv *priv = data;
>>    277  
>>    278          dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
>>    279  
>>    280          if (low) {
>>    281                  if (low > INT_MAX)
>>                             ^^^^^^^^^^^^^
>> Never true
>>
>>    282                          low = INT_MAX;
>>    283                  avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
>>    284                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
>>    285          } else {
>>    286                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 0);
>>    287          }
>>    288  
>>    289          if (high < ULONG_MAX) {
>>                     ^^^^^^^^^^^^^^^^
>> Always true
>>
>>    290                  if (high > INT_MAX)
>>                             ^^^^^^^^^^^^^^
>> Never true
>>
>>    291                          high = INT_MAX;
>>    292                  avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
>>    293                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
>>    294          } else {
>>    295                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 0);
>>    296          }
>>    297  
>>    298          return 0;
>>    299  }
>>
>>
>> regards,
>> dan carpenter


-- 
Florian
