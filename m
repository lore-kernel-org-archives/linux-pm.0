From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 05/15] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Thu,  4 Aug 2016 17:04:52 -0600
Message-ID: <1470351902-43103-6-git-send-email-lina.iyer@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33456 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759363AbcHDXFq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 19:05:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id y134so90786353pfg.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2016 16:05:46 -0700 (PDT)
In-Reply-To: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Update documentation to reflect the changes made to support IRQ safe PM
domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/power/devices.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..a622136 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
 into a low-power state together at the same time by turning off the shared
 power resource.  Of course, they also need to be put into the full-power state
 together, by turning the shared power resource on.  A set of devices with this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may also be
+nested inside another power domain.
+
+Devices, by default, operate in process context. If a device can operate in
+IRQ safe context that has to be explicitly indicated by setting the irq_safe
+boolean inside struct generic_pm_domain to be true. Power domains by default,
+operate in process context but could have devices that are IRQ safe. Such
+power domains cannot be powered on/off during runtime PM. On the other hand,
+IRQ safe PM domains that have IRQ safe devices may be powered off when all
+the devices are in idle. An IRQ safe domain may only be attached as a
+subdomain to another IRQ safe domain.
 
 Support for power domains is provided through the pm_domain field of struct
 device.  This field is a pointer to an object of type struct dev_pm_domain,
-- 
2.7.4

