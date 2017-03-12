From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH V11 1/6] of: base: Implement read function for s32 array
Date: Sun, 12 Mar 2017 22:11:00 +0000
Message-ID: <1489356665-3175-2-git-send-email-stefan.wahren@i2se.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489356665-3175-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

In order to read signed thermal coefficients from DT we need a proper
function.

Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
---
 include/linux/of.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 21e6323..98a046a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -474,6 +474,34 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 }
 
 /**
+ * of_property_read_s32_array - Find and read an array of 32 bit signed integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid s32 value can be decoded.
+ */
+static inline int of_property_read_s32_array(const struct device_node *np,
+					     const char *propname,
+					     s32 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u32_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
  * of_property_read_u64_array - Find and read an array of 64 bit integers
  * from a property.
  *
@@ -676,6 +704,13 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_s32_array(const struct device_node *np,
+					     const char *propname,
+					     s32 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_u64_array(const struct device_node *np,
 					     const char *propname,
 					     u64 *out_values, size_t sz)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
