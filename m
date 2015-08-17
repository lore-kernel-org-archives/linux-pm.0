From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
Date: Tue, 18 Aug 2015 00:14:46 +0200
Message-ID: <55D25CD6.6040404@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ADC.10703@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:51057 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbbHQWLx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 18:11:53 -0400
In-Reply-To: <55D25ADC.10703@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 18.8.2015 v 00:06 Petr Cvek napsal(a):
> Add support for LEDs inside the PASIC3 chip.

BTW During research I have found there was driver in 

	https://github.com/hackndev/linux-hnd 

but it did not make up to vanilla, so I wrote mine from scratch (actually I
have tested the PASIC3 registers mostly by trial and error - and found some
for case open reset).


