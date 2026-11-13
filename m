Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583187;
	b=pw1TDok5cdJX5bpmGGEwllLO679RcBYvxzlEryQGxqqCMX3AFRdJAotBGeFSPeijhBft
	 gQwnBqnE86S3bJ/jg46/7Ef96EYts3GBd49T+nDjM0K+FmsRTwfzjDHQC/iHpTghm0Ac/
	 yrIB/F02JY75TMCNXg6MAlilf04O7123tL9uXjEB9fb4SPoMJfPPIzU9y67nsposl3y15
	 g6sX7kQr5l5h5V0T+2L0C7um0zxp9n+6vKqicDCsUiZvwYOx8wuTzYPaFyjat+R99E7WH
	 voQ9IcRrgRCzt38qA3j/+ZdifxRTBngBTA0TBMrG9lVGRRv3KiroEp1mf5qZ6Og8Rgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=ZtZHqWYp/hdsA8yYdGACABI+e6cOsUYrvHs96UxRF6M=;
	b=4IFV/Y3NKsAQdVAJJ/RQmQYY8uOR+MeXTaXIgZ9xIsFh6WB6Zdqg9sFDI51AWuW9rlcE
	 YHZkcxbdU4zXCNwCc9O/Q1LceTnYsWh11BbKoevFQH0mJXxfaxis8UZQeTQOUIbsOw4EB
	 jL/djVmtVlKu6xcuiolMOChRsUUXKONnXCdE1Su49hbpH7+8ZQcNsYDw+HSw5A2Lto/+U
	 09hAEE849C36Y43SKKBpmDyN/DsDSpsShrT7Z+ZHbtxrR/Kt8CWIqEMcWMOsJtWGSGf7T
	 IAwaZOiamEAVA0/HznfdwZV/eWUDFtyhZUoHnIfrOwXavtX2u/gasok41JRrvqyp3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAUmRoIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A1606A33F;
	Fri, 13 Nov 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAUmRoIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648791F000C5;
	Fri, 13 Nov 2026 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583187;
	bh=ZtZHqWYp/hdsA8yYdGACABI+e6cOsUYrvHs96UxRF6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=MAUmRoIZUjChTEpDWPvuWTkwn2WynFUvIIJCPvrmxfSQ5naonQpSf6j36b7iTgUJr
	 l1/6JDsxCTMG/Zjmn5p3ldkMVURAjIinZkicjHT+W+TwRZWDjhwwT9oSG5TwgS/gD9
	 IdHDSe8R6D4lebxVYRAVpgjiVy39QhWsFAXJNSh2bZJkcgWRx4gi253XTkzwyjgyMA
	 ofvU22hE+8HdbT3qrbWCS49vhkWUlowBw7q3PJV/orwP67Qvd0VUbiIGE6COOGJYYj
	 pTybfPfB8JrKGEFDQW1qdm4ivzXUrMpfjOIOnbtBdW7/ZOjp/O40shbeumT5MKwqEi
	 J46Lo1HbzYxkQ==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] bus: mhi: pci_generic: Prevent MHI from aborting system suspend
Date: Fri, 13 Nov 2026 12:17:59 -0300
Message-ID: <7ce7895da501c3204416b69b0049ff488904f6a5.1794582108.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261113151940.2922539-1-lenb@kernel.org>
References: <20261113151940.2922539-1-lenb@kernel.org>
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

mhi sometimes aborts system suspend on the thinkpad T16 gen3:

mhi-pci-generic 0000:08:00.0:
... failed to suspend device: -16
... PM: pci_pm_suspend(): mhi_pci_suspend [mhi_pci_generic] returns -16
... PM: dpm_run_callback(): pci_pm_suspend returns -16
... PM: pci_pm_suspend returned -16 after 15145 usecs
... PM: failed to suspend async: error -16

Prevent MHI from spreading this device-specific failure
to the rest of the system.  I.e. "Why is a modem that I don't use
preventing me from suspending my laptop?"

This change does not comprehend the internal root cause of the
mhi failure, which should be found and fixed.

There is also a risk that ignoring the MHI error and continuing
to put the device into PCI D3 will leave it in an error state.

Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/bus/mhi/host/pci_generic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 7193a384cca4..343d1046a25e 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1727,7 +1727,12 @@ static int __maybe_unused mhi_pci_runtime_resume(struct device *dev)
 static int  __maybe_unused mhi_pci_suspend(struct device *dev)
 {
 	pm_runtime_disable(dev);
-	return mhi_pci_runtime_suspend(dev);
+
+	/* Ignore errors (e.g. -EBUSY); a failed modem suspend must not abort system suspend */
+	mhi_pci_runtime_suspend(dev);
+
+	/* Must return 0 to allow system suspend to continue */
+	return 0;
 }
 
 static int __maybe_unused mhi_pci_resume(struct device *dev)
-- 
2.45.2

