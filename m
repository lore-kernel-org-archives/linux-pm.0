Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E2598C1D
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202967; cv=none; b=YtxyMwAfLgVK+97zs745xV37kCwB+yHASVu3IxOjbUGBi1XJ+8pbDPRgivRx4ByWskVPJvCGagoGrw/xT8Koi9VyZTWyLgUo57+Kv+ce2QkshwS+Az9jKfNRnbrwlsjvW7ravt90Ii4Jmg5C14qXNRWe52GIku10VfJJvN4rSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202967; c=relaxed/simple;
	bh=dVCVMamiUaB96gu4NX1kujuPDVFnoxAGuPP2zSXDqA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXoJC30ozOj1k074BpRahq6YJpx2kxCDr4aleeT5VN0g2415GN6ztBURmjKXH5mSlk0Lla3Jg4C6SZXZNKTGVS0sr9fXNdx3wXv9zcrDKOOLFfZU6C/D2wDo4tgSqIRjbXvjLfCE+zeWWCMxkSK4bwOjeScNFzfkCy0OF5kYimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la/DfI6Q; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la/DfI6Q"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so1040014fac.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202961; x=1790807761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anf0fctja+VnMMprL/dVwONTSp+dELUQq5LW/V5rUuo=;
        b=la/DfI6QTd1+YOGuL+x1fIC7Dgmsg/bE2W10m+JNaRhlluQESJ62SUM2g8/ZtswlVS
         jbU9PrNEqmve437AfB11EyE3pDakQRMtUgE9aT5EXdgqh/d/4fxV5wEG87Y3MpMOjEEQ
         PbFemXLDbiAInawrxLg2QIrm7FrQH4+sC1IvsyhjQEGuNlQkAa18vcbhkIUg4CPEhhKg
         3yJigbhiOuv/OLpMPWkhZdJrkGkgRb5+t0dcH42LFr56OE10bW80kFaNjLlsB7B4L6ND
         llm+NTVRKe/nIfzE3J6GbdBprMjc64WrCQwznzfu5+9OqiakRmf9Ui8OqDjDHadvqWfO
         /5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202961; x=1790807761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anf0fctja+VnMMprL/dVwONTSp+dELUQq5LW/V5rUuo=;
        b=M8GEUCYsendc1DnC+7HePohWQimxgRRvDjldCGpAVk84+hLGptsiL2RR7hUqrZ+GLM
         5qyYtis3H/C6RbuirKZlLfDe2PTv6JaCTw0n0aJCCavIOqybqIft6dgilhLqKA40ckUQ
         MgPsdu85EhGHqaPbUSur8ytJlZ+NfEaH1IFpY7uOmTX73TMRzMt5vw5ZxrlmaedFD+dx
         YyhWsvIXoS7CYZd1QYYuRjljnuzfNyLXTc3+x/S7lYn6qsLiJ0embABou3Z7z631pLB7
         lVfcTHZ78BKQv2awp6HDjvyNCcuWl2mN9hPS9Du/bsdgimcjj9fTAW9V7pwz5x5EU6aw
         op2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxG07f4GtzQrQolbXHlXfr2IKXSclal6mFjWBZ+vz5xkvGAGXJiJekgHwPk6E82QTzCmnZ3lq+gRg==@vger.kernel.org
X-Gm-Message-State: AFuF++kkM2CfCHhoaWDKCQIzHNZGe50bhlPnImeHwlGveG+qweNNkzDA
	dkdd9BQlo6/Kr91kbQ/O91lFJiHpsJu4Bv8o2Oph2Bvih/m0Kw36ti9i
X-Gm-Gg: AYBFou31sF1zHlEujXnjk7iaaeG3ieM87iq9r+gd5Icj7BvGhXZyXVZBQVOTuyTBHEB
	RUAXwplx3lXJn37zBVFa3FtJhRqXs5XDoBwOXjz5fb/9DFCgNH43H4MzLyWKwHt18rZ/P/hFD5J
	9KNrqwHZYCxge7U1uiL/6HnPmIkiT60EDwYKVGPyuW7P/4Kf7BG2qqK1Dz1KCeiRR1JekIJpgWg
	0fTPmVffVlgMwRdSZBFE4mtFGi+/VbRU/u4w0nxbTNEYTMno6DhdepR9Y4A7PEE+JjQNlrQI7Ra
	BDeB9PEAFcVeixVkq8aqDfNg/f+Km43O4EIcMjsL3RXtlRWWw0DXaJgpHXrMaQv+0g7X76qzflI
	0XG6K3wPt6NaXZklV4bC5pf3ehuHlaLOhjmkdhpCYhmnb5iyqzi3PBETGQVX4tAM6aBDzT2wNwP
	XE6Ldl9GUZkgF4X63nAKebRUN4gxzoZloIS/FNy5xEyjpVoQ99lQo/g11r9dTlEwJLL1c9G0Isv
	7lYd06/zcadt9pbbmSEUEr2Dz+IqxdOdf+V0hcxCp0cCXTG1GPiePfCxUWhSbUkTkYmzefcHHv/
	e0UmAGGN3b/J+3BlgsIA
X-Received: by 2002:a05:6870:3912:b0:491:2ed8:3505 with SMTP id 586e51a60fabf-491e2441c2dmr772232fac.0.1790202961310;
        Wed, 23 Sep 2026 15:36:01 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:00 -0600
Subject: [PATCH v11 36/38] dyndbg: add epilogue to dynamic_debug/control
 file
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-36-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2252;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=dVCVMamiUaB96gu4NX1kujuPDVFnoxAGuPP2zSXDqA4=;
 b=xv600zdesEVIz3KiAGz67sw1u76JqgY26LqYwDj3pdMjhveZMs8ss+XJ/RmWb/HveYQerfo24
 I624GaaLxTQDvfT/Qvyw8uAGdpUY3zCzVd1BxwZnYRc7XkVEOPjCSdX
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Add an epilogue to the control-file, to allow display of statistics
etc, without disturbing the header.

NB: epilogue lines should start with "#: " to distinguish them from
lines describing pr_debugs (and from the header line).  No new lines
are added here, only the place to do so.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v9:
. update ddebug_proc_start() to return EPILOGUE_TOKEN when seeking directly to epilogue.
---
 lib/dynamic_debug.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 098fd2639cb6..88440c1f6abb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1186,6 +1186,9 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
  * read() call from userspace.  Takes the ddebug_lock and
  * seeks the seq_file's iterator to the given position.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 {
 	struct ddebug_iter *iter = m->private;
@@ -1201,7 +1204,9 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	dp = ddebug_iter_first(iter);
 	while (dp != NULL && --n > 0)
 		dp = ddebug_iter_next(iter);
-	return dp;
+	if (dp)
+		return dp;
+	return n <= 1 ? EPILOGUE_TOKEN : NULL;
 }
 
 /*
@@ -1214,12 +1219,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
+	(*pos)++;
+
+	if (p == EPILOGUE_TOKEN)
+		return NULL;
+
 	if (p == SEQ_START_TOKEN)
 		dp = ddebug_iter_first(iter);
 	else
 		dp = ddebug_iter_next(iter);
-	++*pos;
-	return dp;
+
+	if (dp)
+		return dp;
+
+	return EPILOGUE_TOKEN;
 }
 
 static bool ddebug_class_map_in_range(const int class_id, const struct ddebug_class_map *map)
@@ -1271,6 +1284,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 			 "# filename:lineno [module]function flags format\n");
 		return 0;
 	}
+	if (p == EPILOGUE_TOKEN) {
+		/* use this soon */
+		return 0;
+	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,

-- 
2.55.0

