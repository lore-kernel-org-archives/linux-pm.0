Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3C3CFF6C
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869559; cv=none; b=ojusrv1NDFovUvMBXDZC//26NAxKEo9RqSIeYirwRyI0MtQlm6ztHtLcOsCOMgHQufbSCnHCRt6ZKyhu8OLxKOIdxQdVE5ZOwbwRjchosXEMPYZXBM5T9nqD23MPFYNYZLw6eLaMkbRnDvSQ7Nlt/WoC+m0TBrFC6pnsAQdnGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869559; c=relaxed/simple;
	bh=W4q88dV9VxTrbQWDOtogmMurOVzPT5extR6wwZoZJuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwiWHVV9x0mHBofEXLRC5aVh0BcikJQcCN+1ir1BxEz8haKaqW+ENVi7JE4yOqAfliS/bqXkzTX4768gMgR48vz4zEQOnUKiibXjAT8MGozrkiwkbDQGB6N92sjASBFFOSZOWozYq0avy5FQtILg5pIQZ/z60ORXBFfXtO+HRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCYKk20r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCYKk20r"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2105301166b.0
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779869556; x=1780474356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8I5cb9EDSN0CWGopKBTwtEF+OyzEohAwWcJqwzO5iQ=;
        b=fCYKk20rOkIbx3xx5euPaMOIuDjbk0NwitT1KXLXPdxPA4EWSk3dgCsMymqCviKbWT
         6hEqF5ZViUjfjCdf0ogz27zJsWRcXXkDHVwDl2a0ivPtyx9hW+8zvHpcSgDgSx9aiEbm
         WjbR7OwRNErUgERC41i/pN6XGk6Eg+zwRVSjUkoW3nZNN5tswqZwc12us8FFnJLFjnJe
         wQIgYb6XY6rR2eOYg5MIVFiuf0G1Rx33F9C4k3KwaLbyqvz6s3qPUnRAJqRJtCE7k/jw
         urwkGg6IoMP7rSoYWjKwzmO7fiotxYqV9b77en55ddg/OsPqu+Tu36gKH0OWusnqZI1R
         9x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869556; x=1780474356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8I5cb9EDSN0CWGopKBTwtEF+OyzEohAwWcJqwzO5iQ=;
        b=Q9ap5d0+XJFcFYUySB4Di7rzeIoLUj582twnfIoQuQ5+bIvdtfMbj8b7ALVvRaYEav
         SmV5PYEaZEk1sVR3ZrIbGWL9c/iLpaYroJzO/dbxpCZZDEQ2CgBrh2NnrUyty5H+aT++
         E81XlnWaNS+w8emBt0y9OId8hrP06iAS9DKSqlwq5FSu9b8q7PVaQekhbaJAo7mwej7j
         qLl6R6thdwcMMI5D4/dbKiqXl8irz8CtmIwHDnzIyRseJ740wBG+2pwOU2nF+SAhZoPO
         1JavsJ8Pj9n7uf/QRDlOhCUs59E9CufVP5gI600ZkBkLEOopGL/MWJeHmnRybumdtVip
         mPsQ==
X-Forwarded-Encrypted: i=1; AFNElJ83iDyvPMTT1s7WpqPv796LWPZfnB6u0rqL49zdnVWD+4f3qS8nmSTV/+9n6a6Xh8qwuYJkxE654Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3rZ2H1QMFuv++NkDEet6PD7Bt+Mz3N7AbUM7WHmT65EWy4O0
	Q7pmPskoGbdbGtr2U2ISGvuRUy3U2lZYLVLRXsJfo0ReDA9WLdyBZnJB
