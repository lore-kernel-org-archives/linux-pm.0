From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.20-rc6
Date: Wed, 5 Dec 2018 12:53:50 +0100
Message-ID: <CAJZ5v0jCSFiK1mij3ChgxCs04kpFxPjr+u=WKNCFYeY5mUWv4w@mail.gmail.com>
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
 pm-4.20-rc6

with top-most commit a72173ecfc6774cf2d55de9fb29421ce69e3428c

 Revert "exec: make de_thread() freezable"

on top of commit 2595646791c319cadfdbf271563aac97d0843dc7

 Linux 4.20-rc5

to receive a power management fix for 4.20-rc6.

This reverts a problematic recent commit that attempted to
fix a system-wide suspend issue related to the freezer.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "exec: make de_thread() freezable"

---------------

 fs/exec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
