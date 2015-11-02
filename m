From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/2] Fixes for devfreq cooling
Date: Mon,  2 Nov 2015 19:03:02 +0000
Message-ID: <1446490984-18438-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52373 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbKBTDT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 14:03:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, orjan.eide@arm.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>

When devfreq cooling entered Eduardo's tree, the kbuild test robot
spotted a compilation warning on sh.  Also, the first patch aligns the
return type and the parameters of the devfreq register/unregister with
those of the cpu cooling device.

This patches apply on top of eduardo/next.

Javi Merino (2):
  thermal: devfreq_cooling: use a thermal_cooling_device for register
    and unregister
  thermal: devfreq_cooling: Make power a u64

 drivers/thermal/devfreq_cooling.c | 18 +++++++++++-------
 include/linux/devfreq_cooling.h   | 16 ++++++++--------
 2 files changed, 19 insertions(+), 15 deletions(-)

-- 
1.9.1

