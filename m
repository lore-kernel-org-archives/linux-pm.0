From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 3/7] Kconfig: drivers: devfreq: add default idle polling
Date: Tue, 12 Feb 2019 23:23:54 +0100
Message-ID: <1550010238-24002-4-git-send-email-l.luba@partner.samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222433eucas1p264602d67a916c644c7eb5012932fc17a@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds default idle polling value for devfreq devices.
It is used in idle state, when the device is running at lowest frequency.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d3..f0fcc5e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -29,6 +29,19 @@ menuconfig PM_DEVFREQ
 
 if PM_DEVFREQ
 
+config DEVFREQ_DEFAULT_POLLING_IDLE_MS
+	int "Default polling interval in idle state (ms)"
+	default 500
+	help
+	  The devfreq device is being polled by the devfreq framework.
+	  There are two states for the device operation: normal and idle.
+	  Each state has corresponding polling interval.
+	  When a device is not heavily loaded and runs at lowest frequency,
+	  it is in 'idle' state and longer polling interval is used.
+	  This setting controls the idle polling interval.
+	  It is designed to lower for power consumption.
+	  Set this to non-zero if the default value is to big for your system.
+
 comment "DEVFREQ Governors"
 
 config DEVFREQ_GOV_SIMPLE_ONDEMAND
-- 
2.7.4
