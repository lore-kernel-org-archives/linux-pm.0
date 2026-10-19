Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428745;
	b=TS/YF1FHM3ZDkYxfx2SIXVBt6ldaWNjWzU2thOnNtkzRYbM3f7ZLK8vLs75kp+lh/faT
	 KfFAANPU7xvdI5bHXnOX3ZPKQmptm8SEvCSvpPnwyP3aDiEG3+igkBW3fzo7TfyVh7q7O
	 KxYScfk+jdKTjeN86EIuTyBn2rI9ROh6XIr+V2UsTVEft0ZdV8sPzPzxhIO/7VwaTiVLg
	 sLV4EHVn3lxv7zI7Zpne1EBk4rNqqEXRXsls1odsTMmsI3vgJNOkTsmaqUQ33tpwFZkGU
	 l5Y6NGOZewK5YfByEe3Ov54Dj7HcbflLGLBumN0fCFc8xVH0aRf431KcQ6sEXeT4UIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=QQEpj3wWSD+9wod7uCM/8IlbmgGkKUvkpT4ef/f3cgc=;
	b=J/OeWbs3iTAweC7jZo8giW67NdYv2Rh+9kkKfb1TG9RSK0nOyPgHmvw0wBwm9IfRkNyw
	 XwUTsykUhr0/KFcGs9tSe1QGxQHECodmetfX21z76hWOCBQ5hwsLLi+X6GqZlowffFpbv
	 GxLX399DCtZVeZKqswIUamtJhtbCK0+pJKfsT9YfyvJYH2nIZTZgzWZIzoRUtyPINyx+U
	 QlrsW8yfyqDzAKAnF7Tbq2/+guu5EC9qNggNtdZYembzNbjXBIZWNDX+6D1+mehkTI/2Q
	 JwKi4z3sV6FA545xywPKDAtjBEtEtpXng7tT4srvFuntGx7pQinW0JsgG+ZQ+KtvguQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIrLMnYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D2606A32F
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIrLMnYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B81F0157F;
	Mon, 19 Oct 2026 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428744;
	bh=QQEpj3wWSD+9wod7uCM/8IlbmgGkKUvkpT4ef/f3cgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=UIrLMnYdiiB7NgKENfUT9q5X1C9KckXmkIkiEUZ+qmRkVXaOMTgDHB9rnfJiD7LcZ
	 z9ULoGRwgySLcP8QBGYpBaloWGEjNPFOK2xmF2t/j5BoKCw7wVkYQ2yGaj+KmL/MnL
	 6ox8CpD7+sYz3szCnavkjq4lhe6eAZie7wxbf5tKsZ1mxQoHVl7qjtV98RTYo3gFXM
	 CHwTYfhPXoLCRuIlGeka2iE06d/RJ4GtGnIsAC2UKYT2X1C1yxKMdWgm3piE01tIFU
	 BTyfudul3KEgkZrY9O8RRPn3kvrn18XZ0xJJFikNo8annwylVp3SdWYyuOz9vGTDJa
	 aUcO+JyZdZd/A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 16/18] x86_energy_perf_policy: Fix use-after-free in err_on_hypervisor()
Date: Mon, 19 Oct 2026 12:43:37 -0400
Message-ID: <77e30731aaa7d6321dbae7bd58e111d4a73dfd4e.1792428130.git.len.brown@intel.com>
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

Avoid testing a pointer into a freed buffer.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c  | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 70d889c3e0dc..f8ab9f4465ce 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -782,10 +782,10 @@ void err_on_hypervisor(void)
 	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
 	cpuinfo = fopen_or_die("/proc/cpuinfo", "r");
 
-	buffer = malloc(4096);
+	buffer = calloc(4096, 1);
 	if (!buffer) {
 		fclose(cpuinfo);
-		err(-ENOMEM, "buffer malloc fail");
+		err(-ENOMEM, "buffer calloc fail");
 	}
 
 	if (!fread(buffer, 1024, 1, cpuinfo)) {
@@ -814,11 +814,10 @@ void err_on_hypervisor(void)
 	fclose(cpuinfo);
 
 	hypervisor = strstr(buffer, "hypervisor");
-
-	free(buffer);
-
 	if (hypervisor)
 		err(-1, "not supported on this virtual machine");
+
+	free(buffer);
 }
 
 /*
-- 
2.45.2

