From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.7 0/10] bq27xxx_battery partial series
Date: Fri, 21 Apr 2017 02:59:52 -0700
Message-ID: <20170421095959.14151-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35445 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037544AbdDUJ7x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 05:59:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id j201so87676646oih.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2017 02:59:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Latest changes (including 12.6):

Only DM update RAM chips by default

Add config_battery_bq27xxx_dt_updates_nvm. If defined, update NVM chips
 and add module param dt_monitored_battery_updates_nvm

Fixed checkpatch errors and most warnings

Switched from -ENOSYS to -PERM, due to checkpatch warning

Add Copyright notice

unseal() returns error on key==0

Skip reset on non-cfgupdate chips if not updated

Emit warning if no dm_regs table

Map orig ID to chip ID via bq27xxx_chips[]

Drop "prototypes" in enum comments

Rename dupes detector bq27xxx_battery_dbg_regs_dupes()

^.^ ^.^ ^.^ - We has hungry for test!
