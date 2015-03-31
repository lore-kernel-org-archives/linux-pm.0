From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 2/6] [media] v4l2-core: Implement dev_pm_ops.prepare()
Date: Tue, 31 Mar 2015 18:14:46 +0200
Message-ID: <1427818501-10201-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Hans Verkuil <hans.verkuil@cisco.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Ramakrishnan Muthukrishnan <ramakrmu@cisco.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Have it return 1 so that video devices that are runtime-suspended won't
be suspended when the system goes to a sleep state. This can make resume
times considerably shorter because these devices don't need to be
resumed when the system is awaken.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/media/v4l2-core/v4l2-dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index e2b8b3e..b74e3d3 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -219,9 +219,19 @@ static void v4l2_device_release(struct device *cd)
 		v4l2_device_put(v4l2_dev);
 }
 
+static int video_device_prepare(struct device *dev)
+{
+	return 1;
+}
+
+static const struct dev_pm_ops video_device_pm_ops = {
+	.prepare = video_device_prepare,
+};
+
 static struct class video_class = {
 	.name = VIDEO_NAME,
 	.dev_groups = video_device_groups,
+	.pm = &video_device_pm_ops,
 };
 
 struct video_device *video_devdata(struct file *file)
-- 
2.3.4
