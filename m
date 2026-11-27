Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781553;
	b=O8c6aEj5JJAkvgikyqFHoRZdGvUw/TZXxwxwHWPuXtJ49TWPgH4uBbQteaqdv2Yuia4i
	 j3v80nQLAJkhoZl68FYVv3otfFoGtC7BEMjkBPEHTQ3twsuPu9RctmrOc8JKoIylFKN+e
	 539FsO3hrFagDYf3qJTy6UJF61MxHI9j+C0SM9ZvorPgf7Xk6dHA4wN0cIadgGpXPBOaa
	 NFDlXOqKTWUthBlIpYLSSSBDDeFETXyIGXWB2b1D7kqR1S1ZyJl1pIowXpN931kl4auDc
	 Gevqq2GqoqmlI3y/VKxFFkjgffZiIQdXs/dSJ+6/ZJPHGWaXM4QIdO7PvPBodODGyvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781553;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=snuzEJKIHyDMfym5CCf8Mmb7VuRB9rqH271+kfl1bko=;
	b=XNl1sSyCHCCy+jaTDse+hxQAL7m93LFGoydvcXZZT33059by7eBsO9PWdHHKIgRMzx/G
	 zTeYCSFeacpOEclxjxU/51Za/ooLbfDdY7663IMH2qo7kTu7IavPj8D5q6ReRQfqzOiO5
	 sI2+VzoZKXkaMMx1fIPGzqB2xpGaNqrJyEKigDWj1bHgjZyxkh6WPHARvNE3sSEiagoTw
	 YHoNdvbDjSxiMUHdNhFUotxFmm9SYNhLo+JRSKcKFPUqloe6JuHovLcOMUHaQXuEx2uNE
	 h8PMRbHlWXcYndZUjUqApn30OfGbH21ZumGGAMOYpbUph9yonUhRgYwgbcu43hkwpwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=GFoeCEsf;
	arc=none smtp.remote-ip=220.197.31.6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD34606A31C;
	Fri, 27 Nov 2026 12:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD34606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=GFoeCEsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sn
	uzEJKIHyDMfym5CCf8Mmb7VuRB9rqH271+kfl1bko=; b=GFoeCEsfcsurQPaJXE
	STR0xkAnbKWj87EMAxywv+oZEC9baDoQcKau7ySlS/3rePzPHoT5hdeRol6b5UBH
	e7H5k8sWCgK1ZRlZFcK0EHSG5a6M6cNMGADbRjcTRx3xiwUXJkcrXbErk+7Tei9m
	NzuyyNH62SmGCnxTlEXVCtx8Q=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDXB+6PcwlroqgBEQ--.59001S2;
	Fri, 27 Nov 2026 20:12:06 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bilal Hashim <AeeSec@126.com>
Subject: [PATCH] rust: opp: clean up OF OPP table on error paths
Date: Fri, 27 Nov 2026 20:11:29 +0800
Message-ID: <20261127121129.1150-1-AeeSec@126.com>
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
X-CM-TRANSID:PikvCgDXB+6PcwlroqgBEQ--.59001S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4rXry5Kr1DKr45ZFb_yoW8tr1UpF
	48GFW5trZ5ua4xGws7Xa1I9r18W39rXayvv3yUGr9Iva4UCw10qrn8Xa42vas5J3s8Gr1S
	gryvgr4aq3ykJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziGQ6tUUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrRcfuWsJc5d2UgAA3+

In Table::from_of(), if Self::from_dev(dev) fails after
dev_pm_opp_of_add_table_indexed() has succeeded, the newly added C-side
OF OPP table is leaked because Table is never constructed and Drop does
not run.

Similarly, in Table::from_of_cpumask(), if either Self::from_dev(dev) or
CpumaskVar::try_clone(cpumask) fails after
dev_pm_opp_of_cpumask_add_table() succeeds, the C-side cpumask OPP table
is leaked.

Fix both paths by rolling back dev_pm_opp_of_remove_table() /
dev_pm_opp_of_cpumask_remove_table() when Self::from_dev(dev) fails, and
by cloning the cpumask before calling dev_pm_opp_of_cpumask_add_table().

Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -667,7 +667,14 @@ impl Table {
         to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.as_raw(), index) })?;
 
         // Get the newly created [`Table`].
-        let mut table = Self::from_dev(dev)?;
+        let mut table = match Self::from_dev(dev) {
+            Ok(table) => table,
+            Err(e) => {
+                // SAFETY: `dev` is valid and we just added the OF OPP table above.
+                unsafe { bindings::dev_pm_opp_of_remove_table(dev.as_raw()) };
+                return Err(e);
+            }
+        };
         table.of = true;
 
         Ok(table)
@@ -689,14 +696,23 @@ impl Table {
     pub fn from_of_cpumask(dev: &Device, cpumask: &mut Cpumask) -> Result<Self> {
+        let cpus = CpumaskVar::try_clone(cpumask)?;
+
         // SAFETY: The cpumask is valid and the returned pointer will be owned by the [`Table`]
         // instance.
         //
         // INVARIANT: The reference-count is incremented by the C code and is decremented when
         // [`Table`] goes out of scope.
         to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_raw()) })?;
 
         // Fetch the newly created table.
-        let mut table = Self::from_dev(dev)?;
-        table.cpus = Some(CpumaskVar::try_clone(cpumask)?);
+        let mut table = match Self::from_dev(dev) {
+            Ok(table) => table,
+            Err(e) => {
+                // SAFETY: The cpumask is valid and we just added the OF OPP table above.
+                unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_raw()) };
+                return Err(e);
+            }
+        };
+        table.cpus = Some(cpus);
 
         Ok(table)
     }

