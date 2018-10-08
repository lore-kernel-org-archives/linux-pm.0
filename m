From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add multi-pd bindings for
 imx6sx
Date: Mon, 8 Oct 2018 18:06:20 +0000
Message-ID: <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The PCIE and PCIE_PHY blocks are in different power domains on imx6sx
and this needs to be described using multi-pd bindings.

This was not required until now because the power-domain of the PCIE
block (DISPLAY) was always on.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index f37494d5a7be..d514c1f2365f 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -39,11 +39,13 @@ Optional properties:
   host.
=20
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
 	- "pcie_inbound_axi"
-- power-domains: Must be set to a phandle pointing to the PCIE_PHY power d=
omain
+- power-domains: Must be set to phandles pointing to the DISPLAY and
+  PCIE_PHY power domains
+- power-domain-names: Must be "pcie", "pcie_phy"
=20
 Additional required properties for imx7d-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domai=
n
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
--=20
2.17.1