X-Gm-Gg: Acq92OGk2iME4esQaqUlcYzJ8s935t/ZVAChXi5trNjMVBpDbCfWhWqqxTaYex5y5Va
	yp8iwJa99u90KrUnDjMhmwg6UJLRwjbxgFE1HGwAT0CnDiubTTEHyRT4UUccq74Bj8sb0+tIWqZ
	gUZYMQbLPLgPI0bnD7PSY3JIY5mGU39OjHAS2gByUbJhVARu1fR1fLLzyilQoCMKOFLEbapSEu2
	t+ss1gLFgm4uJmmtmusr5gKTI3UbKard9qkycVtqwm1bZ70YHYd1rXqSVMci40Vk93J5m4KXlnN
	fGZy4R31VJAdGVrZOcY22cTsuPyX8Rs1BHd8H5EwrDlR/Iae0VqlyyFtBAe2SztOMEodyVJ4ocd
	RC4O3bR/dlL4kEkBRrbabV+67NV6u+krIyz2u1sMvljspFjMEd75zx4aEgyhNN8srpybFWoCT6P
	KQYlRV6si8NvAxmP+JUr/ojDH+v5CXkqsv+yP4oQE1eRvlAHA/RKVMjlb7jgfwL9Lzr1qM
X-Received: by 2002:a17:907:d0c:b0:bd5:1ad4:cd73 with SMTP id a640c23a62f3a-bdbff5847aamr1432093266b.2.1779869556249;
        Wed, 27 May 2026 01:12:36 -0700 (PDT)
Received: from powerpenguini-l140cu.emea.dell.com ([132.237.167.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc2c4e3d5sm597838466b.15.2026.05.27.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:12:35 -0700 (PDT)
From: =?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: =?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] cpupower: Implement powercap enabled setters
Date: Wed, 27 May 2026 10:12:33 +0200
Message-ID: <20260527081233.4060762-1-jaskiewiczteo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ce170d8f-88a3-4b8b-8e87-744433ebc442@linuxfoundation.org>
References: <ce170d8f-88a3-4b8b-8e87-744433ebc442@linuxfoundation.org>
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
Changes in v3:
- Move the patch changelog below the Signed-off-by trailer so the
  sign-off is kept when the patch is applied.

Changes in v2:
- Check current enabled value before writing.
- Use fd < 0 style for open() failures.
- Print sysfs open/write failures with perror().
- Drop the sizeof(path) typecast.

 tools/power/cpupower/lib/powercap.c | 58 +++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e5..80af65287 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -21,7 +21,7 @@ static unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
 	ssize_t numread;
 
 	fd = open(path, O_RDONLY);
-	if (fd == -1)
+	if (fd < 0)
 		return 0;
 
 	numread = read(fd, buf, buflen - 1);
@@ -36,7 +36,7 @@ static unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
 	return (unsigned int) numread;
 }
 
-static int sysfs_get_enabled(char *path, int *mode)
+static int sysfs_get_enabled(const char *path, int *mode)
 {
 	int fd;
 	char yes_no;
@@ -45,7 +45,7 @@ static int sysfs_get_enabled(char *path, int *mode)
 	*mode = 0;
 
 	fd = open(path, O_RDONLY);
-	if (fd == -1) {
+	if (fd < 0) {
 		ret = -1;
 		goto out;
 	}
@@ -70,6 +70,36 @@ static int sysfs_get_enabled(char *path, int *mode)
 	return ret;
 }
 
+static int sysfs_set_enabled(const char *path, int mode)
+{
+	char yes_no;
+	int fd;
+	int current_mode;
+	ssize_t ret;
+
+	if (mode != 0 && mode != 1)
+		return -1;
+
+	if (sysfs_get_enabled(path, &current_mode) == 0 &&
+	    current_mode == mode)
+		return 0;
+
+	yes_no = mode ? '1' : '0';
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		perror(path);
+		return -1;
+	}
+	ret = write(fd, &yes_no, 1);
+	if (ret != 1) {
+		if (ret < 0)
+			perror(path);
+		close(fd);
+		return -1;
+	}
+	return close(fd);
+}
+
 int powercap_get_enabled(int *mode)
 {
 	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
@@ -77,17 +107,13 @@ int powercap_get_enabled(int *mode)
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
@@ -180,8 +206,18 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
 
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
+	if (ret < 0 || ret >= sizeof(path))
+		return -1;
+
+	return sysfs_set_enabled(path, mode);
 }
 
 
-- 
2.54.0
