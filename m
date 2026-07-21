Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259654D90D8;
	Tue, 21 Jul 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646853; cv=none; b=nEErsW0s6DAvLVZxyEAGkZKHjMlOZbFfHSeCwGdq5Y/CWrnoMVYFSGckQ7WK1wkTODt4xmGS/e+dtYtiYMMnQOqAcFuLCRo0RyzcRmt0iAenx4clqJhem3MLmX/YITPS5/X7iaJAUheGAOxAao4IZUxJbsiqDpyDXuuF0JtEAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646853; c=relaxed/simple;
	bh=pOlYpHB8qYB+i/+0XBWMQ6pRO1+uN4s1NK8suJ7kkfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+4VNTbPDGnv2TdNIfG0iZbkSkLAsJeOdpEOGR1snHQn/5FKQLIsJ8Pbe3cuGevkxfrhzUcIlv8WQSl4lKYcXC2gC7cPpjqhjQDOdpUcpoBn+6Vt8TOLeVoDDY7fU1ytDPSzfImcOFSfeSlA5XXYzMCBBojDRRTNXQV5QLLYaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=dAGopWRe; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="dAGopWRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646850;
	bh=VNv2SZK5IuT20jKf63eyex2nA1u4B3QwivjV7yjy8NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAGopWReZa5yseDbcQ6xaoOpr2kMsGb0yk+jAEqeqe79kRaCkJTozEWK6tQriLaBd
	 IEwhIS9Cs7cVVlBwlBGqQNQGsFwUzKmroAL54ec19pFxl6GSjXNuBwQDr6sG+LQPzK
	 bBSUmDy8TOq6JDKg7edd5udo2qT7arwnzF26ChVc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWk2JWGz6vN3;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWj3r69z4vyJ;
	Tue, 21 Jul 2026 15:14:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 2/3] kexec: log the task that initiated the kexec reboot
Date: Tue, 21 Jul 2026 16:13:57 +0100
Message-ID: <20260721151358.4185467-3-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reboot syscall now logs the initiating task for the restart, halt
and power off commands at the point where they can no longer fail.
The kexec command could not be handled there: kernel_kexec() has
several failure points and returns to a running system when any of
them fires, which would leave a stale "initiated by" line in the log
with no transition behind it.

Call reboot_log_initiator() from kernel_kexec() once the shutdown
of the current kernel is committed, right before the existing
"Starting new kernel" line:

  reboot: initiated by kexec[713]
  kexec_core: Starting new kernel

The preserve_context path is left alone since it returns to the
running kernel instead of tearing it down.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..23b7fe36e64e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1200,6 +1200,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
+		reboot_log_initiator();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
2.50.1

