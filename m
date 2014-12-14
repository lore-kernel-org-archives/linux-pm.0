From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/2] Properly fix sysfs_get_idlestate_count()
Date: Sun, 14 Dec 2014 09:06:36 -0500
Message-ID: <1418565998-3701-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbaLNOGs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Dec 2014 09:06:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

My previous commit 16b7c275c055 ("tools: cpupower: fix return checks for
sysfs_get_idlestate_count()") was not correct.  After looking
at the changelog for cpupower I noticed that Thomas had changed the return of
sysfs_get_idlestate_count() to an unsigned int to simplify the code.  The
problem is really that both he (in his original change) and I (in my new
change) missed the obvious that sysfs_get_idlestate_count()
can't return -ENODEV.  It should just return 0 for "no c-states".

Patch 1 reverts my recent change and patch 2 fixes the problem correctly.

Sorry 'bout that Thomas.  I should have caught that the the first time.

Cc: Thomas Renninger <trenn@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Prarit Bhargava (2):
  Revert "tools: cpupower: fix return checks for
    sysfs_get_idlestate_count()"
  Fix no idle state information return value

 tools/power/cpupower/utils/cpuidle-info.c  |    8 ++++----
 tools/power/cpupower/utils/helpers/sysfs.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.9.3

