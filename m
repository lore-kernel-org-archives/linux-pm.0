From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/7] power: supply: bq24190_charger: Various fixes + extcon support
Date: Wed, 22 Mar 2017 15:55:29 +0100
Message-ID: <20170322145536.30570-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934947AbdCVPEe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:04:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org

Hi Sebastian, Liam, All,

As discussed here is a v2 of my bq24190 charges. I'm not 100% sure
the last patch should go upstream as is, we do want to remove the
battery power_supply but I'm not sure about the timing of doing so.

>From my pov the other patches are ready for merging, but I guess there
may be some remarks and a v3 of this set will be necessary :)

Regards,

Hans
