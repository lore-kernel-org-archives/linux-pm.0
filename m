From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Wed,  5 Oct 2016 17:51:11 +0200
Message-ID: <20161005155112.13774-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754077AbcJEPvT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 11:51:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

Dennis Gilmore (in the Cc) reports that axp20x-i2c does not auto-load
on e.g. the CHIP. I believe this is caused by the i2c-ids table not being
populated.

I believe the patch in the next mail should fix this.

Regards,

Hans
