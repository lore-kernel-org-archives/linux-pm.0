From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/3] LEGO MINDSTORMS EV3 Battery
Date: Mon,  3 Apr 2017 15:23:46 -0500
Message-ID: <1491251029-23256-1-git-send-email-david@lechnology.com>
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
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

This series adds support for the LEGO MINDSTORMS EV3 battery.

David Lechner (3):
  dt-bindings: power: supply: New bindings for LEGO MINDSTORMS EV3
    battery
  power: supply: New driver for LEGO MINDSTORMS EV3 battery
  ARM: dts: da850: Add node for LEGO MINDSTORMS EV3 Battery

 .../bindings/power/supply/lego_ev3_battery.txt     |  21 ++
 arch/arm/boot/dts/da850-lego-ev3.dts               |  28 +++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/lego_ev3_battery.c            | 237 +++++++++++++++++++++
 5 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
 create mode 100644 drivers/power/supply/lego_ev3_battery.c

-- 
2.7.4
