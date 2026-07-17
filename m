Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AB28751B
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331358; cv=none; b=i30JZwEEvz/9ZoeXmeJkFSMLTEQXpRmLLfNlGFe4PB44BzRl0kbLUGEAbMimA0KZSi6vuDEUz7ZJqCgwrybtYvPv2qf4e5XF+gg6NIMQl40gmrIcoRKKDDCfTTw5lTmIV2CloSLvkVCn2HnPZsMcMv7gt4+Xt/0fsewIkHyT40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331358; c=relaxed/simple;
	bh=ZYC0BVHUA9DWfLjamDlXvQyBTsc6cWZh1kFesOJmelU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jqb+LOj2yixdX5UQ0sWDoypepr7LGo0uXllK219oS6QLxWvWr8xzIrVrE+SN7NkiC0HfmfAdx5dGBQ/on2WgpO6kxWGuTlIOCat+CpXyZL6hYOsAqxWPxnuT+efclW94QcWTwUl3lwPvjKManBb3Z1pvVf5g2tgd+teImWtsSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=Gdhwan7a; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="Gdhwan7a"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381216921aaso8275877a91.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1784331337; x=1784936137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkcgPCrUKntk778Bux9cr0o5ER0XvmXk7Las59gJH7A=;
        b=Gdhwan7ah7qV9FRNIrNUWw0NG7kE8pTu2D21dokCq8eQwY1LiuZyf6kromHTu+/gS7
         4X7RuN1mhgQbbrb5Fp8umHDMrjRlaQNlSV5PkOXHjlMrQA4976xiVOr6sHeyRBT7dhmU
         UGpQj/wOZMIxURdOTLGz8FP3HDIXApqKXlj/EpsSd7Dcmo7baEMruhCQ7+OsCLc5M7bc
         mTSZdNn38InygPegO3B0O2Y8xGms0fO2O0FH+X9zEvhb/OZntv9hx8EE6ieAolo0yVso
         VW3nU9oD5jyuXjkmgKhERPJOZvRiFYdb28aukgG4fSjCgSVjv6odUvcR1HXugt9a868m
         npwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331337; x=1784936137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkcgPCrUKntk778Bux9cr0o5ER0XvmXk7Las59gJH7A=;
        b=XUiK0fvdbERQ9FRvNfcrZp0YMOeqW9BE3zDALoSs8ztAJU6ML/JpemfyB5DmPcN4T2
         sCvL1WlrrbFz4Cb+QfU8u4GILJMRfGhcDU7djSBM+V0/N5kba/yTTArSOUGJtTe7OhHc
         7ruJ9fdQDWcmmIyotDs3eIMe12Atp5jNeXfro66gN4r7QLTMd5CqIzyrfWUFSuSTvrr0
         NE4pk8kaOi3FVIXA+JDTboDgcHSIVROVb9Af2o49MqjEIMt6jfqF7Kf4gU9VjUF3AZF7
         dngwiwrO6Bzq8sT+tDvvfcGhu2Lg3YTJzCBvFoASx9txYtSmj+r/OrcGSbadsl0ibd99
         Ghug==
X-Forwarded-Encrypted: i=1; AHgh+RrGGxuG3jjK+usRdEZ2I1TtI7bW3glZ3XcOW4QnVjTQ5xNFYQusdyqFc9pOJorZy+9jxXbSfisvDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+kYG1kjHVRWiHFxj+2MeSgVmAE44YBfLpE93BxTf7gsVqqnM
	o4xAeb0Ezfl2oJdSSIBJzWv77/7TZQcOdW9qV68PN9fL8bkOTyzq9XqCUHHyTLY/aq8=
X-Gm-Gg: AfdE7ck87ChonXgLEe3JjVZ8fGuqj4q78rHkM+eEp6CLpBnNwGQatXz1eT0VFzmZIbs
	n3McYlYUFoe0R2/px9sDMbBIdwD808UreHoDZx5QNbkbAbFG9wtMxi4+6T/GKTc33KK+dRG2pbN
	Ep31uwHF+qoiD4c6Ds6cAsPvCjs/UV7cicZRHNxCe3HKshpYJmvlEbbpdFJglQooWIq8XW8S495
	LIY/+T42cTpsQyCOyxNBFOG1tF3bfmejn9qgwbg5DCPH7kT5EwF6FBXriQzmWeJT1JdrFllRDBd
	GuqE9ECxlLjfRziHkNtgDSLItwpTKJ8JAyYO5UdDqasBldqmM3kCKS9B/bSZgtYNIMYvBUXWosr
	OXbXbqCW4Of9UyK8O+DTUd73wLIpQUTBeuntYQ/WH/k/KeZZr27z4NBvusci3ldG7z9hiR+RLCp
	bZcRUxwnHIrXjb8mjIwgnoCUn5GqxEJcshl1hFGhE=
X-Received: by 2002:a17:90b:3851:b0:37c:774c:77ba with SMTP id 98e67ed59e1d1-38e4b516692mr4624630a91.21.1784331337502;
        Fri, 17 Jul 2026 16:35:37 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm20452266eec.21.2026.07.17.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:35:36 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	aliceryhl@google.com,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	ytan089@ucr.edu,
	pgovind2@uci.edu
Subject: [PATCH v2] rust: cpufreq: Fix temporary write in Registration::bios_limit_callback
Date: Fri, 17 Jul 2026 23:35:35 +0000
Message-Id: <2fd4425697efb6d52459cd886115edd281bd5f44.1784155370.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `Registration::bios_limit_callback`, the expression
`&mut (unsafe { *limit })` creates a reference to a temporary copy
of the value pointed to by `limit` on the stack.
Therefore, writes made by `T::bios_limit` go to this temporary
instead of the memory location pointed to by `limit`.

Additionally, `limit` may be uninitialized, such as when
`Registration::bios_limit_callback` is invoked by `show_bios_limit`
in drivers/cpufreq/cpufreq.c. Therefore dereferencing `limit` is
unsound.

Fix this by changing the signature of `T::bios_limit` to return the limit
value.
`Registration::bios_limit_callback` can then update `limit` directly.

Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend abstractions for driver registration")
Reported-by: Dylan Zueck<dzueck@uci.edu>
Reported-by: Yuan Tan<ytan089@ucr.edu>
Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
Assisted-by: ChatGPT:gpt-5.4

changes in v2:
 - Change the signature of `T::bios_limit` and have
   `Registration::bios_limit_callback` write to `limit` directly instead of initializing `limit` to zero first and passing a mutable reference of `limit` to `T::bios_limit`
 - v1 Link: https://lore.kernel.org/rust-for-linux/cover.1783456063.git.pgovind2@uci.edu/T/#t
---
 rust/kernel/cpufreq.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 58ac04c650a1..5dc09063f4e9 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -817,7 +817,9 @@ fn update_limits(_policy: &mut Policy) {
     }
 
     /// Driver's `bios_limit` callback.
-    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result {
+    ///
+    /// Returns the limit
+    fn bios_limit(_policy: &mut Policy) -> Result<u32> {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -1352,9 +1354,10 @@ impl<T: Driver> Registration<T> {
 
         from_result(|| {
             let mut policy = PolicyCpu::from_cpu(cpu_id)?;
-
+            let val = T::bios_limit(&mut policy)?;
             // SAFETY: `limit` is guaranteed by the C code to be valid.
-            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
+            unsafe { core::ptr::write(limit, val); }
+            Ok(0)
         })
     }
 
-- 
2.34.1

