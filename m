From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc5
Date: Sat, 25 Jun 2016 00:49:20 +0200
Message-ID: <CAJZ5v0j3PHXnX+GrgqQcpsUH5rzE8pq7c2JhEHjf_h3YQtYTvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32948 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbcFXWtW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 18:49:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc5

to receive power management fixes for v4.7-rc5 with top-most commit
e753f3050935ff5a52069fef802bee72ab19c098

 Merge branches 'pm-devfreq-fixes' and 'pm-cpufreq-fixes'

on top of commit 33688abb2802ff3a230bd2441f765477b94cc89e

 Linux 4.7-rc4

Fix for a latent cpufreq driver bug uncovered by a recent ACPICA
change and several fixes for the devfreq framework, including one
fix for an issue introduced recently.

Specifics:

 - Fix a latent initialization issue in the pcc-cpufreq driver
   (incorrect initial value of a structure field) that has been
   uncovered by a recent ACPICA commit (Mike Galbraith).

 - Add a missing notification in an update_devfreq() error code
   path forgotten by a recent devfreq commit (Chanwoo Choi).

 - Fix devfreq device frequency initialization (Lukasz Luba).

 - Fix an incorrect IS_ERR() check in the devfreq framework
   discovered by the Smatch checker (Dan Carpenter).

 - Drop two excessive put_device() calls from the devfreq framework
   (MyungJoo Ham, Cai Zhiyong).

 - Fix a possible memory leak in the devfreq framework and drop an
   unnecessary kfree() invocation from it (MyungJoo Ham).

Thanks!

---------------

Cai Zhiyong (1):
      PM / devfreq: fix double call put_device

Chanwoo Choi (1):
      PM / devfreq: Send the DEVFREQ_POSTCHANGE notification when
target() is failed

Dan Carpenter (1):
      PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check

Lukasz Luba (1):
      PM / devfreq: fix initialization of current frequency in last status

Mike Galbraith (1):
      cpufreq: pcc-cpufreq: Fix doorbell.access_width

MyungJoo Ham (3):
      PM / devfreq: devm_kzalloc to have dev pointer more precisely
      PM / devfreq: fix duplicated kfree on devfreq pointer
      PM / devfreq: remove double put_device

---------------

 drivers/cpufreq/pcc-cpufreq.c       |  2 +-
 drivers/devfreq/devfreq.c           | 27 ++++++++++++++-------------
 drivers/devfreq/event/exynos-nocp.c |  3 ---
 3 files changed, 15 insertions(+), 17 deletions(-)
