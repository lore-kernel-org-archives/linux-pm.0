Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF894480359
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202885; cv=none; b=r+O8Lgi6i1ixhOro+qx8KDMZk1+t84BcahbV5+58u2Xu4XgowD55TzhBYb05ultS1W6zAw4qPsOZoZHOSoZR59fmQuDGx7Gng9y2pcQWG5+AAp4/57QcwJHZqpvr6bPQmzSGutXwEhXsNcseE96fBqaxS6ST1ikAiUjtCMrXNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202885; c=relaxed/simple;
	bh=6qxe0gy40UPEdl0jWeVq5+K3tVsIJlZLuSqprPmS8d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYc08gZrEP3t9jGa+tHTZKfwaX4jGfWEIHK6kKLtL+zcDe7A4m796kFFLDHtKB+VW2DXKyARRuUhQ4KDSJK1BlCCSIq/iQBvOpuPU8XsTlZVp8c1UYYNPdg5vr3jvKXFDy86dfLlvON1eSfLWet24FkIb4PPpFpBUaHXCVYNb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7UypNpx; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7UypNpx"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c63so921625eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202882; x=1790807682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnMlaIiyV9uCkDgs9M5hIDK+zz/c3R7cHWP4ep9lWHU=;
        b=U7UypNpxlVShj9rYNOoyccV1Co6CKM3+LNrIgKc9y0bTqUx217TeKWbyMw0aFLEr1n
         E4JvoK8BPyKj+fbWol5KfeLjYTkcYY4v1hf0hy1nbDdPxoRh+ChMJY1fmjwdINqk/u7p
         tjVw+NlYmOzgajW/mABVFGZadsgUTyeRvwFLD1liR1CNOCEpn4jh1MpfmD5/tD4v8st5
         8APDqD0xt6C6ChvyzadUsB2MHKFCA2+Ve9lD7o8xeSWd1QgtT+fVw+fPWvPHCoEw/ybS
         eaQGvUlclJf+OLtH0Np5zGoXXO5o9YmZWVYe03TcpPE9Kwd2OIBh8FqqaaJP2G4Rvg/w
         hHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202882; x=1790807682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnMlaIiyV9uCkDgs9M5hIDK+zz/c3R7cHWP4ep9lWHU=;
        b=2xHAimX5F7cd0D7XtA4vzl7Ti3gyAEErmGeHI+/hQw3pjuDPufn/uDEZXSB/4opWxX
         64rcoWh15WhgVKahSiYNM0OWvlnbE5jBzyydlE54/p63OAsVIDkRAcq+oPOqRqI5odWI
         ZE7F4Ji18poKAgCuUKxvKox0Uc6hmGFHTXwVEXheEIipvTrja3/5sGe4a0NsFm3LuXl6
         BArXdedbkYtmXPZLK1hAftH0Sy7GIPuGCJYqJQSIMnQitrJfVrDGZF7WJaqESp7/1kvH
         Clvzx0VpCqCnpPvu5wv3n5U8Gm+zRMjJJpar27lym/7QY76L8KOxzNWuR1WPhRKGGDwp
         OS9w==
X-Forwarded-Encrypted: i=1; AKwUvBzl8afHZMOypRfIaIs1htEvhcV4kdLa9pRn91NkxVwOYDDIux6/o7tIaOSfR3I3KOICNRIJ6GIIaA==@vger.kernel.org
X-Gm-Message-State: AFuF++msXPc1s6gGcuSR2QjnzDFL6OCKzIxpjXRHZdGfiXBAIc2Blsp6
	nGoRYad8zjaJFkp2R4pqBv2T28wuLWLE+pH8bQVdpFZImHgA3POoFnyK
X-Gm-Gg: AYBFou37qgjhvpL6S7uM1Fv0861bUqlZn43JxpM9FN8QSqsXmCUagCSbWTvnNfrv95m
	uSWbxzS01y9xUin6oV+uxsN/4r4pLn+WohtN864NgQ57ZruN8an91jkpK47RqZuewNBBVaNb6zM
	qLJKyNJK8XKYD7ojjNd+iDoVh01y/gW9jIYMobdLG9ApEHRuGh8ORZI9v6Qc6v6lOcBOwswsKVX
	YlgXcO7NlSaiakTTSEY83xBWF3XGF6TqFbjt6KVsvPxRdcMeTSQgtjfsBA8agWDlDIMgj7eOYa6
	y7PLd020vURWL2y6hvjurIBDwk12YqcFUZw7XsEreMRiKiLfasqwgjXPboAstnV7SCtrN/pVHAe
	ZBTRukoJN8AifPIIBTu1b91qQlGIpFv3P6Y2EwMS2NBhkfXcs/CuBViLcJGmyGoN22f763H8F4/
	4CM/ChkaK3pPfBBheNoEPS2+XJ1jbG8kvcCVU627SdRfj2nL1nDiBbs3cfVVrPGZMR4eRmm1Au6
	V/FnTEQxasL2ilsSNzfqukYZJjzwUwMNwlEdzi/VX0m+/fGOluvQz/rfL3JzSStc0vlM2QScra/
	etagvQ3aIt/+iVlWPmE=
X-Received: by 2002:a05:6820:f02f:b0:6cd:3fec:de73 with SMTP id 006d021491bc7-6d441b81d40mr645833eaf.73.1790202881675;
        Wed, 23 Sep 2026 15:34:41 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:26 -0600
Subject: [PATCH v11 02/38] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-2-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=6qxe0gy40UPEdl0jWeVq5+K3tVsIJlZLuSqprPmS8d0=;
 b=SbE6VLJkKQA4ZmuNShacCQ41GeiHEqiikvRAmn7Y/poA+1ah98T6vCjhM8agKA4SSUV1iLPsi
 lAjSmEq3yPPDEM+C7k7FjZCi5nPx+bOkRUPxtSyMlpAUpaE+b8snz3X
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NOTES:

These macros are only for use in vmlinux.lds.h, where the _start &
_end symbols are needed.  Modules keep sections separate in ELF
sections, with their boundaries known, so the _start and _end are not
useful, and may confuse tools not expecting them.

This patch ignores a checkpatch warning, because new file is covered
by "GENERIC INCLUDE/ASM HEADER FILES" in MAINTAINERS

CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3: move include to top
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 31 +------------------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..8c29293ca7fb
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
+#define _ASM_GENERIC_BOUNDED_SECTIONS_H
+
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_BEGIN_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_END_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_label_##_BEGIN_ = .;						\
+	KEEP(*(_sec_))							\
+	_label_##_END_ = .;
+
+#define BOUNDED_SECTION_BY(_sec_, _label_)				\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
+#endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2187fb463de6..019072d3d391 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,7 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
 
 #ifndef LOAD_OFFSET
@@ -211,36 +212,6 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
-	_END_##_label_ = .;
-
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
-	_label_##_END_ = .;
-
-#define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
-
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.55.0

