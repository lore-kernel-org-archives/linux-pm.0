From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: i686 suspend broken in 4.15.2
Date: Mon, 12 Feb 2018 14:03:57 +0100
Message-ID: <CAJZ5v0h+om_vtiNTmELJw6p58YsgTG6hMUXriApvjDSZxidKsg@mail.gmail.com>
References: <cd7033eb-1272-f8bc-f13f-afe09fd4864e@gmail.com> <22af3344-99c2-56a2-1465-638d5a07ae35@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:39432 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933646AbeBLND7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 08:03:59 -0500
Received: by mail-oi0-f44.google.com with SMTP id j188so11093657oib.6
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2018 05:03:59 -0800 (PST)
In-Reply-To: <22af3344-99c2-56a2-1465-638d5a07ae35@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Woody Suwalski <terraluna977@gmail.com>
Cc: william.grant@canonical.com, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On Mon, Feb 12, 2018 at 1:58 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 2/12/2018 2:52 AM, Woody Suwalski wrote:
>>
>> Howdy,
>> I have just tested 4.15.2 kernel on a 32-bit Thinkpad x60.
>> While hibernation works OK, suspend2ram fails on wakeup - system goes to
>> sleep OK, however upon wake it simply reboots.
>>
>> I have bisected the problem to:
>>
>> commit 62c00e6122a6b5aa7b1350023967a2d7a12b54c9
>> Author: William Grant <william.grant@canonical.com>
>> Date:   Tue Jan 30 22:22:55 2018 +1100
>>
>>     x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
>>
>
> That would be commit 55f49fcb879fbeeb in the mainline.
>
>> Removing that patch makes the suspend work again (testing is painful
>> because this small patch triggers rebuild of virtually all kernel files :-(
>> )
>>
>> Could there be something triggering it in my config file?
>>
>
> Yes, in theory.

Please create a BZ entry at bugzilla.kernel.org for this (let me know
the number of it) and attach the config to it.

Thanks,
Rafael
