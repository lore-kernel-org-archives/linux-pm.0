Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977530;
	b=F2D5Ufmp68FiB5OXP+KQE+IM0/HUB08jNj0+tdnkF8Uy+5x9HcqkAv3J9sDTk+aUepYd
	 wwwvUDPeEEQ8YumkABwABfuYitvYpuC0do434MqJX/3oKJlBk+52Ce6dWbMPheNGebgMm
	 Uy7DoTipKtFVoLRaLRk6JI8FAFHFAk2PK/J7E1ZmEkZlRO+6g2kdrGYZnVBTn6oZ0hY7/
	 vVz4+NrZ/8GNX4mjLbKcqCogYPwpspxmQ5pLFyO1zURPJkRxPhTO+ujFDqh3BZLUkn2yJ
	 khLTuuFtqXutE1cwp4SkKRfFaseYFzSqJxA2YHSBvw7U8WtkqFgZ8lBTe1gWs45BkiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=Xvpo+iUQfW+f41TLIZncvutMmUua35K7LLGoQrMg57U=;
	b=HeFo23ipNF+Ig6aLEXTMItvCIXn85al+Y/74Yq+6ap1Kt9ePHKJ3upyVl2/nW4Y8Kbql
	 Kry/eOwwuc0qJlcXjfumH+UpcEAyhUJ+f9NtyepbW9yMgFZPAcx7MIoGPjMW3beIIWoiM
	 STJPeZZvLsVySJqsEp8akerX9jpmFAQiDSRN8SJAxb4Ec6iNPUbLmTxiJIJkY9z7XGE6i
	 vtY0VjxClZfDDkK74MT6lDA2tM3o2Nie97elFgPXwL2IpyrpRoOkl9h3w/Q/O5LQpMw2u
	 reZuKbbyYX4/kqZJs7Angjae0JpeTRA2Ftr/OcfsZdpEXKXv41osJddiBNzvqgZ9LbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVUj3BEB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE7606A32E;
	Fri,  6 Nov 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVUj3BEB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400331F0089F;
	Fri,  6 Nov 2026 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977529;
	bh=Xvpo+iUQfW+f41TLIZncvutMmUua35K7LLGoQrMg57U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVUj3BEB8Ez+BKN2xYnC6+lghLgkjoaGSovC9VY2MmJSvz3FCEdIhEaupw8IInwUm
	 pRUmEyzOK8hwuOS9/NXucPe1DoDIjv1NwfZO+ANR3IbzL5CIfwYdQ76dOlmUvXsQ/C
	 7ASjOz8Uu6BdViIX71hrP6+50W9qE43uhvPY+XYepaRUtrl6Iz+NF+0J19C0M1nRFE
	 PplWyvM4Kplzsn/AZmCLdLWjqYAP+NKMQvZMqh25VESCW2PFpPmU80w751dnobpMlO
	 3LKo5J4Y/T8for/oOq1t0HgVDuHqppsw0mxhQmNm0dB9XILfxPGdjeJ7NvfEttq34f
	 8AAi4V2TSluEw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
Subject:
 [PATCH v1 1/2] cpufreq: Cache post-resolution target frequency in
 __resolve_freq()
Date: Fri, 06 Nov 2026 16:04:05 +0100
Message-ID: <14161745.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5176274.31r3eYUQgx@rafael.j.wysocki>
References: <5176274.31r3eYUQgx@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

get_next_freq() in the schedutil governor returns the resolved
frequency from cpufreq_driver_resolve_freq(), and that resolved value
is then passed to cpufreq_driver_fast_switch().  The only reader of
cached_target_freq, acpi_cpufreq_fast_switch(), compares it with the
post-resolution target frequency, but it holds the pre-resolution
clamped frequency, so any request that falls between table entries
misses the cache and falls back to a table scan.

Address this by making __resolve_freq() store the post-resolution
frequency in cached_target_freq.

Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -488,8 +488,8 @@ static unsigned int __resolve_freq(struc
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = target_freq;
-	return policy->freq_table[idx].frequency;
+	policy->cached_target_freq = policy->freq_table[idx].frequency;
+	return policy->cached_target_freq;
 }
 
 /**



