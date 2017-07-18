From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 13:00:07 -0700
Message-ID: <b6bce88c-a13c-8504-18ac-242f637f4d13@android.com>
References: <20170718172525.114514-1-salyzyn@android.com>
 <20170718175224.xccqnv4zjggn4shu@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35983 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdGRUAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 16:00:09 -0400
Received: by mail-pg0-f50.google.com with SMTP id u5so18119220pgq.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 13:00:08 -0700 (PDT)
In-Reply-To: <20170718175224.xccqnv4zjggn4shu@piout.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, linux-rtc@vger.kernel.org

On 07/18/2017 10:52 AM, Alexandre Belloni wrote:
> Hi,
>
> On 18/07/2017 at 10:25:23 -0700, Mark Salyzyn wrote:
>> . . .
> Apart from using rtc_time_to_tm (and you should probably use
> rtc_time64_to_tm), none of this is actually related to the RTC
> subsystem. I feel like you should find another place to put that, maybe
> timekeeping_debug.c?
Makes a lot of sense!

-- Mark
