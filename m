From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] firmware: add support for TI System Control Interface
 (TI-SCI) protocol driver
Date: Thu, 1 Sep 2016 10:24:29 +0300
Message-ID: <375758c3-f5f2-b267-31c2-c28812ed3359@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Santosh,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git 4.8-rc1-ti-sci-fw

for you to fetch changes up to 7a2c510cdfa6a4b2f4200c122a377c4d5f4af552:

   firmware: ti_sci: Add support for reboot core service (2016-08-31 
14:50:20 +0300)

----------------------------------------------------------------
Nishanth Menon (5):
       Documentation: Add support for TI System Control Interface 
(TI-SCI) protocol
       firmware: Add basic support for TI System Control Interface 
(TI-SCI) protocol
       firmware: ti_sci: Add support for Device control
       firmware: ti_sci: Add support for Clock control
       firmware: ti_sci: Add support for reboot core service

  .../devicetree/bindings/arm/keystone/ti,sci.txt    |   66 +
  MAINTAINERS                                        |   10 +
  drivers/firmware/Kconfig                           |   15 +
  drivers/firmware/Makefile                          |    1 +
  drivers/firmware/ti_sci.c                          | 1997 
++++++++++++++++++++
  drivers/firmware/ti_sci.h                          |  492 +++++
  include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
  7 files changed, 2830 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
  create mode 100644 drivers/firmware/ti_sci.c
  create mode 100644 drivers/firmware/ti_sci.h
  create mode 100644 include/linux/soc/ti/ti_sci_protocol.h
