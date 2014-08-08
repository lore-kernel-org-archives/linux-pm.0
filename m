From: =?iso-8859-1?Q?Ren=E9_Moll?= <Rene.Moll@xsens.com>
Subject: [PATCH 0/2] power: reset: add LTC2952 poweroff support
Date: Fri, 8 Aug 2014 13:12:10 +0000
Message-ID: <8B68774BB69A844693005BA12A50F1146D4B78@XSMBXSVR01.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:53014 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641AbaHHNMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 09:12:14 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <Frans.Klaver@xsens.com>

Hi,

This series add a driver for the LTC2952, an external power control chi=
p, which
signals the OS to shut down. Additionally this driver lets the kernel p=
ower
down the board.

This driver was tested with:
- kernel version 3.15.8
- ARM based processor (TI AM335x series)

Thanks,
Ren=E9

Ren=E9 Moll (2):
      power: reset: add LTC2952 poweroff support
      doc: power: reset: add binding info LTC2952 driver

 Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt |  =
26 ++++++++
 drivers/power/reset/Kconfig                                        |  =
 7 ++
 drivers/power/reset/Makefile                                       |  =
 1 +
 drivers/power/reset/ltc2952-poweroff.c                             | 3=
87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 421 insertions(+)
