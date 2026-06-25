Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5F3DFC95
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392062; cv=none; b=bMuxLaaPDLLVJEtpxQyUGVYyaLfjR72f8rAZqaYIHwvjssoEI73GnO+jqtCuYTRPRzdOzT9f2yLxzAQAVgInIKLhvNb429Au038iODVnQLw5V9bNsSDhhjzpyodmJXXHWw1pQWg37t+8Xn1N7ufj2BtDN2fvU8nz+FvkRzNLhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392062; c=relaxed/simple;
	bh=ZwoYLetcUtF9UoQ4QRBlUB3RVZ7uO3Uytsx2+NqgYzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSvXEO4aOqFxtgjXWFCkc8tPOt2/0sgHrQA85AWX4zBWzZ93kIDwKuf+ppLsTl0hG6fNZI6N3oJ3u64acMy49R9IKbKQSGM6XIfQqqr6TEqb4Su7raWPPzVNRYDVgOFD+7SfG1M6Szjk+j5TTTLwYTOwb798GeJkdR2g6m+2q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oa7bnVXp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa7bnVXp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1755253f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782392059; x=1782996859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJAtGQmovXlj8CbbOYVBpCwG1j5kbcJ2ECu+Lwn8HsI=;
        b=oa7bnVXpbA5iHBLS7wTv3D6N+r860Gw2N6/iMG8KeuKt+qsURZSjLM01LOwP6b3ybx
         W/gDc/DYI3b4Y8n+IdtNwfbWy70x1ESPNW8xtMhA09Sjl0wmwxcLH27xWnf8QCx3J5Gq
         VkJmI2kvIaGAQ11xZe+tLf3107UiP33pNtEL0Atw3nV9DCOS+c44f5lVf7TSzMv/+zOD
         5bpSkbE+26mIf7Qwgp30YOh1tA8jnDg/Jhv+r3aiKksqyLEKjKk9T+KXPtt0/nQwS0hy
         8cVoTJlBLPxS1+/9TaDgiFfZQYTu6vKoehdouD5uFo4SSlq1pOMiNby0PhI+878PdGWH
         VUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782392059; x=1782996859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJAtGQmovXlj8CbbOYVBpCwG1j5kbcJ2ECu+Lwn8HsI=;
        b=sstDC71eNqdhIxlbq0HX5rV/a4/LBiQS3BYkQjxQ/TVS7/CaOW9HkasGPCflZDdtJB
         mi0681+ygISOzv2OI0Rqh9A8c3VQYbb/gol9K7Ff5WV10etac/DLuUZ2PbJuDuDG++Lf
         pF2tFA+AUF0Ou2nDnx+yd0DjOsxkeGFubfnL0St/DL3zdC8SFBbpSZ8hKXEpbQrglrx9
         YA5DdftocwQWUWdI2dBRpqrIAmkcW3lmVwpIJrz9WfctjtHOZdsSKmljAWvo7Nq1rBOv
         OlGDKo/eAoBk5m27NE1l/8/wGIKysSHRLVcAI+wPSzHrN1pOqCYa2Eof80hOdCFgrSYy
         wrSg==
X-Gm-Message-State: AOJu0YwyZVxsE05B05YRi6kDDMlFTm1HrEs1dJzwgoX9Z3ZnKnCmKc3H
	mNWw7lVHLT13DcLJE2NzSmjkoz/rJRoZrrUdlva+qpUHpQhDbWTOt1O5
X-Gm-Gg: AfdE7ckGazHNmAlxKlCswH58cR9dVI/1cQY9wbPi+zmwWYU4loAEiWyv9c3HsQIAR1D
	3VpMW/TF71JRgl7qB52qufy7N/TRgDzmypRFbhMpibkGCLt6La/pWToDU04j56+V/0ezma6F7qn
	zgsh9hbLhKcCA1oFzW+a3+SZ+sTzDlN3luqBC7sOBFArAtBj0a/kYE5zW9oD19mYRGnIHcDKE9j
	5/jtmsZ6diDUku5KC4y6zeBM3YercyYWCQmcxj6iFAHwHYbJHGUluq736r007mi5Y/bE78T0+8E
	/Zw61JGKPF4a1YrWCCGhnmhk14dJCUY1V3idmGao3JXfflfKjxLobLJ4GwHu3struiP+oevT1Dm
	2MZcRRm0o6Y/gdV0Subzg4cbOUdCYauO54JpWSsOBpCKs3mlRm5y2PHOvZilxDb5vvZLwQlJ55W
	Y4Z7Zx0WmrtYCHUJ8JlRejHak=
X-Received: by 2002:a05:6000:4286:b0:45e:e9ac:42e8 with SMTP id ffacd0b85a97d-46dc0839ffbmr3888358f8f.18.1782392059131;
        Thu, 25 Jun 2026 05:54:19 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e6167c05fsm724670f8f.25.2026.06.25.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:54:18 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH] selftests: helpers: handle multi line in test_sysfs_prop_optional_list
Date: Thu, 25 Jun 2026 15:52:37 +0300
Message-ID: <20260625125237.36605-1-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify test_sysfs_prop_optional_list to allow multi line parameters, in
order to comply with checkpatch output that limit line by 100 chars.

Allow use cases like:

test_sysfs_prop_optional_list \
        property_name "value1","value2","val3","very_long_option"\
        ,"extra_long_option" \
	,"even_more_data"

Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 tools/testing/selftests/power_supply/helpers.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/power_supply/helpers.sh b/tools/testing/selftests/power_supply/helpers.sh
index 1ec90d7c9108..8535cb7ed094 100644
--- a/tools/testing/selftests/power_supply/helpers.sh
+++ b/tools/testing/selftests/power_supply/helpers.sh
@@ -108,7 +108,7 @@ test_sysfs_prop_optional_range() {
 
 test_sysfs_prop_optional_list() {
 	PROP=$1
-	LIST=$2
+	shift
 
 	TEST_NAME="$DEVNAME".sysfs."$PROP"
 
@@ -118,9 +118,9 @@ test_sysfs_prop_optional_list() {
 	valid=0
 
 	OLDIFS=$IFS
-	IFS=","
-	for item in $LIST; do
-		if [ "$DATA" = "$item" ]; then
+	IFS=",IFS"
+	for item in $*; do
+		if [ "$item" ] && [ "$DATA" = "$item" ]; then
 			valid=1
 			break
 		fi
-- 
2.47.3

