From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCHv2 0/2] Add support for generic register mapped poweroff.
Date: Wed, 11 Mar 2015 15:32:23 -0700
Message-ID: <1426113145-2921-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43157 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbCKWcq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 18:32:46 -0400
Received: by pdjp10 with SMTP id p10so14613622pdj.10
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2015 15:32:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

This patchset adds support for generic register mapped poweroff via SYCON.

v2:
 - Fixed documentation copy & paste
 - Deal with OF dependecies as suggested by Sebastian
 - Remove module specific stuff as suggested by Paul

v1:
 - Earlier versions of this were specific to our product, however,
   as Sebastian suggested, it can be generalized into a generic driver.

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

