From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on recent Dell laptops
Date: Thu, 01 Jun 2017 01:23:43 +0200
Message-ID: <3454366.uzaJljlWGm@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

This is a follow-up for a patch series posted some time ago:

http://marc.info/?l=linux-kernel&m=149324246701378&w=2

The first two patches from that series are in 4.12-rc already and the rest
have been rearranged.

The issue at hand is still the same as before:

On Wednesday, April 26, 2017 11:21:11 PM Rafael J. Wysocki wrote:
>
> The underlying issue is that on some relatively new Dell laltops, including
> Dell XPS13 9360 and 9365, pressing the power button is not sufficient to
> wake up the system from suspend-to-idle (it has to be pressed and held
> down for around 5 sec for the wakeup to happen) which is not expected
> and does not match the Windows' behavior.
> 
> This turns out to be a consequence of the way power button events are signaled
> on those systems, which is through the Embedded Controller (EC).  Namely,
> button events go to the EC which then signals the event through its ACPI GPE
> (General Purpose Event), which triggers an ACPI SCI (System Control Interrupt),
> whose handler executes a specicif AML control method and triggers a Notify()
> targetting a devie object associated with the power button.  The problem with
> suspend-to-idle is that the EC GPE is disabled during suspend, because
> otherwise all EC events would wake up the system from suspend-to-idle (and
> there can be many of them).

The first two patches in the current series  update the drivers used for button
events processing on the affected systems so that they signal wakeup as
expected and avoid propagating the wakeup events as button events to user
space.

The third patch allows the EC GPE to become a wakeup GPE on the affected Dell
laptops and finally makes power button events wake up those systems from
suspend-to-idle.

After this series there still is a concern regarding the possible increase of
power draw that may result from the processing of non-wakeup EC events while
suspended which is why the change only affects Dell XPS13 9360 and 9365
for now.

There is no code dependency between patches [1-2/3] and patch [3/3], but all
of them together are necessary for the feature in question to work on both the
affected systems, so IMO they should be applied together.

The series is available from a git branch at
 
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git s2idle-dell-test
 
and has been included into the testing branch thereof.
 
If there are any concerns regarding this series, please let me know.

Thanks,
Rafael
