From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/4] thermal: imx: cleanup and new formula
Date: Thu, 30 Nov 2017 10:17:34 +0100
Message-ID: <20171130091738.8901-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:36724 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdK3JRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Nov 2017 04:17:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: kernel@pengutronix.de, linux-pm@vger.kernel.org

Hello,

this is v2 of the series to (mainly) update the driver to use an updated
algorithm. It also contains a few cleanups that I noticed on the way.

The changes are documented in the individual patches and are the result
of feedback by Leonard Crestez.

Uwe Kleine-König (4):
  thermal: imx: Use better parameter names than "val"
  thermal: imx: improve comments describing algorithm for temp
    calculation
  thermal: imx: use consistent style to write temperatures
  thermal: imx: update to new formula according to NXP AN5215

 drivers/thermal/imx_thermal.c | 74 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

-- 
2.15.0
