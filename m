Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154A585979
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202916; cv=none; b=kxfeIoxJxx9Rm9IwVgtj+JcVT56wsGfBeJ47vJIb71DwnoN0+8aQW58yWkH9X6gs2UhkvxcUn4JfUXSL9qdbzQ5QJdw+h3NHn+oP6B/9nyGdB0bJ2FXfc3o0U0CzS4Akefr0KViDCIMxIw+veWQrEw1v6SpvDeGoV+PSJtB3Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202916; c=relaxed/simple;
	bh=PHoWIplF+5KumvZl2vjWPwHFDGEYzydpXULFGLWX+GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ic3LrJeldXOYi0/06jCe4WGAxcRkRoO5vFhURISpYDrlZMCOQGeZ7KdJYfHQNJHx10nyYk0zJr1LqYsMeZ/0Y9MGZD3QQz3aFco5V6CoVGSpnPzxujNAh7DIjybyY1YDnig5oXWaYJ0hezJMTiTXRjnEIKqOkuG3NRYL7dnmnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3NilJ3x; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3NilJ3x"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b390bcab0cso815431eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202911; x=1790807711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEU8DzU4LKP6MP5zfWJjBY2eD90eHdHMK7FISxZUBG0=;
        b=e3NilJ3xbyb/PEwpfWk1K8V4GMCtU9iHuarvkMD6BSq/xw1CLuL7Sa0PecrlaubRcV
         gEH84jgCsdlC6fm1K3bPIznqCGdxDUakwJOacvUO+npr2oTeN5X6lc9Bh5hwLNLas0zh
         WHzi3ODd9BSfuRBkGJGrlDa/RJJ12meP0WNSAL53QGZN7qXvS/Srb/baVrCPeUJf8m3r
         5odELXXEIInNTIRNLmi2FN5nN0foQbHYHpTeu21R8wFLEgaS28dgjugPq6wPmJTPmshk
         Xq/kqKZxUV/nVlyJxd365bQqMgF0/hnfCfMwhtkQzjaSyDxCLmpC3VxVXgReccwm5tby
         7BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202911; x=1790807711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEU8DzU4LKP6MP5zfWJjBY2eD90eHdHMK7FISxZUBG0=;
        b=HyvlVVBGJwISHRltZ6D1szUhHb10gA1DMEyBxbL+q5AlveaOGzPVhUvE0fQGfcHkqj
         oF1f4Vorl+boOVc9h7g8Q/r5BJYeocFJq2heZv0l29Pmy5rUP0zJTiDf4KFXtcIXWR9o
         FYRsQF9tKSCadz6vkuFUSHPOQ/WSQYxeZ+p+0MpOYmrfLQEimFk+sNwd1XF6Yu7hDqmb
         fU3Yw+pXwJKdsN3AnlCPgG27GZ5+3/9VBvrcJBNxrW/X6avdpVQ7F3IAEPgzopxn8PW0
         vkJsoh9wsVQiNOjkFd0nQcOcJUvfXTwTnyrR/FrN1MF7IWMNLp/JjUoXg3cKZZuqsQT0
         FklQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5avlp7PDkh8/mtu22iZGcG2Rm0jc5Nu6wfPmWtNfKMhR63YWOa/mNEv6UGLGbIUKN8+o6RTXcVA==@vger.kernel.org
X-Gm-Message-State: AFuF++l0vAN0eBCLznmZ2fy+e9FathXtBHvtXlcDm8rtiGkg4bv6lUw/
	i6D76+JxNIAVGl7x+2ytA8MFjohUPKuzVp5WPDY7uqjI/ea/MxdE6QJu
X-Gm-Gg: AYBFou0hAZv5SoWOfhoxBrQQ40xg4rjw2DerlJQ3ygZyvd6QaNLgLdy64LIF6UEYdPI
	u2fejQxWebJJQDbm3aFEy+7BLMDuNagD+krd7PY4Wygsr/ninBvmbN71dvYH71YPmiuJqRTCCO0
	dNX68hVTPipv7EV3kgcEbhoSpRZVHWfx7r+JbsuxSl75kaIzRVN3LVXByUVBjJNuGLvhaaof1cc
	7/plPkr8AkjmvddXoW6ft+xqb/sJ7Uydqsy5wPD1xmauEoLDRLmWQNjJkTdFhqOTs8tp9CO8I8g
	9KNnwGavCTilkTP5MdNameIjULcLLMQmD/kDOkRqIa+EGtaokf85OCAB8XVarIFGPywCGhkJJgB
	ckS9X05v2Z2UL6goOd4HFQu5w6NF0MradqAn8XFuPQHPT7Oi2AKNqT2IVzR3ejf3z+JQOOBWsoL
	tqe6B8LPda/CqkhGyq4Jzh+26jToIX8iJS9F1OlYzyposguouP0sLqecgakP3F6pyCP8P6ue3YD
	xlA52u//ipmKXqbtpt3ORpzyEwE3VCnQZvwRhcqUCWvymspsEefqKvTZJ8DJkv37TiJci8xcJnq
	gp5Z6rV3hDaIAp4+D00=
