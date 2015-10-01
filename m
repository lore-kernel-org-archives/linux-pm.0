From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] PM / clk: Do not __clk_get passed in clock-references
Date: Thu, 01 Oct 2015 21:05:09 +0200
Message-ID: <4072102.uMAk2BYxyL@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Clock references are on a per-user basis now, so they are not supposed
to be refcounted by itself anymore. Therefore multiple cascaded get and
put calls will fail.

When a clock reference gets passed into pm_clk_add_clk we can assume
that the pm clock handling will take control of the clock reference,
so after this functions returns the caller should've given up control
of that handle.

So remove the additional call to __clk_get() in __pm_clk_add().

The only current user of pm_clk_add_clk is drivers/clk/shmobile/clk-mstp.c
which already follows this paradigm by only getting the clock but not
puting it after passing the reference into pm_clk_add_clk.

In the error case the caller is expected to clean up the clock, as it
may very well try to do something different if pm_clk_add_clk() fails.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
[add commit-message]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Hi Rafael, Pavel,

if that looks acceptable to you, it would be cool if you could ack the
patch and allow me to put it in front of [0] or alternatively
provide a stable-branch I could include.

Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.4-armsoc/drivers

 drivers/base/power/clock_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 652b5a3..6ce7693 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -93,7 +93,7 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 			return -ENOMEM;
 		}
 	} else {
-		if (IS_ERR(clk) || !__clk_get(clk)) {
+		if (IS_ERR(clk)) {
 			kfree(ce);
 			return -ENOENT;
 		}
@@ -127,7 +127,9 @@ int pm_clk_add(struct device *dev, const char *con_id)
  * @clk: Clock pointer
  *
  * Add the clock to the list of clocks used for the power management of @dev.
- * It will increment refcount on clock pointer, use clk_put() on it when done.
+ * The power-management code will take control of the clock reference, so
+ * callers should not call clk_put() on @clk after this function sucessfully
+ * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
 {
-- 
2.5.3
