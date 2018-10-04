From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 0/4] AXP8x3 AC and battery power supply support
Date: Thu,  4 Oct 2018 22:34:06 +0300
Message-ID: <20181004193410.7265-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

AXP803 AC and battery power supply support.
AXP803/AXP813 AC power supply support with input current and
voltage limiting support.

Oskari Lemmela (4):
  dt-bindings: add compatibles for AXP803 AC and battery power supplies
  ARM: dtsi: axp81x: add AC power supply subnode
  arm64: allwinner: a64: add battery and AC power supply support
  power: supply: add AXP803/AXP813 AC and battery power supply support

 .../devicetree/bindings/gpio/gpio-axp209.txt  |   3 +-
 .../bindings/iio/adc/axp20x_adc.txt           |   3 +-
 .../bindings/power/supply/axp20x_ac_power.txt |   4 +
 .../bindings/power/supply/axp20x_battery.txt  |   1 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |  31 +++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 +
 drivers/iio/adc/axp20x_adc.c                  |   1 +
 drivers/mfd/axp20x.c                          |  22 +-
 drivers/pinctrl/pinctrl-axp209.c              |   1 +
 drivers/power/supply/axp20x_ac_power.c        | 194 ++++++++++++++++++
 drivers/power/supply/axp20x_battery.c         |   3 +
 include/linux/mfd/axp20x.h                    |   1 +
 13 files changed, 274 insertions(+), 3 deletions(-)

-- 
2.17.1
