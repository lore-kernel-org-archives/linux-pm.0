From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/6] PM / sleep: Support for quiescing timers during suspend-to-idle
Date: Wed, 11 Feb 2015 05:00:15 +0100
Message-ID: <8292243.ibkmfVtXac@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds support for quiescing timers during the last state of
suspend-to-idle transitions.

Patches [1-4/6] together are functionally equivalent to the combo RFC patch
I sent last time (http://marc.info/?l=linux-kernel&m=142344909201464&w=4).

Patches [5-6/6] add ->enter_freeze callback implementations to intel_idle
and the ACPI cpuidle driver.

[1/6] - Rework the suspend-to-idle "mechanics" in preparation for the subsequent
        changes.  The existing functionality should not change after this.
[2/6] - Modify update_fast_timekeeper() to take struct tk_read_base pointers as
        arguments.
[3/6] - Make it safe to use the fast timekeeper while suspended.
[4/6] - Support for quiescing timers during suspend-to-idle (core part).
[5/6] - ->enter_freeze callback for intel_idle.
[6/6] - ->enter_freeze callback for ACPI cpuidle.

This works as expected on everything I have in my office and can readily test.

The patches should apply without any problems on top of the current Linus' tree.

Rafael
