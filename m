From: Chris Lapa <chris@lapa.com.au>
Subject: Re: [PATCH v2 01/11] power: supplies: bq275xx: rename BQ27500 allow
 for deprecation in future.
Date: Fri, 6 Jan 2017 11:29:19 +1100
Message-ID: <45a0f589-6a11-dcee-8a12-ec89763de501@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-2-git-send-email-chris@lapa.com.au>
 <20170105235957.jfoffcnlqqpw36vp@earth>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36713 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034667AbdAFA3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 19:29:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so3943209pgf.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2017 16:29:24 -0800 (PST)
In-Reply-To: <20170105235957.jfoffcnlqqpw36vp@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/1/17 10:59 am, Sebastian Reichel wrote:
> Hi Chris,
>
> On Fri, Dec 23, 2016 at 11:04:57AM +1100, Chris Lapa wrote:
>> From: Chris Lapa <chris@lapa.com.au>
>>
>> The BQ275XX definition exists only to satisfy backwards compatibility.
>>
>> tested: yes
>>
>> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>>
>> [...]
>>
>>  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>>  {
>> -	if (di->chip == BQ27500 || di->chip == BQ27541 || di->chip == BQ27545)
>> +	if (di->chip == BQ275XX || di->chip == BQ27541 || di->chip == BQ27545)
>>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>>  	if (di->chip == BQ27530 || di->chip == BQ27421)
>>  		return flags & BQ27XXX_FLAG_OT;
>
> This is really getting out of hands in this patchset. Please
> add a patch at the beginning of the patchset, which converts
> this construct into the following:
>
> switch (di->chip) {
> case A:
> case B:
> case C:
> case D:
>     return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> case E:
> case F:
>     return flags & BQ27XXX_FLAG_OT;
> default:
>     return false;
> }
>
> -- Sebastian
>

I was advised to move these tests into a function which I've done in the 
10th patch. I have no issue with changing it to a switch statement, but 
should I drop the bq27xxx_has_multiple_overtemp_flags() function I added?
