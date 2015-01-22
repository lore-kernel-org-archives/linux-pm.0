From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 0/2] power: rt5033: Add Richtek RT533 drivers
Date: Thu, 22 Jan 2015 13:06:38 +0900
Message-ID: <1421899601-19327-1-git-send-email-beomho.seo@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patchset adds driver for Richtek rt5033 chip The chip contains
switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge.
Additionally, This includes document for device tree of RT5033 device.

RT5033 core driver is applied by Lee Jones.
RT5033 regulator driver is applied by Mark Brown.
RT5033 fuelgauge driver is applied by Sebastian Reichel.

Changes in v4:
- Change power supply type.

Changes in v3:
- Applied one of patchset.
- Add acked-by.

Changes in v2:
- Revise binding documentation..

Beomho Seo (2):
  power: rt5033_charger: Add RT5033 charger device driver
  Documentation: Add documentation for rt5033 multifunction device

 Documentation/devicetree/bindings/mfd/rt5033.txt   |  101 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |    8 +
 drivers/power/Makefile                             |    1 +
 drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
 5 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
 create mode 100644 drivers/power/rt5033_charger.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
