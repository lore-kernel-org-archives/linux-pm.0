Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589B3358D6
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279735; cv=none; b=c6oKn8FL0XZQPWYJ1FQ0uROLGFPwPXzyRqsk6dXv7t45359fD1x+5CwqnlToZFt6M3PDkxLE2zB+HPn3Dq8NR2vr/XBzAKB4e1ZD9z/0AGrUWNKAcYMiM68TVw+jfK3oSN1/yslasTte+SpH35gkAgT52Jr23v9IBOTKr6Jo2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279735; c=relaxed/simple;
	bh=jgoLyTJUC2DaQZjW2lRPv7tRz+Xp8O5y2vmzcJ8Cqow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scflXPMz+cHEw2lGtkNGUR3t2axw9oq/rpImxsXvFroxBNIND4mTZ+zUIE85XsHtn6xNjxvIOuek+xlA6WtY7pxERacGpjVqzvhQkJv0ZPYQIUkBdfVUndoFGjuhBuo9G3PJnYpEQ80wEUzIgBlswmydh/4PHfUDCF8Uqw+EUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6a8oGki; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6a8oGki"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bb962ce4dcfso379343866b.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778279732; x=1778884532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZDAeJpt5wP846YrGUXohA2+OtQiagVtYiHK2L2jIog=;
        b=n6a8oGki+F0myMefY3vxUFae7RzQf3lPLpI3syQYblSrHrnX/fBSTuu0RsatUWYCwq
         f4vj+UGDfohFjo6McZQiFqlh/6WiQ0l5LIlK6I+Rcz27IUTXQN3ey/aycM4TyQekZ0RP
         dZPqPlFPtdrcpG/6WkS9Bkwow9jjPCjyydCd+eDPY+rT0Cb1F1Poap7/HLt3P3VzPJnO
         gUyRHDY+wRUGDqK+euvve8WFYo1pCBumkzfcYj7iTkhupNlauc42tTYEitR7eFkNrRIB
         U2WdW/xXCfl4TIH67hdLUhoki3f5DBA1PhYRapC9mrBhmTGB89Yu4m4MvLVWG9VMW/cZ
         PHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778279732; x=1778884532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZDAeJpt5wP846YrGUXohA2+OtQiagVtYiHK2L2jIog=;
        b=qaThzVRnZmTZlmT4Qvof4+PLPn90xJE0CNUUPcn2jxqZOhXHOQJ0c9vgKnCZIP0/jE
         RcDK5RWMwOowlDkX0SpBTD09PvOASBqhrXKlTW04dwqtij1p3Yby5Feo32YXF30AejZ9
         QwgtKRUbUB+R2HD+rkLfPt7YkcVJWUKyb810N9Y1/RHpnIMzIm2Zo0SLSIgDJleGVkO1
         Ym1uNriTrUIsn8xnjLLgAlpOZ5ZLx7yhEws1ppK0K2qmXIe8LQQ1zOw4jviVnuUFzEtI
         +JrNqq46uMLM/jzVt8pE1tSNlj65RN3+0Ozf9LSoDCzXsaQMhKUefmrMhmYDLYfsRc8H
         9Q1Q==
X-Gm-Message-State: AOJu0YxzxTDxLP+LfQUDKuOYCvDviOSxg0mI5dZCdy4GEGs2SMuXG8n4
	+vfzw+OXiVg6IjXlFrJ9fH62vMpvMTJOBZ+7V80b1nAA1hBSWK2QN9rX
