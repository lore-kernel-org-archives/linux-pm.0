From: Andrew-sh Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/3] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
Date: Tue, 29 Jan 2019 14:35:03 +0800
Message-ID: <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1548743704-16821-1-git-send-email-andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob
 Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias
 Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew-sh.Cheng" <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: "Andrew-sh.Cheng" <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This adds dt-binding documentation of cci devfreq
for Mediatek MT8183 SoC platform.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../bindings/devfreq/mt8183-cci-devfreq.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt

diff --git a/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
new file mode 100644
index 0000000..e2b61cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
@@ -0,0 +1,19 @@
+* Mediatek CCI frequency device
+
+Required properties:
+- compatible: should contain "mediatek,mt8183-cci" for cci devfreq
+
+- clocks: for cci devfreq
+
+- clock-names: for cci devfreq driver to reference
+
+- operating-points-v2: for cci devfreq opp table
+
+Example:
+	cci: cci {
+		compatible = "mediatek,cci";
+		clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
+		clock-names = "cci_clock";
+		operating-points-v2 = <&cci_opp>;
+	};
+
-- 
1.8.1.1.dirty
