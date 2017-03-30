From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Do nothing in system suspend/resume when RT suspended
Date: Thu, 30 Mar 2017 15:04:44 +0300
Message-ID: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

There is possibility to enter dw_i2c_plat_suspend() callback twice
during system suspend under certain cases which is causing here warnings
from clk_core_disable() and clk_core_unprepare() as well as accessing the
registers that can be power gated.

Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
system suspend") implemented a prepare callback that checks for runtime
suspended device which allow PM core to set direct_complete flag and
skip system suspend and resume callbacks.

However it can still happen if nothing resumes the device prior system
syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
unsets the direct_complete flag of the parent in __device_suspend() thus
causing PM code to not skip the system suspend/resume callbacks.

Avoid this by checking runtime status in suspend and resume callbacks
and return directly if device is runtime suspended. This affects only
system suspend/resume since during runtime suspend/resume runtime status
is suspending (not suspended) or resuming.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I'm able to trigger system suspend callback while device is runtime
suspended by removing the pm_runtime_resume() call from
drivers/mfd/intel-lpss.c: resume_lpss_device() and having unbound I2C
slave (ACPI enumerated but doesn't bind due an error in probe function).
In that case __device_suspend() for that unbound device has NULL suspend
callback, and thus doesn't cause any runtime resume chain but still unsets
the parent's direct_complete flag.
John Stult <john.stultz@linaro.org> has reported he can trigger this on
HiKey board too.

I'm not sure is this the right thing to do. It feels something the PM core
should do but I'm not sure that either. One alternative could be to resume
runtime suspended parent in in __device_suspend() right after where
parent's direct_complete flag is unset.
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index a597ba32de7e..42a9cd09aa64 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -377,6 +377,9 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	i2c_dw_disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
@@ -388,6 +391,9 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	i2c_dw_plat_prepare_clk(i_dev, true);
 	i2c_dw_init(i_dev);
 
-- 
2.11.0
