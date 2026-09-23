Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E34580399
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202908; cv=none; b=jWpro2nIzKaNqELD/T0hgDu8zFrtWIaxpCBzbDwdxBy+sGMqcE8szWKugNphnYGm5X6FVCdkPK0sFvIlkmfxMqZNdaC/s9POXT9PGpyQeS7f6wAip9e0DmF+Kx7fdRaAzPepC1futXDCbbDqS87IfERKUCXv/cXXXvXkWIbA7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202908; c=relaxed/simple;
	bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7DdYMaBhTrlIwceZIxGlVKmGoXyp9d3r8l2R9g4IVYQoBPFhp400McXV3sL663TMxUdJAHcvn1kA9HWQ469ZMUsHO+LjuZZdCPRhTlLUu933+MTBJqJo2WSbFEIhcLSsjWqRjLLcE22M97Le+O5Wy5mQdn5l8z5G0UWlthNMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBYvlBlI; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBYvlBlI"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so1559104a34.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202903; x=1790807703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=RBYvlBlIxjFCaSwhOX93o9DSTl1aOfPWgyLmqj8/6kmQz5JRXF24LEYqoauYRK3gjN
         Xf5XA8T+bT8/ihUamWoO7zTYFi6tQMT34Zq9brjTW2w3VnOylWxV8bXYmptTfQBTQ9fn
         SpldLgAyLYoQXkSkd4xXcvilTfHCjNUWjSMfmVTOt5K3jMOClRnj2uaQXPUgKSV+rYD4
         dkHzEdz97oT9H7QBhJNn9Fi0rAQMBJ3t8OjDIDU9BcW8oOjR+Yu1U3lpQ1KbSaLp83mS
         6W/NLI++LgbqL2AqsOgyl1LmrhxcQBdQVYtloheNrywdLAU0h8alYjHWkL+2tpVDUJBY
         m5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202903; x=1790807703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=ILKGWexcImTv/76rSnYyvZ5bMbpZuXF6MmJkFoA8XVKNvs6EC1t9F0i06+BT6KdUmg
         E5kn957p56xd8R7JVJ5a8S3qVcTyC6Rb/h7gZVh6FjFAQiVDfI03ysKnQQVldzzgljKp
         9uB8BmtyncRUNqr32LGQEkNjqn4xq8djF5B3Dg9nT4zEhRE3xrRD5Yl4imU3Zkkngcpk
         PFvQ4+OQcLjqt62LMEL8IyGF/LIz3IFTEq8vNnvU1yXKF3BHpX/WTS/m69sj1oLtyJ4K
         i6UTFO/FMVpd4hRUe/Iue0tbydEc3bIf9AKSEJPpZWqf8jF8KMoqWCFwud6dov8qQJHx
         zyjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/Peatc0hq9N0XgT+uFMhNWUnn9Z8zWlh2q2aqLAnV3aGWGJtQ65r+n3zJx8aZ0Fmm+oMEfVpgAw==@vger.kernel.org
X-Gm-Message-State: AFuF++kHjmm6RREeQ1psb63ZMKpUn8Htov/NpwKMDOVdW2P64hXs+1QD
	4scbOMsOflZ7Vtic6BN1OvK1ZDwDfV8jLwgjkrrsPSAm6k/otJ7+/DQ+
X-Gm-Gg: AYBFou3ud9X187/2VSn/zW7Iau/WJFdxJZxdSCsiv7TmU6KB8DHy8ldkqjDdyNtOtwx
	HJE4g090MZBfgVZjJRwEZS6idznFMV+PtdBQF94pRkR5lV9VupgKrhA7Lul1IxKgCYRxmHEH7j5
	x73u05yBNwKYX6U7rjJiMGgmS0WtY7bDTwtYRBuODktYob+PnMcly4LFDOSeb17dhg2M+MT5TUv
	256/xdQqM9YhxmJlFKHzXC5f+elvHvQMtjnLWJGWR9sRfnmqKrGYlyGuHZ9QNNmIbCVQ/aJMPSs
	gz1eqBk/9Lt7OGVrfcpbKT8LekOznrnET9EZc1TbRqYbf8l+ZiCCpr1TsTgetsGUdAjavXPewSz
	e+4hJdMyfXA6Khg5oDHjq/MEd3QaB6j541J1n7gtpUDdZZmRNqnrEh/XAaaUI1UEcOLK3WVPjc1
	3iR3f0MrVSyvzOS31mn70aL19+qvr+0hiXaBd36jnyD2OPlHjCyMKqNKKTDVRYyKsjEmWchbogG
	YzUdhHrXoF1gB/9Ph0L6D+7JDnGUMbt1zzJSRzv9hextfRLsqfD6fKzTtvaoq0GTgoEsgPxk4/d
	IEAtYjdNIVGahmZX//8=
X-Received: by 2002:a05:6820:3090:b0:6c9:80d9:5e9 with SMTP id 006d021491bc7-6d4410d8263mr670241eaf.42.1790202903465;
        Wed, 23 Sep 2026 15:35:03 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:35 -0600
Subject: [PATCH v11 11/38] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-11-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
 b=Vfs3Matpzo3SccOlI8tHyei1RBD+zxWT7bK0muNastsFT501W8UwskuCT5d6UkNx7lTaofuTx
 osWKhGB+d2uDdbEIEynMyQnEsO2jTiildSPH6fRj2j31Ia/oBayQeVB
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

