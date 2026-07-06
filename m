Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63F3939A6
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348770; cv=none; b=iBsCefVOvsAsKdeCZ6+LMUjAGQIS/SH7GeUM25TzYIn1YEDHNvtKgmk3uXC8d67HqQrbAGPw5iTH8/fORdmUSUw6fj2/8AhGoCfgUNotN7vp15HL+nCzqybkuekuTvkYmzgiLe1HQysR1ZT6PPZaLqpz9aVv/+4ur+Lfi+ekRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348770; c=relaxed/simple;
	bh=x90aUn0J9cOzFK9OMOuB1T/9j8EV5QSJzT98AE3Ubb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/pvObkGBHSKCemseiQfjK5lUmJvxw4w+UzErWatHhbY1Z3t+2wSIE7NmhSBg2kU2OynZN7XnkW3jciLSow4a+ueFt1OVk+LXVk13O+hpzZjj/EISNMfN/WJlxOquUq7f8hBeTFrpRwA5dvP1q+4BhKzmhs6jjrsfGL0fzs1U6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9krdShV; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9krdShV"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c888c2cff99so643113a12.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348769; x=1783953569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FfyQp4sNmNhsL49jNoWYN8Wz/1RG0tztSjlIz4Q1N+g=;
        b=Q9krdShVbBLeGfakh7SnPqJwfUsVKx23I7oQuvp385w6eanlpdq2LWyOGKsfuerezQ
         TOGwf38LE57e9ZCyTqm4jrTI5QrADwjcmO42fFAwYnwm/ny4sKXt4hViEVgtVbC6ey3f
         m87NfW7RbSfKrKDRHDy49gpGdVt2FqbKduRkSHcWZj9J4PGEnadi07ftJt4OUKJSKASb
         TTxOLCxmwHFfMvXz/VoBAzGua3LJNYG2WOtOTMJ/alIwcO0liFfznfALOzGZL8RlSKCa
         7IN0EfZsK8oNwV9X7oLLvrgEpwfmZ/OmCItet/OwIIduIdGx+glnQHErb0T/0F7/oGx9
         VoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348769; x=1783953569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfyQp4sNmNhsL49jNoWYN8Wz/1RG0tztSjlIz4Q1N+g=;
        b=WHt2JODurGNZdarxl8JQoARmSivlCoPtfksCALtkSiUHR+cykEYwBzLqzvVpaU7VQC
         UHUle533b56m7m0QAU7FLHs7laqHbEiU/W9l6AJaipPCUF7X7iQ2Ci5NayBYa0G2IOiG
         U5WxE1chHnbbF3E+T5MEBwBf8waPiqyauVLfiQmUnJTLUD81nL5kGMDyuxuGHCIPGRYt
         NhxlCmAsQz2Vi+UOeNO9UjWd4QcVOL9zyGoNdJOHftKLeh12dmEXE1UE4n8xE0S0WMNQ
         e2h+0YdzTfxvDJB/UJTv0RdeFTOIKabwiLeDrf+530Axu6wwSnjSVLWjJBiqSNFlvUGQ
         ZbNQ==
X-Gm-Message-State: AOJu0YwFwyPJJyd8g+cI4uw11oSIGjCcRhd6qoq0/J9DD+3gsD7dITAV
	fBtYuH9IzNvf2w7WNUL+bgJvrooWs+OCa3dgbOwsl/vL1FeEZIggrtQ=
X-Gm-Gg: AfdE7ckHf4hCuhnFapTT/URRC8exhX4/Nkpp4uAeURPN1tP/v1YuNN0m5PQ08NVqY5Y
	Qty3iSPNo85+OyB1OINL/h4S3jSRgVjOuq5IS5eJJhSRcIf5dnHsnx8+vDGGoEQTkqqj7bhhdh4
	G2EL57UeL4B78jMzuJ6Mvy9iqAbMHy9NnQ4tv3XGjY6UqfdK03kCpUHsgg8gfbhjbwtIOTcUK0y
	614OUnrgiZ44s+4MfKn4N8KTppax9IVlYFV3ht6eu2fjEPEpHC9t1C/dWDEGpdFQrBjUljp4488
	9M6ho8thoCeiy9N+fovANWVOX5yDa5i4MM+RBRi/bp9RN4Wl6lW/SXOOnhfDMMmRo4m6RqOQU7y
	rG1saZ7ezH4fZP5Xyg2ZZlVR3M0O7PSzhoSqyVcxUPybMW8qBlrrT0moIlE/qvSCHpAr1kPQT7R
	QYWngvkBxvbW8bU4o2gYbsB0MLDZjOjNHFwWS7o4pV74vR
X-Received: by 2002:a05:6a00:2301:b0:845:c6c3:5e75 with SMTP id d2e1a72fcca58-84826e13ba3mr842845b3a.42.1783348768602;
        Mon, 06 Jul 2026 07:39:28 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609acsm3858991b3a.1.2026.07.06.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:39:27 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/cpufreq: Remove unused local variables from switch_show_governor()
Date: Mon,  6 Jul 2026 23:38:53 +0900
Message-ID: <20260706143857.3306-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

switch_show_governor() assigns the current governor and frequency
to local variables before switching governors.

However, these variables are never referenced afterwards. The function
does not restore the previous governor or use the saved frequency, as
backup_governor() and restore_governor() already handle state preservation
elsewhere.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 tools/testing/selftests/cpufreq/governor.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
index fe37df79c087..212ef1cf43d5 100755
--- a/tools/testing/selftests/cpufreq/governor.sh
+++ b/tools/testing/selftests/cpufreq/governor.sh
@@ -100,11 +100,6 @@ switch_governor()
 # $1: policy, $2: governor
 switch_show_governor()
 {
-	cur_gov=find_current_governor
-	if [ $cur_gov == "userspace" ]; then
-		cur_freq=find_current_freq
-	fi
-
 	# switch governor
 	__switch_governor $1 $2

--
2.43.0
