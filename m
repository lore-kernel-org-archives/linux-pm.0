Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE24BE439
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830107; cv=none; b=MDfd55cwzCzkroKCA7vKAe1bkDFne3vjj9wBkRNAmPBfEgnS9u1Z5HPbB5/VQh81gK7vDEVEzAnoTS8IvyeV2zfDzrWhp2qnBuPl1lHsLW2qHVZCD5vqDoFu5m5iQokCL1kw+wlQWYBjzWuJ9YWUmOzeLS2j7Div2+ICFLqXibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830107; c=relaxed/simple;
	bh=y65vQC8ShNRrGRirPn8YlFN88z59eyGQvJHWaOLREpE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lCwXiPUcWs7ccUBvFXSNMl6YEPhhWpDWZm3Drughb9aMcxKxOBnStb2dS0AbYwvtIE3ve1fjiOpEn7Ot4bFYVY6vDJPUIGH5PcnOTdU07O52kIqA1OJHOH34HO7cub/elbiUX8q7XspZqZQpQTKjQHoeJ9fNCp4jVhzHf8bgj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB63r5Gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB63r5Gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF041F0089B
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830106;
	bh=y65vQC8ShNRrGRirPn8YlFN88z59eyGQvJHWaOLREpE=;
	h=From:To:Subject:Date;
	b=SB63r5GxFhC03vGR1DubDlTr6WjEbnTMbJMiVCWaaMPpCFa63dcWWBAOL/EPCqNrn
	 b1YWDxTRknNc9FXd66g3DDkXM/rLGJpb23nzLOT/OxAbcvqRMTWK9PRkfWKLNK0JJq
	 02p8S4dd40yMRooSPMwynKBLVfK0F6SBGsACIZqbUo9FwlVrmoMPBjOp85bl6jInXh
	 raEh285j3L2ZCMA5uW1s0NMVA8FLFgAf9nrmi8+Jx5GdjRUaJTeHj51p0Ib1a9JXnk
	 P5V4b/ynR29z1u5TFzBfg4F7568K5ZHbb33e5zN19kcrNfIjPwW5KiJp62mPTkf+VW
	 PRYkyBBUdKUvA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/9] turbostat-2026.09.28: fixes for Linux-7.3-rc7
Date: Mon, 12 Oct 2026 14:32:25 -0400
Message-ID: <20261012183457.92243-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you see any troubles with these fixes.

thanks,
-Len

[PATCH 1/9] tools/power turbostat: Read complete CPU lists
[PATCH 2/9] tools/power turbostat: Warn, but don't Err on out-dated
[PATCH 3/9] tools/power turbostat: add NULL check after calloc()
[PATCH 4/9] tools/power turbostat: Sanity check GFX%rc6 and SAM%mc6
[PATCH 5/9] tools/power turbostat: Fix fd_perf leak on reset
[PATCH 6/9] tools/power turbostat: Fix CWF PMT off-by-one
[PATCH 7/9] tools/power turbostat: Fix PMT error path fd handling
[PATCH 8/9] tools/power turbostat: Fix add_counter issue if > 24
[PATCH 9/9] turbostat 2026.09.28
