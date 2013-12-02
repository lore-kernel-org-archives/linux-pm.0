From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
Date: Mon,  2 Dec 2013 16:20:04 +0000
Message-ID: <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386001205-11978-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Dave Martin <dave.martin-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Mark Hambleton <mark.hambleton-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings are compliant
with ePAPR (PowerPC bindings), and rely on the cache bindings already
standardized in the ePAPR v1.1 document; ARM required updates are underline=
d
in the binding document.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++=
++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentatio=
n/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..009cddb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,25 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ARM processors cache binding description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Device tree bindings for ARM processor caches adhere to the cache bindings
+described in [3], in section 3.8 for multi-level and shared caches.
+
+On ARM, internal caches cannot be described in the cpu node but require
+specific nodes marked with compatible string set to "cache" (see [3],
+section 3.8).
+
+Furthermore the cache bindings in [3] require the following property updat=
e:
+
+- [Table 3.9] cache-level: This property of cache nodes must match the cac=
he
+=09=09=09   level encoded in the processors CLIDR (v7) and
+=09=09=09   CLIDR_EL1 (v8) registers, as described in [1][2].
+
+All other properties and rules apply.
+
+[1] ARMv7-AR Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[2] ARMv8-A Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[3] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
--=20
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
