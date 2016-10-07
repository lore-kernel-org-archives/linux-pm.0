From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/2] ARM: at91: properly handle LPDDR poweroff
Date: Fri,  7 Oct 2016 18:34:25 +0200
Message-ID: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37450 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757226AbcJGQel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 12:34:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

This patch set improves LPDDR support on SoCs using the Atmel MPDDR controller.

LPDDR memoris can only handle up to 400 uncontrolled power offs in their
life. The proper power off sequence has to be applied before shutting down the SoC.

I'm not too happy with the code duplication but this is a design choice
that has been made before because both shitdown controler are really
different appart from the shutdown itself.

I guess it is still better than slowly killing the LPDDR.

Alexandre Belloni (2):
  ARM: at91: define LPDDR types
  power/reset: at91-poweroff: timely shitdown LPDDR memories

 drivers/power/reset/at91-poweroff.c      | 52 +++++++++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 48 ++++++++++++++++++++++++++++-
 include/soc/at91/at91sam9_ddrsdr.h       |  3 ++
 3 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.9.3

