From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] PM / sysfs: return -EINVAL for bogus strings
Date: Mon, 10 Jul 2017 10:21:40 +0300
Message-ID: <20170710072140.chms22ep35myvvbd@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the current code, if the user accidentally writes a bogus command to
this sysfs file, then we set the latency tolerance to an uninitialized
variable.

Fixes: 2d984ad132a8 ("PM / QoS: Introcuce latency tolerance device PM QoS type")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 185a52581cfa..156ab57bca77 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -272,6 +272,8 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 			value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
 			value = PM_QOS_LATENCY_ANY;
+		else
+			return -EINVAL;
 	}
 	ret = dev_pm_qos_update_user_latency_tolerance(dev, value);
 	return ret < 0 ? ret : n;
