From: Soeren Moch <smoch@web.de>
Subject: Re: [PATCH v4 2/3] power: reset: imx-snvs-poweroff: add power off
 driver for i.mx6
Date: Tue, 11 Nov 2014 22:42:52 +0100
Message-ID: <546282DC.7070606@web.de>
References: <1411703947-31956-3-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:61892 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbaKKVnU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Nov 2014 16:43:20 -0500
In-Reply-To: <1411703947-31956-3-git-send-email-b38343@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Gong <b38343@freescale.com>, shawn.guo@linaro.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, LW@KARO-electronics.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk, pawel.moll@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> This driver register pm_power_off with snvs power off function. If
> your boards NOT use PMIC_ON_REQ to turn on/off external pmic, or use
> other pin to do, please disable the driver in dts, otherwise, your
> pm_power_off maybe overwrote by this driver.

> Signed-off-by: Robin Gong <b38343@freescale.com>

Any news on this?
Maybe this patchset was lost because it was sent to the old email address of Shawn?

I tested this patchset on a TBS2910 board, works as expected.  Very important feature for me.


Tested-by: Soeren Moch <smoch@web.de>

