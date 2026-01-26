Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721A29A309;
	Mon, 26 Jan 2026 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457842; cv=none; b=MCZ6GRAi9wxAhQmw6DThsDkmiw//rBkWLiNHQQLxj4CegjTbGEMrZG3or9XavccDLVLhPLynT+05tsPPRM1YXnj6qR0laY5wTpYRsnBWMFebxHn7x/b88uTQuyfFDFyi5EFv9Cz/w+GtquSrrHfenedT8QExe5RSH4X+u8GO82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457842; c=relaxed/simple;
	bh=SA7qlov+EqbMPYhGHRRyAU6CqRSIo6pVyv8k9XJfObM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FofYLNSfHuYvZNfCVxq22pPlacqj4xq5fkvFdV8jRsfcYgcnkFqcuiPM2bnRMoD7PGzJ+fOdLkwZYgA+XWCHSn1xv92mhXUZIJfdk5PCEtvydXJNzp7QW8/R4+dZVGFJGFahA0rCuCuelrB6Omi1q8AQTyVPyOFysBQegidswh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd4bPBqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd4bPBqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A2DC116C6;
	Mon, 26 Jan 2026 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457841;
	bh=SA7qlov+EqbMPYhGHRRyAU6CqRSIo6pVyv8k9XJfObM=;
	h=From:To:Cc:Subject:Date:From;
	b=Cd4bPBqw25KrsXNxeOKPvfr8k1MLmNnuifpLP+Cz3QBtK68lNAof1BURjpKBuyHHF
	 1mEf1Rym5rkAt0BW6HAQIvnnH8EPCrIUIQKv8MVHEcmH0AmEvguge0F0Yu8zULLvGw
	 c0zriG+MOhcuMLL9aTNqIk9xAWiFjy4JZ3t+wCclm5CBaCozBVU73S3tVvD18L5CWG
	 EffTPF7sgHtBtE2R70XgTFg/c5RTvIrOxoMnEUNR5p0M/oLFKE/ACr15MxnY9wIL9q
	 y+sW/h2us7yo7HqDFdjudkWyNzdePEOPkZuiwrRdQuVJDzcfctjPMkG/rmpPY6881c
	 EEB3s+6z++E6g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Malaya Kumar Rout <mrout@redhat.com>
Subject:
 [PATCH v1] PM: hibernate: Drop NULL pointer checks before
 acomp_request_free()
Date: Mon, 26 Jan 2026 21:03:57 +0100
Message-ID: <6233709.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acomp_request_free() checks its argument against NULL, the NULL
pointer checks before calling it added by commit ("7966cf0ebe32 PM:
hibernate: Fix crash when freeing invalid crypto compressor") are
redundant, so drop them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/swap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -902,8 +902,8 @@ out_clean:
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			if (data[thr].cr)
-				acomp_request_free(data[thr].cr);
+
+			acomp_request_free(data[thr].cr);
 
 			if (!IS_ERR_OR_NULL(data[thr].cc))
 				crypto_free_acomp(data[thr].cc);
@@ -1502,8 +1502,8 @@ out_clean:
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			if (data[thr].cr)
-				acomp_request_free(data[thr].cr);
+
+			acomp_request_free(data[thr].cr);
 
 			if (!IS_ERR_OR_NULL(data[thr].cc))
 				crypto_free_acomp(data[thr].cc);



