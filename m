From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Mon, 30 Nov 2015 23:42:20 +0100
Message-ID: <1517697.Xq8gZV3Xnd@vostro.rjw.lan>
References: <565C7C86.7030801@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64946 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755133AbbK3WMd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 17:12:33 -0500
In-Reply-To: <565C7C86.7030801@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On Monday, November 30, 2015 04:42:46 PM Jon Hunter wrote:
> Currently, if PM is disabled in the kernel then so is
> PM_GENERIC_DOMAINS. Although this makes sense, I can see a scenario
> where having minimal genpd support could be advantageous.
> 
> I am looking at enabling genpd for Tegra and ideally we would populate
> the power domains when the platform device is probed for the power
> management controller (PMC) as this device contains the registers for
> enabling the power domains.
> 
> This works fine for the case where PM is enabled, but I am concerned
> about the case where we don't have PM enabled in the kernel. In this
> case, because domains are not populated early during the boot process, I
> am concerned that there is a chance for a device dependent on a power
> domain to be probed before the PMC device has been probed and had chance
> to turn on any power domains.

So make the !PM case invalid for that platform.

Seriously, either PM is mandatory, or it isn't.  If it is mandatory, make it so
instead of pretending that you can live without it.

Thanks,
Rafael

