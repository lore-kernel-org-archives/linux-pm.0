From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/4] thermal: imx: cleanup and new formula
Date: Tue, 21 Nov 2017 21:02:21 +0100
Message-ID: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:56970 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKUULk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 15:11:40 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de

Hello,

this series updates the imx driver to use a new formula privided by NXP
for better measurements. The first three patches are not strictly
necessary as preparation, but IMHO make the driver easier to understand.
I hope this is not subjective.

Best regards
Uwe

Uwe Kleine-König (4):
  thermal: imx: Use better parameter names than "val"
  thermal: imx: improve comments describing algorithm for temp
    calculation
  thermal: imx: use consistent style to write temperatures
  thermal: imx: update to new formula according to NXP AN5215

 drivers/thermal/imx_thermal.c | 74 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

-- 
2.14.2