X-Received: by 2002:a05:6820:1f11:b0:6be:4eb3:e1be with SMTP id 006d021491bc7-6d43fe7221bmr682739eaf.39.1790202910732;
        Wed, 23 Sep 2026 15:35:10 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:38 -0600
Subject: [PATCH v11 14/38] dyndbg: Bind callsites and classmaps to
 DDEBUG_MODNAME
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5456;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PHoWIplF+5KumvZl2vjWPwHFDGEYzydpXULFGLWX+GU=;
 b=LjYzw8LB+6ZB21y1mMCWFEMn/XAOgL43i4lFx863vkE7v0z325lnonpCcasvD71zJJpFrS42U
 AX9WB85DgD+DgWvAaQU7P6zjMY5/w4G0hoNtK1VONpxpL4pCJa4wwW5
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Currently, dyndbg binds KBUILD_MODNAME directly into callsite and
classmap declarator macros.

For built-ins, KBUILD_MODNAME defaults to the basename of the source
file. For many subsystems, this fragments what should be a single
module into separate file basenames: kernel/power/ produces "main",
"suspend", "hibernate", "snapshot", and "swap" when all should be
"power". Conversely, multiple unrelated built-in files across the tree
(init/main.c, kernel/power/main.c) all collide under "main".

While consolidating these fragments into unified subsystem names is
desirable for query targeting and classmaps, attempting a bulk heuristic
renaming across Kbuild introduces broad churn and disrupts control file
output across the kernel. Module naming should remain under explicit
maintainer control instead.

Define DDEBUG_MODNAME in include/linux/dynamic_debug.h guarded with
#ifndef, defaulting cleanly to KBUILD_MODNAME. Bind DDEBUG_MODNAME into
callsite and classmap declarator macros instead of hardcoding
KBUILD_MODNAME.

This establishes an opt-in hook allowing subsystem maintainers to
consolidate their module fragments if desired (e.g. via
ccflags-y += -DDDEBUG_MODNAME='"power"' in a subsystem Makefile)
while preserving existing module-name invariants by default.

What's Unchanged:
- Default module names remain strictly identical to KBUILD_MODNAME.
- Zero callsite memory overhead or layout changes in struct _ddebug.
- dynamic_debug/control output remains unchanged across the tree.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h                      | 12 +++++++--
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 29 +++++++++++-----------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index baf5c0853f45..85863e24ad13 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -10,6 +10,14 @@
 
 #define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
+/*
+ * DDEBUG_MODNAME: Subsystem/module name hook for callsites and classmaps.
+ * Defaults to KBUILD_MODNAME.
+ */
+#ifndef DDEBUG_MODNAME
+#define DDEBUG_MODNAME KBUILD_MODNAME
+#endif
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -121,7 +129,7 @@ struct ddebug_class_param {
 	static struct ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.class_names = _var##_classnames,			\
@@ -160,7 +168,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index a7a554bffebf..c279c795867b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -260,34 +260,35 @@ function FT_grammar_errs {
     ddcmd =_
 }
 
-# these queries run against the builtin module: params, and change
-# flags.  The control file state-of-interest is found by path,
-# kernel/params.c, to avoid module keyword entirely
+# these queries run against the builtin file: kernel/params.c, and change
+# flags.  The control file state-of-interest is found by path $f,
+# perfectly binding the stimulus scope to the observation slice.
 function FT_basic_queries {
     v_echo "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP - test requires params, which is a builtin module"
+	echo "SKIP - test requires dynamic_debug built into kernel"
 	return
     fi
+    local f='kernel/params.c'
     ddcmd =_ # zero everything
 
-    ddcmd "module params +mf" 'kernel/params.c'
-    ddcmd "module params +l"  'kernel/params.c'
-    ddcmd "module params -m"  'kernel/params.c'
-    ddcmd "module params =_"  'kernel/params.c'
+    ddcmd "file $f +mf" "$f"
+    ddcmd "file $f +l"  "$f"
+    ddcmd "file $f -m"  "$f"
+    ddcmd "file $f =_"  "$f"
 
     # multi-query commands split on ; on a single line
-    ddcmd "module params +mf ; module params func parse_args +sl"  'kernel/params.c'
+    ddcmd "file $f +mf ; file $f func parse_args +sl" "$f"
 
     # verify multi-cmd input, newline separated, with embedded comments
     ddcmd =_ # reset before multiline query to capture full transition
-    ddcmd "module params =_		# clear params
-      module params +ml			# set flags
-      module params func parse_args +fs # set other flags" \
-	  'kernel/params.c'
+    ddcmd "file $f =_		# clear params
+      file $f +ml		# set flags
+      file $f func parse_args +fs # set other flags" \
+	  "$f"
 
     # clear flags and verify
-    ddcmd "module params =_"  'kernel/params.c'
+    ddcmd "file $f =_" "$f"
 }
 
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)

-- 
2.55.0

