From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [bug report] thermal: add brcmstb AVS TMON driver
Date: Wed, 6 Sep 2017 10:00:21 -0700
Message-ID: <20170906170021.GA119185@google.com>
References: <20170906071522.7wyvtyznp2mdqmd7@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38669 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdIFRAY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 13:00:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id q76so3301915pfq.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Sep 2017 10:00:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170906071522.7wyvtyznp2mdqmd7@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>

On Wed, Sep 06, 2017 at 11:22:42AM +0300, Dan Carpenter wrote:
> Hello Brian Norris,

Hi Dan! Or Dan's robots.

> The patch 1e21c74eda83: "thermal: add brcmstb AVS TMON driver" from

I'll blame Doug or Florian :)

Actually, I'm pretty sure 'low' and 'high' were 'unsigned long' in the
tree where I first wrote this driver (before 'set_trips' was even merged
upstream). We can probably simplify this now.

But I'll leave that to Doug.

Brian

> Aug 9, 2017, leads to the following static checker warning:
> 
> 	drivers/thermal/broadcom/brcmstb_thermal.c:281 brcmstb_set_trips()
> 	warn: impossible condition '(low > ((~0 >> 1))) => (s32min-s32max > s32max)'
> 
> 	drivers/thermal/broadcom/brcmstb_thermal.c:290 brcmstb_set_trips()
> 	warn: impossible condition '(high > ((~0 >> 1))) => (s32min-s32max > s32max)'
> 
> drivers/thermal/broadcom/brcmstb_thermal.c
>    274  static int brcmstb_set_trips(void *data, int low, int high)
>    275  {
>    276          struct brcmstb_thermal_priv *priv = data;
>    277  
>    278          dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
>    279  
>    280          if (low) {
>    281                  if (low > INT_MAX)
>                             ^^^^^^^^^^^^^
> Never true
> 
>    282                          low = INT_MAX;
>    283                  avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
>    284                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
>    285          } else {
>    286                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 0);
>    287          }
>    288  
>    289          if (high < ULONG_MAX) {
>                     ^^^^^^^^^^^^^^^^
> Always true
> 
>    290                  if (high > INT_MAX)
>                             ^^^^^^^^^^^^^^
> Never true
> 
>    291                          high = INT_MAX;
>    292                  avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
>    293                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
>    294          } else {
>    295                  avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 0);
>    296          }
>    297  
>    298          return 0;
>    299  }
> 
> 
> regards,
> dan carpenter
