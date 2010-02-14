From: Erik Andren <erik.andren@gmail.com>
Subject: [PATCH 1/1] platform/x86/dell-laptop: Add another Dell
	laptop to the DMI whitelist
Date: Sun, 14 Feb 2010 11:54:57 +0100
Message-ID: <1266144897-2681-1-git-send-email-erik.andren__498.099232982163$1266145132$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mjg@redhat.com
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Erik Andren <erik.andren@gmail.com>
List-Id: linux-pm@vger.kernel.org

The Latitude C640 has another variation of dell in its DMI vendor entry.
Add it to the whitelist in order to enjoy the sweet fruits of software backlight toggling.

Signed-off-by: Erik Andren <erik.andren@gmail.com>
---
 drivers/platform/x86/dell-laptop.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 3780994..b5246f1 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -79,6 +79,13 @@ static const struct dmi_system_id __initdata dell_device_table[] = {
 			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
 		},
 	},
+	{
+		.ident = "Dell Computer Corporation",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
+		},
+	},
 	{ }
 };
 
-- 
1.6.3.3
