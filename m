Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421A47986D
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202944; cv=none; b=noTipbnJMWjD40v1+4Vm1xDJif2PX3S5+BMJNSM56fhQiosWaBZ+1mTObS/xUaXhN/il5hf7Q23EE7sJUteQa/GbkAKtOyb57lJp6SccTMRSD5iljxV5L7+2e916K6t8MzxRGn1K67R2Lx+aFtMwi1jQF+fcRWMAsH4U1BNOdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202944; c=relaxed/simple;
	bh=FxGWl/qZQ9hT/MhWXIIatHIxLIqLkDD4kgaac7ZQZeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzHkLpR+6x342auizzmMZQm3Hnp4UFIZ18VFGl7uTr+Qd8/1fTiQ5vNxmOYg2eHkD3FN3JIdrTtRlTFd68uv23fkkdZih4hpiRfQFjEUwk7DBayxQA28aHiLZ9gL+QRJYpHgZ+qK+ACLhjMLeJsCzvs7029zlyqLJOyOmIfJK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyLOChST; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyLOChST"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae736c64so1128730eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202936; x=1790807736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRZpLbtJtk8hyONJcypVVqJfATknkih6inIizr3T0ts=;
        b=pyLOChSTgd8LF+g5V9NCzTu31ZTM9gbjB5DuxLYZCGPLVSNEQcOgYHp+pN2K9cyMgZ
         FwiotMZeeFm4SPn2N1JgLYRd2eFHItCYr+8Kp1hsygZFs8j7moQRvymUARozHgLwqiFT
         hX8UrqDjtxJ5b0A9XfLhadcs40m34HlVyBT9OkT0dYiCADcaHuiBYKBX0YCqQdBUWfib
         g22uVkiwVZQKZhNbFBTO6r54JXHyRizzDdP2dKT99rY0uGVuRnZa5/cnuq8ETLb6JB3K
         mnYGtP+0oxdYSyKQi9NFHXZP5/bhbemEeHB+DbtVkjwzJypKYYSm6RjyzhOaNVYWf6g0
         vY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202936; x=1790807736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRZpLbtJtk8hyONJcypVVqJfATknkih6inIizr3T0ts=;
        b=gEiXtpapnddF5ZFhEXqUntLcqhAVjSoMf4UTm32OpSQI2Y+kHBwthMWyUmLCbtp49N
         SZEnomrhev8L80pYUf5LB6XlyP2BvzchIwxFZ42IVeFyxjgodyoPrSYdTf1DE/9QtruR
         UjvytSrDBBkllIoi32TGXvBDZR2gFBW9DAMSGJPOd4XW78OpDtusxd49NfYxQtHXvRZ6
         7bGeVhNtiCFY+ieVx8lBHypm8fcZzL4UfiRyDDxhK+0GR9aT9kQg7tMPmzCpNdR2YxsN
         aLho58LrBm0wjsqZ6vg3nPD3dhPeAtDJJ+RGrPtWegfAoRcNxCYhLk0gih+qHT+V17Si
         IA4A==
X-Forwarded-Encrypted: i=1; AKwUvBzKvclld0t24BcxQ+JpkFFsem84oQ0N/wHWdK6S3PV/lKvyHG5SoE2OD1nWyYBx5gkWCh6LMhrXsw==@vger.kernel.org
X-Gm-Message-State: AFuF++nbdG0Z8Hksp3lHnC0ZmN/7ywy7HCCawXb28szIBuzzl/2YAWAV
	2r3Wg8Vh73qLOMYZV/s7LKGsUabNLXqCYqBAU19rK0a+PRPzqoVPE7aO
