From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.9-rc3
Date: Thu, 27 Oct 2016 15:30:29 +0800
Message-ID: <1477553429.2208.28.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbcJ0Hau (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Oct 2016 03:30:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.9-rc3 with
top-most commit fd0d76af878c18bf3a4c60fd14bdbf2a207c0836:

  thermal/powerclamp: correct cpu support check (2016-10-24 10:38:02
+0800)

on top of commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

Specifics:

- Fix a regression introduced by commit b721ca0d19(thermal/powerclamp:
remove cpu whitelist), that powerclamp driver checks cpu support in a
wrong way. From: Eric Ernst.

- Fix a problem that intel_pch_thermal driver misses passive trip point
when the PCH thermal device has an ACPI companion device associated.
From: Srinivas Pandruvada.

- Add missing support for Haswell PCH thermal sensor. From: Srinivas
Pandruvada.

thanks,
rui

----------------------------------------------------------------
Eric Ernst (1):
      thermal/powerclamp: correct cpu support check

Srinivas Pandruvada (2):
      thermal: intel_pch_thermal: Add an ACPI passive trip
      thermal: intel_pch_thermal: Enable Haswell PCH

 drivers/thermal/intel_pch_thermal.c | 60
+++++++++++++++++++++++++++++++++++++
 drivers/thermal/intel_powerclamp.c  | 14 ++-------
 2 files changed, 62 insertions(+), 12 deletions(-)
