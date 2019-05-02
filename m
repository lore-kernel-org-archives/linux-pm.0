From: michael.kao <michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/8] Add Mediatek thermal dirver and dtsi
Date: Thu, 2 May 2019 18:43:07 +0800
Message-ID: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, louis.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, roger.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patchset supports for MT8183 chip to mtk_thermal.c.
Add thermal zone of all the thermal sensor in SoC for
another get temperatrue. And we add thermal zone nodes
and bind coolers.

This patch series base on these patches [1][2][3][4].

[1]support for reading chip ID and efuse (https://patchwork.kernel.org/patch/10902131/)
[2]arm64: dts: mt8183: Add reset-cells in infracfg (https://patchwork.kernel.org/patch/10908653/)
[3]clk: reset: Modify reset-controller driver (https://patchwork.kernel.org/patch/10908657/)
[4]PM / AVS: SVS: Introduce SVS engine (https://patchwork.kernel.org/patch/10923289/)

Matthias Kaehlcke (2):
	arm64: dts: mt8183: Configure CPU cooling
	arm64: dts: mt8183: Increase polling frequency for CPU thermal zone

Michael Kao (6):
	arm64: dts: mt8183: add thermal zone node
	arm64: dts: mt8183: add/update dynamic power coefficients
	arm64: dts: mt8183: Add #cooling-cells to CPU nodes
	thermal: mediatek: mt8183: fix bank number settings
	thermal: mediatek: add another get_temp ops for thermal sensors
	thermal: mediatek: use spinlock to protect PTPCORESEL

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 137 +++++++++++++++++++++++++++++++
 drivers/thermal/mtk_thermal.c            |  82 ++++++++++++++----
 2 files changed, 205 insertions(+), 14 deletions(-)
