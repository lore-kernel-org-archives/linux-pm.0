From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 13:08:35 -0700
Message-ID: <5a1a1eab-5d5b-b91c-2990-abbd2d17480e@android.com>
References: <20170718172525.114514-1-salyzyn@android.com>
 <20170718175224.xccqnv4zjggn4shu@piout.net>
 <b6bce88c-a13c-8504-18ac-242f637f4d13@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36196 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdGRUIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 16:08:36 -0400
Received: by mail-pg0-f52.google.com with SMTP id u5so18225601pgq.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 13:08:36 -0700 (PDT)
In-Reply-To: <b6bce88c-a13c-8504-18ac-242f637f4d13@android.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, linux-rtc@vger.kernel.org

On 07/18/2017 01:00 PM, Mark Salyzyn wrote:
> On 07/18/2017 10:52 AM, Alexandre Belloni wrote:
>> Hi,
>>
>> On 18/07/2017 at 10:25:23 -0700, Mark Salyzyn wrote:
>>> . . .
>> Apart from using rtc_time_to_tm (and you should probably use
>> rtc_time64_to_tm), none of this is actually related to the RTC
>> subsystem. I feel like you should find another place to put that, maybe
>> timekeeping_debug.c?
> Makes a lot of sense!
>
> -- Mark

Ooops, timekeeping_debug.c is currently only to support a debugfs node. 
Perhaps a _new_ file in that hierarchy like kernel/time/rtc_show_time.c.

-- Mark
