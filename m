Received: from mail-oo2-f33.google.com (mail-oo2-f33.google.com [74.125.231.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24A59C960
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202972; cv=none; b=DtsYTQfJFfv1PhFqajykU/u1WpN6WUnY/Wwn0g0Sxz2yr2Nq6/8PnoqMfc6AVYauWtz1saxemsc0W9W7OSuvJac3uVfMC5BBDMYAE+1Iwg4pRouHqulbw2iZygRMB8UdWkZcsXgUFlw57mZVElkuqVFtDsAK6/m1DCELTGqZOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202972; c=relaxed/simple;
	bh=ATqajf/gbOgVHOHG+dtgeX5M5jVEAjDksP/Pl6A4CSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/p44tG4hxnRVoBN9yeZiNN2ayB+YPQDsaWk80yAwZ7r41Pt6BY6EsgZYN9g+5HS4sY/5SsKqJeMNAuToUeHk5H3npgUMusLef9MqJnt6nejGIM3c+yOpZ/8YuzN3d8agPRd9gWPizxANFzW25eei4h1WB6za9lhN39uPhY7tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He9UO6i3; arc=none smtp.client-ip=74.125.231.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He9UO6i3"
Received: by mail-oo2-f33.google.com with SMTP id 006d021491bc7-6b1ae6a9aeaso896350eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202966; x=1790807766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
        b=He9UO6i3I/LzHDFkvF/3gecqrO0Viyu5QzgBbJTN8DMLtxzjY8Jh1msstmxIZv2j2p
         6LAzhACGkXkH40WdFXrfHYCKlv2NzKs/GUY+g+yaDHdLPL9xxrUdSn/S5dQbMejtGfmR
         MYQEtG+BDHVYbS5BqANO9imsmRW0mP6gtPZe+x5xe3jV/lU5+75fHFFtW7qZG6lCSXza
         a20VYyO4INQppf4XDgNBS7lG9IFIZziNcz6vhOfKCrAojjLAbW945+HBLFwU6/a9azNG
         ilxkGy86TH7i8AaulnFBjcGQ8Yc4m2N3QSiSSUNLPhBFZ6cIGtv2aqy8c2yd/nnn0I+M
         hzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202966; x=1790807766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
        b=duRyz912hVBbXG5vFyQGGhA+5qUtrFRthcRY9jwfutw76/7q43UQq0zxsWghKwQOUW
         E55/HQUAXxFKB3TQhxoNDJyIwRmEGK1kaa6sGz/4oHkCzvvHMWT0GoLit7YQDotkjWot
         qyCZSP5FfQ/eQSe45xodSjct0E6asDcaTT5A4ix+eMJ8sq9U7/M4CrYzpBJVIlWdoXvJ
         fMzqWs+7XhaiegWQJ5AUkraJs9a64rXDiF3OyhXKdJD9t8C2HPj1VsWZkx8/8ej8HZDQ
         AzJLtwWPbpIS5TjVukvggMmPR1KOjPnHYHK4nHVHSOZU9o5tJQqH1sOvlAO9IRt7xljM
         v4KA==
X-Forwarded-Encrypted: i=1; AKwUvBxHZtjaPQx/DTaKfxv7jtw4nXThLRJJceuGmEfbh5sJlgxbn4hRP+1BG3HWZ+BbiQiUOiYvVuVhxg==@vger.kernel.org
X-Gm-Message-State: AFuF++mBhUHFe0kt1rSFNvgs9gVkAmRYGsxoEvIw5N8gG9kMdFi9dPim
	gYxicdue/flLrUG3IhC3AGbEMCqz6CsWa1Dcs/k2hssyn4raKUgW2drsqV1c7ipy
X-Gm-Gg: AYBFou3kjfCUFK55luWAx0D/zTbm3qxefkS5s60IHfEbDZJeZmR/Z8FDgjq7gABy5FH
	eAvY0u8Bb+TyWmG046MRr7S8MylvFtYnXAWogU6ebPGoswZpKFDd/WyDmyZ/XkWt3ES4EKhP8+Y
	XXb/2JIWfrpDTpaT7nyY7U1IzhaelQZXtXNooQNoOoAxWCobQUErSPsvKOdiZgogdnxpMx4haPV
	/aAN8H4Su5k5qWxrqYCDm2GiOmS7XaJiwZQBb3PVI2xQs8IJmffjOBblpB5JKD42h9vIsPDQwJt
	2GmRqm666wyjvUMnOpvuyhzqms69XgpJYIjsgwo70gKXYVdfBqF2kqXFNEGzKP4MWaaWXqDy5KH
	S2DoSczE2yt9L+2hEQ5+IcGmS9jUaMvbEBEVpD91w5/7E93G721C7071booJd9zmvOaJX+qBc0S
	646zOWR0j3Pbgjuidve7MW2LeKrArSSf6nhpQPdAoDtLc3A7HOrNbW9buvw/zWXeYgnpFgT+GvE
	oi2v5lJkGPJFn7C/WRqdwOW925JuuFzh+WUEVq6Pc+9XYlTawArAxniWtZim/IELi6Ee6NG1Q1N
	x6a0aeJzy5BSkftamIQ1kLgVcdv1eg==
X-Received: by 2002:a05:6820:f06:b0:6ce:7f39:7c2d with SMTP id 006d021491bc7-6d441995854mr659245eaf.81.1790202966437;
        Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:02 -0600
Subject: [PATCH v11 38/38] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-38-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2698;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ATqajf/gbOgVHOHG+dtgeX5M5jVEAjDksP/Pl6A4CSs=;
 b=txBmlIpJKZ3sIAFazKAMFYgulL3i/ZCu8HE6q8J8RnlArxGJutYMSYxdMbkYxGs5PglmSgT73
 lKUC42nhgPMAz+S/DRsl2roh66CQA86RbVYjeWEEbt8mfIoVrvaDPAc
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When the dynamic debug core is enabled (CONFIG_DYNAMIC_DEBUG_CORE=y) but
the global CONFIG_DYNAMIC_DEBUG is disabled, subsystems can opt-in to
dynamic debug by defining DYNAMIC_DEBUG_MODULE.

However, for built-in code (like DRM core) where DYNAMIC_DEBUG_MODULE
is not defined, the macros fall back to the disabled #else block in
include/linux/dynamic_debug.h.

In this block, the family of _dynamic_func_call_cls macros were
completely undefined. This caused build failures (implicit declarations)
in subsystems (like DRM) that attempt to use these macros to wrap their
own debug functions even when dynamic debug is disabled.

Add stub definitions that mirror the enabled behavior and respect the
DEBUG macro, similar to pr_debug. If DEBUG is defined, they inject NULL
as the first argument (to satisfy the expected descriptor pointer) and
pass the arguments through, allowing the wrapped function's own slow-path
fallback logic to execute. If DEBUG is not defined, they use an if (0)
statement-expression to compile out the call while returning 0, achieving
zero overhead while maintaining compile-time argument checking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@intel.com/
Assisted-by: Gemini-CLI:gemini-2.5-pro
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 04620b869832..5e69cf6f37fd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -542,6 +542,23 @@ void ddebug_increment_call_count(void);
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
 
+#if defined(DEBUG)
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { func(__VA_ARGS__); } while (0)
+#else
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { if (0) func(__VA_ARGS__); } while (0)
+#endif
+
+#define _dynamic_func_call(fmt, func, ...)			\
+	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc(fmt, func, ...)		\
+	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #define dynamic_dev_dbg(dev, fmt, ...)					\

-- 
2.55.0

