From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL]  Thermal management updates for v4.7-rc3
Date: Sun, 12 Jun 2016 14:08:21 +0800
Message-ID: <1465711701.13475.16.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38942 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbcFLGI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 Jun 2016 02:08:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.7-rc3 with
top-most commit 5a5e78cd706ce0577ed6356634a34552c866cc10:

  thermal: add the note for set_trip_temp (2016-06-01 22:25:48 +0800)

on top of commit 852f42a69b93dc71507adedeed876d57b8c2c2fa:

  Merge branch 'uuid' (lib/uuid fixes from Andy) (2016-05-30 15:27:07
-0700)

Specifics:
- Fix an ordering issue in cpu cooling that cooling device is registered
before it's ready (freq_table being populated). From: Lukasz Luba.
- Fix a missing comment update. From: Caesar Wang.

thanks,
rui

----------------------------------------------------------------
Caesar Wang (1):
      thermal: add the note for set_trip_temp

Lukasz Luba (1):
      thermal: cpu_cooling: fix improper order during initialization

 drivers/thermal/cpu_cooling.c | 16 ++++++++--------
 include/linux/thermal.h       |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)


