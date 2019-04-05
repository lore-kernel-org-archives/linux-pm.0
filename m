From: Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH 1/1] power: reset: nvmem-reboot-mode: use NVMEM as reboot mode
 write interface
Date: Fri, 5 Apr 2019 10:54:55 +0000
Message-ID: <20190405105432.21941-1-nandor.han@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sre@kernel.org" <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Han Nandor <nandor.han@vaisala.com>
List-Id: linux-pm@vger.kernel.org

Add a new reboot mode write interface that is using a NVMEM cell,
called "reboot-mode", to store the reboot mode magic.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---

Description
-----------
Extend the reboot mode driver to use a NVMEM cell as writing interface.

Testing
-------
The testing is done by configuring DT from a custom board.
The NVMEM cell is configured in an RTC non-volatile memory.

DT configurations:
`
...
reboot-mode-nvmem@0 {
    compatible =3D "simple-mfd";
    reboot-mode {
        compatible =3D "nvmem-reboot-mode";
        nvmem-cells =3D <&reboot_mode>;
        nvmem-cell-names =3D "reboot-mode";

        mode-test       =3D <0x21969147>;
     };
};
...
reboot_mode: nvmem_reboot_mode@0 {
        reg =3D <0x00 0x4>;
};
...
`

1. Reboot the system using the command `reboot test`

2. Verify that kernel logs show that reboot was done in mode `test`:
PASS
`[  413.957172] reboot: Restarting system with command 'test' `

3. Stop in U-Boot and verify that mode `test` magic value is present
in RTCs non-volatile memory: PASS

 .../power/reset/nvmem-reboot-mode.txt         | 32 ++++++++
 drivers/power/reset/Kconfig                   |  9 +++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/nvmem-reboot-mode.c       | 75 +++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reb=
oot-mode.txt
 create mode 100644 drivers/power/reset/nvmem-reboot-mode.c

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mod=
e.txt b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
new file mode 100644
index 000000000000..2e1b86c31cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
@@ -0,0 +1,32 @@
+NVMEM reboot mode driver
+
+This driver gets reboot mode magic value from reboot-mode driver
+and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
+can read it and take different action according to the magic
+value stored.
+
+This DT node should be represented as a sub-node of a "simple-mfd"
+node.
+
+Required properties:
+- compatible: should be "nvmem-reboot-mode".
+- nvmem-cells: A phandle to the reboot mode provided by a nvmem device.
+- nvmem-cell-names: Should be "reboot-mode".
+
+The rest of the properties should follow the generic reboot-mode descripti=
on
+found in reboot-mode.txt
+
+Example:
+	reboot-mode-nvmem@0 {
+		compatible =3D "simple-mfd";
+		reboot-mode {
+			compatible =3D "nvmem-reboot-mode";
+			nvmem-cells =3D <&reboot_mode>;
+			nvmem-cell-names =3D "reboot-mode";
+
+			mode-normal     =3D <0xAAAA5501>;
+			mode-bootloader =3D <0xBBBB5500>;
+			mode-recovery   =3D <0xCCCC5502>;
+			mode-test       =3D <0xDDDD5503>;
+		};
+	};
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6533aa560aa1..bb4a4e854f96 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -245,5 +245,14 @@ config POWER_RESET_SC27XX
 	  PMICs includes the SC2720, SC2721, SC2723, SC2730
 	  and SC2731 chips.
=20
+config NVMEM_REBOOT_MODE
+	tristate "Generic NVMEM reboot mode driver"
+	select REBOOT_MODE
+	help
+	  Say y here will enable reboot mode driver. This will
+	  get reboot mode arguments and store it in a NVMEM cell,
+	  then the bootloader can read it and take different
+	  action according to the mode.
+
 endif
=20
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0aebee954ac1..85da3198e4e0 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
+obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/=
nvmem-reboot-mode.c
new file mode 100644
index 000000000000..31b73c7a0dad
--- /dev/null
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Vaisala Oyj. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/reboot-mode.h>
+
+struct nvmem_reboot_mode {
+	struct reboot_mode_driver reboot;
+	struct nvmem_cell *cell;
+};
+
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
+				    unsigned int magic)
+{
+	int ret;
+	struct nvmem_reboot_mode *nvmem_rbm;
+
+	nvmem_rbm =3D container_of(reboot, struct nvmem_reboot_mode, reboot);
+
+	ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	if (ret < 0)
+		dev_err(reboot->dev, "update reboot mode bits failed\n");
+
+	return ret;
+}
+
+static int nvmem_reboot_mode_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct nvmem_reboot_mode *nvmem_rbm;
+
+	nvmem_rbm =3D devm_kzalloc(&pdev->dev, sizeof(*nvmem_rbm), GFP_KERNEL);
+	if (!nvmem_rbm)
+		return -ENOMEM;
+
+	nvmem_rbm->reboot.dev =3D &pdev->dev;
+	nvmem_rbm->reboot.write =3D nvmem_reboot_mode_write;
+
+	nvmem_rbm->cell =3D devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
+	if (IS_ERR(nvmem_rbm->cell)) {
+		dev_err(&pdev->dev, "failed to get the nvmem cell reboot-mode\n");
+		return PTR_ERR(nvmem_rbm->cell);
+	}
+
+	ret =3D devm_reboot_mode_register(&pdev->dev, &nvmem_rbm->reboot);
+	if (ret)
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+
+	return ret;
+}
+
+static const struct of_device_id nvmem_reboot_mode_of_match[] =3D {
+	{ .compatible =3D "nvmem-reboot-mode" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nvmem_reboot_mode_of_match);
+
+static struct platform_driver nvmem_reboot_mode_driver =3D {
+	.probe =3D nvmem_reboot_mode_probe,
+	.driver =3D {
+		.name =3D "nvmem-reboot-mode",
+		.of_match_table =3D nvmem_reboot_mode_of_match,
+	},
+};
+module_platform_driver(nvmem_reboot_mode_driver);
+
+MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
+MODULE_DESCRIPTION("NVMEM reboot mode driver");
+MODULE_LICENSE("GPL v2");
--=20
2.17.2
