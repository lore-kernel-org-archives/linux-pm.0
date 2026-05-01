Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5B3E0236;
	Fri,  1 May 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653217; cv=none; b=amt5G58VC/j0vrNG7kx2rtdYADHAeLFZluKfj0N5fX2h1eZQLz+I95i8ZcTSrA06QyfIYBt9H2lqeoTZ0fe7osXM8Xu2IQlO9ghw+NC2fZy2n47+TXDKi8rDJCBh8MKeKLvLhnFi/h9boURT8i3BuvQiSr2frCZunKvFC/kY3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653217; c=relaxed/simple;
	bh=FmjJIxcZFvR9c0k9reaUBJOzOZJq8TZJ0hL8k5OorwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aougPiRBy4USmMeLg6LGC+nx/8Qo4LewQMb9vX+z001S19RA14qFgdipnko/8iyMFCBCgPShb1N+VpoYnKM9cd4BuGPkUyFU3ypev37tYrxzknj6fy7pUsirtVmz6b101RGaINy3tqfJCwrrau0l/Qr4s65NQeezTS4+FXlieg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RhiPHM1/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RhiPHM1/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=M63oadhbiLEZWn2nFClNFifg5s97W6zysQfmoUQmtJI=; b=RhiPHM1/+eT/nVp9SLJbXEq6IA
	FW9QLY9ll+bzM+bbPexeLmO98fYQIxtsISuBTtmEJN7Mewt9ZpIFMEcvqPE+yplC/+LS3XJpTi7Ce
	Ljs1g9iYvE768FY+Tmhutz+H6HDpKxXZkOjnjOZh4AIsOAuHu08ye4zf1mqnx41CRgYcRVHWNE8et
	gyT7iO7ntoTECkAKE0Yvh/Fnju6bj4sKqjqxh7+RSa46O0Ucr5nx0WHM4iz+07pwOE09Q3WVIHkn5
	+EdT+7+23J/2tdtc2fCptctuMTAGTolvfxJt6e/hFycCaVFl/7dW6eJAK+cJuziKbZJJf2m79Tsh8
	9NZbSYmA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIqnO-008hv8-0Y;
	Fri, 01 May 2026 16:32:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 May 2026 09:32:42 -0700
Subject: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf samples
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
X-B4-Tracking: v=1; b=H4sIAKnV9GkC/yXMQQqDMBAF0KsMf20gCURoriKltMmkjgttJ00Rx
 LuX6vJt3obKKlwRaYPyV6osMyK5jpDG+/xkIxmR4K3vbbDOpKa3ovw2RVaTQ39JxWVng0dHeCk
 XWY9uuJ6u7TFx+vwP7PsPaC+CunAAAAA=
X-Change-ID: 20260501-cur_freq-fix-d569cf1d1052
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
 Lifeng Zheng <zhenglifeng1@huawei.com>, 
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dcostantino@meta.com, pjaroszynski@nvidia.com, Al.Grant@arm.com, 
 linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=leitao@debian.org;
 h=from:subject:message-id; bh=FmjJIxcZFvR9c0k9reaUBJOzOZJq8TZJ0hL8k5OorwM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9NWx4EhnDPE40uinVf8leUXOkdnI7x97OYB1P
 nsE2jEhh32JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafTVsQAKCRA1o5Of/Hh3
 bQROD/9wl3/kVjyOb4HzxpnFsylR7KOnoL/UxsOE9Si0157sOGEEVeokfYutxdm54KVwwZEptkM
 6o1rsAice1O42JBahRGuF1MRooc7ZXX4uQ7ao32HfZwScw/V+L8J3CTKm0hWyk3LjPoXUhoXjV4
 UKvjUIgE36yTJLa0QvthcjAFTs55jJ5WZA5EdJXUwIXjibHXxSC1hZLIfz/LQiMzXevbNlVvKcF
 mbt1z2XxR0xApZ3s7mD218nF5Hu73AmpzNAWmkygr+jSIx5pUydv/dSZqcRRiJ/Mah8HU6VmEDi
 aXaewv79g1p++hK7u4XKGqXh+XOASnUpwl8P64czuR8RKTqpDrmgk2Ut8HJ+4Wq0C2d1qJnWFnN
 LVTMW5dJcDk+MbuMqO82PHxnVnRvismFvOVtYhR9HKqewTZjQ5yuPL2UkRyVHPDcuKKWkRPA3N/
 ubic+ncT62GZo+8NYL8Yvp55bqOK+2+jzpM8636RpoXTdEGzf7PWSbLb5eQubjAtsmAw3yeeprq
 2veHDzs5J6nEKS+HgPCNyZN1W6L9Z855+Kc+IkxaejRBYVW/J88NtxjZvEXMAAB2H+54ZBHVybj
 fwDr6VfbuDtABmAHY2PKU29L2E/RMtaCsvkuioU0t+M9i5mzhhx5TCPK8s7PvBIEwN5mXMo6Gjw
 v6iY3n+h0YquYHQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

cppc_cpufreq_get_rate() derives delivered_perf as:

    delivered_perf = reference_perf * delta_delivered / delta_reference

over a short udelay()-bounded window between two cppc_get_perf_ctrs()
calls. Per-read latency jitter on the underlying CPC register access
can skew the ratio, occasionally producing delivered_perf >
highest_perf. cppc_perf_to_khz() then linearly extrapolates above
(nominal_perf, nominal_freq), so the value reported via
/sys/.../cpufreq/cpuinfo_cur_freq exceeds cpuinfo_max_freq.

Observed on an arm64 host (governor=performance,
cpuinfo_max_freq=3339 MHz): 15 back-to-back reads returned values
between 2997 and 4230 MHz.

Treat an out-of-range sample as invalid and reuse the existing
out_invalid_counters fallback, which returns the platform's
desired_perf. This keeps cpuinfo_cur_freq within
[0, cpuinfo_max_freq] without reporting a value the hardware did
not deliver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24c..dd92aa2bca464 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -814,6 +814,14 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (!delivered_perf)
 		goto out_invalid_counters;
 
+	/*
+	 * Sampling jitter on the CPC counter pair can produce
+	 * delivered_perf > highest_perf, which cppc_perf_to_khz() would
+	 * extrapolate to a frequency above cpuinfo_max_freq. Discard.
+	 */
+	if (delivered_perf > cpu_data->perf_caps.highest_perf)
+		goto out_invalid_counters;
+
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 
 out_invalid_counters:

---
base-commit: 26fd6bff2c050196005312d1d306889220952a99
change-id: 20260501-cur_freq-fix-d569cf1d1052

Best regards,
--  
Breno Leitao <leitao@debian.org>

