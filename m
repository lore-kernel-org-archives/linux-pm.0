From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Introduce domain-performance-state binding
Date: Fri, 18 Nov 2016 14:53:12 +0530
Message-ID: <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479459752.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479459752.git.viresh.kumar@linaro.org>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nayak Rajendra <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

The power-domains until now were only concentrating on the idle state
management of the device and this needs to change in order to reuse the
infrastructure of power domains for active state management.

This patch introduces a new optional property for the consumers of the
power-domains: domain-performance-state.

If the consumers don't need the capability of switching to different
domain performance states at runtime, then they can simply define their
required domain performance state in their node directly. Otherwise the
consumers can define their requirements with help of other
infrastructure, for example the OPP table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index e1650364b296..db42eacf8b5c 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -106,6 +106,12 @@ domain provided by the 'parent' power controller.
  - power-domains : A phandle and PM domain specifier as defined by bindings of
                    the power controller specified by phandle.
 
+Optional properties:
+- domain-performance-state: A positive integer value representing the minimum
+  performance level (of the parent domain) required by the consumer for its
+  working. The integer value '1' represents the lowest performance level and the
+  highest value represents the highest performance level.
+
 Example:
 
 	leaky-device@12350000 {
-- 
2.7.1.410.g6faf27b
