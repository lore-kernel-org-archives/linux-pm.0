From: Marek Vasut <marex@denx.de>
Subject: Re: Freescale MXS battery driver
Date: Tue, 16 Jul 2013 10:26:14 +0200
Message-ID: <201307161026.14916.marex@denx.de>
References: <51E4FE90.9010700@digi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53679 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab3GPI0V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 04:26:21 -0400
In-Reply-To: <51E4FE90.9010700@digi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

Dear Hector Palacios,

> Greetings,
> 
> Does anybody know if there is any on-going work to support Freescale's MXS
> battery driver?

Nothing I know of, but implementing charger itself should be rather easy. 
Implementing overcharging protection and all this stuff would be hell. Good luck 
;-)

Best regards,
Marek Vasut
