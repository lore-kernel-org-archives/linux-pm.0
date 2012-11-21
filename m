From: kbuild test robot <fengguang.wu@intel.com>
Subject: drivers/devfreq/governor_simpleondemand.c:36:11: error:
 dereferencing pointer to incomplete type
Date: Wed, 21 Nov 2012 09:16:25 +0800
Message-ID: <50ac2b69.6fxtK72fycbqA67j%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1780 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab2KUBRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Nov 2012 20:17:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   aa0745b51987fbaf628ee0943907db177335522d
commit: eff607fdb1f787da1fedf46ab6e64adc2afd1c5a PM / devfreq: governors: add GPL module license and allow module build
date:   16 hours ago
config: make ARCH=x86_64 allmodconfig

All error/warnings:

drivers/devfreq/governor_simpleondemand.c: In function 'devfreq_simple_ondemand_func':
drivers/devfreq/governor_simpleondemand.c:36:11: error: dereferencing pointer to incomplete type
drivers/devfreq/governor_simpleondemand.c:37:27: error: dereferencing pointer to incomplete type
drivers/devfreq/governor_simpleondemand.c:38:11: error: dereferencing pointer to incomplete type
drivers/devfreq/governor_simpleondemand.c:39:32: error: dereferencing pointer to incomplete type

vim +36 drivers/devfreq/governor_simpleondemand.c

6530b9de MyungJoo Ham 2011-12-09  30  	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
ce26c5bb MyungJoo Ham 2011-10-02  31  
ce26c5bb MyungJoo Ham 2011-10-02  32  	if (err)
ce26c5bb MyungJoo Ham 2011-10-02  33  		return err;
ce26c5bb MyungJoo Ham 2011-10-02  34  
ce26c5bb MyungJoo Ham 2011-10-02  35  	if (data) {
ce26c5bb MyungJoo Ham 2011-10-02 @36  		if (data->upthreshold)
ce26c5bb MyungJoo Ham 2011-10-02  37  			dfso_upthreshold = data->upthreshold;
ce26c5bb MyungJoo Ham 2011-10-02  38  		if (data->downdifferential)
ce26c5bb MyungJoo Ham 2011-10-02  39  			dfso_downdifferential = data->downdifferential;

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
