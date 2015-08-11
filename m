From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Tue, 11 Aug 2015 07:55:46 +0530
Message-ID: <20150811022546.GL5766@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C9425B.4060207@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10-08-15, 17:31, Stephen Boyd wrote:
> So ret is 0. I thought it was an error path, but I guess this is a
> warning path and we return 0 still?

Urg ..

-------------------------8<-------------------------

Message-Id: <d0e8a9cd6b0fb38fa946cb6274f258d7aa66c00e.1439259818.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 4 Aug 2015 11:57:36 +0530
Subject: [PATCH] PM / OPP: restructure _of_init_opp_table_v2()

'dev_opp' will always be NULL in _of_init_opp_table_v2() after creating
OPPs for a device. There is no point comparing it against NULL there.

Restructure code a bit to make it more efficient.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1daaa1a418a2..f42e098b71fe 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1295,20 +1295,21 @@ static int _of_init_opp_table_v2(struct device *dev,
 	if (WARN_ON(!count))
 		goto out;
 
-	if (!ret) {
-		if (!dev_opp) {
-			dev_opp = _find_device_opp(dev);
-			if (WARN_ON(!dev_opp))
-				goto out;
-		}
-
-		dev_opp->np = opp_np;
-		dev_opp->shared_opp = of_property_read_bool(opp_np,
-							    "opp-shared");
-	} else {
+	if (ret) {
 		of_free_opp_table(dev);
+		goto out;
 	}
 
+	dev_opp = _find_device_opp(dev);
+	if (WARN_ON(!dev_opp)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev_opp->np = opp_np;
+	dev_opp->shared_opp = of_property_read_bool(opp_np,
+			"opp-shared");
+
 out:
 	return ret;
 }
