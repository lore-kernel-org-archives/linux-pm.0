From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] dt-bindings: power: supply: move maxim,max14656.txt to proper location
Date: Thu,  8 Jun 2017 23:36:01 +0200
Message-ID: <20170608213602.13311-1-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This moves maxim,max14656.txt to proper location for
power-supply bindings.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/{power_supply => power/supply}/maxim,max14656.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/maxim,max14656.txt (100%)

diff --git a/Documentation/devicetree/bindings/power_supply/maxim,max14656.txt b/Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power_supply/maxim,max14656.txt
rename to Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
