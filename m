From: shrikant <shrikant.maurya@techveda.org>
Subject: Re: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Sat, 16 Dec 2017 13:45:31 +0530
Message-ID: <cdcefc3b-aa94-98e6-b304-939b2ebcf3d0@techveda.org>
References: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
 <CAMuHMdUrhV9RkUnXkTbSWaRY33iQrANwbKBE5KAPQseNgxOofg@mail.gmail.com>
 <20171215084515.GB8221@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33002 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbdLPIPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 03:15:36 -0500
Received: by mail-io0-f195.google.com with SMTP id t196so4979990iof.0
        for <linux-pm@vger.kernel.org>; Sat, 16 Dec 2017 00:15:36 -0800 (PST)
In-Reply-To: <20171215084515.GB8221@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suniel Mahesh <sunil.m@techveda.org>, Karthik Tummala <karthik@techveda.org>, raghu@techveda.org



On Friday 15 December 2017 02:15 PM, Pavel Machek wrote:
> On Tue 2017-12-12 15:58:00, Geert Uytterhoeven wrote:
>> Hi Shrikant,
>>
>> On Tue, Dec 12, 2017 at 2:45 PM,  <shrikant.maurya@techveda.org> wrote:
>>> From: Shrikant Maurya <shrikant.maurya@techveda.org>
>>>
>>> As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
>>> API's are using GFP_KERNEL to allocate memory which may sleep.
>>>
>>> To ensure atomicity such allocations must be avoided in critical
>>> sections under spinlock.
>>> Fixed by replacing GFP_KERNEL to GFP_ATOMIC.
>>>
>>> Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> Signed-off-by: Shrikant Maurya <shrikant.maurya@techveda.org>
>>> Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
>>> Signed-off-by: Raghu Bharadwaj <raghu@techveda.org>
>>> Signed-off-by: Karthik Tummala <karthik@techveda.org>
>>
>> Can't the call to device_init_wakeup() in isp116x_start() just be moved
>> below the spinlock release?
>>
>>> --- a/drivers/base/power/wakeup.c
>>> +++ b/drivers/base/power/wakeup.c
>>> @@ -92,11 +92,11 @@ struct wakeup_source *wakeup_source_create(const char *name)
>>>  {
>>>         struct wakeup_source *ws;
>>>
>>> -       ws = kmalloc(sizeof(*ws), GFP_KERNEL);
>>> +       ws = kmalloc(sizeof(*ws), GFP_ATOMIC);
>>
>> With GFP_ATOMIC, allocation failure is much more likely to occur.
>> So IMHO it's better to fix the isp116x, than to impose this burden on
>> every user.
>>
>>>         if (!ws)
>>>                 return NULL;
>>>
>>> -       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
>>> +       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_ATOMIC) : NULL);
>>>         return ws;
> 
> NAK. This will silently replace name with NULL if memory is low.

Yes, replacing GFP_KERNEL with GFP_ATOMIC in both places will cause more 
issues than it fixes.

> 
> 									Pavel
> 

Thank you Pavel.

-- 
Shrikant
techveda.org
