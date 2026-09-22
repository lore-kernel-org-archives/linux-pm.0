Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B429B78F;
	Tue, 22 Sep 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039878; cv=none; b=bk++XYXCGtJbH3TsY1JuCpb8sMXWYGjHuHiwWMhWK/0+7UppnwvnLG8QeIQvM74PqrWgNpeb+ui+eo8Qud/03U9MPaV1i0XpMotIqZpaxPC2Dirg5BQF0M8AwykLqkC7koYRy75PBJwguNkSFgf+8oWF1Bj9eN9lpsmNY1AWAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039878; c=relaxed/simple;
	bh=ZHVb45XCWO9w58LLzRNKyyIHjXI2eN1KtCPkmd2PO/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RItw+6m0bVaCHXgV4QNDEPFFwqccJMChzEdBSV3D0l5z34GCFKd8al475wfhgAJjNp4tlgV2GalRmmAdy2H4ecY5F2mz9SSMShVvSgKcantEBrVBzGyFAavhNSEOw8MNGTuGE5qC6N1y0ttnEUuVmfdArYg0you+0+hkuKMs/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c11bYG53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c11bYG53"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9E82C2BCB3;
	Tue, 22 Sep 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039877;
	bh=ZHVb45XCWO9w58LLzRNKyyIHjXI2eN1KtCPkmd2PO/g=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c11bYG53PqIeUNnE+PqljmY33Dxj4ecdevKrpwpUJnHv7q0jJzEPWwIkEvQId7ceC
	 lKjxiXu49lJ3gby9d+hoGuVqCE8QsCd1M03WvjOpURXdRUOupHzLiuSccjKuRkbsbV
	 Zjz4dPh7oStU3b9YzLOMpPgwD2Kt0LzGeVVDcoV3UbjKTeuV4nRDwbnfK1MDkkk0ON
	 1SGlCyA6Jkt10QAZRdgnXQA2EXv1LVXsrPHhUXS7LOJC/zjNVe3ilYG/p2fYY7qXAo
	 XuxoIhfp9T4wztp6Lc/i8PWYmXdbCxpY9Z3mMZD/oCoxV12FQrFeU0BUvAAno9xZo6
	 0GeOZu3PuMl0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB0C982F0;
	Tue, 22 Sep 2026 01:17:57 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:17:55 -0400
Subject: [PATCH] pmdomain: renesas: rcar-sysc: publish the external request
 mask
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-rcar-sysc-v1-1-fb25996bb2f4@vt.edu>
X-B4-Tracking: v=1; b=H4sIAELXsWoC/yXM0Q6CMAyF4VchvbYGBg7wVQwX66gyE6dphWgI7
 +6Gl1/T86+gLIEVzsUKwkvQ8IwJ1aEAP7l4YwxjMpjS2LI3FT4IxTtB/apHy62lbuybrj5Bmry
 Er+Gz5y7D3zrTnf07N/IHOWUkcdFP+bRzaY91ijawbT+Df2GbkAAAAA==
X-Change-ID: 20260921-mb-rcar-sysc-6e76b8d94835
To: Ulf Hansson <ulfh@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039877; l=2526;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=/J+UZmfWmy/IxE0tQAJ0EO14IUIFzykt/G670AOHT38=;
 b=PEN1vUv1FyPiUHVzj+GEzwZkWrshu6uVQzCS8Oh3jmo/jMz+3NIHX13ht9OgFEhnOwxgbOYrU
 4mJIv8BfmPECUc5oJ/dDTQnanqIaT5P44PbJfshWBGFaFSHYakXXXBp
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

rcar_sysc_pd_init() maps the SYSC registers and stores rcar_sysc_base,
rcar_sysc_extmask_offs and rcar_sysc_extmask_val with plain stores,
before it registers the power domains. rcar_sysc_power() tests
rcar_sysc_extmask_val and then writes through rcar_sysc_base at that
offset, from genpd on any CPU.

Publish the mask value last with smp_store_release() and read it once
with smp_load_acquire() in rcar_sysc_power().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index bd7bb9cbd..d0eaaeeb9 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -106,15 +106,19 @@ static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)
 	unsigned int chan_mask = BIT(pd->chan_bit);
 	unsigned int status, k;
 	unsigned long flags;
+	u32 extmask_val;
 	int ret;
 
 	spin_lock_irqsave(&rcar_sysc_lock, flags);
 
+	/* Pairs with the smp_store_release() in rcar_sysc_pd_init(). */
+	extmask_val = smp_load_acquire(&rcar_sysc_extmask_val);
+
 	/*
 	 * Mask external power requests for CPU or 3DG domains
 	 */
-	if (rcar_sysc_extmask_val) {
-		iowrite32(rcar_sysc_extmask_val,
+	if (extmask_val) {
+		iowrite32(extmask_val,
 			  rcar_sysc_base + rcar_sysc_extmask_offs);
 	}
 
@@ -157,7 +161,7 @@ static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
  out:
-	if (rcar_sysc_extmask_val)
+	if (extmask_val)
 		iowrite32(0, rcar_sysc_base + rcar_sysc_extmask_offs);
 
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
@@ -381,7 +385,12 @@ static int __init rcar_sysc_pd_init(void)
 
 	/* Optional External Request Mask Register */
 	rcar_sysc_extmask_offs = info->extmask_offs;
-	rcar_sysc_extmask_val = info->extmask_val;
+	/*
+	 * rcar_sysc_power() tests rcar_sysc_extmask_val and then uses
+	 * rcar_sysc_base and the offset, so publish the value last, with
+	 * release semantics.
+	 */
+	smp_store_release(&rcar_sysc_extmask_val, info->extmask_val);
 
 	domains = kzalloc_obj(*domains);
 	if (!domains) {

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-rcar-sysc-6e76b8d94835

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


