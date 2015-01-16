From: kbuild test robot <fengguang.wu@intel.com>
Subject: [vireshk:cpufreq/core/locking 57/60]
 drivers/cpufreq/cpufreq.c:512:5: sparse: symbol '__cpufreq_boost_supported'
 was not declared. Should it be static?
Date: Fri, 16 Jan 2015 14:55:19 +0800
Message-ID: <201501161410.qF6rUO8n%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7877 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbbAPGzc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Jan 2015 01:55:32 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

tree:   https://git.linaro.org/people/vireshk/linux cpufreq/core/locking
head:   12d5339e685739289c2f629c943b8bfad4c64f1e
commit: fbce49b78afdaeeaee3017cfbd968e44ddba8496 [57/60] cpufreq: Drop forward declaration of __cpufreq_boost_trigger_state()
reproduce:
  # apt-get install sparse
  git checkout fbce49b78afdaeeaee3017cfbd968e44ddba8496
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/cpufreq/cpufreq.c:512:5: sparse: symbol '__cpufreq_boost_supported' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
