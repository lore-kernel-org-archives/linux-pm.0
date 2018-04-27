From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/4] mfd: max8998: Device Tree support fixes
Date: Fri, 27 Apr 2018 18:02:58 +0200
Message-ID: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch series compose of 4 patches.

First patch, fixes platform data retrieval issue in max8998 regulator
driver, which could cause NULL pointer dereference.

Second patch, fixes platform data retrieval issue in max8998 charger
driver, which could cause NULL pointer dereference.

Third patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Fourth patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

All patches has been tested on (not yet mainlined), an S5PV210 based
Samsung Galaxy S (i9000) phone.

Paweł Chmiel (3):
  regulator: max8998: Fix platform data retrieval.
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

Tomasz Figa (1):
  power: supply: max8998-charger: Fix platform data retrieval

 Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++
 drivers/power/supply/max8998_charger.c            | 52 ++++++++++++++++++++++-
 drivers/regulator/max8998.c                       |  3 +-
 3 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.7.4
