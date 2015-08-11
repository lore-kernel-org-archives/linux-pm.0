From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 0/5] power/reset: at91: cleanups and slow clock
Date: Tue, 11 Aug 2015 11:12:45 +0200
Message-ID: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54473 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933713AbbHKJM6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 05:12:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

As discussed this series is now removing non DT initialization, allowing to
compile the drivers as modules and finally adding slow clock support to the
drivers.


Alexandre Belloni (5):
  power/reset: at91-reset: remove useless at91_reset_platform_probe()
  power/reset: at91-reset: allow compiling as a module
  power/reset: at91-reset: get and use slow clock
  power/reset: at91-poweroff: allow compiling as a module
  power/reset: at91-poweroff: get and use slow clock

 drivers/power/reset/Kconfig         |  4 +--
 drivers/power/reset/at91-poweroff.c | 33 ++++++++++++++++--
 drivers/power/reset/at91-reset.c    | 67 ++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 46 deletions(-)

-- 
2.1.4

