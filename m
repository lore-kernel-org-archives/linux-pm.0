From: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 0/3] enable eeprom "size" property and runtime pm
Date: Tue, 10 Oct 2017 11:30:34 +0530
Message-ID: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series adds support for eeprom "size" property which will be read by the
driver for eeprom size. The existing ACPI has a different default size which
can be overridden with a DSD property value provided by the platform FW.

This series also adds support for runtime PM. The eeprom driver currently
did not have support for runtime PM and the device was kept in D0 throughout.

[v1]
- Add support for eeprom "size" property.
- Add runtime PM support to the driver.

[v2]
- Improved the patch subject.

[v3]
- Addressed comments from Sakari Ailus.
- Improved patch description.
- Improved pm support patch.

[v4]
- Improved runtime pm support.
- Addressed comments from Sakari Ailus.

[v5]
- Addressed comments from Sakari Ailus.
- Improved error handling for PM support.

[v6]
- Addressed comments from Sakari Ailus.

[v7]
- Added suggested-by and reviewed-by tags given in
  https://lkml.org/lkml/2017/9/22/444
  https://lkml.org/lkml/2017/9/5/430
- Addressed comments on PM support.

Divagar Mohandass (3):
  dt-bindings: add eeprom "size" property
  eeprom: at24: add support to fetch eeprom device property "size"
  eeprom: at24: enable runtime pm support

 .../devicetree/bindings/eeprom/eeprom.txt          |  2 ++
 drivers/misc/eeprom/at24.c                         | 41 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
