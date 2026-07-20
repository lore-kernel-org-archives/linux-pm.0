Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91163451056
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570461; cv=none; b=Z/X+DNcOB1k/XU/agOpIm+oB53TKJgif2BzuW1B70qFub54HaoqsbY14OseU/7xh91RtALLOQryfRzFmK4ITzjfpsmY1MegPhWxL1dyjvDeubX/r0bDZfPrWpN0jsBtJ9H+8Zc/e0lffyqrHPEOUoRR7xQ242TWxg4EqvBwmw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570461; c=relaxed/simple;
	bh=NwFxwEzduRthsAklGhzehNehnxCMZ1sKcUXTgzWo67I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qaRqpnnclMhDdheo3+uwGTKDad1kLqkvlbl1veq3sadSXOwku0HDSRI9nh8hgIaZRCx6ubkDEJRnvM6BmxqI8Agvv4YDXAjeIpVWrlEjg0T47GjB0SBg29hnOtTRZ7DIFuzp/SaVS6BowoUi6AQ+wSSJYQ5psIsd/FQUsf0yeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=dR5oCnzH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="dR5oCnzH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf707e3a70so2453898a12.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1784570460; x=1785175260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKOREryEfKuNZZdoCOQ4fv+T8IxxHM0POBXRDbZ5okM=;
        b=dR5oCnzH+eWP4FLyw9QlFCfGMwGlpvRbtQidrhxxgjiKdvS2gdc0OThfvPK0yk6YnZ
         a7vC7aqTG8+HRV4C9BWaPQ0bEOLZIl+sq6a0VVWTGgdeD9kiCmfAFneN9Q/FC1DDR0+X
         FZYFBUH9t+MphuRux9PfOl/MGw2ln3pROwsV2+wl67Xf2bkSXwYHXvG0McPJ2lZyOkVg
         dWc5BHODso0fpDYeQgu9OBE/uDK0tQNvHU0W0SZMjJ7CHkbR5Bn9xgcP4J8+l79p+t19
         bNGHfMMe9Y7QwRxkxhZIZiEV+xPsMlNSWhFD7grBHAnrNHvZ5e1YnpeTiCTSsp5o2AKW
         LLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570460; x=1785175260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKOREryEfKuNZZdoCOQ4fv+T8IxxHM0POBXRDbZ5okM=;
        b=J/O6z8IiFrzfGK3XCAU8bpjRl3llvFBh436pS1WlYwRkKpJS1YzsYBeESYPRD6umNT
         p6m/qZ92wt4Fr1UwPRwZY3eC1y9NBF9g6cBn4UOA6FBpwA84sqp9Nsrw2Itw4ES/f1Nf
         /KShhoJtAx67gqvxHXG14h8fmD5DHJodPB29Qu0cZZyzwhZYsJAenMNIJtFkG6bcnN7g
         a5eNTvw3IKElXd6dDEtXyKigj2fEeFiIT7fw84LONGt5n4RcTQOiUXQNhB5PJMV9E6Ue
         TR7XLjouv+0syKj/wc4jgAB96tCsC5VIL8uwpcvReMJSnzgGqBc7brPp1/aL9mtb2blo
         g9RA==
X-Forwarded-Encrypted: i=1; AHgh+RqkM1/TN4AwMQU9YNUXDuudJEf2/EYbZoe4dx9Eri58I92btnvgHP8MGLYqgQckSDa5huXrrGo6fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTnox3Br3/xX4xJLtnzP4Qh5EmZ1qDVFzwYWwkNzcsr5Zo693
	zp0M9UT/ludWvD2htRpMhP7DtL9AFNaTZcjMSFn18Rq2cQaGrZgC6H7ISkATpaQxanw=
X-Gm-Gg: AfdE7cnsMexMqgj+TKFtW2C14Afds+IdSixIrG2sjMXC1UiY8h4YqZDY1OwJn7rLWMr
	OOH6cqs/IH3k9JpP7xWTIYnytNRo8EvYlZs7YUmyU3aP9KNpetjlFjC2HkkIWc4kJue6bvJSggT
	KXZW5RoQVkCT1yIFfR21DHkMvfYJenjv4bY9sABbt4QOpFh/omE8x577Vhv8yo4xtmPZvc1T4aD
	c2oipWtNbaFdDNvtFeqSJuYm3oZaapIQeHZxP/bbF1OAYlTrQ005aLK+Z6tT3dqpgYJM1sSPhUr
	D1f+fDLKECzQTXrS3awpSj/ZHGtpQCuxLynl4Qbl3Ej1teQ4ygkyra7lkohN2B13qEQvUdferO9
	21SSP7x0fX6dr6pF2X4joAhg8Z3WiBMsMRbrECSfewfgnz+dYF72Xebb2ZoDMdRvIS6xifTVf1k
	jFCvovUQKdB3/U+cVsQ1OU77ECKmiYBAYyAjlm8ws=
X-Received: by 2002:a05:6a20:939f:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c38d512647mr21834868637.0.1784570459809;
        Mon, 20 Jul 2026 11:00:59 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3142a1bb770sm42198774eec.16.2026.07.20.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:00:59 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	aliceryhl@google.com,
	gary@garyguo.net,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	ytan089@ucr.edu,
	pgovind2@uci.edu
Subject: [PATCH v3] rust: cpufreq: Fix temporary write in Registration::bios_limit_callback
Date: Mon, 20 Jul 2026 18:00:58 +0000
Message-Id: <c38ed08b34af92e134f5aefc993d349bd1dd11ef.1784569723.git.pgovind2@uci.edu>
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
in drivers/cpufreq/cpufreq.c. Therefore creating a reference to 
`limit` is unsound.

Fix this by changing the signature of `T::bios_limit` to return the limit
value.
`Registration::bios_limit_callback` can then update `limit` directly.

Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend abstractions for driver registration")
Reported-by: Dylan Zueck<dzueck@uci.edu>
Reported-by: Yuan Tan<ytan089@ucr.edu>
Assisted-by: ChatGPT:gpt-5.4
Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>

changes in v3:
 - Update documentation for `bios_limit`
 - Use direct raw pointer assignment instead of non-dropping write for
   `limit`
 - v2 Link: https://lore.kernel.org/rust-for-linux/2fd4425697efb6d52459cd886115edd281bd5f44.1784155370.git.pgovind2@uci.edu/
 - v1 Link: https://lore.kernel.org/rust-for-linux/cover.1783456063.git.pgovind2@uci.edu/T/#t
---
 rust/kernel/cpufreq.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 58ac04c650a1..04b39ade32e2 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -817,7 +817,9 @@ fn update_limits(_policy: &mut Policy) {
     }
 
     /// Driver's `bios_limit` callback.
-    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result {
+    ///
+    /// Returns HW/BIOS max frequency limitations for the CPU.
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
+            unsafe { *limit = val; }
+            Ok(0)
         })
     }
 
-- 
2.34.1

