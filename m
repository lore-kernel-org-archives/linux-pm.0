From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.17-rc2
Date: Fri, 20 Apr 2018 09:18:35 -0700
Message-ID: <20180420161834.GA22776@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Here are a couple of fixes on thermal subsystem.
Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.17-rc2 with top-most

e04907dbc25930b88ee2328fe692c776f63ddf2c:

  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties (2018-04-18 07:04:28 -0700)

on top of commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

BR,

Eduardo Valentin

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      dt-bindings: thermal: remove no longer needed samsung thermal properties

Viresh Kumar (1):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

 .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-----------------
 .../devicetree/bindings/thermal/thermal.txt        | 16 +--------------
 2 files changed, 6 insertions(+), 33 deletions(-)
