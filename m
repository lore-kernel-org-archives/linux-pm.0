From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 0/2] thermal: power allocator: add new divvy-up algorithm
Date: Mon,  8 May 2017 14:40:00 +0100
Message-ID: <1494250802-6663-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdEHNkX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 May 2017 09:40:23 -0400
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

Regards,
Lukasz Luba

Lukasz Luba (2):
  thermal: IPA: add new divvy-up algorithm
  trace: power allocator: add trace for divvyup algorithm

 drivers/thermal/power_allocator.c              | 178 +++++++++++++++++++++----
 include/trace/events/thermal_power_allocator.h |  40 ++++++
 2 files changed, 194 insertions(+), 24 deletions(-)

-- 
1.9.1
