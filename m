From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 3/4] PM: Print wall time at suspend entry and exit
Date: Tue, 18 Jul 2017 16:26:41 -0700
Message-ID: <749ae452-8626-7d6d-60f1-7a949be546a4@android.com>
References: <20170718172600.114761-1-salyzyn@android.com>
 <214360396.4sfZrYBT7N@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34618 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdGRX0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 19:26:43 -0400
Received: by mail-pg0-f48.google.com with SMTP id 123so20600162pgj.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 16:26:43 -0700 (PDT)
In-Reply-To: <214360396.4sfZrYBT7N@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org

On 07/18/2017 03:25 PM, Rafael J. Wysocki wrote:
> On Tuesday, July 18, 2017 10:25:58 AM Mark Salyzyn wrote:
>> Permits power state and battery life diagnosis.
>>
>> Feature activated by CONFIG_RTC_SHOW_TIME.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Please fold the [4/4] into this one and I have a patch series that you'd
> want to rebase this on I guess.  I'll send it shortly.
>
> Thanks,
> Rafael
>
Ok, after all the disputes are laid to rest, I will roll these in 
together on the respin.
