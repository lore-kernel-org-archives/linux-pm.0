From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v4 0/2] Add support for ltc2952 poweroff
Date: Thu, 9 Oct 2014 16:50:40 +0200
Message-ID: <1412866242-6474-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:45112 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbaJIOw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 10:52:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

This is version 4 of the series that adds support for the ltc2952 power=
path chip.

This series adds a driver for the LTC2952, an external power control ch=
ip, which
signals the OS to shut down. Additionally this driver lets the kernel p=
ower
down the board.

This driver was tested with:
  - kernel version 3.15.8, 3.17
  - ARM based processor (TI AM335x series)

v3..v4:
  - Rename *kill to *poweroff
  - Use managed resources (devm_*) where possible
  - Handle irq failures on trigger gpio as if no trigger input was defi=
ned
  - Drop no-op suspend/resume functions
  - Check value before starting timer - it may be possible that the tim=
er fails
    to start on first pass, but starts on second pass. While this is un=
likely,
    it will throw off the entire system. Just check the actual gpio val=
ue to be
    sure.=20
  - Reduce, almost eliminate, use of globals (I dislike them)
  - Fix some style issues
  - Now also tested on v3.17

v2..v3:
  - Allow absence of button input pin (and document that)
  - Fix some whitespace issues
  - Straighten out control flow here and there
  - Get rid of gpio array. This was only used in setup/cleanup cases. I=
t never mattered elsewhere
  - Add some explanation to the commit message that introduces the driv=
er
  - Add other contributors
  - Update Ren=C3=A9's e-mail; his Xsens e-mail is no longer valid
  - Now also tested on v3.17-rc7

Ren=C3=A9 Moll (2):
  power: reset: add LTC2952 poweroff support
  power: reset: document LTC2952 poweroff support

 .../bindings/power/reset/ltc2952-poweroff.txt      |  31 ++
 drivers/power/reset/Kconfig                        |  10 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/ltc2952-poweroff.c             | 327 +++++++++++++=
++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ltc29=
52-poweroff.txt
 create mode 100644 drivers/power/reset/ltc2952-poweroff.c

--=20
2.1.0

