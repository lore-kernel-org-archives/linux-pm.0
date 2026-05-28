Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56D3BD224
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982374; cv=none; b=CRSQswfao9/n7r4GOBCSsillHAbedb9a34eYD1I/RCSgRpWgF6ZCyiGXzByvbitljFWerYe1c5NgWwkd1Zp52bXpxoP2cO7iL9bF+/pokwcZVjTSnXunThGN56cOO7TOiK3MYstRxfDhj2KoeG3q6oJGoU9jGX2Z1VmzSgy8z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982374; c=relaxed/simple;
	bh=CAW3syDKKim3+pEQ7wMxF8KtuVzPR1nXCGH2CuOXEHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+LGCawpofnH82PCzCUngFYeFhDKAaR+QQ7EfqXhOpSnoMY3ai5lkKlFaFHH9x2qL3mi5uy6cOgN2IzRw2fKvuuL8F6EU/xkbOLWXHdELtZBkHXmhwAxRUFXf0vJ+SSWgBtuHe1nW1mtT2Z4P1JuaR16h499ay1QU3VCTBlcCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1m4TV4z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1m4TV4z"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso655741a12.1
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982372; x=1780587172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu1VHF115W9s3boPLAXFQHBS6iEnbQcNg2EXl5Ejckk=;
        b=Z1m4TV4zFVh4FBwVMllyoljddC0Y7uaEs7gbg233nDmp1W4FbkeAGoJHfAuwfjwXaO
         oyD8WZV0FUJJA9ysFLQcbTkOYEx41c0icLXliAIVflyFmwfSGVf5lKTEI02PVeEata7e
         HHFeG/QelfzyNAqMDipwlznYhanGAVJKumW1Ubq0pPRzieIaIOxrF1CAScvP/xN+pFrw
         QHfkD/NaKMYb6JWDZyQAyppRkfineYCThkc9Qhm5vdj1Su2yMje+urlsMl0cdVnMZFVO
         0UcUBIWa66bWbGNmn1fvomHllRmqSULTNpsjYdEfDSRFZebn7obwdp9eyuIRLZM9+RsP
         4WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982372; x=1780587172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bu1VHF115W9s3boPLAXFQHBS6iEnbQcNg2EXl5Ejckk=;
        b=Fl82aLiLb2/Mkwbfo/3tNAFv13MUmsR90ixIcZ2ZYdApZbaEqvvw7mkiBboF5Knrlp
         RI94wffNzaRHiOkRyl0jlFXEtjZ0f+CRgS11QdpgZNArSDPbI98Sj0FArXgCNAMay/qd
         4QM1Fey7Yr5K8S/yyKmhzURgg4g7hql/ScFn4wXc14lIWn9nnAH8h3GXptHnh8mvW3jV
         pX+UVkRIaadHJwYXsKS7vS5G9SVQ1rqa8mF3rKLsdMUIDQySFQWDTBxnxoYlcJkh1Y5F
         vvgKPHtGu1B7clTmL9kSNkV/KU8rOLkKs8XOUifNZXZWUG6FB7u0OmCu1FwgeBstGxvP
         S3iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HGl3uTlI6jD1uWUCiQO/lDIPVynOKTZZNjjV8aHKwNXdyPYdszggmXlKoDjQ7jZgfbHYF6LFATw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wi3Ca8u4m2zZF83OXc63mGsMkPJc0HYAOdBTTCBXjMjH8n7y
	WwIgBV6tHkUXMydJhQ7RFtRf5yWDafD1io6AcUS4rKHIw9SCUEbD8IUU
X-Gm-Gg: Acq92OGisIitmDFo9RVg5kIm17Y7cKo1TwQ/RGpnod75oSHDSvsT6UW1ooMMV41wm6n
	HKBYFzZkvPkDbyrerrGkKWQwuDrXGlF/A32falr2J+HKNYMcthZKXTnpOVftFEQZ6WJq0PELpyd
	SWhqXXfeg3G6LXE3h8we/MfXJhDfhDPl3I0H3KflMeMFrx2iQAvIynZnlbfiQOBc2IR+UV505oX
	g5CjM9+KukHu52ddBDvNsbjNg7QbPJ/YpMvgPh09c4Mg/a5VR1hTMMd2VKE7xb28eqptRWhPYD0
	ziT1hJ3rEiKVIW7KhtLS2ahvIkd7TPL2C5fRSDOPnUk1lCv/WH47w4hmWuVuhnJg+D0V+wYjXJd
	WsQeBGnQEo21RCWA9TRV5JoLZEH0LzCdBNI+IDdYghLIzeXMTmETmlsRqkYji6QiiABG9yB3y3G
	qSEaHzOd0V6Xq2Hnu1+lc3c08Ol0pX/skknBa14qVgipO0T0N2qDarHN+WnuKhFQrOwkxSOrCYq
	AGCdrq94/tVcBwR
X-Received: by 2002:a05:6402:2038:b0:678:a5d1:ca74 with SMTP id 4fb4d7f45d1cf-68b5a0b1b5cmr911530a12.16.1779982372267;
        Thu, 28 May 2026 08:32:52 -0700 (PDT)
Received: from powerpenguini-l140cu (staticline-31-183-186-11.toya.net.pl. [31.183.186.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68b96fd79a4sm311495a12.7.2026.05.28.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:32:50 -0700 (PDT)
From: =?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mateusz=20Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
Subject: [PATCH v4] cpupower: Implement powercap enabled setters
Date: Thu, 28 May 2026 17:32:48 +0200
Message-ID: <20260528153248.4114324-1-jaskiewiczteo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5ff19049-a83a-4ef9-9cae-b97438fb3e77@linuxfoundation.org>
References: <5ff19049-a83a-4ef9-9cae-b97438fb3e77@linuxfoundation.org>
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
Changes in v4:
- Compare the snprintf() return value against SYSFS_PATH_MAX to avoid
  the signedness warning without adding a typecast.

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
index 94a0c69e5..cbbfc4736 100644
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
+	if (ret < 0 || ret >= SYSFS_PATH_MAX)
+		return -1;
+
+	return sysfs_set_enabled(path, mode);
 }
 
 
-- 
2.54.0
