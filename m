Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56364B44C7
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830115; cv=none; b=pw6mqe2GinjzCUyhKXue0N1k7lwOP5xqGPYl9mVnowINpffmnV7sLs9TOqGanQB9cgtKsDUOjiAw/6ym2tR8rwJkCDU4nUbCa4nvQbdC+t5e+i7qJW9tWxb63wwqgSAtttLw2Dewsr7tGV38J6jjTjYQ5m2ZM6/WHck1n8cKwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830115; c=relaxed/simple;
	bh=G1KO1qeSopStPBBjI0juobKDkwuksS6u3MowV6YNjW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si7l97QezUfdFJWCctQoNZ3XkjJzExAl5NtUYiK13tYCVuQh7F2mA/aNC33i/2L5x14kKxLfw7xGgMj+YqhVbjPhfwaLi5rGoDkpkSjIJwdgiNE9wJbWP3cT0x8KGwIgYd7B41RMmNJTD+xmp0otlc3oLsTBakeMYt7s9NoUjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGKajG1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGKajG1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A601F008A1;
	Mon, 12 Oct 2026 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830114;
	bh=H61+FDyWuZWgLNLVfqSVWD9ZaFsmVYeceuo8Nr/QGsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=WGKajG1tjxrR/sElSqN7f0Gt+WLHifIwBExk2YbYjsXi/dO57z+IIwVqkyd5Z55sN
	 fqKpC0Oa1x+Th83CcSh2wdfVNGgaJUN1HZPZVeNGru+IKWQnusF7XROagbBlEMKW0B
	 DrB09Fz62ByORmtoyYa9auoMXlKQJOGSxBz3QDNyT1B23eE7f9SlBbdCN64NM0p1Wa
	 OewY+9mMo9oLMppsq1GCg0MZKh5/eB5kRYFzqI7xHCyZpduy9aEaG7pQyCtpii8Nb5
	 RjxuwwupF+Ov95KIIlHbIRg83z5C5fEHi+IAhPX3De1AlTkSojFFerUG71NCE80YBA
	 lyU5gcMJEJWKA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/9] tools/power turbostat: Fix fd_perf leak on reset
Date: Mon, 12 Oct 2026 14:32:30 -0400
Message-ID: <767c64414c4c5fffd6cbc3a1cf1fb8138b28645b.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
References: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

When turbostat notices a topology change,
it frees perf file descriptors for each CPU
to prepare to re-initialize.

Fix an off-by-one error in that per-cpu loop that
resulted in a file descriptor leak of the file for
the highest numbered CPU in the system.

Fixes: 67bab430f4e7 ("tools/power turbostat: Group SMI counter with APERF and MPERF")
Assisted-by: GitHub Copilot (claude-sonnet-4.6)
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6a59cdcf8ba3..8e017b4dbc6c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5915,7 +5915,7 @@ void free_fd_msr(void)
 	if (!msr_counter_info)
 		return;
 
-	for (int cpu = 0; cpu < topo.max_cpu_num; ++cpu) {
+	for (int cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
 		if (msr_counter_info[cpu].fd_perf != -1)
 			close(msr_counter_info[cpu].fd_perf);
 	}
-- 
2.45.2

