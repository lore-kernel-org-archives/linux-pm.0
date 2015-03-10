From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 0/2] Add support for generic register mapped poweroff.
Date: Tue, 10 Mar 2015 16:21:08 -0700
Message-ID: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:39061 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbCJXVo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 19:21:44 -0400
Received: by pdbft15 with SMTP id ft15so5997839pdb.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2015 16:21:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

This patchset adds support for generic register mapped poweroff via SYCON.

Earlier versions of this were specific to our product, however,
as Sebastian suggested, it can be generalized into a generic driver.

If an entry in the MAINTAINERS file is required I can resend a corrected version.

Moritz Fischer (2):
  power: reset: Add generic SYSCON register mapped poweroff.
  dt: power: Add docs for generic SYSCON poweroff driver.

 .../bindings/power/reset/syscon-poweroff.txt       | 23 +++++
 drivers/power/reset/Kconfig                        |  7 ++
 drivers/power/reset/Makefile                       |  1 +
 drivers/power/reset/syscon-poweroff.c              | 97 ++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
 create mode 100644 drivers/power/reset/syscon-poweroff.c

-- 
1.9.3

