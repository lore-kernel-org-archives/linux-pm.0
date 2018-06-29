From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / Domains: dt: Add a power-domain-names property
Date: Fri, 29 Jun 2018 13:04:30 +0200
Message-ID: <20180629110432.5179-2-ulf.hansson@linaro.org>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180629110432.5179-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <dev@lynxeye.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Let's add a power-domain-names property, to allow consumer drivers to match
the power-domains specifiers via a list of power domain names. This follows
the same concept as for other similar DT bindings.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 9b387f861aed..4d6bc8829468 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -114,18 +114,26 @@ Required properties:
  - power-domains : A list of PM domain specifiers, as defined by bindings of
 		the power controller that is the PM domain provider.
 
+Optional properties:
+ - power-domain-names : A list of power domain name strings sorted in the same
+		order as the power-domains property. Consumers drivers will use
+		power-domain-names to match power domains with power-domains
+		specifiers.
+
 Example:
 
 	leaky-device@12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		power-domain-names = "io";
 	};
 
 	leaky-device@12351000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12351000 0x1000>;
 		power-domains = <&power 0>, <&power 1> ;
+		power-domain-names = "io", "clk";
 	};
 
 The first example above defines a typical PM domain consumer device, which is
-- 
2.17.1
