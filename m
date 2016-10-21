From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 [fix]] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Fri, 21 Oct 2016 15:52:55 -0700
Message-ID: <1477090375-13814-1-git-send-email-lina.iyer@linaro.org>
References: <20161021152313.GC72940@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161021152313.GC72940@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Update documentation to reflect the changes made to support IRQ safe PM
domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes since v3:
- Moved para to the end of the section
- Added clause for all IRQ safe devices in a domain
- Cleanup explanation of nested domains
---
 Documentation/power/devices.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..9218ce6 100644
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
@@ -629,6 +631,13 @@ support for power domains into subsystem-level callbacks, for example by
 modifying the platform bus type.  Other platforms need not implement it or take
 it into account in any way.
 
+Devices and PM domains may be defined as IRQ-safe, if they can be powered
+on/off even when the IRQs are disabled. An IRQ-safe device in a domain will
+disallow power management on the domain, unless the domain is also defined as
+IRQ-safe. In other words, a domain containing all IRQ-safe devices must also
+be defined as IRQ-safe. Another restriction this framework imposes on the
+parent domain of an IRQ-safe domain is that the parent domain must also be
+defined as IRQ-safe.
 
 Device Low Power (suspend) States
 ---------------------------------
-- 
2.7.4
