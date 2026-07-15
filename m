Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8F4A13A5;
	Wed, 15 Jul 2026 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137308; cv=pass; b=rcfNxVZ3S7/01OeUBtZdUQb1ZSVowbB3YVqFgjyygrJrP1J5z3JlYNj/pU71UhxXNYHBfxBgC0FpMdhn37jHIKKgIy1LQFygYt9DFZBnqJ3WhAaSgXlxj0bxvdvoRasP0Z81wKcmKsFH+xHpHStKaOlfU/PYpy8pVJpuwNlw9Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137308; c=relaxed/simple;
	bh=JN/cGS1eC+3xv9m6aJOJLEc0YgdyyIOT353kLKT1J50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IUxmQxIJ/6aTJo6WPAZkRcOWKzN7QTLWQT03LNXILL5MHNUa3nnsQIqwDYTwbSCpaqyuvgCjh2Svo7kIY21b+e12DEWPWxIr+RMgBk2EptfvT1HwTUAl4+m+TL8XWX5LRkD9q/63vqxUcu2JTJV9ewrpXPIYe92JhZbKLiijaGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=IHwcxqTi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="IHwcxqTi"
ARC-Seal: i=1; a=rsa-sha256; t=1784137299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CguAlI96BXnlxSTB1gS/htOoCOXUuAGQt3Ugoad+SHskHHfbI3R9839WxwpUfbcgTVKR6QnEJzIs5IUloJ1eqh4O1WzQ8ULMHqCEz81RV7Dteb9UGanzAR68/w+fQ2hRDJu1keX94xcjwmWfLtokDEWulhyFCkfUUNeeqxDQZe8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784137299; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FOaC/Ja0Bg0HP/RR1H/2OTDtLJm8eCNTzhEVsoHPYrI=; 
	b=WqnAiZiudgTMkU7WLM9ZFj3yQpE621qqzCQTQ4rkDEo26PI2psANbAxD2qffmlK0g63pg4rQ3noFUNdqLNejC/b72JrdWVCSpCWEAqeU3MN+FYgy2QNqByDMMEOjc9rRp604WcK1rsLrjia+IWWH81pMT4mRggZuUXeD8Bq3Q4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784137299;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=FOaC/Ja0Bg0HP/RR1H/2OTDtLJm8eCNTzhEVsoHPYrI=;
	b=IHwcxqTiyZ6A11n0KU/BiAWP7ym5LUfHgdyayC7GKd+DARMM0x7BJSjWDjTnorVH
	TNg5y8BifNwIPereROyoDgRhlqaRXVVqbTSGCdpijhp/sGqxQ63fkn52oIYcvCvjF3+
	Ji27cQb80pP95qhoS34s0oGIOsDIO++hxXtZPBTYW+su1CWXcrctOrW0ZN52zVHwbU/
	RCHcWpR+LZ1nOY6mjZb3KedE36CWVsrWabJeqt3w+OsOnEd3Ng83Or7Y5gIG0On33iQ
	eAopIX2fdWYnHz35gO92reW1u5skxK18YK7AFnYdWL7zosbX4dMFLNelDEWahVEg0rq
	RTHaiJ3vFQ==
Received: by mx.zohomail.com with SMTPS id 1784137296275394.49536392949494;
	Wed, 15 Jul 2026 10:41:36 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 16 Jul 2026 01:41:29 +0800
Subject: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines and
 don't warn
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB2oxir2KtJFMpnaEbSSSUUQ7
 27U5Vv8v4FyEFZ4ZRsEXkTlNyUUeQb0tVPPKD4ZCqKyepgG7ehx1mgj4zKir62rqH22zhtIzRz
 4I+v169639e8GpnhOYN8Psdz7THEAAAA=
X-Change-ID: 1cc24037-amd-pstate-vm-d6ab4c959bd3
To: Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev
X-ZohoMailClient: External

When booting a virtual machine that simulates or passes-through a
relatively new CPUID, one or two warning messages are printed to kmsg:

    amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
    Please enable it if your BIOS has the CPPC option.
    amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Technically the check is not wrong and acts as a safetynet that prevents
the driver from being registered incorrectly, but the warning messages
are noisy and not really helpful, as virtual machines cannot adjust the
CPU frequency from the very beginning. Moreover, mentioning BIOS here
makes the messages even more confusing.

Fix it by bailing out early when running in virtual machines (excluding
Xen Dom0).

Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a74a4cf99d22..f2115f935318 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2228,6 +2228,9 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
+		return -ENODEV;
+
 	/* show debug message only if CPPC is not supported */
 	if (!amd_cppc_supported())
 		return -EOPNOTSUPP;

---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3

Thanks,
Rong

