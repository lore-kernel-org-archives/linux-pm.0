From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] power: Adds support for Smart Battery System
 Manager
Date: Wed, 13 Jul 2016 04:06:55 +0800
Message-ID: <201607130449.xU6uiSoe%fengguang.wu@intel.com>
References: <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-acpi-owner@vger.kernel.org
Cc: kbuild-all@01.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
List-Id: linux-pm@vger.kernel.org

Hi,

[auto build test WARNING on battery/master]
[also build test WARNING on v4.7-rc7 next-20160712]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Karl-Heinz-Schneider/Documentation-Add-sbs-manager-device-tree-node-documentation/20160713-025704
base:   git://git.infradead.org/battery-2.6.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/power/sbs-manager.c:315:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
