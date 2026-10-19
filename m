Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422195;
	b=WSZI8yEP6wMropVPFTnEj4sM6f2eT6d6u2y6gCkCr9k2IDM/iuDGXQA3EsPK08pyjXhZ
	 heEu8fAMZJwndcOmgBsk9mUzQHzC0jWtf0Utj6aGJtNa2OdjbIK4CVfhwYsIKrUtJSloD
	 fvEtnCB2xy6cxhydq4HE/Bihq+g4lPenWJx7ntcvbJZYjYhDYfkCEz0YJ8bUKYHfIkUsu
	 4jdjWJbr6rNqVSne3uCi0O+SMxeZUoD7z5Tegy/zmxe7nQybEAzG514Ui04ik7YkDq3qD
	 lXyaeQpM1IGxaFINLHrfXRbjZTBM9Gi/w/abH+ydKiyyXyTH26387T0abUpXBdX5Hbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422195;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=nJLb9fH+PaZzuCvW09mr0Pe1+PTegGXJsbTj1YNUQLo=;
	b=pNTERKiNltbtxJbb+OFiVFaCU6CHNnanooIOeJSSY3zSeZfhJoVja8u2XTfNI+K2tkhY
	 HofWr7M3dN7Q5kKgPYHvDEb9EhBYPCxinlmcj7fAW7SUziknShQoPzIFDMouNKRDrVYVj
	 9I83iSguTYUb7pFMTLsZdxB2mUKnwUGHhhkammGYIx+BWBe/JSbj+DK7uSTbIzyfSVA3/
	 uKKr4vJmMK7BgXabreVZiT/5vdwMRiSp5DqgWWBP6e5skpvadzUif6QNgs7uilUfqF5ix
	 zEVeZwcu0x+XwrP2KUmYnInirE00G3v68Yw6h9w6BqbuL1UEM1Rlwiex/kbR/L4ETqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXyvnZmu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E898607D374
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXyvnZmu
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9966513CA
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422195; cv=none; b=Z+bb5h4upjFc6rNQdITEDqdGm+c88cKIj2aMAz8KqFg49NnKbMmU0Wj7uSzsUe1PsfkzS9JDn4u5skoLBk/QMVeOG7thrOxJ8KZYbfMM1MiXHGFlsB/l2gIK5T29M1LhgxaaJFnHlpU03XzxxWTPYPETsGiLxE9sxVLNUeWXIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422195; c=relaxed/simple;
	bh=VLANT82rVBGXsKKxumi15+JLMb/yb2Ob4kg9oJWjrNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHLJtRNZv9ZR34JSJR4ZmqLE6OWDC8CDGzazYtdxp7mbjCmwZjok5ZniTZRqp7McmDDG8WmouHMQA+fXPCHj2rTzLvWpPi8eBY1Zd/A8fCKBDg44mhZhpS6yI7VkV1IOa66iEZ1LT/S/NPsj/R4lklDy7FR19XyXWJzgqd9B0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXyvnZmu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEED1F000C4;
	Mon, 19 Oct 2026 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422194;
	bh=nJLb9fH+PaZzuCvW09mr0Pe1+PTegGXJsbTj1YNUQLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=WXyvnZmuQj8l/98V3Jb/+x1Wch4Zjxr36I2icFI8URTh9XAMljmu6tzmt7QG5ROuF
	 naWhl+VjVM+i+XGCWB1IKQo5HsGuKShUKXaT6erxJo1cX9KA+Ssucs67NBQ7OaTWg5
	 y7D3XKZYav7JTOCZ5iNeAOE/JXBsX46Fp/F76TCNub+LqHbeVH8r9nfBc0q4Q5nfrF
	 L7ThU73RA0UuaYo1LXs2xiE9BX3AVBTREEhU4puIQKXsYTvZDAuXUURcPlt5y8+Spz
	 1jRAlWy4ceC0fBFd8YGTIEXwtuF0q0xPmF31nV+QPiH8VBUSimXaJg1mVnlXDW3+Ws
	 Bffn/32k81Jow==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Hemanth Selam <hemanth.selam@gmail.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 20/23] tools/power turbostat: Fix comment typo
Date: Mon, 19 Oct 2026 10:38:53 -0400
Message-ID: <1ab9dde1c8a8a01bf91dd148f29a5161caaf52c1.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
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

From: Hemanth Selam <hemanth.selam@gmail.com>

Spell "instead" properly in comment.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0fce1f3a937f..6ee32fa15c68 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10543,7 +10543,7 @@ void pmt_init(void)
 			 * Set the scope to CPU, even though CWF report the counter per module.
 			 * CPUs inside the same module will read from the same location, instead of reporting zeros.
 			 *
-			 * CWF with newer firmware might require a PMT_TYPE_XTAL_TIME intead of PMT_TYPE_TCORE_CLOCK.
+			 * CWF with newer firmware might require a PMT_TYPE_XTAL_TIME instead of PMT_TYPE_TCORE_CLOCK.
 			 */
 			pmt_add_counter(PMT_CWF_MC1E_GUID, seq, "CPU%c1e", PMT_TYPE_TCORE_CLOCK,
 					PMT_COUNTER_CWF_MC1E_LSB, PMT_COUNTER_CWF_MC1E_MSB, offset, SCOPE_CPU, FORMAT_DELTA, cpu_num, PMT_OPEN_TRY);
-- 
2.45.2

