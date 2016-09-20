From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 0/3] PM / Domains: Add support for devices that require multiple domains
Date: Tue, 20 Sep 2016 11:28:04 +0100
Message-ID: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6472 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbcITK20 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 06:28:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

The Tegra124/210 XUSB subsystem (that consists of both host and device
controllers) is partitioned across 3 PM domains which are:
- XUSBA: Superspeed logic (for USB 3.0)
- XUSBB: Device controller
- XUSBC: Host controller

These power domains are not nested and can be powered-up and down
independently of one another. In practice different scenarios require
different combinations of the power domains, for example:
- Superspeed host: XUSBA and XUSBC
- Superspeed device: XUSBA and XUSBB

Although it could be possible to logically nest both the XUSBB and XUSBC
domains under the XUSBA, superspeed may not always be used/required and
so this would keep it on unnecessarily.

Given that Tegra uses device-tree for describing the hardware, it would
be ideal that the device-tree 'power-domains' property for generic PM
domains could be extended to allow more than one PM domain to be
specified. For example, define the following the Tegra210 xHCI device ...

	usb@70090000 {
		compatible = "nvidia,tegra210-xusb";
		...
		power-domains = <&pd_xusbhost>, <&pd_xusbss>;
	};

This RFC extends the generic PM domain framework to allow a device to
define more than one PM domain in the device-tree 'power-domains'
property.

Jon Hunter (3):
  PM / Domains: Add helper functions for finding and attaching PM
    domains
  PM / Domains: Add support for devices with multiple domains
  dt-bindings: Add support for devices with multiple PM domains

 .../devicetree/bindings/power/power_domain.txt     |   5 +-
 drivers/base/power/domain.c                        | 205 +++++++++++++++------
 2 files changed, 155 insertions(+), 55 deletions(-)

-- 
2.1.4

