From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 7/8] PM / devfreq: tegra: Enable interrupts after resuming the devfreq monitor
Date: Tue, 17 Mar 2015 10:36:17 +0100
Message-ID: <1426584991-11110-8-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/devfreq/tegra-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 23be954..0d1edd5 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -577,8 +577,8 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		tegra_actmon_enable_interrupts(tegra);
 		devfreq_monitor_start(devfreq);
+		tegra_actmon_enable_interrupts(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -592,8 +592,8 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		break;
 
 	case DEVFREQ_GOV_RESUME:
-		tegra_actmon_enable_interrupts(tegra);
 		devfreq_monitor_resume(devfreq);
+		tegra_actmon_enable_interrupts(tegra);
 		break;
 	}
 
-- 
2.1.0
