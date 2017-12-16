From: shrikant <shrikant.maurya@techveda.org>
Subject: Re: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Sat, 16 Dec 2017 13:51:08 +0530
Message-ID: <04001068-2880-d0b8-cf3b-4738b8bb7f2d@techveda.org>
References: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
 <CAJZ5v0jH-hqMGLckGkqOycVML-HTLmXxDLjw0D4qbC1fET2Q_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40576 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPIVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 03:21:14 -0500
Received: by mail-pf0-f193.google.com with SMTP id v26so7640290pfl.7
        for <linux-pm@vger.kernel.org>; Sat, 16 Dec 2017 00:21:14 -0800 (PST)
In-Reply-To: <CAJZ5v0jH-hqMGLckGkqOycVML-HTLmXxDLjw0D4qbC1fET2Q_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sunil.m@techveda.org, karthik@techveda.org, raghu@techveda.org



On Tuesday 12 December 2017 10:25 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2017 at 2:45 PM,  <shrikant.maurya@techveda.org> wrote:
>> From: Shrikant Maurya <shrikant.maurya@techveda.org>
>>
>> As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
>> API's are using GFP_KERNEL to allocate memory which may sleep.
>>
>> To ensure atomicity such allocations must be avoided in critical
>> sections under spinlock.
> 
> That's right.
> 
> Which is why wakeup_source_create() should never be called under a spinlock.

Yes.

Better approach is, to move the call to device_init_wakeup() before the spinlock.

> 
> Are you aware of any place that happens in the mainline kernel?

No.

> 
> Thanks,
> Rafael
> 

Thank you Rafeal.
-- 
Shrikant
techveda.org
