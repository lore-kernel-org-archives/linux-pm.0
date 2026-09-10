Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 52F1545C6EE;
	Thu, 10 Sep 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038834; cv=none; b=KU9ryKMeO7KMHoHtLwJxKQWH9hXxPw/jFDmTFbLyFcgdwp7RQ3zBwRAFwkZBv+clZdv7tpsXz94V6d+pY3J313TbKK3Rk1DqtKx5BWlwRc30mbW5kfxo1Z5pyUUc2ODe86GurXz7CGaKSJkD2y0JOd87l3xZVlDWxlb6/s9TKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038834; c=relaxed/simple;
	bh=RWSZDrbNgqCVEG2aCAVZzGR2cwZCAcQhJmzidRg7wqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfC/rulgrePZqy9mq3leEMvps+hfmAsBkLz5wlsWvpWo1u3JmMpbdG5QSkIN07vSBvmnCuA9Svw5EBNgQmOkAzQjCaEm9kFqKZ8a9UHtCwqGkjuD/cmmuBDbk71ZjGe9Q4ujbQirA7Eo3O3PhS/PElDPbSeYILYrJoBvhvU+TbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=U3m2+LhG; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="U3m2+LhG"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v4 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch between perf->states[] and freq_table[]
Date: Thu, 10 Sep 2026 19:13:27 +0800
Message-ID: <20260910111329.2220-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789038821;
	bh=usu3hguOmcPuHpJ0xtFRkNJ6QHgtOYyhLsbPwFvkw6E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=U3m2+LhGUyZCI7DxQZMRun7EJ4okj5hyjzAXCZutuL2RcJBZcYU2bJjveBqLEuDu5
	 qsiiyuk4wCeVm/17Fj3frZTNUP16p8ZBpr7zJkbRAFiS9LK87IbbEoUft70DwQ3Pue
	 t9R6hNgdFzPBecZ1G6K6uJEiyvQWgLItIqb3id9xnLQ52QyhLK8SvQ9UyewT9k0ikN
	 KN3//VeZqCDm++g/vD3jIZbLikHfJIH3LnM/J0q1DP4i2VI5P0CXfjYawSXwLzkmGJ
	 IHbtlImBToJSgEyuyCk4bKzSNiIjI6SwQb/hBg3wgsbTO5ZxJKg03gahhKMtT0dXsJ
	 v6zHXJ5efZ+Cw==

From: Li RongQing <lirongqing@baidu.com>

perf->state is an index into perf->states[], but freq_table[] is built by
skipping duplicate _PSS entries, so the two arrays no longer share an index
space. Using perf->state to index freq_table[] therefore reads the wrong
slot. This series fixes the two remaining places that do so.

Changes since v3:
- Reword patch 1 and patch 2 per Zhongqiu Han's review: replace "duplicate
  frequencies" with "entries that are not lower in frequency than the previous
  one" to match the actual dedup condition; expand the extract_io() retry
  description to "sleeps through all 100 iterations - at least ~1 ms of
  usleep_range() plus 100 cross-CPU calls and I/O port reads, all with
  policy->rwsem held"; drop the trailing "through data->resume" from patch 2.
- Add Reviewed-by from Zhongqiu Han.

Changes since v2:
- Reword patch 1;
- Rewrite patch 2, using perf->state to index perf->states[] (its native
  index space) instead of the deduplicated freq_table[]
- Fix the Fixes: tags to point at the actual commits that introduced each

Changes since v1:
- Reword patch 1: v1 described it as an out-of-bounds read, which is wrong;
  it is an index-mismatch / wrong-result bug, not a memory-safety issue.
- Add patch 2 for get_cur_freq_on_cpu().
- Add Fixes: tags (not exact, but reasonable backport targets).

Li RongQing (2):
  cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
  cpufreq: acpi-cpufreq: fix P-state index mismatch in
    get_cur_freq_on_cpu()

 drivers/cpufreq/acpi-cpufreq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.9.4


