From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.17-rc7
Date: Thu, 24 May 2018 12:09:40 +0200
Message-ID: <CAJZ5v0jEH2=cAh9EGZmOq-XvdKgZB9wUruFdKDKLYzotm+7KTg@mail.gmail.com>
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
 pm-4.17-rc7

with top-most commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3

 PM / core: Fix direct_complete handling for devices with no callbacks

on top of commit 771c577c23bac90597c685971d7297ea00f99d11

 Linux 4.17-rc6

to receive a power management fix for 4.17-rc7.

This fixes a regression from the 4.15 cycle that caused the system
suspend and resume overhead to increase on many systems and triggered
more serious problems on some of them (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / core: Fix direct_complete handling for devices with no callbacks

---------------

 drivers/base/power/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
