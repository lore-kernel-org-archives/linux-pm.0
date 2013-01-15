From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq: add imx6q-cpufreq driver
Date: Tue, 15 Jan 2013 22:53:57 +0800
Message-ID: <20130115145356.GD6574@S2101-09.ap.freescale.net>
References: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
 <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
 <50F427A7.7000203@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:57352
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730Ab3AOOxs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jan 2013 09:53:48 -0500
Content-Disposition: inline
In-Reply-To: <50F427A7.7000203@boundarydevices.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Eric,

On Mon, Jan 14, 2013 at 08:43:35AM -0700, Eric Nelson wrote:
> >+	/* scaling up?  scale voltage before frequency */
> >+	if (freqs.new > freqs.old) {
> >+		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> >+		if (ret) {
> >+			dev_err(cpu_dev, "failed to scale voltage up: %d\n", ret);
> >+			return ret;
> >+		}
> >+
> >+		/*
> >+		 * Need to increase vddpu and vddsoc for safety
> >+		 * if we are about to run at 1.2 GHz.
> >+		 */
> >+		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> >+			regulator_set_voltage_tol(pu_reg,
> >+					PU_SOC_VOLTAGE_HIGH, 0);
> >+			regulator_set_voltage_tol(soc_reg,
> >+					PU_SOC_VOLTAGE_HIGH, 0);
> >+		}
> 
> I believe you need a delay here to let the LDOs ramp before changing
> the CPU frequency.
> 
> According to the i.MX6Q reference manual, with the factory default
> step times in PMU_MISC2 and the maximum voltage swing is
> 	1.25V (1.2GHz) - 0.95V (400MHz) == 0.325V
> 
> or 13 steps at 25mV.
> 
> The default step time is 0.000021333s (512 clocks at 24MHz), so
> the worst case delay needed is ~280uS.
> 
> This could also be done in the regulator driver, but that may
> require multiple delays if multiple rails are changed.
> 
I initially thought that regulator driver should take care of it.  But
now I agree with you that we can do it here for the least latency.

Will roll it into v4.  Thanks.

Shawn