X-Gm-Gg: Acq92OH5hfrodA1eL3m7/BUfVua0DlQTD8XpN+U9UKbnOCy3Nb8KYMDCVPJzm70YOup
	T8hLs+vWDLkNf/mGIL1Qi9Bfw//7g3kkzobZ+z6+RREV19vCqha/mjNxZAZ0kaizZzvQbiBp0gv
	tsD+lzUXWxZJDib410Grh3BEzWg4RxPVN32fpJWvpvbwLZ1RplqVtPJLHGhXX7zR9cox6iUXkJK
	QZZ8s+NXEm5znrEmzE+xBzmTQSuIAjrb2g4E0IPxjEm5acv2lT+gMiD3josFX2GdgeRrd4hu5mw
	E23tNLKc2IkR90V12TiERVqbVrUGu+U2WRlAJXrL5wEMdXXt1Ra/E5hui7TI1hs8ZaxGad1Z4ff
	bHyX6Ae85hCmWy8TOFS00auvEJP66ExX0p3nV3TadZQgl5Pk8U2TseNyeyWdeczvfE2aduKIHQj
	+t4nCgpfnQRGjT048ilRUiR41+l5fI08d2kI5CZwKjFVKNSKvg6ld4rWdLMIyt5NynMKPqRIv9k
	cK2U6nD
X-Received: by 2002:a17:907:fd8a:b0:bc2:1dab:3ea0 with SMTP id a640c23a62f3a-bc56aa45b32mr789198766b.8.1778279731722;
        Fri, 08 May 2026 15:35:31 -0700 (PDT)
Received: from powerpenguini-l140cu (staticline-31-183-167-127.toya.net.pl. [31.183.167.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3a8063dsm143968066b.41.2026.05.08.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:35:30 -0700 (PDT)
From: =?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
Subject: [PATCH] cpupower: Implement powercap enabled setters
Date: Sat,  9 May 2026 00:35:24 +0200
Message-ID: <20260508223524.1314573-1-jaskiewiczteo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

powercap_set_enabled() and powercap_zone_set_enabled() are part of the
public libcpupower API, but both currently return success without
updating sysfs.

Write the requested value to the matching enabled attribute so callers
can actually enable or disable the powercap control type or zone, and
report write failures back to the caller.

Signed-off-by: Mateusz Jaśkiewicz <jaskiewiczteo@gmail.com>
---
 tools/power/cpupower/lib/powercap.c | 43 +++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e5..6d8b83428 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -70,6 +70,27 @@ static int sysfs_get_enabled(char *path, int *mode)
 	return ret;
 }
 
+static int sysfs_set_enabled(const char *path, int mode)
+{
+	char yes_no;
+	int fd;
+	ssize_t ret;
+
+	if (mode != 0 && mode != 1)
+		return -1;
+
+	yes_no = mode ? '1' : '0';
+	fd = open(path, O_WRONLY);
+	if (-1 == fd)
+		return -1;
+	ret = write(fd, &yes_no, 1);
+	if (ret != 1) {
+		close(fd);
+		return -1;
+	}
+	return close(fd);
+}
+
 int powercap_get_enabled(int *mode)
 {
 	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
@@ -77,17 +98,13 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
-/*
- * TODO: implement function. Returns dummy 0 for now.
- */
 int powercap_set_enabled(int mode)
 {
-	return 0;
+	return sysfs_set_enabled(PATH_TO_RAPL "/enabled", mode);
 }
-
 /*
  * Hardcoded, because rapl is the only powercap implementation
-- * this needs to get more generic if more powercap implementations
+ * this needs to get more generic if more powercap implementations
  * should show up
  */
 int powercap_get_driver(char *driver, int buflen)
@@ -180,8 +197,18 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
 
 int powercap_zone_set_enabled(struct powercap_zone *zone, int mode)
 {
-	/* To be done if needed */
-	return 0;
+	char path[SYSFS_PATH_MAX];
+	int ret;
+
+	if (!zone)
+		return -1;
+
+	ret = snprintf(path, sizeof(path), "%s/%s/enabled",
+		       PATH_TO_POWERCAP, zone->sys_name);
+	if (ret < 0 || ret >= (int)sizeof(path))
+		return -1;
+
+	return sysfs_set_enabled(path, mode);
 }
 
 
-- 
2.54.0

