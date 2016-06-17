From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2] intel_idle updates
Date: Fri, 17 Jun 2016 01:28:32 -0400
Message-ID: <20160617052834.26064-1-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34475 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbcFQF3K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 01:29:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Rafael,

Since you've already pulled Dave's intel-family.h intel_idle changes
into your tree, please also apply these intel_idle patches to that branch.  

[PATCH 1/2] drivers/idle: make intel_idle.c driver more explicitly
[PATCH 2/2] idle_intel: Add Denverton

And if you prefer to use git...

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git cpuidle

for you to fetch changes up to 264f6eef366c0669cf9c8b1850977e13be85160a:

  idle_intel: Add Denverton (2016-06-16 21:05:24 -0400)

----------------------------------------------------------------
Jacob Pan (1):
      idle_intel: Add Denverton

Paul Gortmaker (1):
      drivers/idle: make intel_idle.c driver more explicitly non-modular

 drivers/idle/intel_idle.c | 76 +++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 33 deletions(-)


thanks!
-Len

