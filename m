Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96A4BE439
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830111; cv=none; b=D4iXXV8+wTFXM/g5O+qVYWTps4X8jQOkdBIuNtgDBPELhzXDKLwURrM2qY31G3dCJKBKZGwcy4UTNA+TRAL9lm01yNJEFk1mKeotBXn12Bn6ggUETSkydCr3B8ykfx5lEbIS2rK5z7xc0MwNuViEOJU0k/QLvK6IWTNjgBynN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830111; c=relaxed/simple;
	bh=7WUMoe77425DXW+xyCxOnuJoLY4zu9nrwIMHF0JBSVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC2Tkh7ZgBA2eaXXp6V+CKinclTvSz6jV2M6ZVNz+gIXoOrA0mDCzMJa6Fsl9iWVoNRRNJ8KTUaX1fPq4NZCMVLfLSKVmHonhrF6satYzPvlHx1zoU5arX3YsZ7OD37z/bq+qw/BuNAdl3FfyYbM1te1ME1c3VoNaNfK4361G0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmv9mo9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmv9mo9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC49F1F0089B;
	Mon, 12 Oct 2026 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830110;
	bh=mo32IdjoH9Lm+Moax0hk1p7HViNAR2th2GjZQG1G8gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Vmv9mo9wr8brAx2UUpL5FjRLGHeMjPiXCunNO7a8QR5aP8egRX6r2rh30woBpG4E/
	 xhUm4iy7o+AczOHSvlGUm2rh+0fRMz+nR4hkmyeCJtILVPJzEJVncwMwVR26JsUz9z
	 QaVv8rdnUK8uPLzTvLHCt6DviotoUphjetzY7KcC2J6sGeB0GkQlKZR+DYJwryhcy9
	 qU5499EoL8/CwASr+VCMXk6HoplxvGOlrcXOrlHpdk2tU0d7bBplQenzmr5NL9X42+
	 huRGa5DsKiFQ9lIs6CkEpUQS0sgPcXBjr5QdwV0rod94wvJRIMFyvgWV8LpwaBSEA4
	 eyox1sikbJvZg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 2/9] tools/power turbostat: Warn, but don't Err on out-dated perf systems
Date: Mon, 12 Oct 2026 14:32:27 -0400
Message-ID: <1de8307e861759386057f8683bdf0594b2c803f0.1791829903.git.len.brown@intel.com>
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

Some systems in the field have perf enabled,
but their kernel perf support lacks the latest L2 stats.
Warn, but don't Err on those systems, and suggest how to avoid the Warn.

Fixes: dd23bfe4c317 ("tools/power turbostat: Add L2 cache statistics")
Reported-by: David Arcari <darcari@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cec3f2fbba45..0c55698d6843 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9477,8 +9477,10 @@ void perf_l2_init(void)
 				free_fd_l2_percpu();
 				return;
 			}
-		} else
-			err(-1, "%s: cpu%d: type %d", __func__, cpu, cpus[cpu].type);
+		} else {
+			warn("%s: cpu%d: type %d: Update kernel perf support or use \"--hide L2MRPS,L2%%hit\" or \"--hide cache\" or \"--no-perf\"", __func__, cpu, cpus[cpu].type);
+			return;
+		}
 	}
 	BIC_PRESENT(BIC_L2_MRPS);
 	BIC_PRESENT(BIC_L2_HIT);
-- 
2.45.2

