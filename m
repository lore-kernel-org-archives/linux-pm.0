From: Rajat Jain <rajatja@google.com>
Subject: Re: Understanding pm_wakeup_event() call in acpi/button.c in acpi_lid_notify_state
Date: Thu, 15 Feb 2018 11:20:38 -0800
Message-ID: <CACK8Z6FUB=eNYrUBsU6cZtMgEaYaGJy96k532Uct+w-GECH-bQ@mail.gmail.com>
References: <CAOGSYL0Oo-OLFZk9FxK1q92h3saMYnq+BOhR5DqyLmHahhS7NQ@mail.gmail.com>
 <CAE_wzQ9+oqKS8FSc=BP5fFezmF2pKabTrP75--NdQn=NFqXRvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37055 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161052AbeBOTVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Feb 2018 14:21:19 -0500
Received: by mail-yw0-f196.google.com with SMTP id v139so524276ywg.4
        for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2018 11:21:19 -0800 (PST)
In-Reply-To: <CAE_wzQ9+oqKS8FSc=BP5fFezmF2pKabTrP75--NdQn=NFqXRvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: Ravi Chandra Sadineni <ravisadineni@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Furquan Shaikh <furquan@google.com>

[+Furquan]

On Thu, Feb 15, 2018 at 10:52 AM, Dmitry Torokhov <dtor@google.com> wrote:
> Hi Ravi,
>
> On Thu, Feb 15, 2018 at 10:42 AM, Ravi Chandra Sadineni
> <ravisadineni@google.com> wrote:
>>
>> Hi,
>>
>> we have a user space daemon that identifies wakeup source based on the
>> device wakeup counts. We are facing issues with the ACPI buttons
>> driver(acpi/buttons.c) as the wakeup_count increments immaterial of
>> the wake source, if the lid is open.  The reason seems to be
>> pm_wakeup_event() call in  acpi_lid_notify_state if the lid state is
>> open.
>>
>>     if (state)
>>            acpi_pm_wakeup_event(&device->dev);
>>
>>
>>
>> What is the reason for calling pm_wakeup_event() in
>> acpi_lid_notify_state() which is in turn called  every time the lid is
>> open on resume ? Can this be removed ?
>
> I think you really want to signal the wakeup event on transitions to
> open, can you try
>
> if (state && do_update)
>          acpi_pm_wakeup_event(&device->dev);

Furquan had thought of an interesting corner case, not sure if
"do_update" takes care of it. If a system is suspended by some other
means instead of a "lid close", and there after the lid is actually
closed, and subsequently opened, the kernel would not see a transition
from closed to open because when the kernel was suspended, the lid was
still "open". In this scenario, will the do_update be set to true or
false?

>
> Thanks,
> Dmitry