X-Gm-Gg: AYBFou0VdTJMW6536eLsA3NXv5X0+xCAM9H5P6lSxZOMRnMATt/0UIyPUUGCuHd4xi+
	0n4Oop7bk7iV+XyNimtts+ET9T4POWdcKGVuPQeo5fJcfmF3pYif1+YtGRHFgap5BhqM2bWIoC4
	uQ4dAHx1epWieoRC+/dTHxREmMeoMevklVE6T1Y64Fab1DvAymhXCZCYqhNKObZkfqVRh2KI73f
	UM/dUizwZDwY75LAJFjcrnw8Cbipt5n/q5ojLBdWUB8NSusBFe1YKGJ77kRkthAN3h5DPz12Xc7
	AkuR7JuJWnJu860lyL0PgQZqJMC7VEva851NYTRDfVywRHAthZ+b7/7u1yFDnxN9iQdU3UWxQ7F
	bvlOPY+6XyjKRwwGSZlT5yWqN9kCAYg4qumUA07P3YASVk8J5uHkbVQVtL7gOn8Xwz2PJalTLlf
	gYJ5PjR/k0lfCMj9QYHbeuSi691CwfnrahGp/lrSN3H37bmkheVcjL0GY6ymJpEajeAxwEv+QIe
	oDolSTxOTouwZxbbqhR5Tt6kuNsHkT/l8XT6qI3iYdgRPYpofHTki5dcGFdSq9Be0IVBIpjko6c
	AQy/039gR8P+K+FtpQ8=
X-Received: by 2002:a05:6820:81cf:b0:6b7:8415:d77f with SMTP id 006d021491bc7-6d4410d98aemr809891eaf.42.1790202936233;
        Wed, 23 Sep 2026 15:35:36 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:35 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:49 -0600
Subject: [PATCH v11 25/38] dyndbg: detect class_id reservation conflicts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-25-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=7918;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=FxGWl/qZQ9hT/MhWXIIatHIxLIqLkDD4kgaac7ZQZeI=;
 b=dVnpdnVOhsyNH04hJqkbikqFWgQdXmK6tpT9ciPy6PMExQXjwbLQEkgwvbXNl4K2i2abW6I3+
 D8ms/H0SYtrD+fKH1KvHYK9fntToOELaap1NkvJwjPINUlJd6IWnIpl
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

If a module _DEFINEs 2 or more classmaps, it must devise them to share
the per-module 0..62 class-id space; ie their respective base,+length
reservations cannot overlap.

To detect conflicts at modprobe, add ddebug_class_range_overlap(),
call it from ddebug_add_module(), and WARN and return -EINVAL when
they're detected.

This insures that class_id -> classname lookup has just 1 answer, so
the 1st-found search in find-class-name works properly.

test_dynamic_debug.c:

If built with -DFORCE_CLASSID_CONFLICT, the test-modules invoke 2
conflicting DYNAMIC_DEBUG_CLASSMAP_DEFINE() declarations, into parent
and the _submod.  These conflict with one of the good ones in the
parent (D2_CORE..etc), causing the modprobe(s) to WARN and fail.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v11:
. only increment mod_ct when ddebug_add_module() returns 0.
  Sashiko review complaint (patch 25):
  "Is it intentional to unconditionally increment mod_ct here? By
  changing this from a fatal error to a warn-and-continue, if
  ddebug_add_module() fails, the inflated mod_ct will cause inaccurate
  initialization logs (vpr_info) and an incorrect calculation for memory
  used by ddebug tables. Should the increment only happen on success?"

v9:
. make ddebug_add_module() failure non-fatal during dynamic_debug_init(),
  logging warning and continuing instead of tearing down all tables kernel-wide.
v2: RvB after SoB

old-v9 - fix WARN() by adding new 1st arg 1.
old-v12 - drop maybe_unused on range-overlap fn
---
 lib/dynamic_debug.c      | 73 ++++++++++++++++++++++++++++--------------------
 lib/test_dynamic_debug.c |  8 ++++++
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8c314a52d8f9..64ad70738d95 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1102,18 +1102,19 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_map *map)
+static bool ddebug_class_map_in_range(const int class_id, const struct ddebug_class_map *map)
 {
+	if (!map)
+		return false;
 	return (class_id >= map->base &&
 		class_id < map->base + map->length);
 }
 
