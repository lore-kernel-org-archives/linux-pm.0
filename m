From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] cpupower: Use conventional shared library versioning
Date: Fri, 10 Jun 2016 02:05:54 +0100
Message-ID: <20160610010554.GR7555@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p11K2BJEgMZL61bg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44444 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119AbcFJBF7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 21:05:59 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org


--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current choice of variable names is rather confusing.  LIB_MIN is
used for the soname version, which would normally be the *major* part
of the version.

- Rename LIB_MAJ (the full version) to LIB_VER and LIB_MIN (the soname
  version) to LIB_SONAME_VER
- Define LIB_SONAME_VER to be the first component of LIB_VER
- Bump the full version to 1.0.0, since the soname version is currently 1

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/power/cpupower/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 0b85f5915ce8..1ef6cdfd3f4a 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -63,8 +63,8 @@ DESTDIR ?=3D
 # and _should_ modify the PACKAGE_BUGREPORT definition
=20
 VERSION=3D			$(shell ./utils/version-gen.sh)
-LIB_MAJ=3D			0.0.1
-LIB_MIN=3D			1
+LIB_VER=3D			1.0.0
+LIB_SONAME_VER=3D			$(word 1,$(subst ., ,$(LIB_VER)))
=20
 PACKAGE =3D			cpupower
 PACKAGE_BUGREPORT =3D		linux-pm@vger.kernel.org
@@ -201,14 +201,14 @@ $(OUTPUT)lib/%.o: $(LIB_SRC) $(LIB_HEADERS)
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -fPIC -o $@ -c lib/$*.c
=20
-$(OUTPUT)libcpupower.so.$(LIB_MAJ): $(LIB_OBJS)
+$(OUTPUT)libcpupower.so.$(LIB_VER): $(LIB_OBJS)
 	$(ECHO) "  LD      " $@
 	$(QUIET) $(CC) -shared $(CFLAGS) $(LDFLAGS) -o $@ \
-		-Wl,-soname,libcpupower.so.$(LIB_MIN) $(LIB_OBJS)
+		-Wl,-soname,libcpupower.so.$(LIB_SONAME_VER) $(LIB_OBJS)
 	@ln -sf $(@F) $(OUTPUT)libcpupower.so
-	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MIN)
+	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_SONAME_VER)
=20
-libcpupower: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+libcpupower: $(OUTPUT)libcpupower.so.$(LIB_VER)
=20
 # Let all .o files depend on its .c file and all headers
 # Might be worth to put this into utils/Makefile at some point of time
@@ -218,7 +218,7 @@ $(OUTPUT)%.o: %.c
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -I./lib -I ./utils -o $@ -c $*.c
=20
-$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_VER)
 	$(ECHO) "  CC      " $@
 ifeq ($(strip $(STATIC)),true)
 	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lrt -lpci -L$(OUTPUT) -=
o $@
@@ -251,7 +251,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
 		fi; \
 	done;
=20
-compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+compile-bench: $(OUTPUT)libcpupower.so.$(LIB_VER)
 	@V=3D$(V) confdir=3D$(confdir) $(MAKE) -C bench O=3D$(OUTPUT)
=20
 # we compile into subdirectories. if the target directory is not the

--p11K2BJEgMZL61bg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV1oScee/yOyVhhEJAQpVWA/9ERcLlN1uxMdB15l0dW8+vJSWYx5MFIwR
p8en+1wIS9PzlmryyFBJnU2tUTEbzHOFkvwojimb/BbGU2/GPdfZbZJDUcghFz9B
jF/AT7t9mx014bW4ZMVlJOOHvsAC8ZPmQckcDUkTWRzv1ppBekKhgmMrEV8UM6kR
3YqSW53GikyNXn/3XoObs+okSYxx6nCICGtRDT9ZuUy1yRsgj5MEKwW8ODEQwOp7
qKMhs9Fb0DG8pPMiw7Uvuz8fQfEMdmwjrGn3i0DKL/ZWfXgyKo5KJYems2Fv8QhC
z7rBYe2ZuI60fjhKH0ijENJAo3VtLhv57qvwTig1MkMYvByRBHXsCMsSqdwtzQjs
JHhPA5Y+Wz5BGkpG9imndFMf/RWaBXxyCvA9GjL8k9UrPUChZdDnODH3CcuL9z0A
b1JmUkp5OY14jMK8m8ZFNC7g9UW7WW28eVF9T13//Y/hFHyNvLTukXPN1rNgXRtP
tDym7KAw2/CQOEA3k7YkHuF9HhCC7g4KFzwdK3tG6+FYT0aqJtgtPS96+Q0s85Nq
8V4v4pQ4Rfp8OvS5Dn70SNE3upUnKtnksGS5ZW5ghEEe+c9n/VV1lQb+bNvIjl+S
VvSKyS0gc2nq2TFkqtJfNOYqL0NYPKbtuJYN14wb7YOxutqGc5MjBFAqUSFWGfiz
DQMufh7MrmM=
=Og8g
-----END PGP SIGNATURE-----

--p11K2BJEgMZL61bg--
