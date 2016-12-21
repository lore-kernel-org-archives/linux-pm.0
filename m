From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] power: supply: axp288_charger: Use one notifier_block per extcon cable
Date: Wed, 21 Dec 2016 18:28:22 +0100
Message-ID: <20161221172823.14406-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbcLUR20 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 12:28:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org

Hi All,

Here is one more axp288_charger fix, note this applies on top of v2 of my
previous axp288_charger fixes series.

Regards,

Hans
