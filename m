From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Sun, 9 Jul 2017 18:45:01 +0200
Message-ID: <CA+kEDGFBre3Uvei9SNpdM9LR8xV8g10zde81stt9OFU=Wax_Mg@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
 <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
 <1872413.KDFIRZOQLU@aspire.rjw.lan> <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
 <CA+kEDGF57sfz+f8_9XMqGQqPt-5LmtvceO70_gOpdaZ548tT-g@mail.gmail.com>
 <CAJZ5v0jHf3zDJ6K8pN3DQZa2Xq14Cz5XQMpwxqJfwH=nS8jGdA@mail.gmail.com>
 <CA+kEDGFiyynapLQPgnxNxuphBFYNpp7OYu9dn7vv-Z9PJNG6dA@mail.gmail.com>
 <CAJZ5v0h=GVjqwZ7fdJGHWrQN5GuNotk5xCH-nYynFUadVAH0Xg@mail.gmail.com> <CA+kEDGHS0JAoPiXowBEYCRwgi43-Ss_sJa9ngiuwP_xYt3rtaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34993 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIQpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jul 2017 12:45:43 -0400
In-Reply-To: <CA+kEDGHS0JAoPiXowBEYCRwgi43-Ss_sJa9ngiuwP_xYt3rtaA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <Mario.Limonciello@dell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Rafael,

>>> Would a patch to handle this specific case be acceptable in the kernel though?
>>
>> We have quirks. :-)
>>
>> That said I think intel-hid could check the 0xCE event unconditionally
>> in the "wakeup" mode, but that will be a separate patch on top of my
>> series.
>
> I guess I'll wait for your s2-idle-dell-test patch series to land first, to
> discuss then how to handle this other Dell model (with Alex Hung?).
>
> In the meantime, I'll update the bug report I had created:
> https://bugzilla.kernel.org/show_bug.cgi?id=195897

It seems your series should land in 4.13 so I'm looking at proposing a
patch on top of it, as discussed.

However, I realize that I only know how to handle the wakeup case but
not the suspend one which doesn't work either. Indeed I've always
triggered suspend via the command line so far.

In intel-hid.c I see no obvious code referring to suspend. With added
debug logs, I can see that notify_handler receives the same 0xce / 0xcf
Notify events upon power button press when the system is running.

What would be the expected way then to trigger a normal suspend
sequence, when catching these uncommon events? Should a more
standard event be created instead? If that's a right approach, is
there existing kernel code to do so ?

Thank you,
Jerome
