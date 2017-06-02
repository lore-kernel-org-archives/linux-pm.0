From: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] dt-bindings: thermal: add file extension to brcm,ns-thermal
Date: Fri,  2 Jun 2017 10:31:39 -0700
Message-ID: <20170602173139.71901-1-code@mmayer.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add the missing .txt extension to the Broadcom Northstar binding document.

Signed-off-by: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---

I noticed the missing .txt extension while preparing another patch series.

 .../devicetree/bindings/thermal/{brcm,ns-thermal => brcm,ns-thermal.txt}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/thermal/{brcm,ns-thermal => brcm,ns-thermal.txt} (100%)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
similarity index 100%
rename from Documentation/devicetree/bindings/thermal/brcm,ns-thermal
rename to Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
