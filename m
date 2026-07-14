Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71C18FDBE
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061039; cv=none; b=lQOGUIp/LIArzMuu/u1eBemX4pEz5ZFbdsdCHP5gzBjsXt2PPEHGXC1/Y8CF3E370TFtrwfDNV2l/qGx3KJn0642VV2qRvvx6G81YKUnJD3JzPX+yUhhIqn4goWqxXOs+oALXAlyTjx/uCtwCZi65PzyPwkI/NbiFKPwl2llgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061039; c=relaxed/simple;
	bh=9lzeEK5f4xVEeNfsDDbBIJeouVhKJZp/W013tI692aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYxkeyJHaluIupJHNwwA5Ob66XKlAxFBOUtK2eJTXnzBTFNLK1dDTAN96qEbem29qqwEA/tLmhGO5h3zc5hymzycUWcWErHXugILX9WOgRhO0urMCJMP21y1dHtfgndvYnvrKv6R7T5Xsy73zMCZd+4D1zgdsPRPhCka2P64S0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=ke0XwS3l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="ke0XwS3l"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca913a601fbso3294029a12.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1784061037; x=1784665837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EiAMDgMBcK99WPRXAfTnx98/jjzLbYV0ClzW0tPa7Ro=;
        b=ke0XwS3lC1H4232MH7+nXokcvnfu5jSiHiKR0oJBDoBuLTWqhWid6FohuIg8N/AInT
         6THO2w7ioZ7x79Ol5aDIcs7KfRmc1Xr0yO8gDMiMC4wXsXsgoYtivhOXwCcm/7JTWmgh
         jEEZbh5lOERLTK/z+GUS0waz9azWomA6oJzfQh4Ut88vTJSRtTInM5DWM/PV4lBeB5cY
         uNDuriyO5wSMkL3YPNaYsp4YmFH1oh92KH8toh09qNVHjuV+uocB2mGQ+W+d4WQ3S9x3
         rmq0f5bZStHL6K/kRivsS5IMYDWpKVsg4vjwUCUyJ9dxPqLU2tTm2u5M+bao0TgF8zRU
         MjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061037; x=1784665837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiAMDgMBcK99WPRXAfTnx98/jjzLbYV0ClzW0tPa7Ro=;
        b=Y4xNqXI8eC9dzuxqAF3BjuW6676bhDPLJj1fFDcHEhtJCKkQgucrAEU+gWvBHZK3kO
         R4UnMvxZPMHMZJha5yR1+jV65u6pxN23muxexiNnZEHUHKpbQtqAvUY6VEUL5Da0FrzK
         p0EXVrUvqXuNxv6T9XWXdagBOVldh/NT24EoMgpjtbzsA0+33jk7akwAj3rTY9eANTZS
         Ds1jJJG7vfIReUCi8otgV1WXB1XSYi9Wg3LlleJ/0gQz1ts2Bar0oDWSd6DuOgCiBqz6
         BKo3reVY3CyJujhheAnxYtw/HCz+nEYBscpJlD7trQ+ejTUBC4YR91vcbpmfb7ewXfDC
         VamA==
X-Forwarded-Encrypted: i=1; AHgh+RqqEIKbpKepuhhoesciBLP92wMoKQsXCjV8JPN31YmBSNpr4wpoVM7RJeeAvuoE9KdytRx/oHuLqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxX+pQtkDlfxzKTB5MZBb7SgPXQI8yxocC3ZA0NAmJ07cbvVTR
	hGB+c+OOYVA/ikbxhXghSpUaaVB/5sBAuuXemqQ7BTv7UeYCX3zUf2t2bWDU14fxTuU=
X-Gm-Gg: AfdE7clNYsnEICXWbgH+GnKOFSblnBjeFuQd3hwnTVO4c+zYyNk3WmqOGJyEUBP+cJU
	pDdt1L34PfEBExoOoLZVQJKXYozMMsO8oGEMjSqAK6HI4svzMECGnH4Xbtp02YM0q+7JLgF9DmF
	LrLnp/hSpgrWDclDAQPZCVzaaRBOYrF7Y6B9zZmwRRHEvuxA6SvVrAYjFikLMvtBXjeDjQ3C0LJ
	zO7XSyaaPtVeR9PMrgrIbZ4HK3jsByi8TrxIn8SFaBW+Vcq3nlWTmZo9JechvE5IkFGGxqRF6um
	5AUjsYlHeMctcU4TJlTc1RkmE619ZVuzCfsGamd7fqFEh0OPyx5XGyH+jpCKyvD1CtuNtJctEIT
	yLDj3L6sqo0p4NRCSMMibK/R8h2IhC7+gdYiQnMhLT4qtQ3VRWgQSDMPCjzg+ug35EjUKAQOHWi
	J6hftiHan5E++oxDrjr4d+3mtn3EZsdjncvkV3BfiKO8X7DZtHdQ==
X-Received: by 2002:a05:6a21:329d:b0:3bf:9fe1:c27 with SMTP id adf61e73a8af0-3c35754e38fmr4375761637.40.1784061037321;
        Tue, 14 Jul 2026 13:30:37 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b924258a2sm76521483c88.1.2026.07.14.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:30:36 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	ytan089@ucr.edu,
	pgovind2@uci.edu
Subject: [PATCH 1/1] rust: cpufreq: Fix temporary write in Registration::bios_limit_callback
Date: Tue, 14 Jul 2026 20:30:35 +0000
Message-Id: <f56e1010822963b2f8133c63de47645834281007.1783456063.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783456063.git.pgovind2@uci.edu>
References: <cover.1783456063.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writes made by `T::bios_limit` go to a temporary on the stack instead of the 
limit pointer passed by C. 
Fix by creating a mutable reference to the actual memory location of
the limit pointer.

Additionally there is a creation of a reference from the 
uninitialized limit pointer which is unsound. 
Fix by initializing the limit pointer to 0 before 
calling `T::bios_limit`.

---
Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend abstractions for driver registration")
Reported-by: Dylan Zueck<dzueck@uci.edu>
Reported-by: Yuan Tan<ytan089@ucr.edu>
Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
Assisted-by: ChatGPT:gpt-5.4

 rust/kernel/cpufreq.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 58ac04c650a1..0f9385d41b64 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1349,12 +1349,12 @@ impl<T: Driver> Registration<T> {
     unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> c_int {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_i32_unchecked(cpu) };
-
+        unsafe { core::ptr::write(limit, 0); }
         from_result(|| {
             let mut policy = PolicyCpu::from_cpu(cpu_id)?;
 
             // SAFETY: `limit` is guaranteed by the C code to be valid.
-            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
+            T::bios_limit(&mut policy, unsafe { &mut *limit }).map(|()| 0)
         })
     }
 
-- 
2.34.1

