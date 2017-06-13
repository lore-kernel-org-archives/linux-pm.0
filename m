From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Tue, 13 Jun 2017 23:11:46 +0200
Message-ID: <CA+kEDGHS0JAoPiXowBEYCRwgi43-Ss_sJa9ngiuwP_xYt3rtaA@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
 <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
 <1872413.KDFIRZOQLU@aspire.rjw.lan> <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
 <CA+kEDGF57sfz+f8_9XMqGQqPt-5LmtvceO70_gOpdaZ548tT-g@mail.gmail.com>
 <CAJZ5v0jHf3zDJ6K8pN3DQZa2Xq14Cz5XQMpwxqJfwH=nS8jGdA@mail.gmail.com>
 <CA+kEDGFiyynapLQPgnxNxuphBFYNpp7OYu9dn7vv-Z9PJNG6dA@mail.gmail.com> <CAJZ5v0h=GVjqwZ7fdJGHWrQN5GuNotk5xCH-nYynFUadVAH0Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h=GVjqwZ7fdJGHWrQN5GuNotk5xCH-nYynFUadVAH0Xg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <Mario.Limonciello@dell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

>>> However, the bottom line is that there is no way for the kernel at all
>>> to know in advance that these events are going to be generated.
>>
>> Would a patch to handle this specific case be acceptable in the kernel though?
>
> We have quirks. :-)
>
> That said I think intel-hid could check the 0xCE event unconditionally
> in the "wakeup" mode, but that will be a separate patch on top of my
> series.

Thank you again, Rafael and Mario, to have helped understand the
special behavior implemented on this system / BIOS combination. I
guess I'll wait for your s2-idle-dell-test patch series to land first, to
discuss then how to handle this other Dell model (with Alex Hung?).

Or do you have another suggestion about how to proceed?

In the meantime, I'll update the bug report I had created:
https://bugzilla.kernel.org/show_bug.cgi?id=195897
to track and share there all the discoveries from this thread.

Jerome
