From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 0/2] soc: amlogic: add support for Meson GX VPU Domains
Date: Sat, 28 Oct 2017 18:40:15 +0200
Message-ID: <1509208817-30632-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@baylibre.com, carlo@caione.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[Resent with *correct* linux-pm in CC]

On the Amlogic Gx SoCs (GXBB, GXL & GXM), the VPU power domain is initialized
by the vendor U-Boot code, but running mainline U-boot has been possible
on these SoCs. But lacking such init made the system lock at kernel boot.

This patchset adds the Video Processing Unit power domain driver to enable
the same power-on and power-down sequences and was designed to allow booting
with the power domain already initialized or not.

This driver has been tested on :
- Odroid-C2 (GXBB) with Vendor and Mainline U-Boot
- P212 (GXL) with Vendor and Mainline U-Boot
- Khadas Vim (GXL) with Vendor U-Boot
- Khadas Vim2 with (GXM) Vendor U-Boot

Changes since v1:
- fixed bindings compatible string

Neil Armstrong (2):
  soc: amlogic: add Meson GX VPU Domains driver
  dt-bindings: power: add amlogic meson power domain bindings

 .../bindings/power/amlogic,meson-gx-pwrc.txt       |  61 ++++++
 drivers/soc/amlogic/Kconfig                        |  10 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            | 234 +++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-pwrc-vpu.c

-- 
2.7.4
