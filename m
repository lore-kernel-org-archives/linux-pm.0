From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 4/5] cpufreq: imx6q: Use id_table to distinguish between
 SoCs
Date: Mon, 14 Dec 2015 09:30:31 +0800
Message-ID: <20151214013031.GN11252@tiger>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
 <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49026 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbbLNBaw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Dec 2015 20:30:52 -0500
Content-Disposition: inline
In-Reply-To: <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Oct 28, 2015 at 08:59:13AM +0100, Sascha Hauer wrote:
> The i.MX6 cpufreq driver is instantiated from a static device in
> architecture code and not from the device tree. These devices offer the
> id_table mechanism to distinguish between different types of devices.
> Use this mechanism rather than of_machine_is_compatible() as it scales
> better with increasing number of SoCs to check against.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Sorry for my oversight on that Sascha was asking my ACK on this patch in
the cover letter.  Only noticed that with Lucas' ping.

Shawn
