From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq: i.MX6: -EPROBE_DEFER fixes
Date: Wed, 28 Oct 2015 04:27 +0100
Message-ID: <1625342.QihRV1d1Kl@vostro.rjw.lan>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50840 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754077AbbJ1C6D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 22:58:03 -0400
In-Reply-To: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On Thursday, October 22, 2015 10:47:28 AM Sascha Hauer wrote:
> The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
> regulator_get/clk_get. This series fix that and some other small issues.
> 
> This series supersedes
> [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
> [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
> from Heiner Kallweit.

I'm expecting a new version of this addressing the review comments to be
submitted.

Thanks,
Rafael

