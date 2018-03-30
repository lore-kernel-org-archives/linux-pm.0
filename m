From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] add thermal monitor support for UniPhier PXs3 SoC
Date: Fri, 30 Mar 2018 12:51:18 +0900
Message-ID: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

Add support for thermal monitor implemented on UniPhier PXs3 SoC.

Kunihiko Hayashi (2):
  dt-bindings: thermal: uniphier: add a compatible string for PXs3
  thermal: uniphier: add UniPhier PXs3 support

 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt | 1 +
 drivers/thermal/uniphier_thermal.c                             | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4
