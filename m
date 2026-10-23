Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744310;
	b=BIg2JkFsDD5hV6J5GFyuA6hWjIrY3eq3T/5NpJ9AvCZQPWbu2/nWN8CRKz+bW1w2ujBZ
	 E3+muonkbM63NTWkaMF6FTlOIg5UffX9qzCsvUbfKjGGf46hb7za8x14cYJ1u+rdmifcU
	 sTWOmCf3HUljfIQrCbu2/rso8uG960QZ3u/NLINrm4KRMU7UJJTTMwSxNDc3b/jNzj+0J
	 A0J4eJVLyC+ZL+qZpoMZ+uTxuF4h201Vy7D7P64qARH1oIXcFAcPOBa7IV4EBhxGJujBW
	 vERh9mIx4LI4YyKKGtwpQH38vNj1bs5c/T7lpyOhjBeX+9CPHD0DroKYsyQl7xiAAmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E05olwjMu5WDS6DflFS2ipV3arJ+f6q+MONc7cQ+gq4=;
	b=WE4iMA2oHeDCw8MHQYXhyl4caqOS88azsj25F09z7afBhSqUO4xt+bRCRLbx9OUGlGJr
	 weKMNgbHnDB3eCr20/2zFF4YnIwAXPqwcdB6vlbf0dtKsPiAjaojQ8Gw9GJGIaJo5ezo3
	 u6MPLuAULTQmIe/g/3a3MGn7nenzw0yY91aRAD/YSwxtxDz1GeEjxWOubTSNVkiPHnOXq
	 1hPuvSuffDMqIFLP2w/+tI0deCicqetePvuT5M5UOamBi36qXG6R9vCp7ISpwFJBpLC+y
	 Bs7iCOf4QOxormK9XcqLjKgvf8n210CMibw0sHIGBiu9p8MgWgvM7GyQE6CXyCqEvRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JLKUQzn8;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD8606A31E
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 08:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBD8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JLKUQzn8
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so145337c88.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792744309; x=1793349109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E05olwjMu5WDS6DflFS2ipV3arJ+f6q+MONc7cQ+gq4=;
        b=JLKUQzn82EfCS/PK4aDyVvcv3gYzzF2Jtqxle8dQaEIXSK0iSxGVmaHOhLDPhqwcLV
         fxkZ2Q+sQKbT0SfGeyo7Rut5L5ow2DF2LTK2Co6uMsAColZi3HbzLIfrr/oG0QopJSi0
         MGihT/tiCRNM5m+eeUsFm0U4IVyrpIvWqjt2sPapnF+iAStCdEmfOV9lh3ile94LoGTZ
         UI0ufV00ZQax8L1zOcqsqAM3aC2yIVS+/cIscbBDCU82qRvYZci8WRp1NR43Cyr/3yF+
         6ssn89p6r9ttb++NaQC9TVRGSxIFjABuU9ToR+SKRK7z7N4THok3MzmLHhUMo5XF/N7E
         sDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744309; x=1793349109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E05olwjMu5WDS6DflFS2ipV3arJ+f6q+MONc7cQ+gq4=;
        b=gU2LMRMj3mw7r7jg0Op/p06/V7AH97EBrI3H7KMly9cTGweXqVD7fMA2GLuLUZ9UtK
         ZzO/3VpIIgeAFqqhqO33KYvfEE/JrgCxpbHEAnG+cmCZhfl77yuyI8LT089i2RGYZ/UB
         +XrDyff872Iy0MUCWJASRPEQCiF79JG/r1Z/3Bsod/9dag9Di7iPc/o9iXI1y1aQDXw5
         h4kAz+ZNIkEEl4raM77sFRY5oNBzsN9GKxhAtlTe33Awk2J0yz31yuLEdB5ut1k2n9cB
         ky/sQ2UsPABqaA8aGWZ0PzoN2vJ3y/c2MB1cQ/0QqMGgOgLEw77KueKB4hZkOIkJAWV4
         ZRmg==
X-Forwarded-Encrypted: i=1; AKwUvBx7AlfspLmzjCTP9Pd5fTFmAvDLsoSUyhN2qR/E+Bejpk70xe0rcgTQqVJdKIZhIlJ7628FaJd4Eg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4YJrf8b5IJ6yaC+PI3VrKcq3ZNoEU9vakspc13rU7KNWW9QSC
	kY8Y3CoJrdhZzN/bsNVxNjGE2sPmBqT+Mw05eNp6yMMUc8qf2RPccb/Pj6iv3tY/
