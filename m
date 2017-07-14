From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 0/5] thermal: imx: Add nvmem-cells binding on imx6sx
Date: Fri, 14 Jul 2017 17:11:05 +0300
Message-ID: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On imx6sx accessing OCOTP directly is wrong because the ocotp clock needs to be
enabled first. Fix this by adding a nvmem-cells binding and using it on imx6sx,
imx6ul and imx6ull.

The existing binding is kept around because it works fine on imx6qdl.

This was initially reported by Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> in reply
to a patch adding imx6ul/ull support:

Link: https://lkml.org/lkml/2017/6/9/578

---
Changes since v1:
 * Move nvmem_cell_read_u32 to nvmem core (Shawn Guo, Srinivas Kandagatla)
 * Adjust binding description (Rob Herring)
 * Adjust formatting of thermal info cells (Shawn Guo)
 * Link: https://lkml.org/lkml/2017/7/6/426

Leonard Crestez (5):
  thermal: imx: Add nvmem-cells alternate binding for OCOTP access
  nvmem: core: Add nvmem_cell_read_u32
  thermal: imx: Add support for reading OCOTP through nvmem
  ARM: dts: imx6sx: Use nvmem-cells for tempmon
  ARM: dts: imx6ul: Add imx6ul-tempmon

 .../devicetree/bindings/thermal/imx-thermal.txt    |   7 ++
 arch/arm/boot/dts/imx6sx.dtsi                      |  13 ++-
 arch/arm/boot/dts/imx6ul.dtsi                      |  19 ++++
 drivers/nvmem/core.c                               |  37 ++++++++
 drivers/thermal/imx_thermal.c                      | 103 +++++++++++++++------
 include/linux/nvmem-consumer.h                     |   8 ++
 6 files changed, 156 insertions(+), 31 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
