From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: [PATCHv2 0/4] Qualcomm Switch-Mode Battery Charger and Boost
Date: Thu, 30 Jul 2015 10:53:53 -0700
Message-ID: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This series adds bindings and a device driver for the Qualcomm Switch-Mode
Battery Charger and Boost block found in pm8941.

Changes since v1:
- Corrected authorship of the patches
- Gave dt properties qcom vendor prefix
- Updated names of dt properties
- Dropped MODULE_ALIAS

Courtney Cavin (4):
  spmi: pmic-arb: add support for irq_get_irqchip_state
  dt-binding: power: Add Qualcomm SMBB binding
  power: Add Qualcomm SMBB driver
  ARM: dts: qcom-pm8941: Add charger node

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 131 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  21 +
 drivers/power/Kconfig                              |  12 +
 drivers/power/Makefile                             |   1 +
 drivers/power/qcom_smbb.c                          | 951 +++++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                       |  17 +
 6 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
 create mode 100644 drivers/power/qcom_smbb.c

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
