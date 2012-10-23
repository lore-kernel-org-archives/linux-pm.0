From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/cpuidle/governors/menu.c:268:2: warning: comparison of
 distinct pointer types lacks a cast
Date: Tue, 23 Oct 2012 11:37:10 +0800
Message-ID: <508610e6.lZq8SVXFvwZCcvw6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36680 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab2JWDhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Oct 2012 23:37:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: linux-pm@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi Youquan,

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   13f5e2d9a915373dd1573d8fe0214738bc69004f
commit: 0c963c99eb65aa9991cec6b3ea3188862167c427 cpuidle: Get typical recent sleep interval
date:   4 hours ago
config: sh-sh7785lcr_32bit_defconfig # make ARCH=sh sh7785lcr_32bit_defconfig

All warnings:

drivers/cpuidle/governors/menu.c: In function 'get_typical_interval':
drivers/cpuidle/governors/menu.c:268:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
drivers/cpuidle/governors/menu.c:277:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]

vim +268 drivers/cpuidle/governors/menu.c

0c963c99 Youquan Song     2012-10-23  252  	int64_t thresh = LLONG_MAX; /* Discard outliers above this value. */
0c963c99 Youquan Song     2012-10-23  253  	unsigned int ret = 0;
1f85f87d Arjan van de Ven 2010-05-24  254  
0c963c99 Youquan Song     2012-10-23  255  again:
1f85f87d Arjan van de Ven 2010-05-24  256  
0c963c99 Youquan Song     2012-10-23  257  	/* first calculate average and standard deviation of the past */
0c963c99 Youquan Song     2012-10-23  258  	max = avg = divisor = stddev = 0;
0c963c99 Youquan Song     2012-10-23  259  	for (i = 0; i < INTERVALS; i++) {
0c963c99 Youquan Song     2012-10-23  260  		int64_t value = data->intervals[i];
0c963c99 Youquan Song     2012-10-23  261  		if (value <= thresh) {
0c963c99 Youquan Song     2012-10-23  262  			avg += value;
0c963c99 Youquan Song     2012-10-23  263  			divisor++;
0c963c99 Youquan Song     2012-10-23  264  			if (value > max)
0c963c99 Youquan Song     2012-10-23  265  				max = value;
0c963c99 Youquan Song     2012-10-23  266  		}
0c963c99 Youquan Song     2012-10-23  267  	}
0c963c99 Youquan Song     2012-10-23 @268  	do_div(avg, divisor);
0c963c99 Youquan Song     2012-10-23  269  
0c963c99 Youquan Song     2012-10-23  270  	for (i = 0; i < INTERVALS; i++) {
0c963c99 Youquan Song     2012-10-23  271  		int64_t value = data->intervals[i];
0c963c99 Youquan Song     2012-10-23  272  		if (value <= thresh) {
0c963c99 Youquan Song     2012-10-23  273  			int64_t diff = value - avg;
0c963c99 Youquan Song     2012-10-23  274  			stddev += diff * diff;
0c963c99 Youquan Song     2012-10-23  275  		}
0c963c99 Youquan Song     2012-10-23  276  	}

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
