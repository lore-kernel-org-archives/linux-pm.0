From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 0/8] tools/thermal: tmon: UI and build system improvements
Date: Tue, 17 Feb 2015 18:18:28 -0800
Message-ID: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43899 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbbBRCT2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 21:19:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

This patch set includes a few build system improvements and a few UI fixes.

The last patch is ugly, and personally, I don't care if it's included. But it's
an attempt to kill a warning. Better suggestions are welcome.

Thanks,
Brian

Brian Norris (8):
  tools/thermal: tmon: add --target-temp parameter
  tools/thermal: tmon: add min/max macros
  tools/thermal: tmon: tui: don't hard-code dialog window size
    assumptions
  tools/thermal: tmon: fixup tui windowing calculations
  tools/thermal: tmon: add .gitignore
  tools/thermal: tmon: support cross-compiling
  tools/thermal: tmon: use pkg-config to determine library dependencies
  tools/thermal: tmon: silence 'set but not used' warnings

 tools/thermal/tmon/.gitignore |  1 +
 tools/thermal/tmon/Makefile   | 15 ++++++++++++---
 tools/thermal/tmon/tmon.8     |  2 ++
 tools/thermal/tmon/tmon.c     | 14 ++++++++++++--
 tools/thermal/tmon/tui.c      | 45 ++++++++++++++++++++++++++++++++++---------
 5 files changed, 63 insertions(+), 14 deletions(-)
 create mode 100644 tools/thermal/tmon/.gitignore

-- 
1.9.1

