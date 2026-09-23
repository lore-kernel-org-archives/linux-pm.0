Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE21596500
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202963; cv=none; b=dm1AOzGgMCfBX1O0+AKcnQOklbIIwOvGSBERLNLZ7puRrW/5pifpqfK2DrCTMwY3LoJoKzPvg3dYHKPGo3pycCH6E4h1bXrX0z70dgzX7OSY69eUa0gprVXmPrvdW9ZglsfXkYA4kFKO6gyphrA3D8XZkikhTOuSBUYjQ9C/M1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202963; c=relaxed/simple;
	bh=bDBlM3OKBf1bitIDxea2Srxslww3od17iV3usIW+vIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8RaccaQym5G4RYoO1zt+pE4woxEIuFzMTKeC0hJG6sQRdeJb2iOpkFGee6P+ajcHWtxuE359ZFfQyz23UdA8HAhXGfgxXIl1JdnSk+97GT9D/XU6flppS7uyx1/O38h9nltMN5+9Csg6mshkU9Bqp556DAYH+Ff756DDmostuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVdsGlz3; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVdsGlz3"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d06a12d360so808799eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202957; x=1790807757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzrePIK2UG1fsggT5lm/vt0wyrwfQ1fIWAnYfLJvTcU=;
        b=jVdsGlz3FLlRzT4yrbyonY5QLlPd+LhKFai1+XxHnKtGM+VQ1PwnfOyMf9581RAaW8
         YfYHRFvmAeUoaKjEqUxq10tsr+hrNGHqQ+mmf3EswxWL2VtimY2VpKNxXNfFsJVPyEFz
         4NN15ScvLNyHNMw6iqYuGDhs/jXV1D7S9hucJHdBeGaA3Pbzzx8C26QvX/6QwdifBEXU
         VSh73sRiawBQ98LfztZ3CaFmGdswCdla8NQ/A9lWFht/vDFAAtQpju4d4r4yo3FP8JAi
         5JyRKLB46XME2YxfnHU75w7qtpOyob0dsTT4qU4nZdaKQvwyyr1oN+yO0FJM8ZU2Csor
         WSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202957; x=1790807757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzrePIK2UG1fsggT5lm/vt0wyrwfQ1fIWAnYfLJvTcU=;
        b=SWnDDrHpVsJKtO7Jp0TcnKxpkRYbfgfvFqqP6bOk28ZYP2HN0P5g+rGIotUJZdYDtu
         s81OosVsstzx46BeeL35R4DnalCcQRxkscFTMhmZlqAx2bILRgCGQMwbWXk/oXsp3z1J
         bOzY/xj8MIVEeAo9LP1hg2G15WY083bu7e56S09mWiYbAOHv1cfq1biOXMdnZvRgYtHF
         g+oIH+pOCRpINFNmui7/WILZIiHF3js5GzN/8rk3idAnO6Vv+vuXwYvXZpnVNy7GWLmZ
         PL+w1JRg6zJD7uk3v0xzEpRirenBk/VXQSnItLYLCJzUWJG1gyXvm+Hb3R9z/uKy+Cif
         Vagw==
X-Forwarded-Encrypted: i=1; AKwUvBxkK+dfI7Nox8IhuUEMxB0DyXEEiK6y5ZhVhZkqzlNdG0b3kd6G8ze1xdZ17NrePdgvy5qzkU38vA==@vger.kernel.org
X-Gm-Message-State: AFuF++l7ndbZ8zSNW5zewuMfl4ZdmypuFhJMoNwz4miclkBaq14o7wPh
	Kbt2dtu3KO3rWB8b5/v0einNj8S4mdQH/9eJ+rAY/6kPGnhRDyymi5zh
X-Gm-Gg: AYBFou2f0dARRvo1ss5AudMI9zMdvzhMC/3QC9RfDcuoB2fKAPSWiEl8FqIYMyq9Lqm
	tIPO0ZGrsDOZtgJd5disirsaXfBzlgKvUVZLByX3yIC5BArxwpi/i9fJ/P591zP0GKeGxEvKsc2
	NzC7+uSB0JZBB55vaJz/+d0q3Zy+BPv6iZs2kyzV+7E+DO5/WtEKSJBl2WNgYHkkBQPkmw4Ymyb
	PCRzbSE5cKvxN/8erDCtkRCnCA4CHkbKczJkdVKCL7HIPW7djQfQ7mjTsrPPdIPbrypvm6r+jQe
	Fs+ORUtwtttg2l4fyJtHQOCKMkxxfCKsJRS4QDQQcWtKcjI8NM/+n1L6ZEvDkWMahDn2b/v5CVW
	U6LSGoBEHFTB+fjUtOIw7E5hBY1bCJaasqnCAI0r6GllxuLJmiiXFBQhoYMBE367cGqw1yez2xZ
	m3MS/h9UP9rC0hYuCA9cCGqYJ4AtYNJiKmByfwb3r3aKZqg5k57VDpF/h3YEh66GWwAY6SLYfXW
	0XcGSIIu1lK3GfT6lwDXihL+yy0GSnWsIXSllmeUYF0whoPEnYfc6KSowaprfOL1a276EEUvLDw
	QVdLhLfcUaziJ3WvI2oyFlaBjV/nWA==
X-Received: by 2002:a05:6820:60b:b0:6c1:f832:9b42 with SMTP id 006d021491bc7-6d440a0ecaamr669237eaf.51.1790202957035;
        Wed, 23 Sep 2026 15:35:57 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:58 -0600
