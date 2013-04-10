From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/2] MAINTAINERS: Add Thermal subsystem co-maintainer
Date: Wed, 10 Apr 2013 10:44:08 -0400
Message-ID: <1365605049-22635-2-git-send-email-eduardo.valentin@ti.com>
References: <1365605049-22635-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51312 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760120Ab3DJOo6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 10:44:58 -0400
In-Reply-To: <1365605049-22635-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Adding myself as co-maintainer for the thermal subsystem.

The agreed work split will be so that as a co-maintainer
I will be taking care of platform thermal drivers, non-ACPI
thermal drivers and making sure the thermal framework core
code will continue to suffice the non-ACPI thermal needs.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 836a618..0850f21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7899,6 +7899,7 @@ F:	arch/xtensa/
 
 THERMAL
 M:      Zhang Rui <rui.zhang@intel.com>
+M:      Eduardo Valentin <eduardo.valentin@ti.com>
 L:      linux-pm@vger.kernel.org
 T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
 S:      Supported
-- 
1.7.7.1.488.ge8e1c

