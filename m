From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.12-rc4
Date: Sat, 3 Jun 2017 00:43:58 +0200
Message-ID: <CAJZ5v0i=YSDidLqiCW-Axj++BpDZ9wHOiBAgkktM0r9tw7nZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36832 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBWn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2017 18:43:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.12-rc4

with top-most commit bb5710e72c217e5bbdf0969a2fd84f5f5ad7fc2b

 Merge branch 'pm-cpufreq'

on top of commit 5ed02dbb497422bf225783f46e6eadd237d23d6b

 Linux 4.12-rc3

to receive power management fixes for v4.12-rc4.

These fix two bugs in error code paths in the cpufreq core and in
the kirkwood-cpufreq driver.

Specifics:

 - Make cpufreq_register_driver() return an error if the ->init()
   calls fail for all CPUs to prevent non-functional drivers from
   hanging around for no reason (David Arcari).

 - Make kirkwood-cpufreq check the return value of clk_prepare_enable()
   (which may fail) as appropriate (Arvind Yadav).

Thanks!


---------------

Arvind Yadav (1):
      cpufreq: kirkwood-cpufreq:- Handle return value of clk_prepare_enable()

David Arcari (1):
      cpufreq: cpufreq_register_driver() should return -ENODEV if init fails

---------------

 drivers/cpufreq/cpufreq.c          |  1 +
 drivers/cpufreq/kirkwood-cpufreq.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)