Subject: [PATCH v11 34/38] docs/dyndbg: add classmap info to howto
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-34-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=7938;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=bDBlM3OKBf1bitIDxea2Srxslww3od17iV3usIW+vIY=;
 b=fcWamNnVEKC0lE/IxMSCBV/GHM18pP+u9tgmuybiw6ZnxkLxSgqRg8tfTQCCvT2QFXuFSIJn0
 eMcZi99HVQNDvFrMTdVU5XhsVkk/gIClmOUA4BHFcT1xUSE4h9tmEkw
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Describe the 3 API macros providing dynamic_debug's classmaps

DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

NB: The _DEFINE & _USE model makes the user dependent on the definer,
just like EXPORT_SYMBOL(__drm_debug) already does.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v9:
. fix typo in class keyword documentation.
. document DYNAMIC_DEBUG_CLASSMAP_PARAM_REF.
v2: RvB after SoB
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 145 ++++++++++++++++++++--
 1 file changed, 135 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index a8962ab22aaf..f5b1470a4b88 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -146,6 +146,9 @@ keywords are::
   "1-30" is valid range but "1 - 30" is not.
 
 
+Keywords
+--------
+
 The meanings of each keyword are:
 
 func
@@ -193,16 +196,6 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
-class
-    The given class_name is validated against each module, which may
-    have declared a list of known class_names.  If the class_name is
-    found for a module, callsite & class matching and adjustment
-    proceeds.  Examples::
-
-	class DRM_UT_KMS	# a DRM.debug category
-	class JUNK		# silent non-match
-	// class TLD_*		# NOTICE: no wildcard in class names
-
 line
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
@@ -217,6 +210,25 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+class
+
+    The given class_name is validated against each module, which may
+    have declared a list of class_names it accepts.  If the class_name
+    is accepted by a module, callsite & class matching and adjustment
+    proceeds.  Examples::
+
+	class DRM_UT_KMS	# a drm.debug category
+	class JUNK		# silent non-match
+	// class TLD_*		# NOTICE: no wildcard in class names
+
+.. note::
+
+    Unlike other keywords, classes are "name-to-change", not
+    "omitting-constraint-allows-change".  See Dynamic Debug Classmaps
+
+Flags
+-----
+
 The flags specification comprises a change operation followed
 by one or more flag characters.  The change operation is one
 of the characters::
@@ -238,6 +250,11 @@ The flags are::
   l    Include line number
   d    Include call trace
 
+.. note::
+
+   * To query without changing	``+_`` or ``-_``.
+   * To clear all flags		``=_`` or ``-fslmpt``.
+
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
@@ -394,3 +411,111 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+.. _dyndbg-classmaps:
+
+Dynamic Debug Classmaps
+=======================
+
+The "class" keyword selects prdbgs based on author supplied,
+domain-oriented names.  This complements the nested-scope keywords:
+module, file, function, line.
+
+The main difference from the others: classes must be named to be
+changed.  This protects them from unintended overwrite::
+
+  # IOW this cannot undo any drm.debug settings
+  :#> ddcmd -p
+
+This protection is needed; /sys/module/drm/parameters/debug is ABI.
+drm.debug is authoritative when dyndbg is not used, dyndbg-under-DRM
+is an implementation detail, and must not behave erratically, just
+because another admin fed >control something unrelated.
+
+So each class must be enabled individually (no wildcards)::
+
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+That makes direct >control wordy and annoying, but it is a secondary
+interface; it is not intended to replace the ABI, just slide in
+underneath and reimplement the guaranteed behavior.  So DRM would keep
+using the convenient way, and be able to trust it::
+
+  :#> echo 0x1ff > /sys/module/drm/parameters/debug
+
+That said, since the sysfs/kparam is the ABI, if the author omits the
+CLASSMAP_PARAM, theres no ABI to guard, and he probably wants a less
+pedantic >control interface.  In this case, protection is dropped.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this maps
+classnames (a list of strings) onto class-ids consecutively, starting
+at _base.
+
+DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
+call this to refer to the var _DEFINEd elsewhere (and exported).
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
+maps/exposes bits 0..N as class-names.
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(name,bits,var,flags) - connects an
+existing module parameter variable (e.g. __drm_debug) to a classmap.
+
+Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
+dyndbg to update those named classes.  "class FOO" queries are
+validated against the classes defined or used by the module, this
+finds the classid to alter; classes are not directly selectable by
+their classid.
+
+Classnames are global in scope, so subsystems (module-groups) should
+prepend a subsystem name; unqualified names like "CORE" are discouraged.
+
+NB: It is an inherent API limitation (due to class_id's int type) that
+the following are possible:
+
+  // these errors should be caught in review
+  __pr_debug_cls(0, "fake DRM_UT_CORE msg");  // this works
+  __pr_debug_cls(62, "un-known classid msg"); // this compiles, does nothing
+
+There are 2 types of classmaps:
+
+* DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like drm.debug
+* DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM - modelled after module_param_cb, it
+refers to a DEFINEd classmap, and associates it to the param's
+data-store.  This state is then applied to DEFINEr and USEr modules
+when they're modprobed.
+
+The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself.  There is no implied meaning in names like "V4"
+or "PL_ERROR" vs "PL_WARNING".
+
+Modules or subsystems (drm & drivers) can define multiple classmaps,
+as long as they (all the classmaps) share the limited 0..62
+per-module-group _class_id range, without overlap.
+
+If a module encounters a conflict between 2 classmaps it is _USEing or
+_DEFINEing, it can invoke the extended _USE_(name,_base) macro to
+de-conflict the respective ranges.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the class'd pr_debug callsites can be forced off by toggling the
+classmap-kparam all-on then all-off.
+
+Self-Testing and Validation
+===========================
+
+Dynamic debug includes a regression test script in kselftest::
+
+  :#> make -C tools/testing/selftests TARGETS=dynamic_debug run_tests
+  # Or run directly on a running kernel:
+  :#> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+

-- 
2.55.0

