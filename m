From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 00/12] power: supply: axp288_charger: Various fixes
Date: Wed, 21 Dec 2016 15:36:45 +0100
Message-ID: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

Here is v2 of my axp288_charger series, which fixup the axp288_charger
code to actually work.

This implements the suggestion by Chanwoo Choi on how we can use the
existing extcon_get_extcon_dev instead of introducing a new
extcon_get_extcon_dev_by_id. So this series no longer depends on any
extcon sub-sys changes.

I've also rebased it on top of linux-power-supply/for-next-next to avoid
some conflicts with patches already there which Chanwoo pointed out,
so assuming review goes well merging these to for-next-next should go
smoothly :)

Regards,

Hans
