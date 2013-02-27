From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] time : pass broadcast parameter
Date: Wed, 27 Feb 2013 10:39:14 +0530
Message-ID: <512D94FA.7070207@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org> <1361917047-29230-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37193 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab3B0FH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Feb 2013 00:07:58 -0500
In-Reply-To: <1361917047-29230-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: john.stultz@linaro.org, tglx@linutronix.de, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linus.walleij@stericsson.com

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> The broadcast timer could be passed as parameter to the function
> instead of using again tick_broadcast_device.evtdev which was
> previously used in the caller function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
The change doesn't buy us as such even after looking
at next patch which tries to use bc. No strong opinion
though.

Regards,
Santosh
