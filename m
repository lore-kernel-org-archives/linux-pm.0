Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AFDD5242D97;
	Thu, 20 Aug 2026 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191656; cv=none; b=T6NGI8Toh5nsepufR+p+osdKJZRALpc3OUqX4FJy1dDn4sE6QD8DsucHPdBTkDzy7OGe1lQrjD/N9xp77TzpsfEFN4Ka8p7gHIhquDqJTO8l2bgRJ3mwN6JkwJC1KUpsTs59BWLdPcov4SThfxZRLcqQnj2+KH87EXksXVquYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191656; c=relaxed/simple;
	bh=tnHPPH64vWf7wPkv4WwhoSbdWq0GqvgbCia9gTcZ8Qc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKB1QaXQBCVe+Hb18dKGDwi+5guTLBubuNqMWW3yvdH6qYLs9N8ErQy0C8nYA9CH42hrtL9b/dWILn9Rwkf8MAcY3OKh82+Pcp1SzhUh2Bfmv8kC6vZ+y32VI1IlmmXDRaNPPxEFVKRRnvNXpvOIZ78v8ae4gShPydZsLMO9Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=IGuoHnwe; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="IGuoHnwe"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch between perf->states[] and freq_table[]
Date: Thu, 20 Aug 2026 10:07:13 +0800
Message-ID: <20260820020715.2344-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1787191643;
	bh=C83lHpYZPPackaH+mvFCpyUJ1+N9MUwvOJtPyWGjgPI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=IGuoHnweS9yJIvt29V8nsu9OdS03vjgbC+L3z0D+6nQQpPy780nkgp9DSNXZwizy3
	 lnmKJPlQNiN/T8Mvihh1TGUG6bD88VKJT0/iqT4uGEbKNssGjz8QqYIg/6dI51JX/q
	 Fu+iQCyWoorG0liDPmGam//4+cEtFlzBjPfafVVvBi72C83k4MUVjJa0ym9B/KKBCo
	 Pbux9goRBVGqxu5fQs4qDXW5T9UwpFE323GmeRf9Ix6OPNXSlDbXWagXjxgNb4o2J+
	 Q1rkwpqGMB0Xriha58KFrTwH4mAmv4iJ3EMhDsVOGFbsi6LZygInNZkl09wmmVK3QP
	 POQ8xMqeLVTTw==

From: Li RongQing <lirongqing@baidu.com>

perf->state is an index into perf->states[], but freq_table[] is built by
skipping duplicate _PSS entries, so the two arrays no longer share an index
space. Using perf->state to index freq_table[] therefore reads the wrong
slot. This series fixes the two remaining places that do so.

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

