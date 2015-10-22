From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Thu, 22 Oct 2015 20:02:37 +0800
Message-ID: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Use Intelligent Power Allocation (IPA) technical to add static/dynamic power model for binding CPU thermal zone.
The power allocator governor allocates power budget to control CPU temperature.

Power Allocator governor is able to keep SOC temperature within a defined temperature range to avoid SOC overheat and keep it's performance. mt8173-cpufreq.c need to register its' own power model with power allocator thermal governor, so that power allocator governor can allocates suitable power budget to control CPU temperature.

PATCH1 is base on
https://patchwork.kernel.org/patch/7034601/

PATCH2 is base on Sascha's thermal driver V9
https://patchwork.kernel.org/patch/7249821/
https://patchwork.kernel.org/patch/7249861/
https://patchwork.kernel.org/patch/7249891/

Change since V1:
include mt8171.h and sort header file for mt8173.dtsi

Change since V2:
Move dynamic/static power model in device tree

Dawei.Chien (2):
  thermal: mediatek: Add cpu power cooling model.
  arm64: dts: mt8173: Add thermal zone node for mt8173.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   97 ++++++++++++++++++++++++++----
 2 files changed, 130 insertions(+), 11 deletions(-)

--
1.7.9.5
