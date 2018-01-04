From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:build-test 15/15] drivers/base/power/domain.c:1053:2-35: code
 aligned with following code on line 1054 (fwd)
Date: Thu, 4 Jan 2018 15:27:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801041526490.3077@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, devel@acpica.org, linux-acpi@vger.kernel.org, kbuild-all@01.org
List-Id: linux-pm@vger.kernel.org

An open brace seems to be missing on line 1052.

julia

---------- Forwarded message ----------
Date: Thu, 4 Jan 2018 22:20:55 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:build-test 15/15] drivers/base/power/domain.c:1053:2-35: code
    aligned with following code on line 1054

CC: kbuild-all@01.org
CC: linux-acpi@vger.kernel.org
CC: devel@acpica.org
CC: linux-pm@vger.kernel.org
TO: "Rafael J. Wysocki" <rjw@rjwysocki.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git build-test
head:   3fd9789833d2e4a4a10ec7cf20b762290ed50b62
commit: 3fd9789833d2e4a4a10ec7cf20b762290ed50b62 [15/15] PM / genpd: Stop/start devices without pm_runtime_force_suspend/resume()
:::::: branch date: 71 minutes ago
:::::: commit date: 71 minutes ago

>> drivers/base/power/domain.c:1053:2-35: code aligned with following code on line 1054

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=3fd9789833d2e4a4a10ec7cf20b762290ed50b62
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout 3fd9789833d2e4a4a10ec7cf20b762290ed50b62
vim +1053 drivers/base/power/domain.c

596ba34b Rafael J. Wysocki  2011-07-01  1022
596ba34b Rafael J. Wysocki  2011-07-01  1023  /**
10da6542 Mikko Perttunen    2017-06-22  1024   * genpd_finish_suspend - Completion of suspend or hibernation of device in an
10da6542 Mikko Perttunen    2017-06-22  1025   *   I/O pm domain.
0496c8ae Rafael J. Wysocki  2012-01-29  1026   * @dev: Device to suspend.
10da6542 Mikko Perttunen    2017-06-22  1027   * @poweroff: Specifies if this is a poweroff_noirq or suspend_noirq callback.
0496c8ae Rafael J. Wysocki  2012-01-29  1028   *
0496c8ae Rafael J. Wysocki  2012-01-29  1029   * Stop the device and remove power from the domain if all devices in it have
0496c8ae Rafael J. Wysocki  2012-01-29  1030   * been stopped.
0496c8ae Rafael J. Wysocki  2012-01-29  1031   */
10da6542 Mikko Perttunen    2017-06-22  1032  static int genpd_finish_suspend(struct device *dev, bool poweroff)
0496c8ae Rafael J. Wysocki  2012-01-29  1033  {
0496c8ae Rafael J. Wysocki  2012-01-29  1034  	struct generic_pm_domain *genpd;
122a2237 Ulf Hansson        2016-05-30  1035  	int ret;
0496c8ae Rafael J. Wysocki  2012-01-29  1036
0496c8ae Rafael J. Wysocki  2012-01-29  1037  	genpd = dev_to_genpd(dev);
0496c8ae Rafael J. Wysocki  2012-01-29  1038  	if (IS_ERR(genpd))
0496c8ae Rafael J. Wysocki  2012-01-29  1039  		return -EINVAL;
596ba34b Rafael J. Wysocki  2011-07-01  1040
d0af45f1 Geert Uytterhoeven 2017-11-07  1041  	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
d4f2d87a Rafael J. Wysocki  2011-07-01  1042  		return 0;
d4f2d87a Rafael J. Wysocki  2011-07-01  1043
10da6542 Mikko Perttunen    2017-06-22  1044  	if (poweroff)
10da6542 Mikko Perttunen    2017-06-22  1045  		ret = pm_generic_poweroff_noirq(dev);
10da6542 Mikko Perttunen    2017-06-22  1046  	else
10da6542 Mikko Perttunen    2017-06-22  1047  		ret = pm_generic_suspend_noirq(dev);
10da6542 Mikko Perttunen    2017-06-22  1048  	if (ret)
10da6542 Mikko Perttunen    2017-06-22  1049  		return ret;
10da6542 Mikko Perttunen    2017-06-22  1050
3fd97898 Rafael J. Wysocki  2018-01-04  1051  	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
3fd97898 Rafael J. Wysocki  2018-01-04  1052  	    !pm_runtime_status_suspended(dev))
3fd97898 Rafael J. Wysocki  2018-01-04 @1053  		ret = genpd_stop_dev(genpd, dev);
122a2237 Ulf Hansson        2016-05-30 @1054  		if (ret)
122a2237 Ulf Hansson        2016-05-30  1055  			return ret;
122a2237 Ulf Hansson        2016-05-30  1056  	}
122a2237 Ulf Hansson        2016-05-30  1057
0883ac03 Ulf Hansson        2017-02-08  1058  	genpd_lock(genpd);
596ba34b Rafael J. Wysocki  2011-07-01  1059  	genpd->suspended_count++;
0883ac03 Ulf Hansson        2017-02-08  1060  	genpd_sync_power_off(genpd, true, 0);
0883ac03 Ulf Hansson        2017-02-08  1061  	genpd_unlock(genpd);
596ba34b Rafael J. Wysocki  2011-07-01  1062
596ba34b Rafael J. Wysocki  2011-07-01  1063  	return 0;
f721889f Rafael J. Wysocki  2011-07-01  1064  }
f721889f Rafael J. Wysocki  2011-07-01  1065

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
