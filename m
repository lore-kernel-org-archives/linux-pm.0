From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 0/2] Allow OF created trip points to be writablee
Date: Tue,  3 Mar 2015 10:43:02 +0000
Message-ID: <1425379384-17000-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:39075 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754819AbbCCKms (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 05:42:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Punit Agrawal <punit.agrawal@arm.com>

Hi Eduardo,

I am re-sending the patch to enable writable-trips when using OF
thermal along with the Kconfig change to allow disabling updatable
trip points in the config.

The first patch adds a Kconfig option to disable writable trip
points. The Kconfig option overrides the preference specified at
thermal zone registration and should be enabled for trips to be
writable.

The second patch defaults OF defined trip points to be writable. This
is useful for system tuning, but also for production systems having a
userspace component that can adjust trip points at runtime.

The requirement of root privileges to update trip points is not
affected by these patches.

All comments welcome.

Cheers,
Punit

Punit Agrawal (2):
  thermal: Default OF created trip points to writable
  thermal: core: Add Kconfig option to enable writable trips

 drivers/thermal/Kconfig        | 11 +++++++++++
 drivers/thermal/of-thermal.c   |  6 +++++-
 drivers/thermal/thermal_core.c |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.1.4

