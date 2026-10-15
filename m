Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298694D90D4;
	Thu, 15 Oct 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050784; cv=none; b=TJ4FVxw+9hB633vuwLNEyR7Kke7gY/nSeKOeAdPFNDTyScr8yJ2lDB66mHfZvKKSRj6+06bJyGK+g0E+7WQ2PHOu/rBR1e2MelDe+5JXUgLX/aMn88rYRmuCxv8PKEX2QP090RKOKJ6TZOgf4Vm6v92T3tfg27kbho+LqhzAioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050784; c=relaxed/simple;
	bh=WFQ7BwC5+DnwbRLqZd62nCcFCGtmiySPavqpe57To08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuK8iIIJWeCuxpOAueNdCA/l4/D5su63640fXKPUNILYdf/ZZg9Q9T+cX9kmpuprYpfdOfsAWLAvszqXPS1P08Ahv6UjwrRrgjSABa2+vKWF694FLb2hPhqE3qIg+95iptppYOvgtzLWRHFznzw9ul+EewqVhzpfPhNoKRjV4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rommQw9r; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rommQw9r"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A55BB1F8;
	Thu, 15 Oct 2026 09:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050653;
	bh=WFQ7BwC5+DnwbRLqZd62nCcFCGtmiySPavqpe57To08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rommQw9rGxv/+/JNatADPr6Q33ystvzgtNKFRO1r1BHK1CfnnWpPlgbERhqYn5TUK
	 Xdn+nwGgXJYVXcyKPCY8dWtPOkgGfndbIZ4bJz8WTvN6NoEHyxn4UK32bAkDY48AHb
	 LiGgNWv79a5fH8HA0+ZloVJ+voUpvtirI4m8JMa8=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:51 +0900
Subject: [PATCH v3 11/15] media: vsp1: Fix du_complete race condition issue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-11-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Phong Hoang <phong.hoang.wz@renesas.com>
X-Mailer: b4 0.14.2

From: Phong Hoang <phong.hoang.wz@renesas.com>

vsp1_du_pipeline_frame_end() runs in hardirq context and tests
drm_pipe->du_complete before calling it. vsp1_du_setup_lif() clears
the same pointer on the CRTC-disable path while holding only drm->lock,
a mutex that does not serialize against the IRQ. On SMP, du_complete
can be cleared between the NULL check and the call, leading to NULL
pointer dereference.

Therefore, fixing this issue by using READ_ONCE()/WRITE_ONCE() for
du_complete and ensuring du_private is initialized first.

Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Reviewed-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_drm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
index 9cd5c025d2be8461bd76e14b15f990eb8bfa2909..3dcb83df46f485ecc94334e7a48871e2368a3527 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
@@ -35,8 +35,10 @@ static void vsp1_du_pipeline_frame_end(struct vsp1_pipeline *pipe,
 				       unsigned int completion)
 {
 	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
+	void (*du_complete)(void *data, unsigned int status, u32 crc);
 
-	if (drm_pipe->du_complete) {
+	du_complete = READ_ONCE(drm_pipe->du_complete);
+	if (du_complete) {
 		struct vsp1_entity *uif = drm_pipe->uif;
 		unsigned int status = completion
 				    & (VSP1_DU_STATUS_COMPLETE |
@@ -44,7 +46,7 @@ static void vsp1_du_pipeline_frame_end(struct vsp1_pipeline *pipe,
 		u32 crc;
 
 		crc = uif ? vsp1_uif_get_crc(to_uif(&uif->subdev)) : 0;
-		drm_pipe->du_complete(drm_pipe->du_private, status, crc);
+		du_complete(drm_pipe->du_private, status, crc);
 	}
 
 	if (completion & VSP1_DL_FRAME_END_INTERNAL) {
@@ -694,8 +696,8 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
 		 * Register a callback to allow us to notify the DRM driver of frame
 		 * completion events.
 		 */
-		drm_pipe->du_complete = cfg->callback;
 		drm_pipe->du_private = cfg->callback_data;
+		WRITE_ONCE(drm_pipe->du_complete, cfg->callback);
 
 		/* Disable the display interrupts. */
 		vsp1_write(vsp1, VI6_DISP_IRQ_STA(pipe_index), 0);
@@ -764,7 +766,7 @@ int vsp1_du_disable(struct device *dev, unsigned int pipe_index)
 			brx->inputs[rpf->brx_input].rpf = NULL;
 		}
 
-		drm_pipe->du_complete = NULL;
+		WRITE_ONCE(drm_pipe->du_complete, NULL);
 		pipe->num_inputs = 0;
 
 		dev_dbg(vsp1->dev, "%s: pipe %u: releasing %s\n",

-- 
2.47.3

