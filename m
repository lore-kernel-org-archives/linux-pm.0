Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8031F99C
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392012; cv=none; b=GE8lBjw1P+lH6oKp6ra0aOrnAoYWuvLNzfeYiJipeCszgPwvHpozhHfHTIbqfRkL0Ie4zOHJZjUwREDd9i8ZJqZN8bMje2OwYXglQLnRc4FzY5pnBPd8nlPn2CAnXIiUVnJ0/NKp4jNHP0oDy4xRiRqBJxNoUTSuG+NmcKq3tmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392012; c=relaxed/simple;
	bh=OhuP3tAcJmVqXVszBqvkZtypULCHkKW7v7O9yuwvS28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4aRq6VE/6SSvTE5YMkPrBN6Opd6PjX9/dq58VCV+JRsYjBzumCU+NiqB+c2MlIepjhGLl3ghqmnFEjipM5fpDq4T6myFIUOFZl3fHSS4JweMY4bad6jcW5tyrLvN/b1sWxt9Ovdrqjczrd+0+jf0B3wRM98W8QCrdfq4rHtYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=acSU9qco; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="acSU9qco"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774392006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QNB1Hbsxs/JtyNuWfqo2wy08tBtyAtouMKdqMjJjkak=;
	b=acSU9qcoYrcJ46eWqw8cNjLpBIyPoDWR4kcwnjYofJLq3Q9qKWjc7/7WIa39lCF3ukQlGF
	ciQSJrW3ACFFfpfl7L8NkdgaDKBNCtDEa48cxhNlZG0kmftp2D1L9K93a8RxxdAuz2QTy4
	gmF/SBjjgdgpeay+zCV4Pw45+jI3OgKr8pFSKhYRLIDaohFyl0ordl+aXTH5o6qmSrO6Rx
	tuEsBxNjqprEIRe/xCYkNfhcMe7ZQi5ParaHQgNqGf/WE58jvhMLWOS6nbiltCH94UlV/9
	GlVF9joAr3JA44dx+puFGmDnDw3CmwuvR66wuu6K0JUzXv4BNZE6QSUgN+hnvQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v5 0/4] cpupower: fix various man pages issues
Date: Tue, 24 Mar 2026 23:39:00 +0100
Message-ID: <20260324223921.14317-1-io@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series fixes a few issues with the cpupower manual pages,
such as missing or incorrect options and trailing whitespace.

Signed-off-by: Roberto Ricci <io@r-ricci.it>

---
Changes in v5:
- Drop whitespace removal patches
  Link to v4: https://lore.kernel.org/linux-pm/20260324013543.4776-1-io@r-ricci.it/

Changes in v4:
- Remove Fixes tags from commit messages
- Fix issues reported by scripts/checkpatch.pl
- Add patches to trim whitespace from some files
- Add cover letter
  Link to v3: https://lore.kernel.org/linux-pm/20260312102029.14980-1-io@r-ricci.it/

Changes in v3:
- Resend because v2 patches have been incorrectly sent as replies to
  individual v1 messages.
  Links to v2:
  - https://lore.kernel.org/linux-pm/abH7pF9p8KxAsHIE@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9KsKbvyi-iceb@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9rMVuy8wmzgkG@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9_Jk-ckkJvsGb@desktop0a/

Changes in v2:
- More descriptive commit messages
  Links to v1:
  - https://lore.kernel.org/linux-pm/abHAZj9xwfDf5JVZ@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAdH-ggaxUugCy@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAhAg-6gaK0Qn7@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAkgiPg8VDpDoV@desktop0a/
---

Roberto Ricci (4):
  cpupower-idle-info.1: fix short option names
  cpupower-frequency-info.1: use the proper name of the --perf option
  cpupower-frequency-info.1: document --boost and --epp options
  cpupower-info.1: describe the --perf-bias option

 tools/power/cpupower/man/cpupower-frequency-info.1 | 8 +++++++-
 tools/power/cpupower/man/cpupower-idle-info.1      | 4 ++--
 tools/power/cpupower/man/cpupower-info.1           | 9 ++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.53.0

