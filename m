Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2357F728
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202899; cv=none; b=dEGqT1dK7v1ieM7UtyDJ/JT18LKVhNET0TuRDoPTEU0RyIAunjkqMHdUGU0owdLLO5BoGSL3dguA5dnjyDe7MsWExvQCzzxDMEgndjtJ05qA0Qj+4NNRU5KCGi1sp0VE5aN1gfH3146rpJz6zsSL413ZlqXY1DrmM1/vnHq4lsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202899; c=relaxed/simple;
	bh=Ea2Lf2NOIb4xfOxyj7JKgPRMz10QHHz8z+1IIkR3nVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhWP54tjufXO6r2tKfYEQqIzOFmPM1AJbbY1LcNmWlPSDqzywU/lx0HCmQkErUcazKeIdCQYzlyyHCIdp1iMCbvxZNRXTZopIJ593fJJWic5ZULrg+z4ApsOQO+AZylIIdncknzNzWvW8+lK1ah2Ds39SKF0eewE96vTfnadOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2mDLzjP; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2mDLzjP"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4906fabf6deso994330fac.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202894; x=1790807694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pY/j1ww3Y8UnMsGPx7zQGy6NPa6GEKgP8JCREIbwugg=;
        b=e2mDLzjPO4nfot00leAVLmf+ToxEEEPQ0fCS3eS5UVbxgLzr6fOFhwBYy60qsclKd9
         305pKhgv/WXwkwI9BdWbQfXBOqm+PqRzJ1m0SaK7DkIAkiZgqKF5pv3sjDzmOVcIVwQT
         V/pCjgKEIvhjIj+/MVLncff+FqwxdWnyJOgToHYI9C1cAey3KmftM0i4awpqq6vMaw3D
         aborQi79n6YHb/8K8e+Q/DVtSRs61jNAlR0hK7XGVK5vl9GFkHolldq48PpoB5AjDeH8
         wnOslq3tIUIYKcUzhH1DQGwB+vr71CJN1y5F4tjjKA8i/T5yqxN79Zpnywozbm7yHMI6
         +Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202894; x=1790807694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pY/j1ww3Y8UnMsGPx7zQGy6NPa6GEKgP8JCREIbwugg=;
        b=p6CwRgyQXr3Sa2VxzjUdNxvw7qXDmrdo6u+3guCIQQFveJd3EkUq2fsdFTh87psHjq
         Pa8fvEKT0B1QV57V6IasL5NPlu5W/qrSGETirwFFDREXLqzjVnRr0xoR+l/kpVpUFFCq
         kzP1EUWfRWF5R7MIJbAV7fclZcXuUCFDJzuDDeXLWulSIDSs+nnlDf/rd2403VEwyCZg
         cRQwn60otPB4hCocEuYOawDbozEOVXMKx+Cv2dgPMGcR52mK6p6HsdeOQjobi3WYYBMh
         DMJlYqYDXHyJporxlPSS5WsZFoaaDK9qRmHE+vBZcJm6HtLt0cFWmlq/FBi03GbaW5Fs
         QRhg==
X-Forwarded-Encrypted: i=1; AKwUvBygRKCy9zylO5/6Mk9OTId7FDY0EKPgp0Z46iZJCrynq2rP/mebVKKhtdW7MTtdF/vyOml6wV/kxA==@vger.kernel.org
X-Gm-Message-State: AFuF++l2zbm2xZpOrHPIxzJN/W4iAgjDQ2lTo41lWSCNE+QD5e4zqhgt
	gzbPXxK0deb2pzHJZX0KooIZIkXh5pqDt8GXPZ6Fab6KRrt/OsR4jUcC
X-Gm-Gg: AYBFou1OKIjeYX4a2saCPN6R9Gvc4NSHiRMxbRr2n28r7eyLyQB9hzikNfU70e0qcPl
	kL/n8wVDwynCz7tVzl9kuIFyCggUVerEfNsTm0mNV5Movnww1I6judQng5QWYK/0QNyKw8QE7o2
	9zNQ9qPAMf3rJkFZHqq7pZu//risooDBNDc6rrOy3Se8gvzuBio+F7mDIac+YTy7ALNj2COBAZP
	h/vBAeiwBM25GIwThn/Obgaa+McZ7OQQ5Fa8MQ2OguN6TJVcBD2MswC7hB/0TRKkzPN2mvkv130
	fsjyIYJTZPaybDpFTmpJS0phOuI4bSdCBvNrcyt40VKvXzMZZQeAlp07K6X5AZ3P1Q8ld9otUdB
	9F46VkkEXFQGCV5/jp7NkwVA8TSFu6vLYgqNuDOO16q/SRJTslph+3S0H2Bcqn5AJb9rTdF1h6V
	6+XQ7RhbR9MKdl/1UGPlB84HFXHlBxmYeNMpzo0yh5jAB+wpOD0B/6n5vwVGOOW54MmugLVynsq
	domtxa6X9dcec0cbrYaihhO6AwaFRZBv+72Cgu6rm5cKzLwZJYUa3kGc6etpWPOj3Ft3w4L14wc
	TluRYCeiFr7apn8AVNw=
X-Received: by 2002:a05:6870:6783:b0:487:31c8:f341 with SMTP id 586e51a60fabf-491e549eaecmr721076fac.19.1790202893734;
        Wed, 23 Sep 2026 15:34:53 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:31 -0600
Subject: [PATCH v11 07/38] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-7-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5231;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ea2Lf2NOIb4xfOxyj7JKgPRMz10QHHz8z+1IIkR3nVY=;
 b=Wq1j33LYlnk4/v38X95dwW7rLmRMFQGkcjeMowlE5C9vXaIuKAiQNHIStsK0SHxoEw2YOGQ1U
 kgs4mu9en9+D9zx428a2j2DNgycLXIGQgxm08Up1gD3jLuugn9wl68e
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v11:
. move doc comment block down to precede ddebug_change().
  Sashiko review complaint (patch 7):
  "Does this placement separate the block comment from its intended
  target? The comment describes a function that returns the number of
  matching callsites and takes ddebug_lock, which accurately describes
  ddebug_change(). However, by inserting ddebug_match_desc()
  immediately after this comment, does it leave ddebug_change()
  undocumented and make the comment falsely apply to
  ddebug_match_desc()..."

v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
v7: elevate null format to pr_err adding filename, function, lineno.
---
 lib/dynamic_debug.c | 91 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 49334d1aa4b3..8682c23b5fe7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -166,6 +166,60 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 }
 
 #define __outvar /* filled by callee */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	if (!dp->format) {
+		pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
+				   dp->filename ? dp->filename : "?",
+				   dp->function ? dp->function : "?",
+				   dp->lineno);
+		return false;
+	}
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -204,42 +258,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;

-- 
2.55.0

