From: Chris Zhong <zyw@rock-chips.com>
Subject: [PATCH 0/2] Support disable the wakeup event of gpio-charger
Date: Tue, 10 Feb 2015 16:12:23 +0800
Message-ID: <1423555945-24289-1-git-send-email-zyw@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, dianders@chromium.org, dtor@chromium.org, djkurtz@chromium.org, sonnyrao@chromium.org
Cc: linux-rockchip@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko.stuebner@bq.com>, David Woodhouse <dwmw2@infradead.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

If you needn't the wakeup event of gpio-charger, this patch can help.
Please set "gpio-charger,disable-wakeup" in gpio-charger node.


Chris Zhong (2):
  dt-bindings: add disable-wakeup property for gpio-charger
  power: gpio-charger: support disable the wakeup event

 Documentation/devicetree/bindings/power_supply/gpio-charger.txt | 2 ++
 drivers/power/gpio-charger.c                                    | 5 ++++-
 include/linux/power/gpio-charger.h                              | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.9.1
