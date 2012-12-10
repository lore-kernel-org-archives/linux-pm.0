From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [RESEND PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
Date: Mon, 10 Dec 2012 16:25:37 +0100
Message-ID: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:59257 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186Ab2LJP0P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Dec 2012 10:26:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

This patchset starts by renaming the db8500 cpufreq driver to a more generic
name. There are new variants which rely on it too, so instead we give it a
family name of dbx500.

On top of that a fixup patch for initialization of the driver and some minor
cleanup patches are included as well.

These patches can be material for 3.8.

Since some patches for the db8500 cpufreq driver has recently been merged
through Mike Turquette's clk tree, I decided to base these patches on top
of the clk-next branch. So I hope Mike is fine by merging these patches
through his tree.

So I will try to collect ACKs from Rafael for the cpufreq patches. The
mfd patch has already been ACKED by Samuel.

Jonas Aaberg (1):
  cpufreq: dbx500: Minor code cleanup

Lee Jones (3):
  cpufreq: Give driver used for dbx500 family a more generic name
  mfd: db8500: Update cpufreq device name
  cpufreq: dbx500: Update file header

Ulf Hansson (1):
  cpufreq: dbx500: Move clk_get to probe

 drivers/cpufreq/Makefile         |    2 +-
 drivers/cpufreq/db8500-cpufreq.c |  179 -------------------------------------
 drivers/cpufreq/dbx500-cpufreq.c |  180 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/db8500-prcmu.c       |    4 +-
 4 files changed, 183 insertions(+), 182 deletions(-)
 delete mode 100644 drivers/cpufreq/db8500-cpufreq.c
 create mode 100644 drivers/cpufreq/dbx500-cpufreq.c

-- 
1.7.10

