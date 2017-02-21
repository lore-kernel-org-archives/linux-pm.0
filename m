From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 0/1] thermal: mt8173: minor mtk_thermal.c cleanups
Date: Tue, 21 Feb 2017 20:26:51 +0800
Message-ID: <1487680012-61948-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

If thermal bank with 4 sensors, thermal driver should read TEMP_MSR3.

However, currently thermal driver would not read TEMP_MSR3 since mt8173
thermal driver only use 3 sensors on each thermal bank at the same time,
so this patch would not effect temperature.
Only if mt mt8173 thermal driver use 4 sensors on any thermal bank, would
read third sensor two times, and lose fourth sensor of vale.

Change since V1:
1. Update commis message
 a. Add Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
 b. Add tag Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
