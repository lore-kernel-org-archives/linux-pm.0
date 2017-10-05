From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.14-rc4
Date: Fri, 6 Oct 2017 00:45:19 +0200
Message-ID: <CAJZ5v0hBid3HBLuD_mK+wJ8dOpCAwF0oVkwS8kF__ErvL7HhRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc4

with top-most commit ca935f8e769c3e36e1b6339cc527a25c49f4d624

 Merge branch 'pm-sleep'

on top of commit 9e66317d3c92ddaab330c125dfe9d06eee268aff

 Linux 4.14-rc3

to receive a power management fix for v4.14-rc4.

This fixes a code ordering issue in the main suspend-to-idle loop
that causes some "low power S0 idle" conditions to be incorrectly
reported as unmet with suspend/resume debug messages enabled.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / s2idle: Invoke the ->wake() platform callback earlier

---------------

 kernel/power/suspend.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
