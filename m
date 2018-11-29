From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.20-rc4
Date: Thu, 29 Nov 2018 21:51:44 +0100
Message-ID: <CAJZ5v0hgS2fyWLDyeeGzqyFyeie26KnswNnc=aX3RYoP5Zv7vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc5

with top-most commit 36c3aeb4b48d5b058526d606fde14db4fd7e5e6d

 Merge branch 'opp/fixes-for-4.20' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436

 Linux 4.20-rc4

to receive power management fixes for 4.20-rc5.

These fix two issues in the operating performance points (OPP)
framework.

Specifics:

 - Fix the handling of the "operating-points-v2" property to
   avoid failures if multiple phandles are present in it which
   is legitimate (Viresh Kumar).

 - Drop the unnecessary static initialization of the .owner field in
   the ti_opp_supply_driver structure (YueHaibing).

Thanks!


---------------

Viresh Kumar (1):
      OPP: Fix parsing of multiple phandles in "operating-points-v2" property

YueHaibing (1):
      opp: ti-opp-supply: Fix platform_no_drv_owner.cocci warnings

---------------

 drivers/opp/of.c            | 6 ++----
 drivers/opp/ti-opp-supply.c | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)
