From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/15] ACPI video: use after
	input_unregister_device()
Date: Mon,  4 Jun 2012 01:40:02 -0400
Message-ID: <301f33fbcf4ced53b3de114846ecece5d6aafeeb.1338786832.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We can't use "input" anymore after calling input_unregister_device().
The call to input_free_device() is a double free.  The normal way to
deal with this is to make input_register_device() the last function
called in the function.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 609262d..a576575 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1687,10 +1687,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
 	set_bit(KEY_DISPLAY_OFF, input->keybit);
 
-	error = input_register_device(input);
-	if (error)
-		goto err_stop_video;
-
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
@@ -1701,12 +1697,16 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	video->pm_nb.priority = 0;
 	error = register_pm_notifier(&video->pm_nb);
 	if (error)
-		goto err_unregister_input_dev;
+		goto err_stop_video;
+
+	error = input_register_device(input);
+	if (error)
+		goto err_unregister_pm_notifier;
 
 	return 0;
 
- err_unregister_input_dev:
-	input_unregister_device(input);
+ err_unregister_pm_notifier:
+	unregister_pm_notifier(&video->pm_nb);
  err_stop_video:
 	acpi_video_bus_stop_devices(video);
  err_free_input_dev:
-- 
1.7.11.rc0.100.g5498c5f
