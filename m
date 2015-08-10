From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/3] Let the power allocator thermal governor run on any thermal zone
Date: Mon, 10 Aug 2015 17:04:49 +0100
Message-ID: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
References: <20150806083045.GB2640@e104805>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50396 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbHJQFO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Aug 2015 12:05:14 -0400
In-Reply-To: <20150806083045.GB2640@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>

Relax the thermal governor requirements of sustainable_power and at
least two trip points so that it can be bound to any thermal zone.
Its behavior won't be optimal, it would be the best it can with the
data provided.

Javi Merino (3):
  thermal: power_allocator: relax the requirement of a sustainable_power
    in tzp
  thermal: power_allocator: relax the requirement of two passive trip   
     points
  thermal: power_allocator: exit early if there are no cooling devices

 Documentation/thermal/power_allocator.txt |   2 +-
 drivers/thermal/power_allocator.c         | 158 +++++++++++++++++++++---------
 drivers/thermal/thermal_core.c            |  28 ++++++
 include/linux/thermal.h                   |   6 ++
 4 files changed, 144 insertions(+), 50 deletions(-)

-- 
1.9.1

