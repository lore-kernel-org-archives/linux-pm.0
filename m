From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sat,  7 Nov 2015 18:50:23 -0800
Message-ID: <1446951024-7621-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Changes from v1:
* add mutex lock in measurement reading function
* add missing pm_runtime_mark_last_busy() call
* use pm_runtime_get_sync() function instead of async version

Matt Ranostay (1):
  iio: pulsedlight-lidar-lite: add runtime PM

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 63 ++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

-- 
1.9.1
