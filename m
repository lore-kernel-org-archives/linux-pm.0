From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.19-rc7
Date: Fri, 5 Oct 2018 11:59:09 +0200
Message-ID: <CAJZ5v0jforeFZjY6oTB3e7y_UHyzsixs7PxmW5=O6NQTemAomg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc7

with top-most commit 69e445ab8b66a9f30519842ef18be555d3ee9b51

 PM / core: Clear the direct_complete flag on errors

on top of commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38

 Linux 4.19-rc6

to receive a power management fix for 4.19-rc7.

This fixes a bug that may cause runtime PM to misbehave for some
devices after a failing or aborted system suspend which is nasty
enough for an -rc7 time frame fix.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

---------------

 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
