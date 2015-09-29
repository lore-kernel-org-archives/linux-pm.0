From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v5 0/2]
Date: Tue, 29 Sep 2015 14:29:18 +0200
Message-ID: <1443529760-17612-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, martyn.welch-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

this is v5 of an attempt to make it easier for devices to remain in
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

Changes in v5:
- Check for all dev_pm_ops instances associated to a device, updating a
  no_pm_callbacks flag at the times when that could change.

Tomeu Vizoso (2):
  PM / sleep: Go direct_complete if driver has no callbacks
  USB / PM: Allow USB devices to remain runtime-suspended when sleeping

 drivers/base/dd.c           |  3 ++
 drivers/base/power/domain.c |  5 ++++
 drivers/base/power/main.c   | 69 ++++++++++++++++++++++++++++++++-------------
 drivers/base/power/power.h  |  2 ++
 drivers/usb/core/port.c     |  6 ++++
 drivers/usb/core/usb.c      | 11 +++++++-
 include/linux/pm.h          |  1 +
 7 files changed, 77 insertions(+), 20 deletions(-)

-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
