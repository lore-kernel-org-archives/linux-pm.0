From: Hans de Goede <hdegoede@redhat.com>
Subject: Moving forward with the patches for using the bq24190 on x86 systems
Date: Mon, 3 Apr 2017 09:27:03 +0200
Message-ID: <527947b5-948b-1aab-233f-c421bdf317e2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbdDCH1F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 03:27:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi Sebastian, Liam,

I still have 2 patches pending for using the bq24190 on x86 systems,
which I would like to see merged in some form (and if possible in
time for 4.12):

1) The "power: supply: bq24190_charger: Never reset the charger chip" patch.

Sebastian you said you would merge this after letting it sit a bit longer
on the list, unless any problems with it were noticed. I believe Liam
would prefer for this to not get merged as-is. So I see 3 options:

a) Merge as-is (AFAIK no problems with it have been noticed)
b) Add a "no-reset-on-probe" boolean device property which will
make the driver not do a reset on probe (nor on resume)
c) Add a "reset-on-probe" boolean device property and make the
driver only do a reset on probe (and on resume) if this is set

Sebastian, can you please pick one of these 3 options ? Then I
will adjust my patch as necessary and post a new version.


2) The "power: supply: bq24190_charger: Remove battery power_supply device" patch

The problem with this one is that it removes userspace ABI on which
Liam is relying, so this cannot go upstream as is. I think that
for now it is best to add a "disable-battery-power-supply-iface"
boolean device-property (for kernel internal use only, not part
of the DT bindings) and guard the power_supply_register call
for the battery interface with a check for this.

Sebastian, would this work for you ?


Regards,

Hans
