Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397233;
	b=cQCnF6PjLlTrYXTyKNNvNf0JGaUPU/jlu5NYaF+1W9MYMEo/6s68+mAKFrF4nHA8snW+
	 TLbqX/+UTVtACguAOTu9H1rHNoF6GtkGyLJ0EmoV1ICRDVtLNQdDDH+rx4jJ6g8dMbliA
	 HIFmZzqDqbVW1D8/hpnl/ya9UmodOwiCrW6TY7I4OtnvIc8MTPSnF+yQ6i7e9AuESLruG
	 mhQbUxNtxlgoXctsvmsZrdXThV3zuotODbdzronYbzVaVWr2WI60aakc22ezZhWdogpvo
	 0Wu2oudKBZoNxNT8fT1FR48LNpce4yQAHBzL3aguoLJIGsPOmoq1XnysDvW08ygBVpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397233;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ogQtYDBJv4vT5OrszcZv0KYQ/leURTInx/kaevVzlo8=;
	b=JyHMbBOL4s4Er9dnG+VjJc9oDlFRbZ9fupa+Mnu2Ym8ZfboS5X/x+k0fVwJvJ7VUm6GM
	 Ua7xoy0w8rfh5gn8liAflfW4cP/kAUj1ku1mBtfnvw4Ab9gNNPGhzBi2+KLhlPaKa/FNH
	 NmEAGDH0p7JoqAc6QN0axMDmjfDTXXw5c/wO4BLPvg3yHgUjLgjFpbC+ek9P5M93+dJit
	 f0QzyxiRGg/V48Xr+0M9Xo/kkKTeXiFQovprZx91B5Sc5nByticXW8MxhBMQjQfOQirQp
	 2U0urG/EPeNyBGWGaUX+tjmpvoy27ovRgOiEYKrFJJHK3Euv/bNhYSWWuTjjcVs95aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Rk0ePdko;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD75606A31A;
	Fri, 30 Oct 2026 21:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Rk0ePdko
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 182614B0;
	Fri, 30 Oct 2026 22:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793397096;
	bh=SbwUdP2djrhmAtB75jWLtmU9/D9shgsQxCWx3JG24pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk0ePdko6dxw0r2u2YpqG8aEYPA44SyTx81+OoyIRaPbPutCIMtlz6jcIJRbRAo1A
	 DpfiAIX9IUjbMat8PNwbgYqHqYzK71z2a9H4SX1K49abAaeg3mZ0/3MLiaIcQ2yoTT
	 nUOXrzOMlVA6zdKIjYeJn/skN8rYbEKEYD4EGbkk=
Date: Fri, 30 Oct 2026 23:53:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 14/15] media: vsp1: Complete buffers as queued in
 start_streaming error path
Message-ID: <20261030215349.GF3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-14-e052903a3832@ideasonboard.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-14-e052903a3832@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Oct 15, 2026 at 04:51:54PM +0900, Paul Elder wrote:
> In the error path of vsp1_video_start_streaming, the queued buffers are
> released via vsp1_video_release_buffers with the state
> VB2_BUF_STATE_ERROR. This causes subsequent start_streaming calls to hit
> the following warning in vb2_start_streaming:
> 
> /*
>  * If done_list is not empty, then start_streaming() didn't call
>  * vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED) but STATE_ERROR or
>  * STATE_DONE.
> */

Missing space. I recommend copying indentation from the original source
to make it clearer:

	/*
	 * If done_list is not empty, then start_streaming() didn't call
	 * vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED) but STATE_ERROR or
	 * STATE_DONE.
	 */
	WARN_ON(!list_empty(&q->done_list));

> WARN_ON(!list_empty(&q->done_list));
> 
> Fix this by completing the queued buffers with the state set to
> VB2_BUF_STATE_QUEUED in the error path of vsp1_video_start_streaming.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/platform/renesas/vsp1/vsp1_video.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_video.c b/drivers/media/platform/renesas/vsp1/vsp1_video.c
> index b85351986fae50aa678032b05b0352dff2b5a26a..46e0d6f8a66bddb4064e52e1521f3c9da7192868 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_video.c
> @@ -765,7 +765,8 @@ static int vsp1_video_setup_pipeline(struct vsp1_pipeline *pipe)
>  	return 0;
>  }
>  
> -static void vsp1_video_release_buffers(struct vsp1_video *video)
> +static void vsp1_video_release_buffers(struct vsp1_video *video,
> +				       enum vb2_buffer_state state)
>  {
>  	struct vsp1_vb2_buffer *buffer;
>  
> @@ -773,7 +774,7 @@ static void vsp1_video_release_buffers(struct vsp1_video *video)
>  	guard(spinlock_irqsave)(&video->irqlock);
>  
>  	list_for_each_entry(buffer, &video->irqqueue, queue)
> -		vb2_buffer_done(&buffer->buf.vb2_buf, VB2_BUF_STATE_ERROR);
> +		vb2_buffer_done(&buffer->buf.vb2_buf, state);
>  	INIT_LIST_HEAD(&video->irqqueue);
>  }
>  
> @@ -802,7 +803,7 @@ static int vsp1_video_start_streaming(struct vb2_queue *vq, unsigned int count)
>  		if (pipe->stream_count == pipe->num_inputs) {
>  			ret = vsp1_video_setup_pipeline(pipe);
>  			if (ret < 0) {
> -				vsp1_video_release_buffers(video);
> +				vsp1_video_release_buffers(video, VB2_BUF_STATE_QUEUED);
>  				vsp1_video_cleanup_pipeline(pipe);
>  				return ret;
>  			}
> @@ -858,7 +859,7 @@ static void vsp1_video_stop_streaming(struct vb2_queue *vq)
>  	}
>  
>  	video_device_pipeline_stop(&video->video);
> -	vsp1_video_release_buffers(video);
> +	vsp1_video_release_buffers(video, VB2_BUF_STATE_ERROR);
>  	vsp1_video_pipeline_put(pipe);
>  }
>  

-- 
Regards,

Laurent Pinchart
