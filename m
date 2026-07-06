Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717841F7D5
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354521; cv=none; b=R3J0qCS70pcp391GoE0tlbxA4cWNgQZSQgOWO8QqK+TswGVxZIhStK7V119VFiMfYqb1ayujM/F3mR5MOvKm1Kp3+KMSSB5z+5slb3F5XELY6bdHH9LlAM+omUmbq6hMgT9jvf9pJW8BN63c97Bec6+vSyKlg97fELEm7dITfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354521; c=relaxed/simple;
	bh=5G5FB9kOtpFLC9ywyKU/WqUp5GOuGEuJ4zI7XGzDU/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdqTehNOCZfaPSiipT8Xmn9LjljimrUL5GWBi+wdQ145fo4thHKCqmHIeeSDsVgL73aSKsWjw2u/1Y60hg4lsBezmSYmEOd9BGg1fq1IfStGfWNAYBGR27TlpfV4rjtpFeCeZAnUF7I09sbueNCrCjUrue+9/IrzRIfaIiifCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dsf6MDyX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsf6MDyX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so25625525ad.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783354518; x=1783959318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/3RgXCA9XKT4PqM3Zw2JPstafRKCR+nS+crMfKpAcE=;
        b=Dsf6MDyXItcjWn9QJIcv5EzfidGxocrrA7mt65C0Rpsf3CECAM0+kMW2UryOaySVtH
         HY7B2hOkvyy7vX6MZqSEEwcY0tFjhG5v+YPiZHiLYpTyHvYk5mZ8oL+Jof2aPolBb7oX
         vxTFesMrDGFsVxx2qbqlNZGUKkQwhoMKA1r4CElWLlkbCKWgtx4AUu5QfV58yjbUoYBL
         jE5qjwVVkeeTfJ4hCXDhBOWqchfxSV51XazD9Abk0jqHEo33FxtIG28YbbMTlUhFOHvq
         zPW5WE2TFZtc1wc8Ckn89C5QnQFa4Ow3nMs7G60Yl4wfsBiQXRDjb+L+o4ukoYoImAiS
         7TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354518; x=1783959318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/3RgXCA9XKT4PqM3Zw2JPstafRKCR+nS+crMfKpAcE=;
        b=EqywLCaTmfhbvIl6uZR9ZD2RWCLj8YjVi2SAI9ulz9APEzFTboCiLFEJM+2lAURvBy
         PN11tCwzkUiLkheLZsX4tihLbeS0X6hlI5Zq2bxYmVhPaR/vKFJnmVL9V0KiZBZjWwDx
         FRnFcxtO8jZ3TEqyUHeLaYvVvnU1NPNUVdmJ88J7B6sIBtapg0+oaodU/8VATpaHRRAm
         PJdQ+6blKirO+OMhU0mw3KrRQfwdkxL0X+sMxyD9xoRHoXD9qUfdVdOTvuf3iYNFvzqK
         /JGy/A9EO3niSC8CnX/9vamZWQK+RaF4H2GVIzsVX/8xHxSUC+4lccl9QLQOV5kfvyi3
         5SIA==
X-Gm-Message-State: AOJu0YxSRwMkGckC/UZK+dNQWBOZrOXK7wjTldHY9OjhtIW5KQRmkalh
	13ELnTwEB6xob8MUs2Z5N5LOfye97LwObzw2FEJfcQL/k7zZ05lK9p+p
X-Gm-Gg: AfdE7ck5sv1Qd5KCg0qHbJ6BJvUrDXFQavFmI9q5UB3yfygFYX+BXbg+779TWbfzbMa
	cdfxSQzcDb9tuWsNhoRD0JT96pmYVFjRrWeRY8V60LjkdlEwwNiwGt6UW5dWUY6xNUQKLFqqfte
	iYoYidvJuYcJu6HAo6TnVK/jus8e77cn4FjaSPJyqM6sdhXyb92d/GIghEO1q6erDdp55SjjV+N
	IcVnJqvGTtD1ej4dvAzhYVKArivNgfX59Qo640sBmg7lpYNHCCnpV7reYDCeKfpOwdTt22KJheY
	ll4iJpAV89bvc5sPX65UAbEQVe7GHgrzRxmXIy3NdkejXoq5Qxwmq65Xt8fxzn85ExjXhKyaLfw
	sE84Ti0eVHol8fXSzCykL2H6SaffCydNuGk5TN311AhOVuHQjP+fUdZ83aA7GeuxfvgvdymOGMW
	L/w1q1tFiFcyQWbdZxXixTpVkN5CW+MEdAws/zJLBHzt42hzOsH57RqlPzzjIHWOJ/jEjKJFmwg
	oMHqPej2PuW3lYzZP7HyJCNYbXumI8=
