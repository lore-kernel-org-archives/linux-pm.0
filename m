From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 0/6] BQ24190 charger fixes
Date: Mon, 16 Jan 2017 18:28:28 -0800
Message-ID: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35065 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdAQC23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 21:28:29 -0500
Received: by mail-io0-f194.google.com with SMTP id m98so14436401iod.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 18:28:29 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

These are misc fixes, tested on a custom OMAP3 board.

Changes in v3

#1 fixes figure ID to 37
#5 fixes line over 80 chars
#* adds Acked-by Tony & Mark

Changes in v2

#1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
#2 factors out part of: Call power_supply_changed() only for relevant component
#3 replaces:            Call enable_irq() only at the end of probe()
#4 reorders:            Call power_supply_changed() only for relevant component
#5 unscrambles:         Don't read fault register outside irq_handle_thread()
#6 factors out part of: Don't read fault register outside irq_handle_thread()

These are dropped; Tony will resubmit them in new patchset:
  Check the interrupt status on resume
  Use PM runtime autosuspend

Initial patchset v1

Mark, I missed Tony's 0/6 preamble last time. It was...

Liam Breck (4):
  power: bq24190_charger: Call enable_irq() only at the end of probe()
  power: bq24190_charger: Fix irq triggering to IRQF_TRIGGER_FALLING
  power: bq24190_charger: Call power_supply_changed() only for
relevant component
  power: bq24190_charger: Don't read fault register outside irq_handle_thread()

Tony Lindgren (2):
  power: bq24190_charger: Check the interrupt status on resume
  power: bq24190_charger: Use PM runtime autosuspend
