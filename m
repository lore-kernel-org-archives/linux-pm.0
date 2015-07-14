From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:bleeding-edge 10/17] kernel/power/snapshot.c:928:5: sparse:
 symbol 'swsusp_page_is_valid' was not declared. Should it be static?
Date: Tue, 14 Jul 2015 16:23:38 +0800
Message-ID: <201507141612.6eLYehfL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   4835ff4dabfa392ba9f10218231ea8b6972d9459
commit: d09d85e88f60a6e4d9f8159556f024bd588f11f0 [10/17] PM / hibernate: make sure each resuming page is in current memory zones
reproduce:
  # apt-get install sparse
  git checkout d09d85e88f60a6e4d9f8159556f024bd588f11f0
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> kernel/power/snapshot.c:928:5: sparse: symbol 'swsusp_page_is_valid' was not declared. Should it be static?
   kernel/power/snapshot.c:1354:14: sparse: symbol 'alloc_normal' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