X-Received: by 2002:a17:902:d2ca:b0:2c9:da58:17dd with SMTP id d9443c01a7336-2ccbf02ea30mr12245295ad.34.1783354518316;
        Mon, 06 Jul 2026 09:15:18 -0700 (PDT)
Received: from NV-9MNJ414.nvidia.com (2001-b011-2005-72fc-7da4-215b-b67f-50ea.dynamic-ip6.hinet.net. [2001:b011:2005:72fc:7da4:215b:b67f:50ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260a1sm53394545ad.11.2026.07.06.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:15:17 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH] kselftest: cpufreq: Backup and restore governor for sptests
Date: Tue,  7 Jul 2026 00:14:30 +0800
Message-Id: <20260706161430.16949-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After executing cpufreq sptest, the system governor
will be overwritten with the governor switched
during the test. Restore this setting to maintain
consistency before and after the test.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
 .../selftests/cpufreq/special-tests.sh        | 13 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
index fe37df79c0871..5d105ab9c9222 100755
--- a/tools/testing/selftests/cpufreq/governor.sh
+++ b/tools/testing/selftests/cpufreq/governor.sh
@@ -16,6 +16,12 @@ source cpufreq.sh
 CUR_GOV=
 CUR_FREQ=
 
+# Per-policy backup, keyed by policy so multiple policies can be saved at once
+# (backup_governor/restore_governor also keep CUR_GOV/CUR_FREQ for callers that
+# read them directly).
+declare -A SAVED_GOVERNORS
+declare -A SAVED_FREQS
+
 # Find governor's directory path
 # $1: policy, $2: governor
 find_gov_directory()
@@ -39,11 +45,13 @@ find_current_governor()
 backup_governor()
 {
 	CUR_GOV=$(find_current_governor $1)
+	SAVED_GOVERNORS[$1]=$CUR_GOV
 
 	printf "Governor backup done for $1: $CUR_GOV\n"
 
 	if [ $CUR_GOV == "userspace" ]; then
 		CUR_FREQ=$(find_current_freq $1)
+		SAVED_FREQS[$1]=$CUR_FREQ
 		printf "Governor frequency backup done for $1: $CUR_FREQ\n"
 	fi
 
@@ -53,11 +61,13 @@ backup_governor()
 # $1: policy
 restore_governor()
 {
+	CUR_GOV=${SAVED_GOVERNORS[$1]}
 	__switch_governor $1 $CUR_GOV
 
 	printf "Governor restored for $1 to $CUR_GOV\n"
 
 	if [ $CUR_GOV == "userspace" ]; then
+		CUR_FREQ=${SAVED_FREQS[$1]}
 		set_cpu_frequency $1 $CUR_FREQ
 		printf "Governor frequency restored for $1: $CUR_FREQ\n"
 	fi
@@ -65,6 +75,17 @@ restore_governor()
 	printf "\n"
 }
 
+# Save/restore governors for every policy at once
+save_all_governors()
+{
+	for_each_policy backup_governor
+}
+
+restore_all_governors()
+{
+	for_each_policy restore_governor
+}
+
 # param:
 # $1: policy, $2: governor
 __switch_governor()
diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
index 8d40505dc4682..c7eddadd047d1 100755
--- a/tools/testing/selftests/cpufreq/special-tests.sh
+++ b/tools/testing/selftests/cpufreq/special-tests.sh
@@ -40,7 +40,9 @@ simple_lockdep()
 {
 	printf "** Test: Running ${FUNCNAME[0]} **\n"
 
+	save_all_governors
 	for_each_policy __simple_lockdep
+	restore_all_governors
 }
 
 # Test 2
@@ -56,7 +58,10 @@ concurrent_lockdep()
 {
 	printf "** Test: Running ${FUNCNAME[0]} **\n"
 
+	save_all_governors
 	for_each_policy_concurrent __concurrent_lockdep
+	wait
+	restore_all_governors
 }
 
 # Test 3
@@ -68,17 +73,23 @@ quick_shuffle()
 		echo ondemand | sudo tee $CPUFREQROOT/policy*/scaling_governor &
 		echo userspace | sudo tee $CPUFREQROOT/policy*/scaling_governor &
 	done
+	wait
 }
 
 governor_race()
 {
 	printf "** Test: Running ${FUNCNAME[0]} **\n"
 
+	save_all_governors
+
 	# run 8 concurrent instances
 	for I in `seq 8`
 	do
 		quick_shuffle &
 	done
+	wait
+
+	restore_all_governors
 }
 
 # Test 4
@@ -112,5 +123,7 @@ hotplug_with_updates_cpu()
 
 hotplug_with_updates()
 {
+	save_all_governors
 	for_each_non_boot_cpu hotplug_with_updates_cpu
+	restore_all_governors
 }
-- 
2.34.1

