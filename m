From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 4/4] dt-bindings: Add support for devices with multiple PM domains
Date: Tue, 28 Mar 2017 15:14:03 +0100
Message-ID: <1490710443-27425-5-git-send-email-jonathanh@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490710443-27425-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Now that the generic PM domain framework supports consumers that can
control multiple PM domains, update the device-tree binding for generic
PM domains to state that one or more PM domain is permitted for a
device.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 723e1ad937da..fb28d37f9e1f 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -20,8 +20,15 @@ Required properties:
    as specified by device tree binding documentation of particular provider.
 
 Optional properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
+ - power-domains : An array of one or more PM domain specifiers (defined by the
+		   bindings of the PM domain provider) for each PM domain that
+		   is required by the device.
+ - power-domain-names: A list of strings of PM domain names. The list must have
+                       a name for each PM domain specifier in the
+		       'power-domains' property and these names must be unique
+		       within the context of this property. The names must be
+		       indexed so that the first name corresponds to the first
+		       PM domain specifier and so on.
    Some power domains might be powered from another power domain (or have
    other hardware specific dependencies). For representing such dependency
    a standard PM domain consumer binding is used. When provided, all domains
-- 
2.7.4
