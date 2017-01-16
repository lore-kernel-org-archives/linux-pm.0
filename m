From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 0/6] BQ24190 charger fixes
Date: Sun, 15 Jan 2017 22:05:26 -0800
Message-ID: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34867 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdAPGF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 01:05:27 -0500
Received: by mail-io0-f196.google.com with SMTP id m98so11628863iod.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2017 22:05:27 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

Changes in v2:

#1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
#2 factors out part of: Call power_supply_changed() only for relevant component
#3 replaces:            Call enable_irq() only at the end of probe()
#4 reorders:            Call power_supply_changed() only for relevant component
#5 unscrambles:         Don't read fault register outside irq_handle_thread()
#6 factors out part of: Don't read fault register outside irq_handle_thread()

These are dropped; Tony will resubmit them in new patchset:
  Check the interrupt status on resume
  Use PM runtime autosuspend
