From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 1/4] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Tue, 25 Oct 2016 08:26:36 -0700
Message-ID: <1477409199-52182-2-git-send-email-lina.iyer@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36572 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932389AbcJYP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 11:26:47 -0400
Received: by mail-pf0-f182.google.com with SMTP id e6so121097277pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 08:26:47 -0700 (PDT)
In-Reply-To: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Update documentation to reflect the changes made to support IRQ safe PM
domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 Documentation/power/devices.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..73ddea3 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -607,7 +607,9 @@ individually.  Instead, a set of devices sharing a power resource can be put
 into a low-power state together at the same time by turning off the shared
 power resource.  Of course, they also need to be put into the full-power state
 together, by turning the shared power resource on.  A set of devices with this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may also be
+nested inside another power domain. The nested domain is referred to as the
+sub-domain of the parent domain.
 
 Support for power domains is provided through the pm_domain field of struct
 device.  This field is a pointer to an object of type struct dev_pm_domain,
@@ -629,6 +631,16 @@ support for power domains into subsystem-level callbacks, for example by
 modifying the platform bus type.  Other platforms need not implement it or take
 it into account in any way.
 
+Devices may be defined as IRQ-safe which indicates to the PM core that their
+runtime PM callbacks may be invoked with disabled interrupts (see
+Documentation/power/runtime_pm.txt for more information).  If an IRQ-safe
+device belongs to a PM domain, the runtime PM of the domain will be
+disallowed, unless the domain itself is defined as IRQ-safe. However, it
+makes sense to define a PM domain as IRQ-safe only if all the devices in it
+are IRQ-safe. Moreover, if an IRQ-safe domain has a parent domain, the runtime
+PM of the parent is only allowed if the parent itself is IRQ-safe too with the
+additional restriction that all child domains of an IRQ-safe parent must also
+be IRQ-safe.
 
 Device Low Power (suspend) States
 ---------------------------------
-- 
2.7.4

