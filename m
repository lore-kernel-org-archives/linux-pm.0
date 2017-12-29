From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/3] renesas: irqchip: Use WAKEUP_PATH driver PM flag
Date: Fri, 29 Dec 2017 14:31:41 +0100
Message-ID: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43975 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdL2Nbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Dec 2017 08:31:55 -0500
Received: by mail-lf0-f67.google.com with SMTP id o26so33911485lfc.10
        for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2017 05:31:55 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Changes in v2: [By Ulf Hansson]
	- I have picked up the series from Geert [1] and converted it into use
	the WAKEUP_PATH driver PM flag. This includes some minor changes to each
	patch and updates to the changelogs.
	- An important note, the WAKEUP_PATH driver PM flag is introduced in a
	separate series [2], not yet applied, so @subject series depends on it.
	- One more note, two of the patches has a checkpatch error, however I
	did not fix them, becuase I think that should be done separate.

[1]
https://lkml.org/lkml/2017/11/9/382
[2]
https://marc.info/?l=linux-pm&m=151454744124661&w=2

More information below, picked from Geert's previous cover letter.

Kind regards
Uffe


Hi all,

If an interrupt controller in a Renesas ARM SoC is part of a Clock
Domain, and it is part of the wakeup path, it must be kept active during
system suspend.

Currently this is handled in all interrupt controller drivers by
explicitly increasing the use count of the module clock when the device
is part of the wakeup path.  However, this explicit clock handling is
merely a workaround for a failure to properly communicate wakeup
information to the device core.

Hence this series fixes the affected drivers by setting the devices'
power.wakeup_path fields instead, to indicate they are part of the
wakeup path.  Depending on the PM Domain's active_wakeup configuration,
the genpd core code will keep the device enabled (and the clock running)
during system suspend when needed.

Note that most of these patches depend on the series "[PATCH v2 0/3] PM
/ Domain: renesas: Fix active wakeup behavior", hence they should not be
applied yet.

This has been tested on r8a73a4/ape6evm, r8a7740/armadillo,
r8a7791/koelsch, r8a7795/salvator-x and -xs, r8a7796/salvator-x, and
sh73a0/kzm9g.

Thanks for your comments!

Geert Uytterhoeven (3):
  irqchip/renesas-intc-irqpin: Use WAKEUP_PATH driver PM flag
  irqchip/renesas-irqc: Use WAKEUP_PATH driver PM flag
  gpio: rcar: Use WAKEUP_PATH driver PM flag

 drivers/gpio/gpio-rcar.c                  | 40 +++++++++++------------------
 drivers/irqchip/irq-renesas-intc-irqpin.c | 42 +++++++++++--------------------
 drivers/irqchip/irq-renesas-irqc.c        | 32 +++++++++++------------
 3 files changed, 45 insertions(+), 69 deletions(-)

-- 
2.7.4
