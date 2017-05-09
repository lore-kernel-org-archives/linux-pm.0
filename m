From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 0/2] thermal: power allocator: add new divvy-up algorithm
Date: Tue,  9 May 2017 15:13:54 +0100
Message-ID: <1494339236-22666-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbdEIOOP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 May 2017 10:14:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com

Hi,

This patch set introduces a new algorithm in IPA.
It distributes the power in different way.
In first phase the spare power is splited between the same
type of deveices. In the next phase the rest of the power
is split among all other devices.
More detailed description can be found in first patch.
Second patch adds trace to the algorithm.

Patch set is based on v4.11.

This is a v2, v1 failed on 0-day build test
due to division issue.

Changes:
v2
- change division to div_u64()

Regards,
Lukasz Luba

Lukasz Luba (2):
  thermal: IPA: add new divvy-up algorithm
  trace: power allocator: add trace for divvyup algorithm

 drivers/thermal/power_allocator.c              | 179 +++++++++++++++++++++----
 include/trace/events/thermal_power_allocator.h |  40 ++++++
 2 files changed, 195 insertions(+), 24 deletions(-)

-- 
1.9.1
