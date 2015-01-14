From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH RESEND 00/13] ltc2952 modernization and new functionality
Date: Wed, 14 Jan 2015 09:15:33 +0100
Message-ID: <1421223346-27410-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:42119 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbANI3I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 03:29:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi there,

Here's a resend of an earlier cleanup and improvement series for the ltc2952
driver.

This series implements devm_* usage, reduction of globals, some cleanup and
finally makes the input trigger optional.

>From the changes to the previous submissions I did not include renaming kill to
poweroff. The name poweroff is already used a lot. Besides that, the control
is referred to as kill in the ltc2952 datasheet.

Thanks,
Frans

Frans Klaver (13):
  power: reset: ltc2952: prefer devm_kzalloc over kzalloc
  power: reset: ltc2952: prefer devm_request_irq over request_irq
  power: reset: ltc2952: unroll gpio_desc array
  power: reset: ltc2952: prefer devm_gpiod_get over gpiod_get
  power: reset: ltc2952: reduce dependency on global variables
  power: reset: ltc2952: remove global variable poweroff_panic
  power: reset: ltc2952: drop empty suspend/resume functions
  power: reset: ltc2952: cleanup control flow in poweroff_handler
  power: reset: ltc2952: remove C++ style function pointers
  power: reset: ltc2952: disable timers in _remove
  power: reset: ltc2952: check trigger value before starting timer
  power: reset: ltc2952: make trigger input optional
  power: reset: ltc2952: document optional trigger behavior

 .../bindings/power/reset/ltc2952-poweroff.txt      |  13 +-
 drivers/power/reset/ltc2952-poweroff.c             | 290 +++++++++------------
 2 files changed, 129 insertions(+), 174 deletions(-)

-- 
2.1.0

