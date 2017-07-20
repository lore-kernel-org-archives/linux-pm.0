From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Modern Suspend on Dell Latitude 5285 does not resume
Date: Fri, 21 Jul 2017 01:05:05 +0200
Message-ID: <CAJZ5v0j6H+R869-h0FnnL3NTyOFoPODSbvEeug_YPcBdz+BCcg@mail.gmail.com>
References: <87k233nfz0.fsf@ungleich.ch> <b967fdf2361d4ea29b8c76c62de0b7fc@ausx13mpc120.AMER.DELL.COM>
 <87r2xaloin.fsf@ungleich.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <87r2xaloin.fsf@ungleich.ch>
Sender: linux-acpi-owner@vger.kernel.org
To: Nico Schottelius <nico.schottelius@ungleich.ch>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Lv <lv.zheng@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 21, 2017 at 12:41 AM, Nico Schottelius
<nico.schottelius@ungleich.ch> wrote:
>
> Good evening Mario,
>
>> Currently the patch does not look at anything in the system to default to S2I vs S3.
>> This will affect systems that offer S3 and S2I (even if S3 is broken).
>>
>> Have you configured /sys/power/mem_sleep to s2idle?
>> https://github.com/torvalds/linux/blob/master/Documentation/power/states.txt#L35
>
> indeed, after configuring it to s2idle, it works like charm!
>
> Do you have any plans on defaulting to s2idle for machines that do not
> properly support s3?

Yes, we do.

Thanks,
Rafael
