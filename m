From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Thu, 8 Jun 2017 01:05:44 +0200
Message-ID: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Here is some feedback for Dell Latitude 7275, as suggested by Srinivas
in https://bugzilla.kernel.org/show_bug.cgi?id=3D195897#c15 .

For some context on that model, suspend-to-RAM is not safe as the
system hangs (raised in the above bug report). I'm wondering if this
is expected somehow, due to S3 not being supported on that model, as
discussed for the XPS 13 9365. Maybe Mario or someone else from Dell
would be able to confirm this point.

While it's not set by default, suspend-to-idle works fine. However the
power button needs a very long press of about 6-7s to trigger the
wake-up (quite surprising at first).

I've applied Rafael's patch series on 4.12-rc4, with the 3rd patch
modified to add the Latitude 7275 DMI values, to check if the proposed
fix for the XPS 13 9360 and 9365 could also work for this other quite
recent Dell model.

Sadly with the latest BIOS 1.1.31, this patch set doesn't seem to
change anything: the long press is still needed.

Surprisingly and more for reference I suppose, this patch set works as
intended with an older BIOS 1.1.20 : the system can then be woken up
from system-to-idle with a usual short press. Cf.
https://bugzilla.kernel.org/show_bug.cgi?id=3D195897#c9 for more details
about why I've downgraded to and tested that specific older BIOS.

I'm wondering if there could be ways to modify slightly this patch
series to also cover the Latitude 7275 when running the current BIOS.
If I can provide any inputs that could be useful to investigate,
please let me know.

Thanks,
J=C3=A9rome
