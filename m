From: tuukka.tikkanen@linaro.org
Subject: [PATCH 0/8] Cpuidle: Menu governor fixes
Date: Wed, 14 Aug 2013 19:02:33 +0300
Message-ID: <cover.1376487596.git.tuukka.tikkanen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: private-pmwg@linaro.org, linux-kernel@vger.kernel.org, Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>

This series of patches fixes some bugs, style issues and wild use of
variable types in cpuidle menu governor. One of the bugs is a logic
flaw where a detected previously recurring pattern is given priority
over known guaranteed earlier wakeup. The others involve value
overflows.

Tuukka Tikkanen (8):
  Cpuidle: Ignore interval prediction result when timer is shorter
  Cpuidle: Rearrange code and comments in get_typical_interval()
  Cpuidle: Check called function parameter in get_typical_interval()
  Cpuidle: CodingStyle: Break up multiple assignments on single line
  Cpuidle: Fix menu_device->intervals type
  Cpuidle: Fix variable domains in get_typical_interval()
  Cpuidle: Add a comment warning about possible overflow
  Cpuidle: Change struct menu_device field types

 drivers/cpuidle/governors/menu.c |   96 ++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 31 deletions(-)

-- 
1.7.9.5
