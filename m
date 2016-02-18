From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/3] thermal: exynos: Fixes for vtmu-supply regulator handling
Date: Thu, 18 Feb 2016 15:19:08 -0300
Message-ID: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On a recent patch series to build a PMIC chip as a module [0], Krzysztof
asked me to check if all the consumer drivers, using the resources that
this PMIC provides, already support probe deferral.

While investigating that, I noticed that the Exynos TMU didn't do it so
this series fix that bug and other two minor issues that I noticed while
reviewing the driver and its DT binding.

The series are on top of Krzysztof's patches [1,2,3] not because there's
a dependency but to avoid merge conflicts with in-flight patches. Please
let me know if you prefer to use a different base instead.

[0]: https://lkml.org/lkml/2016/2/11/857
[1]: https://patchwork.kernel.org/patch/8345791/
[2]: https://patchwork.kernel.org/patch/8345741/
[3]: https://patchwork.kernel.org/patch/8345701/

Best regards,
Javier


Javier Martinez Canillas (3):
  thermal: exynos: List vtmu-supply as optional property in DT binding
  thermal: exynos: Use devm_regulator_get_optional() for vtmu
  thermal: exynos: Defer probe if vtmu is present but not registered

 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
 drivers/thermal/samsung/exynos_tmu.c                         | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.5.0
