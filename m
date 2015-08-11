From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v2 0/4] Let the power allocator thermal governor run on any thermal zone
Date: Tue, 11 Aug 2015 11:21:29 +0100
Message-ID: <1439288493-19740-1-git-send-email-javi.merino@arm.com>
References: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52982 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934022AbbHKKVv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Aug 2015 06:21:51 -0400
In-Reply-To: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>

Relax the thermal governor requirements of sustainable_power and at
least two trip points so that it can be bound to any thermal zone.
Its behavior won't be optimal, it would be the best it can with the
data provided.

Changes since v1:
  - Let the power allocator governor operate if the thermal zone
    doesn't have tzp as suggested by Chung-yih Wang

Javi Merino (4):
  thermal: power_allocator: relax the requirement of a sustainable_power
    in tzp
  thermal: power_allocator: relax the requirement of two passive trip   
     points
  thermal: power_allocator: don't require tzp to be present for the
    thermal zone
  thermal: power_allocator: exit early if there are no cooling devices

 Documentation/thermal/power_allocator.txt |   2 +-
 drivers/thermal/power_allocator.c         | 178 ++++++++++++++++++++++--------
 drivers/thermal/thermal_core.c            |  28 +++++
 include/linux/thermal.h                   |   6 +
 4 files changed, 165 insertions(+), 49 deletions(-)

-- 
1.9.1

