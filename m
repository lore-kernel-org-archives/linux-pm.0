From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 0/3] tools/thermal: tmon: Makefile improvements
Date: Wed, 27 Sep 2017 16:02:34 -0700
Message-ID: <20170927230237.62199-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:57243 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdI0XCt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 19:02:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

This series introduces a number of improvements to tmon's Makefile. The
changes are meant to make it easier to cross-compile tmon on a greater
number of platforms by giving more control to the person performing the
build.

At the same time, sensible defaults are retained so that building tmon
will continue to work without any customizations on platforms on which
it currently builds.

Markus Mayer (3):
  tools/thermal: tmon: use "-fstack-protector" only if supported
  tools/thermal: tmon: allow $(CC) to be defined externally
  tools/thermal: tmon: use $(PKG_CONFIG) instead of hard-coding
    pkg-config

 tools/thermal/tmon/Makefile | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.7.4
