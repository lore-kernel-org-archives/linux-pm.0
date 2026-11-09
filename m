Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231356;
	b=qpgtQIC830TUJXRKG+rr/t1LS+aQ8DvnAFzgn8pmAKtSKBiPNaaUI9SON0SI2lhxSCZA
	 EK3nfpmuEiF/hsIJjQ+HfUQAiJT9Ck49OioJh6zNdqZHKoV3rSiyVL7lpf467ivd61QIn
	 gALsQkpuwnpE4sO6TloO/qu2s/htHwrgZfhcjsBSyvoOnJZBFic1Wejw+PN/p+qUmWF8S
	 eE0G/aC0fGXFRDKhmdjnyxxbHNrdv1YsayjV9pNaUJceYlQf4ZAvyQtSn1SQbvqVHhUA0
	 5jdaPa3GSqEKYFyP3kKY5x14wX8TcXFKz0mwcYBkJ/pUhEHP4Zw0Y1LtLKsh7YkJ2LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231356;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=tgP4XviTGIz0oLC0rNHIuVfneaVy2vOwc2jM4Exgjbw=;
	b=PT8wVX82S417HMAGkbdZRHTO+cIcn8nB3r33WrONDrOXYBS5yLqOW+jhDXlSbfsLOcdB
	 /MwcB4I7mrB6yzJ+Ctz7gZIXtViy8Qfo2RCPsdJoSkq+MCfZmIl2qriRfaps/IeYIDRSh
	 cPr45OcNoeKMLJmvuVOPpQA26DjRrSOO+g+mgYr2MKfa1xe590BKngICCsKCvdrUxgkMT
	 rW6ZXsLgUkuAQzQu9DrArylCL32AHJeG7RXEyEvvZeV9kF2j7Kf2HxRzBo6CHitigiPJS
	 1xCW0qp+ANHjFYEsxO1mBknGrKJBx5hLoQGDU2hWPcqR2zm8fEvEnecbsg2taNa1ndQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=tIGD1wmI;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D87606D810;
	Mon,  9 Nov 2026 13:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D87606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=tIGD1wmI
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5B1DDA8;
	Mon,  9 Nov 2026 14:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231213;
	bh=CgJnLgnX5CuxDpunc/vPz+9rP/dBSdnVQgPc8N5Uilw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tIGD1wmIInmnPvodb8cAyyag37DpzaiTu0V0eXsFfJVy8YJxlD7nfzbOD9cBd13ke
	 uIhlwEzjgU+2aQBeD8xusyzXIB0JAohgTbIGbA8JgF4H0bXLe0PdyJoloOVWsYqWd2
	 STjwxiDEE86db6Q41tc3gZNpWcwEufP+yRN6Z0yc=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:33 +0900
Subject: [PATCH v4 12/13] media: vsp1: Complete buffers as queued in
 start_streaming error path
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-12-1b2072e8c37e@ideasonboard.com>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

In the error path of vsp1_video_start_streaming, the queued buffers are
released via vsp1_video_release_buffers with the state
VB2_BUF_STATE_ERROR. This causes subsequent start_streaming calls to hit
the following warning in vb2_start_streaming:

	/*
	 * If done_list is not empty, then start_streaming() didn't call
	 * vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED) but STATE_ERROR or
	 * STATE_DONE.
	 */
	WARN_ON(!list_empty(&q->done_list));

Fix this by completing the queued buffers with the state set to
VB2_BUF_STATE_QUEUED in the error path of vsp1_video_start_streaming.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_video.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_video.c b/drivers/media/platform/renesas/vsp1/vsp1_video.c
index b85351986fae50aa678032b05b0352dff2b5a26a..46e0d6f8a66bddb4064e52e1521f3c9da7192868 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_video.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_video.c
@@ -765,7 +765,8 @@ static int vsp1_video_setup_pipeline(struct vsp1_pipeline *pipe)
 	return 0;
 }
 
-static void vsp1_video_release_buffers(struct vsp1_video *video)
+static void vsp1_video_release_buffers(struct vsp1_video *video,
+				       enum vb2_buffer_state state)
 {
 	struct vsp1_vb2_buffer *buffer;
 
@@ -773,7 +774,7 @@ static void vsp1_video_release_buffers(struct vsp1_video *video)
 	guard(spinlock_irqsave)(&video->irqlock);
 
 	list_for_each_entry(buffer, &video->irqqueue, queue)
-		vb2_buffer_done(&buffer->buf.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buffer->buf.vb2_buf, state);
 	INIT_LIST_HEAD(&video->irqqueue);
 }
 
@@ -802,7 +803,7 @@ static int vsp1_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 		if (pipe->stream_count == pipe->num_inputs) {
 			ret = vsp1_video_setup_pipeline(pipe);
 			if (ret < 0) {
-				vsp1_video_release_buffers(video);
+				vsp1_video_release_buffers(video, VB2_BUF_STATE_QUEUED);
 				vsp1_video_cleanup_pipeline(pipe);
 				return ret;
 			}
@@ -858,7 +859,7 @@ static void vsp1_video_stop_streaming(struct vb2_queue *vq)
 	}
 
 	video_device_pipeline_stop(&video->video);
-	vsp1_video_release_buffers(video);
+	vsp1_video_release_buffers(video, VB2_BUF_STATE_ERROR);
 	vsp1_video_pipeline_put(pipe);
 }
 

-- 
2.47.3

