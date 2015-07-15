From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 0/3]
Date: Wed, 15 Jul 2015 14:40:05 +0200
Message-ID: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

this is v4 of an attempt to make easier for devices to remain in runtime
PM when the system ges to sleep, mainly to reduce the time spent
resuming devices.

In this version there's a patch from Alan that relaxes the conditions
that allow a device to go directly to the complete phase, thus allowing
its ancestors to do the same.

Also, we interpret the absence of all PM callback implementations as
being safe to do direct_complete as well.

With these changes, a uvcvideo device (for example) stays in runtime
suspend when the system goes to sleep and is left in that state when the
system resumes, not delaying it unnecessarily.

Thanks,

Tomeu


Alan Stern (1):
  PM / sleep: Allow devices without runtime PM to do direct-complete

Tomeu Vizoso (2):
  PM / sleep: Go direct_complete if driver has no callbacks
  USB / PM: Allow USB devices to remain runtime-suspended when sleeping

 Documentation/power/devices.txt    |  7 +++++++
 Documentation/power/runtime_pm.txt |  4 ----
 drivers/base/power/main.c          | 19 ++++++++++++++++++-
 drivers/usb/core/port.c            |  6 ++++++
 drivers/usb/core/usb.c             | 11 ++++++++++-
 include/linux/pm_runtime.h         |  6 ------
 6 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.4.3
