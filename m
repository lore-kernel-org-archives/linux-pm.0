Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231344;
	b=zybhkXhjvv825YkZkNg38lTuX6z5tPIh1lx5BT3NzBHgLAXGpNiuqwLRdPJgRfkxb4+T
	 3oscyjJbbDSm1tW6o6+EwlCui11ziZ8OI6Rc76c9B4yYvB8FTTLKRe/c1B4zgKSBtIStI
	 kMK5/sjdd5S/hYDz5Opg7pyO9WYQD412zYDRj+ukgaCyxAheeWB2cClg9hhpOQNIhS4en
	 mfh1Lu9ob/RH3xiJ0A7gq2Ecg8ltV71Du0SkIJzJ4ELGjdJlQmSzNaucqMQTqPcN/xE71
	 Gv/jcXSmUf15JyNgTTN5hFCVJsLTBQnizMqFjlOx9+ccrcn6sQn4x9LQomXsV7FA0lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231344;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=c8Z1ip9TBXqKyI4X7VpGPnuu1/adw5JmuFhegoSwDwg=;
	b=hxvxqbprxgenjF5BY9Fdc/VoEs3sjjaIYobZA/ttdgMmoKUGZHG1LcYQqkNEDxNvv8IU
	 sndqJ/rltkst7ytLhJDnlxR7Fx2oQJqiByZxt/OQSpNsI+UOxJtXKfbcn22tNrfj9jBXL
	 y+YdPLjySxIKyf3+uI9YCZdF9ByDXE1sqSiJyb1mbdrrkTKZyCDufZ7DAe+hHPjQ6WiXY
	 O+M4Az6EV2XRt/g9jahF4xSdMXyXBsCfN8K/sM+7lHo6uJWtfKStQzlCvk82GiTZf/P7w
	 hcUBf28zoyQ8AUVEUO09D5Ni91/qsVo3I6Qp96vIqqbkXJa0VZX1LL6v6D9enLQZTdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lZBX8DlQ;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE17606A321;
	Mon,  9 Nov 2026 13:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE17606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lZBX8DlQ
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04E24DA8;
	Mon,  9 Nov 2026 14:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231201;
	bh=KQzB3A+G40tugQO/kEHn9gWiWxMD7lAli5QEf2SIV6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZBX8DlQ0enOn55uNC/yuLzlcKs37ydeU08tZF/kUzHqTrs+hvTMOzVftfBZmTRVL
	 VwjDwk24xBjyQ6j1FkY4cwCkkicl2Flh7n03tmJ67wE2VYG2NishztUVapdFhW5PDo
	 PfH+XKle9ABjF0fDRsn6wN/Wz25RuAciYb/A1TN8=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:31 +0900
Subject: [PATCH v4 10/13] media: vsp1: Fix du_complete race condition issue
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-10-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
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
index adb89e69938903e3bb617c0ea4857e1d2fcfa312..c2bf34c1e57fae45dd6d419167889f59f575434b 100644
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
@@ -698,8 +700,8 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
 		 * Register a callback to allow us to notify the DRM driver of frame
 		 * completion events.
 		 */
-		drm_pipe->du_complete = cfg->callback;
 		drm_pipe->du_private = cfg->callback_data;
+		WRITE_ONCE(drm_pipe->du_complete, cfg->callback);
 
 		/* Disable the display interrupts. */
 		vsp1_write(vsp1, VI6_DISP_IRQ_STA(pipe_index), 0);
@@ -768,7 +770,7 @@ int vsp1_du_disable(struct device *dev, unsigned int pipe_index)
 			brx->inputs[rpf->brx_input].rpf = NULL;
 		}
 
-		drm_pipe->du_complete = NULL;
+		WRITE_ONCE(drm_pipe->du_complete, NULL);
 		pipe->num_inputs = 0;
 
 		dev_dbg(vsp1->dev, "%s: pipe %u: releasing %s\n",

-- 
2.47.3

