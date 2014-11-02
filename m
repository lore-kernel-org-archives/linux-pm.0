From: Linus Walleij <linus.walleij@linaro.org>
Subject: [GIT PULL] Ux500 core changes for v3.19
Date: Sun, 2 Nov 2014 23:17:31 +0100
Message-ID: <CACRpkda3KMkrCSDeSUycmeDUJTDFVq6hesYfLTfmoeCB3oP6MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43911 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBWRc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Nov 2014 17:17:32 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn18so3695189igb.15
        for <linux-pm@vger.kernel.org>; Sun, 02 Nov 2014 14:17:31 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "arm@kernel.org" <arm@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi ARM SoC folks,

please pull in these Ux500 core changes for this kernel development
cycle: mainly a generic power domain implementation from Ulf Hansson
that needs to get queued up in -next and tested.

Yours,
Linus Walleij

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-for-arm-soc

for you to fetch changes up to 29417fe80ad2fd4f62f00dcca96c7198870e5642:

  ARM: ux500: Add i2c devices to the VAPE PM domain (2014-10-28 10:50:46 +0100)

----------------------------------------------------------------
Generic power domains for the Ux500

----------------------------------------------------------------
Joe Perches (1):
      ARM: u300: Convert pr_warning to pr_warn

Ulf Hansson (8):
      dt: bindings: ux500: Add documentation for PM domains
      dt: bindings: ux500: Add header for PM domains specifiers
      ARM: ux500: Initial support for PM domains
      ARM: ux500: Enable Kconfig for the generic PM domain
      ARM: ux500: Add DT node for ux500 PM domains
      ARM: ux500: Add sdi devices to the VAPE PM domain
      ARM: ux500: Add spi and ssp devices to the VAPE PM domain
      ARM: ux500: Add i2c devices to the VAPE PM domain

 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ++++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 22 ++++++
 arch/arm/mach-u300/dummyspichip.c                  | 65 ++++++++----------
 arch/arm/mach-ux500/Kconfig                        |  1 +
 arch/arm/mach-ux500/Makefile                       |  1 +
 arch/arm/mach-ux500/pm.c                           |  4 ++
 arch/arm/mach-ux500/pm_domains.c                   | 79 ++++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h                   | 17 +++++
 include/dt-bindings/arm/ux500_pm_domains.h         | 15 ++++
 9 files changed, 203 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h
