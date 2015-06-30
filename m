From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.2-rc1
Date: Tue, 30 Jun 2015 18:09:03 +0200
Message-ID: <CAJZ5v0haq+JQumnW42neguDPZHJRqKd_9VJ+-UTpWetMEODQ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.2-rc1-2

to receive power management and ACPI fixes for v4.2-rc1 with
top-most commit 132c242d95063f0c362597e74ee6759403a3f700

 Merge branches 'acpi-video', 'device-properties', 'pm-sleep' and 'pm-cpuidle'

on top of commit 43c9fad942b5afb9e03801c0721d83160fa5b0dd

 Merge tag 'pm+acpi-4.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are fixes that didn't make it to the previous PM+ACPI pull
request or are fixing issues introduced by it.

Specifics:

 - Fix a recently added memory leak in an error path in the ACPI
   resources management code (Dan Carpenter).

 - Fix a build warning triggered by an ACPI video header function
   that should be static inline (Borislav Petkov).

 - Change names of helper function converting struct fwnode_handle
   pointers to either struct device_node or struct acpi_device
   pointers so they don't conflict with local variable names
   (Alexander Sverdlin).

 - Make the hibernate core re-enable nonboot CPUs on failures to
   disable them as expected (Vitaly Kuznetsov).

 - Increase the default timeout of the device suspend watchdog to
   prevent it from triggering too early on some systems (Takashi Iwai).

 - Prevent the cpuidle powernv driver from registering idle
   states with CPUIDLE_FLAG_TIMER_STOP set if CONFIG_TICK_ONESHOT
   is unset which leads to boot hangs (Preeti U Murthy).

Thanks!


---------------

Alexander Sverdlin (1):
      ACPI / OF: Rename of_node() and acpi_node() to to_of_node() and
to_acpi_node()

Borislav Petkov (1):
      ACPI / video: Inline acpi_video_set_dmi_backlight_type

Dan Carpenter (1):
      ACPI / resources: free memory on error in add_region_before()

Preeti U Murthy (1):
      tick/idle/powerpc: Do not register idle states with
CPUIDLE_FLAG_TIMER_STOP set in periodic mode

Takashi Iwai (1):
      PM / sleep: Increase default DPM watchdog timeout to 60

Vitaly Kuznetsov (1):
      PM / hibernate: re-enable nonboot cpus on disable_nonboot_cpus() failure

---------------

 drivers/acpi/resource.c           |  4 +++-
 drivers/base/property.c           | 26 +++++++++++++-------------
 drivers/cpuidle/cpuidle-powernv.c | 15 ++++++++++++---
 drivers/gpio/gpiolib.c            |  4 ++--
 drivers/leds/leds-gpio.c          |  2 +-
 include/acpi/acpi_bus.h           |  2 +-
 include/acpi/video.h              |  2 +-
 include/linux/acpi.h              |  4 ++--
 include/linux/of.h                |  4 ++--
 kernel/power/Kconfig              |  2 +-
 kernel/power/hibernate.c          |  4 +++-
 11 files changed, 41 insertions(+), 28 deletions(-)
