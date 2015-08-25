From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH v1 0/3] thermal: iio bindings
Date: Tue, 25 Aug 2015 12:58:29 -0700
Message-ID: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

v1
- Change commit message to be more clear
- Split in three patches (First for thermal_iio.c, second to integrate
to thermal_core and third for user space governor).
- Removed IIO defines in thermal.h
- Removed direct push to buffers
- Other comments from Jonathan except introduce validate_trigger

v0
Base version for first review

Srinivas Pandruvada (3):
  thermal: iio device for thermal sensor
  thermal: use iio binding calls
  thermal: user space governor: Notification for IIO bindings

 drivers/thermal/Kconfig        |  11 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_core.c |   9 +-
 drivers/thermal/thermal_iio.c  | 341 +++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/user_space.c   |   1 +
 include/linux/thermal.h        |  31 ++++
 6 files changed, 392 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/thermal_iio.c

-- 
2.4.3
