From: Nico Schottelius <nico.schottelius@ungleich.ch>
Subject: Re: Modern Suspend on Dell Latitude 5285 does not resume
Date: Fri, 21 Jul 2017 00:41:36 +0200
Message-ID: <87r2xaloin.fsf@ungleich.ch>
References: <87k233nfz0.fsf@ungleich.ch> <b967fdf2361d4ea29b8c76c62de0b7fc@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <b967fdf2361d4ea29b8c76c62de0b7fc@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, mika.westerberg@linux.intel.com, tom@oneshoeco.com, jerome.debretagne@gmail.com, torvalds@linux-foundation.org, lv.zheng@intel.com
List-Id: linux-pm@vger.kernel.org


Good evening Mario,

> Currently the patch does not look at anything in the system to default to S2I vs S3.
> This will affect systems that offer S3 and S2I (even if S3 is broken).
>
> Have you configured /sys/power/mem_sleep to s2idle?
> https://github.com/torvalds/linux/blob/master/Documentation/power/states.txt#L35

indeed, after configuring it to s2idle, it works like charm!

Do you have any plans on defaulting to s2idle for machines that do not
properly support s3?

Best,

Nico


--
Modern, affordable, Swiss Virtual Machines can be found on www.datacenterlight.ch
