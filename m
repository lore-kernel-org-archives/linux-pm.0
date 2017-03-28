From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of PM domains
Date: Tue, 28 Mar 2017 15:13:59 +0100
Message-ID: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, rnayak@codeaurora.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The current generic PM domain framework (GenDP) only allows a single
PM domain to be associated with a given device. There are several
use-cases for various system-on-chip devices where it is necessary for
a PM domain consumer to control more than one PM domain where the PM
domains:
i).  Do not conform to a parent-child relationship so are not nested
ii). May not be powered on and off at the same time so need independent
     control.

The solution proposed in this RFC is to allow consumers to explictly
control PM domains, by getting a handle to a PM domain and explicitly
making calls to power on and off the PM domain. Note that referencing
counting is used to ensure that a PM domain shared between consumers
is not powered off incorrectly.

The Tegra124/210 XUSB subsystem (that consists of both host and device
controllers) is an example of a consumer that needs to control more than
one PM domain because the logic is partitioned across 3 PM domains which
are:
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
		power-domain-names = "host", "superspeed";
	};

This RFC extends the generic PM domain framework to allow a device to
define more than one PM domain in the device-tree 'power-domains'
property. If there is more than one then the assumption is that these
PM domains will be controlled explicitly by the consumer and the device
will not be automatically bound to any PM domain.

This RFC is a follow-up to the following RFC but because it is a
completely different approach has not been titled V2.

https://lkml.org/lkml/2016/9/20/173

Jon Hunter (4):
  PM / Domains: Prepare for supporting explicit PM domain control
  PM / Domains: Add support for explicit control of PM domains
  PM / Domains: Add OF helpers for getting PM domains
  dt-bindings: Add support for devices with multiple PM domains

 .../devicetree/bindings/power/power_domain.txt     |  11 +-
 drivers/base/power/domain.c                        | 203 ++++++++++++++++++++-
 include/linux/pm_domain.h                          |  35 ++++
 3 files changed, 246 insertions(+), 3 deletions(-)

-- 
2.7.4
