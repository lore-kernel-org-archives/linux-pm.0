Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFC4D598D
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830118; cv=none; b=YUzvIQl+5+lubF5K/IwpZVfLZsX1TF3JSpVP3rufMqDt//z3e45x5S/gRjd9Vs4YzFRbUtsgG1qbQ27JaGDzyJCQH8tXGHx9nrwbh6UwXb2u/mWo5yhnlJgkViCRzxv0b1Oxl2ZdBFrkFnDxangfpbzphY+bz+YNEOj9MeYWxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830118; c=relaxed/simple;
	bh=37guZ2NPOvrH8BgeB1wSODTlo73CVX8M1KGKJ6doL2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN9Xrrqhl1/c8zDgSag6wHK4i1671BoGlWppFjFHdsFIGiuqTrE3/lb/jeEtaQPaaYRTi69DDqpiog+I1qpOIIMXiOx33ocDXDRsUdw+WzvDIjcR57hk3Gr0nffNfkdZE/0kydl+9Bm78mOzdPIMh2QL5Tlx5gAj6qKXgOVCum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHtx3wlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHtx3wlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626441F0089B;
	Mon, 12 Oct 2026 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830117;
	bh=PihZU///0bHP57mQA8YBZq2yuedRPCZv931KppTbr3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=VHtx3wlK3r/0aoQuibf5Qh1o2JfFuz1fLN9xKFpU8X8JzWp7WYrld8IbVOWXK02pH
	 bFD4znjg/G55ImIMegNtQhTqH5L9qK47e2iwoyplTrz/2jpG7Kjjw83R0qXJ/0F9wU
	 QGmVFPhfdA7M0L2fQEoej++6P4QDc/hnSQwNNKaWOqMCVwfua7bZn6muTp3TB0OBzT
	 H/LxMFr02WfMDxr7QF3uGBQOoIj4KFdrqzMvWjAfMZ722XqdRdaJoKgSkqE2bDpWKp
	 7zfh2tmc7OL9UHuLQZNGYXJZxUdJQMGD/jGe1COt9Vbg2p+ogufbtRlG5AaWRnWdGp
	 PiHqzC1+sajxA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/9] tools/power turbostat: Fix PMT error path fd handling
Date: Mon, 12 Oct 2026 14:32:32 -0400
Message-ID: <11741cc90f9176746b8595beab4fec8d736ebd18.1791829903.git.len.brown@intel.com>
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

It is possible to leak a file descriptor if a diretory
open succeeds, but the scan fails.  Close the fd on error.

Also, on cleanup, check for NULL fd.

Assisted-by: Claude: Claude Sonnet 4.6
Fixes: 4265a86582ea ("tools/power turbostat: Add PMT directory iterator helper")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 795946bcfd94..bb1e54a23ae8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2034,8 +2034,11 @@ const struct dirent *pmt_diriter_begin(struct pmt_diriter_t *iter, const char *p
 			return NULL;
 
 		num_names = scandir(pmt_root_path, &iter->namelist, pmt_telemdir_filter, pmt_telemdir_sort);
-		if (num_names == -1)
+		if (num_names == -1) {
+			closedir(iter->dir);
+			iter->dir = NULL;
 			return NULL;
+		}
 	}
 
 	iter->current_name_idx = 0;
@@ -2063,8 +2066,10 @@ void pmt_diriter_remove(struct pmt_diriter_t *iter)
 	iter->num_names = 0;
 	iter->current_name_idx = 0;
 
-	closedir(iter->dir);
-	iter->dir = NULL;
+	if (iter->dir) {
+		closedir(iter->dir);
+		iter->dir = NULL;
+	}
 }
 
 unsigned int pmt_counter_get_width(const struct pmt_counter *p)
-- 
2.45.2

