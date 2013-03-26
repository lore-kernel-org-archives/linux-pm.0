From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/15] timer: move enum definition out of ifdef section
Date: Tue, 26 Mar 2013 10:06:43 +0530
Message-ID: <515125DB.2040806@ti.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42613 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab3CZEf4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 00:35:56 -0400
In-Reply-To: <1364234140-514-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, andrew@lunn.ch, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Monday 25 March 2013 11:25 PM, Daniel Lezcano wrote:
> The next patch will setup automatically the broadcast timer for
> the different cpuidle driver when one idle state stops its timer.
> This will be part of the generic code.
> 
> But some ARM boards, like s3c64xx, uses cpuidle but without the
> CONFIG_GENERIC_CLOCKEVENTS_BUILD set. Hence the cpuidle framework
> will be compiled with the code supposed to be generic, that is
> with clockevents_notify and the different enum, but will fail to
> compile because the enum is not defined.
> 
> Also the function clockevents_notify is a noop macro, this is fine
> except the usual code is:
> 
> 	int cpu = smp_processor_id();
> 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> 
> and that raises a warning telling the variable 'cpu' is not used.
> 
> Move the clock_event_nofitiers enum definition out of the
> CONFIG_GENERIC_CLOCKEVENTS_BUILD section to prevent a compilation
> error when these are used in the code.
> 
> Change the clockevents_notify macro to a static inline noop function
> to prevent a compilation warning.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

So why can't s3c64xx enable "CONFIG_GENERIC_CLOCKEVENTS_BUILD" if they
wants to use broadcast notfiers ? May be am missing something.

Regards,
Santosh

