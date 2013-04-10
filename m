From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/2] MAINTAINERS: update thermal subsystem entry
Date: Wed, 10 Apr 2013 10:44:07 -0400
Message-ID: <1365605049-22635-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51291 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760120Ab3DJOoi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 10:44:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hi Linus, Rui,

I am adding myself as thermal subsystem co-maintainer, as discussed
off line with Rui.

The work split will be so that I will help by taking care of platform
thermal drivers and non-ACPI thermal drivers. I will also help by making
sure we keep the thermal framework core code generic enough to cover
the non-ACPI thermal drivers too.

Rui will continue his current role and will be keeping the tree and sending
out the pull requests. I can of course help there too, whenever there is
a need or when he is off.

I took the opportunity to also add the patchwork entry for the thermal subsystem.

Regards,

Eduardo Valentin (2):
  MAINTAINERS: Add Thermal subsystem co-maintainer
  MAINTAINERS: Add patchwork entry for Thermal subsystem

 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.7.1.488.ge8e1c