-static bool ddebug_user_class_in_range(const int class_id, const struct ddebug_class_user *cli)
+static bool ddebug_class_user_in_range(const int class_id, const struct ddebug_class_user *user)
 {
-	if (!cli || !cli->map)
+	if (!user)
 		return false;
-	int base = cli->map->base + cli->offset;
-	return (class_id >= base && class_id < base + cli->map->length);
+	return ddebug_class_map_in_range(class_id - user->offset, user->map);
 }
 
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
@@ -1123,11 +1124,11 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (ddebug_class_in_range(dp->class_id, map))
+		if (ddebug_class_map_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	for_subvec(i, cli, di, users)
-		if (ddebug_user_class_in_range(dp->class_id, cli))
+		if (ddebug_class_user_in_range(dp->class_id, cli))
 			return cli->map->class_names[dp->class_id - cli->map->base - cli->offset];
 
 	return NULL;
@@ -1396,6 +1397,20 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 		__di->_vec.start = __start;				\
 })
 
+static int ddebug_class_range_overlap(struct ddebug_class_map *cm, u64 *reserved_ids)
+{
+	u64 range = (((1ULL << cm->length) - 1) << cm->base);
+
+	if (range & *reserved_ids) {
+		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
+		       cm->base + cm->length - 1, cm->class_names[0],
+		       *reserved_ids);
+		return -EINVAL;
+	}
+	*reserved_ids |= range;
+	return 0;
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1405,6 +1420,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct ddebug_class_map *cm;
 	struct ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1436,6 +1452,13 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_set_module_subrange(i, cm, &dt->info, maps);
 	dd_set_module_subrange(i, cli, &dt->info, users);
 
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+
+	/*
+	 */
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1453,6 +1476,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
@@ -1495,14 +1522,14 @@ int ddebug_dyndbg_module_param_cb(char *param, char *val, const char *module)
 	return ddebug_dyndbg_param_cb(param, val, module, -ENOENT);
 }
 
+#ifdef CONFIG_MODULES
+
 static void ddebug_table_free(struct ddebug_table *dt)
 {
 	list_del_init(&dt->link);
 	kfree(dt);
 }
 
-#ifdef CONFIG_MODULES
-
 /*
  * Called in response to a module being unloaded.  Removes
  * any ddebug_table's which point at the module.
@@ -1554,18 +1581,6 @@ static struct notifier_block ddebug_module_nb = {
 
 #endif /* CONFIG_MODULES */
 
-static void ddebug_remove_all_tables(void)
-{
-	mutex_lock(&ddebug_lock);
-	while (!list_empty(&ddebug_tables)) {
-		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						     struct ddebug_table,
-						     link);
-		ddebug_table_free(dt);
-	}
-	mutex_unlock(&ddebug_lock);
-}
-
 static __initdata int ddebug_init_success;
 
 static int __init dynamic_debug_init_control(void)
@@ -1636,9 +1651,9 @@ static int __init dynamic_debug_init(void)
 			di.mod_name = modname;
 			ret = ddebug_add_module(&di);
 			if (ret)
-				goto out_err;
-
-			mod_ct++;
+				pr_warn("failed to add built-in module %s: %d\n", modname, ret);
+			else
+				mod_ct++;
 
 			iter_mod_start = iter;
 			modname = iter->modname;
@@ -1651,9 +1666,9 @@ static int __init dynamic_debug_init(void)
 	di.mod_name = modname;
 	ret = ddebug_add_module(&di);
 	if (ret)
-		goto out_err;
-
-	mod_ct++;
+		pr_warn("failed to add built-in module %s: %d\n", modname, ret);
+	else
+		mod_ct++;
 
 	ddebug_init_success = 1;
 	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg_descs section\n",
@@ -1676,10 +1691,6 @@ static int __init dynamic_debug_init(void)
 		   0, 0, 0, NULL, &ddebug_dyndbg_boot_param_cb);
 	kfree(cmdline);
 	return 0;
-
-out_err:
-	ddebug_remove_all_tables();
-	return 0;
 }
 /* Allow early initialization for boot messages via boot param */
 early_initcall(dynamic_debug_init);
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 34e51996aa20..3a69cc3cae6d 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -128,6 +128,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 			      V1, "V1", "V2", "V3", "V4", "V5", "V6", "V7");
 
+#ifdef FORCE_CLASSID_CONFLICT
+/*
+ * Enable with -Dflag on compile to test overlapping class-id range
+ * detection.  This should warn on modprobes.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*

-- 
2.55.0

