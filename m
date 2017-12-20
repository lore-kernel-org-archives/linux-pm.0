From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/3] phy: core: Re-work runtime PM deployment and fix an issue
Date: Wed, 20 Dec 2017 15:09:17 +0100
Message-ID: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44933 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbdLTOJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 09:09:28 -0500
Received: by mail-lf0-f68.google.com with SMTP id g63so2145985lfl.11
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 06:09:28 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Changes in v2:
	- Address scenario, pointed out by Kishon, that runtime PM may be
	enabled by the phy provider driver, *after* it have called
	devm_phy_create() or phy_create().

The intend of this series is to simplify the runtime PM deployment in the phy
core, but while doing that fixing a related problem for a Renesas SoC making use
of a phy. This issue was raised by Geert Uytterhoeven and Yoshihiro Shimoda, due
to a changed behaviour in the runtime PM core.

The commit in question is f8817f61e821 (PM / runtime: Drop children check from
__pm_runtime_set_status()). However, it turned out that the problem existed
already prior this change, only that the error was printed instead of giving a
WARN splat.

More details about the changes are available in each change log. For additional
background, please have look at the link below.

https://patchwork.kernel.org/patch/10086651/


Ulf Hansson (3):
  phy: core: Move runtime PM reference counting to the parent device
  phy: core: Drop unused runtime PM APIs
  phy: core: Update the runtime PM section in the docs to reflect
    changes

 Documentation/phy.txt   | 29 ++++++++++++----------
 drivers/phy/phy-core.c  | 65 +++++++------------------------------------------
 include/linux/phy/phy.h | 46 +---------------------------------
 3 files changed, 26 insertions(+), 114 deletions(-)

-- 
2.7.4
