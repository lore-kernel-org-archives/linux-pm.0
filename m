From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] of: thermal: Mark cooling-*-level properties optional
Date: Tue,  8 Sep 2015 12:20:49 +0100
Message-ID: <1441711249-11434-2-git-send-email-punit.agrawal@arm.com>
References: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441711013-11220-1-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The cooling-{min,max}-level properties are marked as optional in
Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt and the usage
in various device tree matches this, i.e., some cooling device in the
device trees provide these properties while others do not.

Make the bindings in
Documentation/devicetree/bindings/thermal/thermal.txt consistent with
the cpufreq-dt bindings by marking the cooling-*-level properties as
optional.

Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 8320186..41b817f 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -60,14 +60,6 @@ properties) should be defined in a particular device's binding.
 For more examples of cooling devices, refer to the example sections below.
 
 Required properties:
-- cooling-min-level:	An integer indicating the smallest
-  Type: unsigned	cooling state accepted. Typically 0.
-  Size: one cell
-
-- cooling-max-level:	An integer indicating the largest
-  Type: unsigned	cooling state accepted.
-  Size: one cell
-
 - #cooling-cells:	Used to provide cooling device specific information
   Type: unsigned	while referring to it. Must be at least 2, in order
   Size: one cell      	to specify minimum and maximum cooling state used
@@ -77,6 +69,15 @@ Required properties:
 			See Cooling device maps section below for more details
 			on how consumers refer to cooling devices.
 
+Optional properties:
+- cooling-min-level:	An integer indicating the smallest
+  Type: unsigned	cooling state accepted. Typically 0.
+  Size: one cell
+
+- cooling-max-level:	An integer indicating the largest
+  Type: unsigned	cooling state accepted.
+  Size: one cell
+
 * Trip points
 
 The trip node is a node to describe a point in the temperature domain
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
