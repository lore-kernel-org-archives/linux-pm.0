Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFD3BFAE2
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602274; cv=none; b=AlYz+w2TaTfdm8CwgX6rQ8O0J7tmE6ph65HVep7dbkARjPsG36McbYJSG67d8QqvD/f1nX9b6+2TXc2cYOzUorAkyQ6G/fYIPnhP9jcVHKC+OLRO5WvH/b5FgW5snmoblfnHL2MAbtB66wkHwvWsCP4kRVRiqpqxUMN+8eZR+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602274; c=relaxed/simple;
	bh=Ypsdih1wp4GADRM1IZUEZmGVRVc30J0Dc4mtPVW9xcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvZG2p0xkwvirp8F/8caE/kzt9nBgOzam37CCMkn4GjuUhfG8Ei38rz2GqFDHNMtU08oYPhPkhRlt+SRsm9HyTstx3jGkc3VqJiJC8nBjHGN/dcEn3FPZlNPoUiHsi1XM44K3XY3TCCi4MD797DBFESRcKGSaHOU65biCpS1jYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhYWuvuy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhYWuvuy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd2e8931915so131464666b.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778602271; x=1779207071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nl4fvUc0mpSDliYL+xcrqVrvd75JJ70LNza5Lkr610=;
        b=BhYWuvuyX9duCancECU2iSTH3NwZwQLxZ8lw4DW9nbTa3lIAyGuZ/D27BbVYZYNOLz
         X9ojxOgY14Hfjg0uI/7j4n9HAWQCgBzqPWNG4eczNBVdQD97AC8wGM/DKJ6Cekc1IhMM
         Opl2bI/hwyhd+WcuTr8XEZ5x328/hmOXWWBPtxcjUofRIx9yueq8Tn/V0y/69bX+BiHj
         zfU2rKmeuz8rZT/p6/jAm9O5kCKcTUi/M9ootIPnTA4N4qa0wLMmRCrrgIyO4EVXSV3u
         AAEJszBu8kXgbn1FrvDu9hZLvKi24NZcjoCg/fseVyHbFovN65BJAdTfoI+8rYyhq0d6
         xjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602271; x=1779207071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nl4fvUc0mpSDliYL+xcrqVrvd75JJ70LNza5Lkr610=;
        b=qn8v1aI0mrwqzXLP+JywFUWThCJ0VYUTHpJpgslm+X8OX5rWjTX9jeeXMsg5uW13rv
         JObdRRxbDmjDjsUKloKMrZRoWQJd+hzPsF/XpFqLYNGe6zk9hH/aOx3q4w+kHLq/njJz
         8f7Mp0iNYrMjtO+n9Z+c3QH7rUmqmjXFwmP9jz296deXr0nwmqT39h62Is5QdQCbPykW
         vbT/PLJJzVQ3Rv+g6R7zb9OD2KIvT9n8xuKacdekxku1FPRx/r4AhHiUI9S8W+b5HKZV
         /aHFEm8KjXfowarm/zGeFFv+igj9H2Q+WrvZ6kCbWjPQuYeQCPDSRl4BnhMhTqDuUyhc
         Tpdw==
X-Forwarded-Encrypted: i=1; AFNElJ97DWiXYznhj2CfQdbQqre7PVRGXpgd/Ll6P3z3Jxr73yQ5vQFgfXtHhR6jh4szUNR1Ri7hoaknDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNj2dtkM56/FYkbs5PedUROdwfHlWrbjS9KhIYkhoIQ8nJVsuu
	bbddSEymgxf3pyNe/mhoVzPV3SoJxUasoBwIXzySHrgbF0ko5Ac/9ee+
X-Gm-Gg: Acq92OHOIlMVRk9PoDld7tIjAiEqKnO6J8QT4ziNKZqkjx1faCsPRjIz4c4LzyQEe+m
	tXFN32eX0pnbTGPvDDVlErV7pjpUDgTa3t5qtZhEG48v4xLB0maClUjxbhhvnFt27NQj5ntUViW
	hhbRis3HOhq8eEh3ZSIh82dBxBVxL0vFBT0f5Ep3kCXHOPIckmACRI9YohjZ8qK63wWRzfgbvqF
	+ibhZN6FZj1chOleVLf3cI5xslIcngWW9kdToWw6PdmNR6YoEcCoC8e3gMdylwedaLa9sygp/nG
	+TK8bXpcMVSteRcSwl7v+kF/PKqbzJ49+4zlonuvu5oIeTBLz11XQPGrLVBHjdDzCIqG35G+H6p
	tbw3Hl9SsVA4X9zEustHen2+kWqu02fuHHbJ+y6XBkltximqfr8Pe6mojhAA/aSfvISlSjP77CL
	/IUsuuLkfY+Llpe+XuriX4PjIktGeMPcFaptPfrg==
X-Received: by 2002:a17:907:c298:b0:bd3:8be5:cf59 with SMTP id a640c23a62f3a-bd38be5e05cmr17631066b.12.1778602270533;
        Tue, 12 May 2026 09:11:10 -0700 (PDT)
Received: from powerpenguini-l140cu ([188.146.44.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3989fbesm695444966b.33.2026.05.12.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:11:10 -0700 (PDT)
From: =?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
To: skhan@linuxfoundation.org
Cc: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	=?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpupower: Implement powercap enabled setters
Date: Tue, 12 May 2026 18:11:01 +0200
Message-ID: <20260512161101.2993280-1-jaskiewiczteo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <60d4f650-84fc-4697-8390-98d9e9ebed31@linuxfoundation.org>
References: <60d4f650-84fc-4697-8390-98d9e9ebed31@linuxfoundation.org>
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

---
Changes in v2:
- Check current enabled value before writing.
- Use fd < 0 style for open() failures.
- Print sysfs open/write failures with perror().
- Drop the sizeof(path) typecast.

Signed-off-by: Mateusz Jaśkiewicz <jaskiewiczteo@gmail.com>
---
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

