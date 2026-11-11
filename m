Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417815;
	b=qKBAnXyaq2+M9juaI9w3vK2QLILGwOXhELZEg9xw6BRsPKFHqbrPTYDNeeD+pCwepTF+
	 FQTMPeyISpmWWKvRVJFRuwNLCqt2hA82IP/7EcSQVoLj7IPq984bV0J2BExwLC9nqNhcS
	 5fj9/iHgMwzeRmseegsGeQ+TMlEmOqtJ059yq4E8W/8j1LjPmTLY+00hKEJp+SH/3ofjQ
	 G65z+hppJn/RMfSLFIdXbN0JRCniU1UoiJR2BmHlcBplLoC7k/VFzH9IDeEO8jkB/Ju+n
	 YN9u68TluH2SMdIYrB7+jcLukx8ZmUAC5jqWFrIh3nx4ENeFmqfr43o4vaquCw5dRRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417815;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Reply-To:Organization:Content-Transfer-Encoding;
	bh=amdozvEXKjSjaaYnV4Mv1pVbh2XMgfKLrjXQ4vsAgUI=;
	b=f3CKrSO/dAJmTpPPrYcMO6UorXoBsnpo1ha/BM+M0WPg26gJ3v31bGIunkl8Tsq/O0Rr
	 I16QTL8DskvMMhS/m7gLy2eMp0TF5GVsK1+QfWDAGXYlFzuCRNJh9XP3K3Kj6uo08KeCE
	 3LyPedD5qS4CG20zYfwJqlcZhzBDM8OK0jcL/QRjXP722TSRPKoQIE/0+J/Bj6HZLWW+S
	 rrH8UkM9eFdfYceD76KV6tVTZISiP/fo4td28tjTakfpnI6MP2UognLUn5EuNusaNLYm6
	 CUgHnhdXbQIVlCBDQF5vWeXAtbiHJB43ecROOts8XF5+2GevldpiNFXpRfWrRwFfpsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooY2l0aw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1449606A337;
	Wed, 11 Nov 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooY2l0aw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72661F00A05;
	Wed, 11 Nov 2026 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417815;
	bh=amdozvEXKjSjaaYnV4Mv1pVbh2XMgfKLrjXQ4vsAgUI=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=ooY2l0awGQBdAUWEwaogJFVPGkUGlz3YBBCBOt56rW5Y6r4PGf3lNQAKSoTkKXZCh
	 kMZKQHa74jlSh+lZPzfj9ltJkj0O3igk6fOQVOzj6Tqonu0AQtuFaK/YDAeD1Fttqr
	 eMzYgQWFQH/v/Lx6ZOrkYpTtxEsDoUAtg9VrlyU/65QuJsfK/JOKceYOJS+caDr4gn
	 szJAWqVzhh7ZnIwv9MsejDg1mWjk8BaJ55OZ+fa+nbRBphyAUP87F099BGfWUQ2ZS0
	 cB1cGWtYuIGZJvEtQ1FgCvFXFbFiUMKL2UtTOk7cc8T52Of4EDa7pzOUJP3WwkERd5
	 N6uDlRsgH4W0g==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bus: mhi: pci_generic: Fix erroneous system suspend abort
Date: Wed, 11 Nov 2026 14:23:26 -0300
Message-ID: <b47282f1514a9012ac51d0915afb83782c3c0050.1794417398.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
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

mhi-pci-generic 0000:08:00.0: failed to suspend device: -16
mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend(): mhi_pci_suspend [mhi_pci_generic] returns -16
mhi-pci-generic 0000:08:00.0: PM: dpm_run_callback(): pci_pm_suspend returns -16
mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend returned -16 after 15145 usecs
mhi-pci-generic 0000:08:00.0: PM: failed to suspend async: error -16

When a driver returns -EBUSY for its runtime suspend method,
that means "try again later".

But when a driver returns anything but 0 from its system-suspend
method, that means "abort system suspend".

Always return 0 from mhi_pci_suspend().

Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/bus/mhi/host/pci_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 7193a384cca4..b036fa6e06c4 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1727,7 +1727,8 @@ static int __maybe_unused mhi_pci_runtime_resume(struct device *dev)
 static int  __maybe_unused mhi_pci_suspend(struct device *dev)
 {
 	pm_runtime_disable(dev);
-	return mhi_pci_runtime_suspend(dev);
+	mhi_pci_runtime_suspend(dev);
+	return 0;
 }
 
 static int __maybe_unused mhi_pci_resume(struct device *dev)
-- 
2.45.2

