Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD344BB26D;
	Thu, 15 Oct 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050796; cv=none; b=LmYMcgdyg8J6fwePXGwt3jAOU6X7qDeEF1wS1Gf9s6tzbowCOoGyhi9IzRXCBdQxLJOqjzv8TsSEo5Gd9Gd2SPoNfEutNnx5KPhCyhiF9BcJiMMtGjt7d4XlwqaQB5oClFTj/r4QTxeDsHyHdrfo77Yx6azyaUxofKc5LTZecOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050796; c=relaxed/simple;
	bh=wO5KaF5TGSYeGD/dfuhCnTlO3hTYFr553PjDcF97S2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4AOSCEFQzUuS33AB2T1mPZ/Zf6vjvme1XycUTk0NBY3P93MNO6JE77D2bvexCuumQXcdrNNluH/CkuE5s/WoCFtFxPVjdPXh3/iGKIK42Kvwr+bIJxEYvaI+kXP5q1hSKm89eOtvqMB+kNvztSsaIxA9YK8W2qvmgU34HRQZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DNSXWAFn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DNSXWAFn"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1A7E1F8;
	Thu, 15 Oct 2026 09:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050670;
	bh=wO5KaF5TGSYeGD/dfuhCnTlO3hTYFr553PjDcF97S2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DNSXWAFnNJA1mcppehL1VqP+a0f30HujuNwZiQJAH7nrk6WFgRoYYwaxJs4atUl3Y
	 rZDs9wkCsyHinUNbGK9+L1wZJ9gPkwP3yVuXm1Fq4U/4oyGpp2re/nJbFOAc+WDRkp
	 CVKOUWK2U3n3XVEf+90H77n+Zw7pTNd5NtxRS7LM=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:54 +0900
Subject: [PATCH v3 14/15] media: vsp1: Complete buffers as queued in
 start_streaming error path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-14-e052903a3832@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>
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

