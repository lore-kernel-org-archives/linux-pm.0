From: <sean.wang@mediatek.com>
Subject: [PATCH 0/2] add cpufreq support to MT7622
Date: Wed, 9 Aug 2017 18:12:37 +0800
Message-ID: <cover.1502272372.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add cpufreq support to MT7622 SoC and also include some cleanups
with the generic naming to explicitly support all MediaTek SoCs.

Sean Wang (2):
  cpufreq: mediatek: add cleanups with the more generic naming
  cpufreq: mediatek: add support of cpufreq to MT7622 SoC

 drivers/cpufreq/mediatek-cpufreq.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.7.4
