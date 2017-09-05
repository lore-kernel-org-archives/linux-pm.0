From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] thermal: tegra: remove null check for dev pointer
Date: Tue,  5 Sep 2017 00:41:16 -0700
Message-ID: <1504597276-22924-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The dev pointer is going through a null check after a dereference.
So this patch removes that useless check since the driver does not
pass a null dev pointer in any case.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changelog
v2:
 * By following Thierry's comments, changed to remove the null pointer
   check directly and revised the patch subject according.

 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 7d2db23..075db1d 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -483,7 +483,7 @@ static int throttrip_program(struct device *dev,
 	unsigned int throt;
 	u32 r, reg_off;
 
-	if (!dev || !sg || !stc || !stc->init)
+	if (!sg || !stc || !stc->init)
 		return -EINVAL;
 
 	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
-- 
2.1.4