X-Gm-Gg: AYBFou0V3qc3UjoXhdXDjnstiiVQzPOyJ8wyamFloU+YONXSsoT6OYl/c9bbS5AwMMG
	NqPU7zAcDR4a/2sMYoiOcmY5udNk5hOQkF3JxBWollyiFpy8nF8NIPAREr4n1UrdKf9B5nhN7F0
	kKg+L4qhZRYaHhDeaSn2B0f8mMjKkYxpDHMqTBkyxmhN/xwnh/qhT55AgPY5nLEndw8LTfM9r8l
	ALoct0cHIZ2g75eaJmHmtSnXDiCuq3MxdL/BrqYJJNf4AJe/IYrSGQUsPH2NJiCpKl4tL0NmDGG
	Cn7U/umY6gUNomGlsYvm+vrY9iUqfd5OCwrtp17J62eeB6Ao+D/Q4pwviajhv4r94L+X4bWW/7K
	aNh9WXnBPIMSkJDBKJadW7ZHKGVciKSbc56xvgCnZoredOwXljSvCVBpqYpC1VLFdYAIGIBayUy
	5GPKftq2TqPgHQ75aKTqnSHQmbowryt+BfL+6Yib6mIeE1Msqxdw79c4t87mfPEDdFmOz7ZEfRc
	uErA4MpVQzSfQecgPofwfZtiJnRLmDKQZbpVc21g/1W7bzXaR9z2615maeB5JZg0KzzTgeP3bG4
	w9wL5gg=
X-Received: by 2002:a05:701b:4194:20b0:189:d6bf:7eaa with SMTP id a92af1059eb24-195c4d61629mr2215801c88.16.1792744308436;
        Fri, 23 Oct 2026 01:31:48 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195dfbc23fbsm4661551c88.0.2026.10.23.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:31:47 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: zouyipeng@huawei.com
Cc: zhoujinghao24b@gmail.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH] cpufreq: ext: serialize BPF registration with governor teardown
Date: Fri, 23 Oct 2026 08:31:31 +0000
Message-ID: <20261023083131.58291-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927101342.3240263-2-zouyipeng@huawei.com>
References: <20240927101342.3240263-2-zouyipeng@huawei.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct_ops link can outlive the last policy using the ext governor.
Switching that policy to performance releases the DBS tuners and clears
ext_global_tuner. Destroying the link afterwards calls ext_disable(),
which unconditionally dereferences the NULL pointer.

Serialize tuner publication and release with BPF registration and
unregistration using ext_mutex, and allow unregistering after the tuners
have gone away. Preserve registered BPF operations when the governor is
initialized again while the link is still alive.

Take the CPU hotplug read lock before ext_mutex in the BPF callbacks and
use the cpuslocked static-key helpers. Governor callbacks can run under
the hotplug write lock, so acquiring the read lock inside ext_mutex would
invert their lock order.

Reproduce by selecting ext, attaching the RFC sample, selecting
performance, then destroying the link. This was tested on arm64 QEMU
with Linux 6.12 plus the RFC and Jinghao Zhou's ext_gov_update() fix.
Lifecycle, frequency-limit and original sample checks also passed with
lockdep, jump labels and CPU hotplug enabled.

The 2025 fix addresses a separate policy-state lookup error. This
teardown bug is present in the original, unmerged RFC as well.

