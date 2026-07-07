Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC93E8688
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442214; cv=none; b=ju80MamWv7/OZglkxd1D7OH67PvZdtZt9kA/sWHRugLCMofiNhwbA78jQr7o1g3ZhAO1ow4hlocfhomKK02kOcox5lYdotb9kuQ4rV79yOTpiAJc7s5Ju/F+vwGha95Q/B6lb9Eh8C1SisO+oh/tW+epcy1pZuOru5GlljPTPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442214; c=relaxed/simple;
	bh=ke8OFstbdA/XHRGMxrbiN265g4oaheYPg0LqgQ63z+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uBXvT0/vBaqW1sFPWxPGx/AyK4UBkrwJnJJVbkYO5Ev6w9yVTSOddPsZF+O1buotPwDkRwlqaSp/44KP/k6GY+rp03phpWA8eClOGwnXPS0sPDmlgJyZIfuBcQiKaS1BN12hTP5QbFBfvH3YjjeVn0uKqtqoq5xmtb8QoWF11sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs5R3tWC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs5R3tWC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845ea8924fdso5012157b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783442212; x=1784047012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59KAfUy7DDwnSuMBWSJQPVmdDSAgriDADemJejGadBs=;
        b=Zs5R3tWCRWpcZxE2HEFClpoqwv1zl9s8uzD7f2LEwocxMOmQmqmLVOpc/LT4JEQDFh
         k2X8trvhGYVXNXQu3sqradmOemSMCksrpl00Hc7NKC4/VA3122GeQ5ahQ/IYsEpPvXLz
         b/nwmuJB10O9LZdjuW74H26bM5nE06njXR+Ig8s8440/Bq/DlePCbez4nBNa3uWDPnKE
         gWyzzO0ekR4W9WX1bDfkFO4Je/rUFsU7Tv5Gb9icN4u3KTKseSOXUg3pGB4RaHjaO8d1
         VHrQ43hGJF86vefU0fgumlQX9jaotvUkgLaIOWVyudeHPrmR4umbIfKCKY5n6dYltXd8
         7smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442212; x=1784047012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59KAfUy7DDwnSuMBWSJQPVmdDSAgriDADemJejGadBs=;
        b=oeW+UvLScgve5Ca7EMcqsZstv1FoMVFRy40qGpBsw3hzGTW2Y8+rLXjR5hwRCT1TwH
         nmO3u+W3iMS+CBfMCCQdiwkUfHtXgVf/lKciDZb9ZwE/Su0yndOx5wYaWWIPgR82OADB
         oeQb4LzDhEfBxHswZpzEi9LzRm13zgsrF17bj1nJ5nq8Ye/ivaRbGmxLcfRB/YkhdUV9
         4I0Nzm3/Gq8BcCkx3/bxNwVG10i3Izhy7FP1Zikl+HgPQ3hOTnhYV6cpsd2x1k+xK+CP
         +3Q0HZZQ+TAZLhPIZpmhWuyDQd33Y9qZ5sIFEOSS5XGc4cWAs6imZJNaGmsilEnhIclD
         taQw==
X-Gm-Message-State: AOJu0YwU+1Qr2U5syhB5hr3RloPbrVI/oQ1VvkMt31JejuiGhaTNbeEF
	aAt3Kx2IdW6v0v6Xkyi82K4/moPIASBEADdr+bY27RYi78wVrssFx9Ku
X-Gm-Gg: AfdE7cm8MLL4lDBJ9mguTbddHr1op2B64dpuB5r8mjE7H7v6FNiq9qQMvMCnOBLvCBX
	PD4a+rascabgXKuuHX2hikqPaNjOnG3ksmluYH0W/lh7T8LZN/eiFML2cCAvfdNWuGz8Mm0eY6J
	UWz+Z77N6LSdHy4qCfB7lg2bTPIMw+ibHGvvz5rKllPvC6+h94lEf0iVgtBhqz3H5+LJgSF7Y7u
	KgT2DwpahoSVxSSIiEIURO+rdhgUFfvAfw4OfIceuZUxtcDtbSOSqXMTOI6A/5GpraaxLog/Twq
	URqtMWwIuhH0VfMNw6LU3z1VUvlQbE1YjJzZuKi7xFJsNWysZLLNAyYMx/SbxsWZoyZXUQWqLWa
	V83xtVkM+2EZHKqQBtFdvpMvbBfAgSykeaNOVawgmKVaiuhPkTkzCrMFfDywzft3VPSWCy40POv
	+sOeo4QnTn3e6sKf8sDYLFvkppKEAEHBXk6Jds1c4pGVV64/YOBEsID+zFTqCcyvwZU/A3+014m
	Iz02Q24XmtOj2+WUXAUqOH8FViys2s=
X-Received: by 2002:a05:6a00:2d19:b0:848:2f6e:e52c with SMTP id d2e1a72fcca58-8482f6f0336mr3163662b3a.64.1783442211806;
        Tue, 07 Jul 2026 09:36:51 -0700 (PDT)
Received: from NV-9MNJ414.nvidia.com (2001-b011-2005-986c-7892-641c-1789-73b1.dynamic-ip6.hinet.net. [2001:b011:2005:986c:7892:641c:1789:73b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4dbdesm5721700b3a.31.2026.07.07.09.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:36:51 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2] kselftest: cpufreq: Backup and restore governor for sptests
Date: Wed,  8 Jul 2026 00:36:47 +0800
Message-Id: <20260707163647.6646-1-s921975628@gmail.com>
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
Change-Logs in V2:
- Wait for all background processes to finish before restoring governors
  in sptest4

---
 tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
 .../selftests/cpufreq/special-tests.sh        | 14 +++++++++++++
 2 files changed, 35 insertions(+)

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
index 8d40505dc4682..954c5fddf4d3f 100755
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
@@ -112,5 +123,8 @@ hotplug_with_updates_cpu()
 
 hotplug_with_updates()
 {
+	save_all_governors
 	for_each_non_boot_cpu hotplug_with_updates_cpu
+	wait
+	restore_all_governors
 }
-- 
2.34.1

