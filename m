From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 0/2] Allow USB devices to remain runtime-suspended when sleeping
Date: Tue, 29 Sep 2015 17:32:52 +0200
Message-ID: <1443540774-5286-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

this is v6 of an attempt to make it easier for devices to remain in
runtime PM when the system goes to sleep, mainly to reduce the time
spent resuming devices.

For this, we interpret the absence of all PM callback implementations as
it being safe to do direct_complete, so their ancestors aren't prevented
from remaining runtime-suspended.

Additionally, the prepare() callback of USB devices will return 1 if
runtime PM is enabled and the current wakeup settings are correct.

With these changes, a uvcvideo device (for example) stays in runtime
suspend when the system goes to sleep and is left in that state when the
system resumes, not delaying it unnecessarily.

Thanks,

Tomeu

Changes in v6:
- Add stub for !CONFIG_PM.
- Move implementation of device_check_pm_callbacks to power/main.c as it
  doesn't belong to CONFIG_PM_SLEEP.
- Take dev->power.lock before modifying flag.

Changes in v5:
- Check for all dev_pm_ops instances associated to a device, updating a
  no_pm_callbacks flag at the times when that could change.

Tomeu Vizoso (2):
  PM / sleep: Go direct_complete if driver has no callbacks
  USB / PM: Allow USB devices to remain runtime-suspended when sleeping

 drivers/base/dd.c           |  3 +++
 drivers/base/power/common.c | 27 +++++++++++++++++++++++++++
 drivers/base/power/domain.c |  5 +++++
 drivers/base/power/main.c   | 44 +++++++++++++++++++++++++-------------------
 drivers/base/power/power.h  |  6 ++++++
 drivers/usb/core/port.c     |  6 ++++++
 drivers/usb/core/usb.c      | 11 ++++++++++-
 include/linux/pm.h          |  1 +
 8 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.4.3
