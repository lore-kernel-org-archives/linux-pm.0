From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
Date: Fri, 13 Mar 2015 16:03:41 +0000
Message-ID: <20150313160341.GQ8656@n2100.arm.linux.org.uk>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43363 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbbCMQEA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:04:00 -0400
Content-Disposition: inline
In-Reply-To: <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org

On Fri, Mar 13, 2015 at 04:43:43PM +0100, Ulf Hansson wrote:
> To sucessfully probe some devices their corresponding PM domains may
> need to be powered.
> 
> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
> domain.

Given that AMBA gets the runtime PM status across a probe, none of this
should be necessary, as generic PM domains ensures that if runtime PM
is active for any device bound to the PM domain, the PM domain will be
powered up.

In that respect, AMBA is a model of how runtime PM should've been done
for stuff like platform devices. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
