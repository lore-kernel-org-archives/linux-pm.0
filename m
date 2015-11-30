From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Mon, 30 Nov 2015 16:42:46 +0000
Message-ID: <565C7C86.7030801@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17234 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbK3Qmw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 11:42:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

Currently, if PM is disabled in the kernel then so is
PM_GENERIC_DOMAINS. Although this makes sense, I can see a scenario
where having minimal genpd support could be advantageous.

I am looking at enabling genpd for Tegra and ideally we would populate
the power domains when the platform device is probed for the power
management controller (PMC) as this device contains the registers for
enabling the power domains.

This works fine for the case where PM is enabled, but I am concerned
about the case where we don't have PM enabled in the kernel. In this
case, because domains are not populated early during the boot process, I
am concerned that there is a chance for a device dependent on a power
domain to be probed before the PMC device has been probed and had chance
to turn on any power domains.

Obviously, we could try and play with the ordering of devices, but it
seems to me that even if PM is not enabled, it would still be nice to
register power domains with the kernel and allow devices to attach to
them and only probe the device if they are powered.

Does this sound reasonable or is there a better approach?

Cheers
Jon
