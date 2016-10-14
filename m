From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 8/8] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Fri, 14 Oct 2016 10:47:56 -0700
Message-ID: <1476467276-75094-9-git-send-email-lina.iyer@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Update documentation to reflect the changes made to support IRQ safe PM
domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
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
