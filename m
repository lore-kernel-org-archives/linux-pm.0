From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 0/7] BQ24190 charger fixes
Date: Wed, 18 Jan 2017 09:26:47 -0800
Message-ID: <20170118172654.19416-1-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35585 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdARR1i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:27:38 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so1513185pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:27:38 -0800 (PST)
In-Reply-To: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>

Hi Sebastian, thanks for your patience :-)

These are misc bq24190_charger fixes, tested on a custom OMAP3 board.

Changes in v4

#4 factors out whitespace change in "Install irq_handler_thread() at end of probe()"

Note: The other whitespace issue Mark raised is related to the purpose of that patch "Don't read 
fault register outside irq_handle_thread()"

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

Liam Breck (4):
  power: bq24190_charger: Call enable_irq() only at the end of probe()
  power: bq24190_charger: Fix irq triggering to IRQF_TRIGGER_FALLING
  power: bq24190_charger: Call power_supply_changed() only for relevant component
  power: bq24190_charger: Don't read fault register outside irq_handle_thread()

Tony Lindgren (2):
  power: bq24190_charger: Check the interrupt status on resume
  power: bq24190_charger: Use PM runtime autosuspend

