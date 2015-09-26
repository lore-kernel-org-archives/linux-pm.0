From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 13/26] ARM: pxa: magician: Fix and add charging detection functions
Date: Sat, 26 Sep 2015 16:45:32 +0200
Message-ID: <87eghli6di.fsf@belgarion.home>
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA48A0.9090709@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:53428 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbIZOx3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2015 10:53:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch fixes the charging detection functions for pda_power driver
> (according to newly discovered EGPIOs) and add NiCd backup accumulator
> charging support.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
> +static int magician_is_usb_online(void)
> +{
> +	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
> +		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
No need to the extra parenthesis, just :
> +	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
> +		!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE); /* USB=0 */

As the remaining looks sgood to me, I'll wait for a week for Philipp's ack and
queuing it after with this parenthesis thing fixed, won't cost me much.

Cheers.

--
Robert
