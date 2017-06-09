From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Sat, 10 Jun 2017 01:11:15 +0200
Message-ID: <CA+kEDGFVgmXf_B=qHfhWS1HCD+Ei6KSp_rSJBOGYtNZVkm+MeA@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFUuSC1CpCEgOT+HMTrDa-r1y59kM9-CYn0PSgtuKaG5Q@mail.gmail.com> <343a8430fb144adf8d65ef9d0b2bfd40@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <343a8430fb144adf8d65ef9d0b2bfd40@ausx13mpc124.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

> I got a response back that confirmed that this machine only is supported
> with CS/MS.  I would not expect S3 to work properly.

Thanks for the confirmation, that's what I expected following the feedback on
other recent Dell machines.

> Even if S3 is part of the ACPI namespace, the behavior that Windows follows
> is that S3 is not offered when the low power idle bit is set in FADT.
>
> I know that the current behavior in Linux does not review low power idle
> bit to determine whether to offer S2I or S3

Is it something that is envisioned already as a future evolution in Linux as
well, if more and more systems are now designed with S2I in mind?

> so I'm inquiring if we can remove
> S3 from a future BIOS update on this platform to let Linux work better
> even though we don't ship this platform with Linux.

That would be a great fix, removing the default to S3 for this system on Linux.

> For now I would recommend that you focus efforts exclusively on making
> S2I work, and ignore S3 problems.

Well noted!

> It's unclear to me exactly when you tested s2idle-dell-test.
> Can you re-test with Rafael's newest submissions and changes to s2idle-dell-test
> committed 28 hours ago?
> You'll still have to add your system to the DMI whitelist for the last patch
> but he has reworked a bunch of related wakeup code that has also changed.

I've just done so, using the updated s2idle-dell-test branch + my DMI
adaptation.

I still get exactly the same results than during my previous tests:
- it provides the expected fix when running BIOS 1.1.20: short press to wake-up
- it doesn't fix with the current BIOS 1.1.31: long press still needed
to wake-up
so something has clearly changed between these 2 versions. Btw, the EC is
explicitly updated when flashing version 1.1.31, that's one of the
visible steps.

Some assumptions now: either the SCI is ignored erroneously or it's
not interpreted correctly by the expected driver? I guess that's the 2
possibilities I'll try to investigate.
