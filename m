Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783280;
	b=wXKSZ+78/89V1O906m4UZJfZn0crxaV/DhiUQJzKBIWkUCnGjGZFNiD67DshxtEOBL+Z
	 LKmtCobA3D4jwsypXes+55wlsnqSrjXtB0pLPwmkCogU71ZFylwUrUkOd6rqo71Ny91UB
	 MJaWW3OF58su6s4ti47hzYOYxULblKDRW6MIvTRef/EmBdne5XB+4BgTBAVQP8+2+7Fcn
	 i22liS5KSt2Mj4/UfNw0lzh9YW5rvM8Wv40XMwF3vQHKWM9A+HXcYwfgc/ocA0SwqB0sO
	 PMHLgnb2mxOzP6pz0w/z+P+jzpkEieQpDGxf6BbaQY0UieRrMR9WUErj4nkAc3Bv9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783280;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=RX3fzEdwUjmGJgfb5WwQYbXjcguQbLTc/Bu5Kcu6W5Q=;
	b=ZlfySpeSKZ3bL/0vvU96MQ10g6lge/Tn0+07dHFzYzgN5lZsJ8rqfREZCIEnSiJqEo0e
	 BR1cpjbLH9ak2J9/Vs3acODIWiiCLoKJ5sD73rehJEAX5UjVg8f7sKagQDNj/NAE9cQCj
	 CXNsRqvpwGEpm3DxuIN27JBfThasx7EAJ9O2FtpMadNnXpWN9usNrgOqhoDO2+DMlIT44
	 W5xP6a8easy4tlxcze9KlobL5W8smXtIfZUPLO4H6lawc+hsrF+hXdX3I8MOMleE8qBIs
	 WRkloMhKTOJ/NFZ5RxaovGIMYqvSZLso+JoDPBac5lm57KmN1LJA6N1gugb1oIPvxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=pkB2H5XB;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CD606A31C;
	Fri, 27 Nov 2026 12:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=pkB2H5XB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RX
	3fzEdwUjmGJgfb5WwQYbXjcguQbLTc/Bu5Kcu6W5Q=; b=pkB2H5XBBlnZbXO5lh
	zLuUs3K5ttroa+hKTfB82Q0Jjf+bCdg0G26TwZxa1bWaaqQW9zLMPWfjSAihZ2ul
	8OMwnR+q2tjy7TwIRFdv1d6tMGA4kzcZA6mK5EygfseGzKQFxBxFBOoDn1jM/L4n
	uPp9L3VU2nh3ESc0AdILoQHhU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t15NeglrlgYZBQ--.51046S2;
	Fri, 27 Nov 2026 20:40:48 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bilal Hashim <AeeSec@126.com>
Subject: [PATCH] cpufreq: rcpufreq_dt: avoid dangling policy->freq_table on init error
Date: Fri, 27 Nov 2026 20:40:18 +0800
Message-ID: <20261127124018.972-1-AeeSec@126.com>
X-Mailer: git-send-email 2.47.0.windows.2
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
X-CM-TRANSID:_____wD3t15NeglrlgYZBQ--.51046S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1rWF45urWkAF4DCF4fAFb_yoW8Aw43pF
	WrtrZ0yr1rXF9xZw47Xr4Y9r18tF4DCrWUGryUWrnav3srAF4j9a1jgry8XF4kurn8CrWS
	yrnY9FW7JFW8JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi0D7DUUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBnhHPamsJelGkfQAA36

In CPUFreqDTDriver::init(), policy.set_freq_table(&freq_table) stores a
raw pointer to `freq_table` inside `policy->freq_table` before
policy.set_clk() and Arc::new() are called.

If either policy.set_clk() or Arc::new() fails, Rust drops `freq_table`
(freeing it via dev_pm_opp_free_cpufreq_table()), while the C cpufreq
core's `out_clear_policy:` error path in cpufreq_online() only clears
`policy->cpus` and does not reset `policy->freq_table`. When a policy is
reused on subsequent CPU online attempts, `policy->freq_table` retains a
dangling pointer to freed memory.

Allocate the `Arc<CPUFreqDTDevice>` before installing `freq_table` into
`policy` so that `policy->freq_table` is only set once `init()` cannot
fail.

Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -134,15 +134,13 @@ impl cpufreq::Driver for CPUFreqDTDriver {
             .set_transition_latency_ns(transition_latency);
 
         let freq_table = opp_table.cpufreq_table()?;
-        // SAFETY: The `freq_table` is not dropped while it is getting used by the C code.
-        unsafe { policy.set_freq_table(&freq_table) };
 
         // SAFETY: The returned `clk` is not dropped while it is getting used by the C code.
         let clk = unsafe { policy.set_clk(dev, None)? };
 
         mask.copy(policy.cpus());
 
-        Ok(Arc::new(
+        let data = Arc::new(
             CPUFreqDTDevice {
                 opp_table,
                 freq_table,
@@ -151,7 +149,12 @@ impl cpufreq::Driver for CPUFreqDTDriver {
                 _clk: clk,
             },
             GFP_KERNEL,
-        )?)
+        )?;
+
+        // SAFETY: `data` owns `freq_table` and will not be dropped while in use by the C code.
+        unsafe { policy.set_freq_table(&data.freq_table) };
+
+        Ok(data)
     }
 
     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result {

