From: Doug Berger <opendmb@gmail.com>
Subject: Re: [bug report] thermal: add brcmstb AVS TMON driver
Date: Wed, 6 Sep 2017 12:33:33 -0700
Message-ID: <56f58145-4225-a00f-394a-c43102a5c072@gmail.com>
References: <20170906071522.7wyvtyznp2mdqmd7@mwanda>
 <20170906170021.GA119185@google.com>
 <e0d20842-4ab2-e889-0434-9ca12f192777@gmail.com>
 <20170906183720.GA35422@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36482 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdIFTdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 15:33:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id i14so3631682qke.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Sep 2017 12:33:37 -0700 (PDT)
In-Reply-To: <20170906183720.GA35422@google.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Markus Mayer <code@mmayer.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, colin.king@canonical.com

On 09/06/2017 11:37 AM, Brian Norris wrote:
> Hi,
>
> On Wed, Sep 06, 2017 at 11:08:59AM -0700, Florian Fainelli wrote:
>> On 09/06/2017 10:00 AM, Brian Norris wrote:
>>> On Wed, Sep 06, 2017 at 11:22:42AM +0300, Dan Carpenter wrote:
>>>> Hello Brian Norris,
>>>
>>> Hi Dan! Or Dan's robots.
>>>
>>>> The patch 1e21c74eda83: "thermal: add brcmstb AVS TMON driver" from
>>>
>>> I'll blame Doug or Florian :)

I of course have to blame Markus ;)

>>>
>>> Actually, I'm pretty sure 'low' and 'high' were 'unsigned long' in the
>>> tree where I first wrote this driver (before 'set_trips' was even merged
>>> upstream). We can probably simplify this now.
>>
>> That is exactly what happened yes :) and Colin already sent a fix for
that:
>>
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1483884.html
>
> Colin didn't fix all the problems. See below:
>
>>>
>>> But I'll leave that to Doug.
>>>
>>> Brian
>>>
>>>> Aug 9, 2017, leads to the following static checker warning:
>>>>
>>>> 	drivers/thermal/broadcom/brcmstb_thermal.c:281 brcmstb_set_trips()
>>>> 	warn: impossible condition '(low > ((~0 >> 1))) => (s32min-s32max
> s32max)'
>>>>
>>>> 	drivers/thermal/broadcom/brcmstb_thermal.c:290 brcmstb_set_trips()
>>>> 	warn: impossible condition '(high > ((~0 >> 1))) => (s32min-s32max
> s32max)'
>>>>
>>>> drivers/thermal/broadcom/brcmstb_thermal.c
>>>>    274  static int brcmstb_set_trips(void *data, int low, int high)
>>>>    275  {
>>>>    276          struct brcmstb_thermal_priv *priv = data;
>>>>    277
>>>>    278          dev_dbg(priv->dev, "set trips %d <--> %d\n", low,
high);
>>>>    279
>>>>    280          if (low) {
>>>>    281                  if (low > INT_MAX)
>>>>                             ^^^^^^^^^^^^^
>>>> Never true
>>>>
>>>>    282                          low = INT_MAX;
>>>>    283                  avs_tmon_set_trip_temp(priv,
TMON_TRIP_TYPE_LOW, low);
>>>>    284                  avs_tmon_trip_enable(priv,
TMON_TRIP_TYPE_LOW, 1);
>>>>    285          } else {
>>>>    286                  avs_tmon_trip_enable(priv,
TMON_TRIP_TYPE_LOW, 0);
>>>>    287          }
>>>>    288
>>>>    289          if (high < ULONG_MAX) {
>>>>                     ^^^^^^^^^^^^^^^^
>>>> Always true
>
> We didn't expect this one ^^^ and Colin didn't fix it. We expected a
> "max" value to turn the trip point off (in the 'else' branch). But we
> can never possibly reach the 'else'.
This actually appears to be the heart of the matter.

As stated above, the set_trips patch API that this logic was developed
for was different from the version of the patch ultimately merged
upstream and the brcmstb_thermal driver logic was not corrected before
being submitted upstream.

The key change appears to be as follows:

Old API - unsigned long ints and "If there is no trip point above or
below the current temperature, the passed trip temperature will be
ULONG_MAX or 0 respectively.

New API - ints and "If there is no trip point above or below the current
temperature, the passed trip temperature will be -INT_MAX or INT_MAX
respectively."

So there are latent logic errors in addition to the "dead code" errors
flagged here.

>
> Maybe my expectations are off now (I'm not really that familiar with the
> current state of the thermal framework), but at any rate, we shouldn't
> be leaving dead code.
>
> I'll make a quick comment on Colin's patch too, so this doesn't get
> lost.
>
> Brian
>
>>>>    290                  if (high > INT_MAX)
>>>>                             ^^^^^^^^^^^^^^
>>>> Never true
>>>>
>>>>    291                          high = INT_MAX;
>>>>    292                  avs_tmon_set_trip_temp(priv,
TMON_TRIP_TYPE_HIGH, high);
>>>>    293                  avs_tmon_trip_enable(priv,
TMON_TRIP_TYPE_HIGH, 1);
>>>>    294          } else {
>>>>    295                  avs_tmon_trip_enable(priv,
TMON_TRIP_TYPE_HIGH, 0);
>>>>    296          }
>>>>    297
>>>>    298          return 0;
>>>>    299  }
>>>>
>>>>
>>>> regards,
>>>> dan carpenter
>>
>>
>> --
>> Florian

I'll leave it to Markus to correct the logic, unless he wants to punt it
back to me :).

Thanks!
    Doug
