From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/2] drivers: cpuidle: minor suspend-to-idle fixes
Date: Tue, 24 Feb 2015 17:58:48 +0000
Message-ID: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34420 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752791AbbBXR62 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 12:58:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Rafael, Daniel,

while reviewing CPUidle code I bumped into a couple of leftovers
from the merge window and put together these two patches to try
to "fix" them (I could not trigger any issue, just code inspection),
please let me know what you think.

Thanks,
Lorenzo

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Lorenzo Pieralisi (2):
  drivers: cpuidle: remove stale irq disabling call in
    cpuidle_enter_freeze()
  drivers: cpuidle: add driver/device checks in cpuidle_enter_freeze()

 drivers/cpuidle/cpuidle.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.2.1

