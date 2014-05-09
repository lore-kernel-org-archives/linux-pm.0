From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] ARM: ux500: Add initial support for power domains
Date: Fri,  9 May 2014 15:05:01 +0200
Message-ID: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:56298 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaEINFK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 09:05:10 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so411513lab.1
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 06:05:08 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Alessandro Rubini <rubini@unipv.it>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Initial support for power domains for ux500. To enable this feature we require
to use DT, thus we need to add bindings for the ux500 specific parts as well.

The implementation of the ux500 power domains is based upon the generic power
domain.

An important note, this patchset depends on Tomasz Figa patchset, which is still
in the review phase:

[PATCH v4 0/3] Generic Device Tree based power domain look-up
http://www.spinics.net/lists/kernel/msg1738549.html

I assume that patchset will be queued through Rafael's linux pm tree. Let's see
what the prefer way is for how to deal with this patchset, after that point.


Ulf Hansson (3):
  ARM: ux500: Initial support for power domains
  ARM: ux500: Add DT node for ux500 power domains
  ARM: ux500: Add sdi[n] devices to VAPE power domain

 .../devicetree/bindings/arm/ux500/power_domain.txt |   35 +++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   11 +++
 arch/arm/mach-ux500/Kconfig                        |    5 ++
 arch/arm/mach-ux500/Makefile                       |    1 +
 arch/arm/mach-ux500/pm.c                           |    4 +
 arch/arm/mach-ux500/pm_domains.c                   |   77 ++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +++++
 include/dt-bindings/arm/ux500_pm_domains.h         |   15 ++++
 8 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

-- 
1.7.9.5

