From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] OMAPDSS: hdmi: Remove __exit qualifier from hdmi_uninit_output()
Date: Tue, 2 Dec 2014 18:12:50 +0200
Message-ID: <1417536771-12907-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38027 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbaLBQNB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Dec 2014 11:13:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, pavel@ucw.cz, t-kristo@ti.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Remove __exit qualifier from hdmi_uninit_output() because it is used
also in omapdss_hdmihw_probe().

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi5.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index e76cc5f..f1a02bf 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -510,7 +510,7 @@ static void hdmi_init_output(struct platform_device *pdev)
 	omapdss_register_output(out);
 }
 
-static void __exit hdmi_uninit_output(struct platform_device *pdev)
+static void hdmi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index cbfb282..d9d0d78 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -538,7 +538,7 @@ static void hdmi_init_output(struct platform_device *pdev)
 	omapdss_register_output(out);
 }
 
-static void __exit hdmi_uninit_output(struct platform_device *pdev)
+static void hdmi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
 
-- 
1.7.9.5

