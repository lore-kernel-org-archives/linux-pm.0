From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned long
Date: Fri, 27 Mar 2015 10:18:14 +0000
Message-ID: <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
	<1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36988 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750819AbbC0KSR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 06:18:17 -0400
In-Reply-To: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de> (Sascha
	Hauer's message of "Thu, 26 Mar 2015 16:53:48 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Sascha,

Sascha Hauer <s.hauer@pengutronix.de> writes:

> The thermal framework uses int, long and unsigned long for temperatures
> in millicelsius. The majority of functions uses unsigned long, so change
> the remaining functions to use this type aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I'd suggest changing to long instead. It would allow the use of the
thermal framework in environments where temperatures are below 0C -
quite easily reached in many parts of the world.

Regards,
Punit

> ---
>  drivers/thermal/thermal_core.c | 10 +++++-----
>  include/linux/thermal.h        |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

[...]

