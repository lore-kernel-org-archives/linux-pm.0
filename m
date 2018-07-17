From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 0/3] power: supply: max8998-charger: Device Tree support
Date: Tue, 17 Jul 2018 18:05:06 +0200
Message-ID: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch series compose of 3 patches.

First patch, fixes platform data retrieval issue in max8998 charger
driver, which could cause NULL pointer dereference.

Second patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Third patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

All patches has been tested on, Samsung Galaxy S (i9000) phone.

Changes from v2:
  - Make charge-restart-level-microvolt and charge-timeout-hours
    properties optional. If they're not present, assume they're disabled.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit for charger properties
  - Removed already applied patch

Paweł Chmiel (2):
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

Tomasz Figa (1):
  power: supply: max8998-charger: Fix platform data retrieval

 Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++
 drivers/power/supply/max8998_charger.c            | 62 ++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.7.4
