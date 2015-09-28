From: Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] thermal: avoid division by zero in power allocator
Date: Mon, 28 Sep 2015 23:28:34 +0200
Message-ID: <1443475714-19871-2-git-send-email-aarcange@redhat.com>
References: <1443475714-19871-1-git-send-email-aarcange@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443475714-19871-1-git-send-email-aarcange@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-pm@vger.kernel.org

During boot I get a div by zero Oops regression starting in v4.3-rc3.

Reviewed-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 drivers/thermal/power_allocator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 7ff9627..e570ff0 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -144,6 +144,16 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 		switch_on_temp = 0;
 
 	temperature_threshold = control_temp - switch_on_temp;
+	/*
+	 * estimate_pid_constants() tries to find appropriate default
+	 * values for thermal zones that don't provide them. If a
+	 * system integrator has configured a thermal zone with two
+	 * passive trip points at the same temperature, that person
+	 * hasn't put any effort to set up the thermal zone properly
+	 * so just give up.
+	 */
+	if (!temperature_threshold)
+		return;
 
 	if (!tz->tzp->k_po || force)
 		tz->tzp->k_po = int_to_frac(sustainable_power) /
