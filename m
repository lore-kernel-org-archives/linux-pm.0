Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A619DF4F;
	Wed, 18 Feb 2026 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383847; cv=none; b=MC90Qj0w+hq3OB0vOiJZRLhG17x4iMkQ5IioNyHNvpnKW5RQwh365+vXM/9O7QivvhZuES7vPu2YltyrNDjFk9Nw0H3y2GXcDho9+m+nZ0s3ej9vZ6gZlio3TLJm/wsO1jKuTcNTHE++kpWgMSTXmhKnGHQT7k39g4EhF1mlEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383847; c=relaxed/simple;
	bh=n5C8O2UjAbnVhM65NF7FyqtQEYGhu8ksdxvDSsZVZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POTq1N8JY0iIdiJq05JGXmmy4wqhCnKVNZVBrYpoQL7t5+atjYL9pasdhem44zHVg115luU23W2onF5gGPbIC7h3OLMfLgyRevtNb4nkVl9siS/QHt9ZEXcOmB3BO6Ip7UY5yH//wz4NyBM3/cWoyl8MrvtXxlC241JiQTvCA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbO1Xxzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbO1Xxzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E00C4CEF7;
	Wed, 18 Feb 2026 03:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771383847;
	bh=n5C8O2UjAbnVhM65NF7FyqtQEYGhu8ksdxvDSsZVZbs=;
	h=From:To:Cc:Subject:Date:From;
	b=mbO1XxzxGJZIJn7HVragMojD/kYwPYiuLtWHisIFGcGAuNZJbrYg6DIHLM3a/8wi5
	 3HjLALFo+oT8O0yzt4Sqp8ZiI7W8g2XiVYGZh5Cbr7/tZ92RhzU8wQgEzZ0YXW33cL
	 SB7QnBHN6Dsk/pzT18Ju17r7C/+lrEf72bYXRwKnCWBLllX8NJAYpGLyMe2iucXuBz
	 awDMVtdu9XFhVoPr5kskaH2isRPIpk5TNTh1zftW84eImghdN0/FltjvFY27DvAAKd
	 jexnAw0oby+HbsX07Me7ky68KiqOHo4rDrD42BWPU9LUzdrCKlxjCd25PIacN2TqiF
	 QzJAYG3tbCk5Q==
From: Len Brown <lenb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] turbostat-v2026.02.14+AMD
Date: Tue, 17 Feb 2026 21:02:03 -0600
Message-ID: <20260218030402.694540-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull this turbostat-v2026.02.14+AMD patch.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 51496091dd37b405e6e399a9638da3f1da3f4c64:

  tools/power turbostat: version 2026.02.14 (2026-02-13 14:08:33 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-v2026.02.14+AMD

for you to fetch changes up to cfd5ff044914fd5f7fae2403675b68593f986055:

  tools/power turbostat: Fix AMD RAPL regression (2026-02-17 20:47:16 -0600)

----------------------------------------------------------------
turbostat-v2026.02.14+AMD

Fix regression on AMD in 2026.02.14

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: Fix AMD RAPL regression

 tools/power/x86/turbostat/turbostat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
