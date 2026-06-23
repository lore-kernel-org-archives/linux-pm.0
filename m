Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7231E848;
	Tue, 23 Jun 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233864; cv=none; b=Vz1gzpOIM/RhM0Iz0QXOSiW2Om2QRbM/DuuXvBggYc6ekPdaBGgGd1eQ239EWmvP1FAlU08rspCZQAsWG3NEevg5Lz3UgvPwRGCd8B0l33IyblNHak0uj4XkfjUl2U/hdL2PMKjR+e3T8JYUk5E3Jh0pqjb4hZzh8sQ2JFk1cK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233864; c=relaxed/simple;
	bh=4nxsQ++sloI1fhzQSm3M9LEUwp3Kv5U7xT28nHK1SVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC26+5jJfGXwEqtTkft8UlqpFefMEF4WXAEnG56zsAQJ6eOJd4IDT9bRU004BzudEaxD+rI8jaZPYVOu/rcOmq6Xys4VdIw/SsdYs7miiztgcEY9BFnbZba+2DHiIW3x5naL+08aO09rzdgTrBpY7ZPDai56dAPCMU5NudDOmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=d5DKwBrJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="d5DKwBrJ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 99B1226670;
	Tue, 23 Jun 2026 18:57:41 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_ABm08VHI-u; Tue, 23 Jun 2026 18:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782233861; bh=4nxsQ++sloI1fhzQSm3M9LEUwp3Kv5U7xT28nHK1SVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5DKwBrJUMjjzv52AXMeWssCq1JPIFnsUTQ+7nDaAxQ6BE4XExa4UD1Urhh0Fopfp
	 XF8+BxvHseSWejQTtpfAcjkLqhQ0t7ieLtg/mjClSgUSFD+T5Tt26KJ6/ZPlxnwttu
	 9t50e4i7UA9YlY9BsWXQ6/SVyleURuruPzKklVRKKsmfKNcZLhyhHp5pGU6Dlfa5z1
	 LIFD8B0jNeDNVq4FQ3RN+DkVaY6+U0/QrYjcTugS/iwWrzLubEU+WKkF+s6ECQgk95
	 KS23ADBRFVAQBlDHS5dqyEJpL1Rh2XMeZJijmbiNeMW8aSD6kH98h9mTyc+WifTBfH
	 jSCE56VkRoqjA==
From: Marco Scardovi <scardracs@disroot.org>
To: moravec@ukf.sk
Cc: bp@alien8.de,
	crecklin@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	pavel@kernel.org,
	rafael@kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	scardracs@disroot.org,
	tglx@kernel.org,
	x86@kernel.org
Subject: [PATCH v2 1/4] PM: hibernate: Declare hibernate_relaxed_memmap
Date: Tue, 23 Jun 2026 18:47:27 +0200
Message-ID: <20260623165724.10753-2-scardracs@disroot.org>
In-Reply-To: <20260623165724.10753-1-scardracs@disroot.org>
References: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
 <20260623165724.10753-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare the 'hibernate_relaxed_memmap' global variable in
include/linux/suspend.h, which will be used to relax the E820 memory map
integrity check.

Assisted-by: Antigravity:gemini-3.5-flash

Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 include/linux/suspend.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..92eb3eb23422 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -393,6 +393,7 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
+extern bool hibernate_relaxed_memmap;
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
-- 
2.54.0

