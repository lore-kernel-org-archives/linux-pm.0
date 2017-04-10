From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.6 0/11] bq27xxx_battery partial series
Date: Sun,  9 Apr 2017 22:07:05 -0700
Message-ID: <20170410050712.930-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35772 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdDJFHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 01:07:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so24237501pge.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2017 22:07:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Latest changes:

New patch to disable updates to flash/NVM. The purpose of this series has always
been to update NVM or RAM via DT. It was Sebastian's idea to site the properties
in a fixed/simple-battery node representing the battery to the fuel gauge (i.e.
your characterization that I "misused" the battery node is mistaken). I relent
only because I've switched from a NVM to RAM gauge. I expect others will succeed
in reverting this. Also, I have no need for a knob which lets userspace trigger
NVM update, so I leave that to others.

Add module param use_monitored_battery to the power_supply_battery_info patch;
it is dropped in the above patch. Allowing users to ignore the DT properties
is the correct solution IMO.

Add Copyright notice

unseal() returns error on key==0

Skip reset on non-cfgupdate chips if not updated

Emit warning if no dm_regs table

Map orig ID to chip ID via bq27xxx_chips[]

Drop "prototypes" in enum comments

Rename dupes detector bq27xxx_battery_dbg_regs_dupes()

^.^ ^.^ - We can has test?
