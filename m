From: "Javi Merino" <javi.merino@arm.com>
Subject: [PATCH TRIVIAL] thermal: cpu_cooling: fix typo highjack -> hijack
Date: Wed, 25 Jun 2014 18:11:17 +0100
Message-ID: <1403716277-1351-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55607 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719AbaFYRLq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 13:11:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Javi Merino <javi.merino@arm.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>

Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 84a75f89bf74..1ab0018271c5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -305,7 +305,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling=
_device *cpufreq_device,
  * @event: value showing cpufreq event for which this function invoked.
  * @data: callback-specific data
  *
- * Callback to highjack the notification on cpufreq policy transition.
+ * Callback to hijack the notification on cpufreq policy transition.
  * Every time there is a change in policy, we will intercept and
  * update the cpufreq policy with thermal constraints.
  *
--=20
1.9.1