Link: https://lore.kernel.org/linux-pm/20240927101342.3240263-2-zouyipeng@huawei.com/
Link: https://lore.kernel.org/linux-pm/20250918125241.80968-1-zhoujinghao24b@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/cpufreq/cpufreq_ext.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ext.c b/drivers/cpufreq/cpufreq_ext.c
index c79068e86..20d4d3648 100644
--- a/drivers/cpufreq/cpufreq_ext.c
+++ b/drivers/cpufreq/cpufreq_ext.c
@@ -197,8 +197,9 @@ static int ext_check_member(const struct btf_type *t,
 static void ext_disable(void)
 {
 	pr_info("%s : Unregister ext governor(%s).\n", __func__, ext_ops_global.name);
-	static_branch_disable(&ext_gov_load);
-	ext_global_tuner->ext_gov_stat = CPUFREQ_EXT_INIT;
+	static_branch_disable_cpuslocked(&ext_gov_load);
+	if (ext_global_tuner)
+		ext_global_tuner->ext_gov_stat = CPUFREQ_EXT_INIT;
 	ext_ops_global.get_next_freq = get_next_freq_nop;
 	ext_ops_global.get_sampling_rate = get_sampling_rate_nop;
 	ext_ops_global.init = init_nop;
@@ -210,6 +211,7 @@ static int ext_reg(void *kdata, struct bpf_link *link)
 {
 	struct cpufreq_governor_ext_ops *ops = (struct cpufreq_governor_ext_ops *)kdata;
 
+	cpus_read_lock();
 	mutex_lock(&ext_mutex);
 
 	/*
@@ -218,12 +220,14 @@ static int ext_reg(void *kdata, struct bpf_link *link)
 	if (ext_global_tuner == NULL) {
 		pr_err("%s : Need set ext governor first.\n", __func__);
 		mutex_unlock(&ext_mutex);
+		cpus_read_unlock();
 		return -EEXIST;
 	}
 
 	if (ext_global_tuner->ext_gov_stat != CPUFREQ_EXT_INIT) {
 		pr_err("%s : Already register.\n", __func__);
 		mutex_unlock(&ext_mutex);
+		cpus_read_unlock();
 		return -EEXIST;
 	}
 
@@ -233,17 +237,20 @@ static int ext_reg(void *kdata, struct bpf_link *link)
 	if (ext_ops_global.init && ext_ops_global.init()) {
 		ext_disable();
 		mutex_unlock(&ext_mutex);
+		cpus_read_unlock();
 		return -EINVAL;
 	}
 
-	static_branch_enable(&ext_gov_load);
+	static_branch_enable_cpuslocked(&ext_gov_load);
 	pr_info("%s: Register ext governor(%s).\n", __func__, ext_ops_global.name);
 	mutex_unlock(&ext_mutex);
+	cpus_read_unlock();
 	return 0;
 }
 
 static void ext_unreg(void *kdata, struct bpf_link *link)
 {
+	cpus_read_lock();
 	mutex_lock(&ext_mutex);
 
 	if (ext_ops_global.exit)
@@ -251,6 +258,7 @@ static void ext_unreg(void *kdata, struct bpf_link *link)
 
 	ext_disable();
 	mutex_unlock(&ext_mutex);
+	cpus_read_unlock();
 }
 
 static int ext_init(struct btf *btf)
@@ -470,9 +478,13 @@ static int ext_gov_init(struct dbs_data *dbs_data)
 	dbs_data->ignore_nice_load = 0;
 	dbs_data->tuners = tuner;
 	dbs_data->up_threshold = DEAFULT_FREQUENCY_UP_THRESHOLD;
+
+	mutex_lock(&ext_mutex);
 	ext_global_tuner = tuner;
-	/* Disable ext_gov_load as default */
-	static_branch_disable(&ext_gov_load);
+	if (static_branch_unlikely(&ext_gov_load)) {
+		tuner->ext_gov_stat = CPUFREQ_EXT_LOADED;
+		goto unlock;
+	}
 
 	/* As default, set ext_ops_global to nop function */
 	ext_ops_global.get_next_freq = get_next_freq_nop;
@@ -480,6 +492,8 @@ static int ext_gov_init(struct dbs_data *dbs_data)
 	ext_ops_global.init = init_nop;
 	ext_ops_global.exit = exit_nop;
 	strscpy(ext_ops_global.name, CPUFREQ_EXT_DEFAULT_NAME, strlen(CPUFREQ_EXT_DEFAULT_NAME));
+unlock:
+	mutex_unlock(&ext_mutex);
 	return 0;
 }
 
@@ -490,11 +504,14 @@ static void ext_gov_exit(struct dbs_data *dbs_data)
 	if (!dbs_data || !dbs_data->tuners)
 		return;
 
+	mutex_lock(&ext_mutex);
 	tuner = (struct ext_tuner *)dbs_data->tuners;
 	tuner->ext_gov_stat = CPUFREQ_EXT_NONE;
+	if (ext_global_tuner == tuner)
+		ext_global_tuner = NULL;
 	kfree(dbs_data->tuners);
 	dbs_data->tuners = NULL;
-	ext_global_tuner = NULL;
+	mutex_unlock(&ext_mutex);
 }
 
 static void ext_gov_start(struct cpufreq_policy *policy)
-- 
2.43.0

