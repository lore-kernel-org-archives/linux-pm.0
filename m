From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:bleeding-edge 79/97] drivers/acpi/acpi_lpss.c:810:2-33: code
 aligned with following code on line 812 (fwd)
Date: Sat, 21 Oct 2017 19:05:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710211905060.2889@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:22568 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932172AbdJURF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2017 13:05:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, devel@acpica.org, linux-acpi@vger.kernel.org, kbuild-all@01.org

It's not really aligned, but there is an extra space before ret in line
812, if you want to bother with it.

julia

---------- Forwarded message ----------
Date: Sun, 22 Oct 2017 01:00:32 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:bleeding-edge 79/97] drivers/acpi/acpi_lpss.c:810:2-33: code
    aligned with following code on line 812

CC: kbuild-all@01.org
CC: linux-acpi@vger.kernel.org
CC: devel@acpica.org
CC: linux-pm@vger.kernel.org
TO: "Rafael J. Wysocki" <rjw@rjwysocki.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   1e8b75402e66ed7b5abd6092e541b97aed5e296e
commit: a1faf87f800227d53150e4ac776d2106c19d176c [79/97] ACPI / LPSS: Consolidate runtime PM and system sleep handling
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

>> drivers/acpi/acpi_lpss.c:810:2-33: code aligned with following code on line 812

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=a1faf87f800227d53150e4ac776d2106c19d176c
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout a1faf87f800227d53150e4ac776d2106c19d176c
vim +810 drivers/acpi/acpi_lpss.c

eebb3e8d Andy Shevchenko   2015-12-12  803
a1faf87f Rafael J. Wysocki 2017-10-16  804  static int acpi_lpss_suspend(struct device *dev, bool wakeup)
c78b0830 Heikki Krogerus   2014-05-23  805  {
cb39dcdd Andy Shevchenko   2014-11-05  806  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
cb39dcdd Andy Shevchenko   2014-11-05  807  	int ret;
c78b0830 Heikki Krogerus   2014-05-23  808
cb39dcdd Andy Shevchenko   2014-11-05  809  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
cb39dcdd Andy Shevchenko   2014-11-05 @810  		acpi_lpss_save_ctx(dev, pdata);
cb39dcdd Andy Shevchenko   2014-11-05  811
a1faf87f Rafael J. Wysocki 2017-10-16 @812  	 ret = acpi_dev_suspend(dev, wakeup);
eebb3e8d Andy Shevchenko   2015-12-12  813
eebb3e8d Andy Shevchenko   2015-12-12  814  	/*
eebb3e8d Andy Shevchenko   2015-12-12  815  	 * This call must be last in the sequence, otherwise PMC will return
eebb3e8d Andy Shevchenko   2015-12-12  816  	 * wrong status for devices being about to be powered off. See
eebb3e8d Andy Shevchenko   2015-12-12  817  	 * lpss_iosf_enter_d3_state() for further information.
eebb3e8d Andy Shevchenko   2015-12-12  818  	 */
eebb3e8d Andy Shevchenko   2015-12-12  819  	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
eebb3e8d Andy Shevchenko   2015-12-12  820  		lpss_iosf_enter_d3_state();
eebb3e8d Andy Shevchenko   2015-12-12  821
eebb3e8d Andy Shevchenko   2015-12-12  822  	return ret;
c78b0830 Heikki Krogerus   2014-05-23  823  }
c78b0830 Heikki Krogerus   2014-05-23  824

:::::: The code at line 810 was first introduced by commit
:::::: cb39dcdd4ef6a31028ecd663768b99e6230d3ee6 ACPI / LPSS: add all LPSS devices to the specific power domain

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
