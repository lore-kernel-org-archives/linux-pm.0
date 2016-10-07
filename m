From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 8/8] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Fri,  7 Oct 2016 15:37:01 -0700
Message-ID: <1475879821-8035-9-git-send-email-lina.iyer@linaro.org>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34085 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755079AbcJGWh1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 18:37:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id e6so29281941pfk.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 15:37:27 -0700 (PDT)
In-Reply-To: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Update documentation to reflect the changes made to support IRQ safe PM
domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/power/devices.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..0401b53 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -607,7 +607,14 @@ individually.  Instead, a set of devices sharing a power resource can be put
 into a low-power state together at the same time by turning off the shared
 power resource.  Of course, they also need to be put into the full-power state
 together, by turning the shared power resource on.  A set of devices with this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may also be
+nested inside another power domain.
+
+Devices and PM domains may be defined as IRQ-safe, if they can be powered
+on/off even when the IRQs are disabled. An IRQ-safe device in a domain will
+disallow power management on the domain, unless the domain is also defined as
+IRQ-safe. The restriction this framework imposes on the parent domain of an
+IRQ-safe domain is that it must also be defined as IRQ-safe.
 
 Support for power domains is provided through the pm_domain field of struct
 device.  This field is a pointer to an object of type struct dev_pm_domain,
-- 
2.7.4

