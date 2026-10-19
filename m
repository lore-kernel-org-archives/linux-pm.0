Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428737;
	b=0pwdSqpecM32X9dF8LGq0UqHkBYG8KG/wgQJhJDJ5fPgu+qbfDWj80EhVnDXHuyh3pej
	 ZHotadOFmEMLRUYjRSgrgSiPhzHi5KMrXJQjo2prlEiyW/cRs15cRhq4DpUJ7QVRaaOD4
	 aGfdapaKdJkM/YKnOkUozW0T5hHOpujm5PtD8fQC04/yIA7hMV/bXUhTxOB+PX7xeho2D
	 Dvd4uCXOSwOKxPYMzt+Gk3ond3dXU+FlM47Me6tWP/+CFjFXoUbvgxFRQ+IBObPbIU/UL
	 FNqkJdcK4Wz0TggWsqyOlVJa67go8b+6PpT/FGz2ecp4D8zTvIx6M4N8T/4IeASuLuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428737;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=MM8IoSQyexk0kPVHQSG7nC+Nk6M/V1DXY2d+KyCq4h4=;
	b=T8GKyMJuJw+2kwPoExz0KY5+8YI24YZqUkU418CS3dlJzLFgejLDhxasgVFW6JzW/KQb
	 TQOO3abi1oGN8l41TRUwHMVSzDXDgu93CeonxnLVpLh77r8klvrjJdpRJKNr+uEaE3WSE
	 q/gjxVhF6I2YLXLVh6Azw0HHpltmBQ8nnivYYVYBGetPWshFepuka5AA5WX3Mi6dD4KGP
	 BXY+5KUFmGDSwOwYY6CFoYDVfGpNtFz4Ze6j2u5h2xMjUnVaq5UtcQcZyS5p90uaj9QLE
	 /CR+xw79PRAZQjiG3YQc6O0SFoml0bN1RGmLSyJKYk/eK0Xs05p001A+sfsd6lOfnWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViD1fmUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3404606A31B
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViD1fmUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5861F000CE;
	Mon, 19 Oct 2026 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428736;
	bh=MM8IoSQyexk0kPVHQSG7nC+Nk6M/V1DXY2d+KyCq4h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=ViD1fmUANQnD4jgK/R+wv+936ndZ4W5jLrYsZwDot4t9UySRz5UMN/1rrOw/FnI1k
	 o4m+ktxTAQkpspV6TO3jKHhqR9LCXNGauMXtJ3OVRj2tX2ssLcbmTp6/CEBXEVKNVz
	 q1hfANRcOmByFmc1WX4XIjsBfQbyfvpUjT6nEDmBcciy2ayy3WWWfuNPchApyn1QBG
	 vCtbPuwYvwUPAxb/h7K/WPsOwAYFEHVUoy4aZXf0N84n6c0KfbVtD3Hmv1DTnexc5Q
	 4HArlXnm9MdQo0pEImAjVACmHXCAhodQc8y/BrL3STzo2mjcWoFoWQtlLCUpw+5gch
	 mUFXiqJG7rj3g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/18] x86_energy_perf_policy: Cleanup: Check fseek() in VM path
Date: Mon, 19 Oct 2026 12:43:32 -0400
Message-ID: <25c6883177af543bebaf92443c8cfe85b621ded2.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Add return value validation for fseek() and ensure consistent
resource cleanup on all error paths in err_on_hypervisor().

Fixes: 0936cdfbb527 ("tools/power x86_energy_perf_policy: Input/output error in a VM")
Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index cfd9d8df6ec1..1343966b1f07 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -797,7 +797,11 @@ void err_on_hypervisor(void)
 		err(1, "Failed to find 'flags' in /proc/cpuinfo");
 	}
 	rewind(cpuinfo);
-	fseek(cpuinfo, flags - buffer, SEEK_SET);
+	if (fseek(cpuinfo, flags - buffer, SEEK_SET) != 0) {
+		fclose(cpuinfo);
+		free(buffer);
+		err(1, "Failed to seek in /proc/cpuinfo");
+	}
 	if (!fgets(buffer, 4096, cpuinfo)) {
 		fclose(cpuinfo);
 		free(buffer);
-- 
2.45.2

