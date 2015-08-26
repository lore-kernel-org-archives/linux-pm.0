From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v4 0/5] Let the power allocator thermal governor run on any thermal zone
Date: Wed, 26 Aug 2015 14:26:39 +0100
Message-ID: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45117 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbHZN1P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 09:27:15 -0400
In-Reply-To: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>

Relax the thermal governor requirements of sustainable_power and at
least two trip points so that it can be bound to any thermal zone.
Its behavior won't be optimal, it would be the best it can with the
data provided.

Changes since v3:
   - Don't hardcode a value for sustainable power and re-estimate
     the PID controllers every time if no sustainable power is given
     as suggested by Eduardo Valentin.
   - power_actor_get_min_power() moved to a patch of its own.

Changes since v2:
  - Typos suggested by Daniel Kurtz

Changes since v1:
  - Let the power allocator governor operate if the thermal zone
    doesn't have tzp as suggested by Chung-yih Wang

Javi Merino (5):
  thermal: Add a function to get the minimum power
  thermal: power_allocator: relax the requirement of a sustainable_power
    in tzp
  thermal: power_allocator: relax the requirement of two passive trip   
     points
  thermal: power_allocator: don't require tzp to be present for the
    thermal zone
  thermal: power_allocator: exit early if there are no cooling devices

 Documentation/thermal/power_allocator.txt |   2 +-
 drivers/thermal/power_allocator.c         | 241 ++++++++++++++++++++++--------
 drivers/thermal/thermal_core.c            |  28 ++++
 include/linux/thermal.h                   |   6 +
 4 files changed, 212 insertions(+), 65 deletions(-)

-- 
1.9.1

