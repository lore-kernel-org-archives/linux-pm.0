From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 4/9] dt-bindings: add domain-idle-state compatible to arm,idle-state
Date: Mon, 24 Oct 2016 15:21:03 -0700
Message-ID: <1477347668-41901-5-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendan.jackman-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

CPU's idle states are defined by the arm,idle-state compatible flag. See
[1]. PM domains that can contains devices and other domains also has
similar definition for its idle state. Reuse the definition of
arm,idle-state for PM domains by allowing an addition compatible string
("domain-idle-state") to denote idle states that are specific to PM
Domains.

[1]. Documentation/devicetree/bindings/arm/idle-states.txt

Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Suggested-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index b8e41c1..4b0ff59 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -271,6 +271,9 @@ follows:
 		Usage: Required
 		Value type: <stringlist>
 		Definition: Must be "arm,idle-state".
+			    Additionally, nodes that are used to describe a
+			    idle-state of PM domain must also define
+			    "domain-idle-state" as compatible string.
 
 	- local-timer-stop
 		Usage: See definition
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
