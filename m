From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.15-rc3
Date: Thu, 7 Dec 2017 18:22:05 +0100
Message-ID: <CAJZ5v0gnYLWkoiZ6hq1f4K1t6ZtcP3gXiJ2pBH0YVCs=BvSDKA@mail.gmail.com>
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
 pm-4.15-rc3

with top-most commit 31eb7431805493e10f4731f366cf4d4e3e952035

 PM / runtime: Fix handling of suppliers with disabled runtime PM

on top of commit ae64f9bd1d3621b5e60d7363bc20afb46aede215

 Linux 4.15-rc2

to receive a power management fix for 4.15-rc3.

This fixes an issue in the device runtime PM framework that prevents
customer devices from resuming if runtime PM is disabled for one or
more of their supplier devices (as reflected by device links between
those devices).

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / runtime: Fix handling of suppliers with disabled runtime PM

---------------

 drivers/base/power/runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
