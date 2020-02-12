Return-Path: <SRS0=mnou=4A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A7CC2BA83
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 05:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6A206D7
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 05:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581485831;
	bh=MYOk5l8LeBp7t3UAirlej4R3sYmg+j85WJ1V6b5sRkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DjCg/X7DplSpae+xnFVxFKnyKqEQIt/pBSwBOcgGZJBqfGf5cffJbss56nLrw6+8G
	 +pGgq7vIdTzgCPW8qOAswyEhloiW50j+1sASK3I/b7WhOIUPpXcq6Ew4ODFeXyRGC0
	 Xp5NXNdhL+gPQrbUNHNqeJsbuJA0/U1Xd91SFJ1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgBLFhK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:37:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgBLFhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 00:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=epOzv8qqRSYrUwjbfQXnznYOcMvnz1PALKcpr17HVYU=; b=Gn+rl5vGGvWLJCD4MrD5ffjHMf
        CFEvj014eTZTQHkSwhBLHivv46sKqrGUV4wkO+royAmms2NaYruLoTA2Ui7968nYcfUGrq+p8fmra
        wmdIIVR9FcNt7+9VTiIZGJA4+BEYhPMh0ztYZPtaMr8tXquuI4QkHheUCtQOlNsg1QQYtK0uORBvL
        91JXNUMDuPb+FDNWH0y39HAO87QOwuUweOCRLf9EASAjYt06c8E+93BI8Ry1L86l3nRu+FiV8OLZD
        XON8QW/qh+3cYTBNCVMVIodxykgNfIi0NsGRv2hOq+S+w87Qi8PGmMivtXBdg0tsUjvxy52hWhk6I
        Mo6AOCkw==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1khx-0006eb-CW; Wed, 12 Feb 2020 05:37:09 +0000
Date:   Wed, 12 Feb 2020 06:37:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 18/28] drivers: media: Call cpu_latency_qos_*() instead
 of pm_qos_*()
Message-ID: <20200212063705.2dd3b206@kernel.org>
In-Reply-To: <4139443.DiSibVL1GN@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
        <4139443.DiSibVL1GN@kreacher>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Wed, 12 Feb 2020 00:17:51 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Call cpu_latency_qos_add/remove_request() instead of
> pm_qos_add/remove_request(), respectively, because the
> latter are going to be dropped.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm assuming that this will be applied via your tree. So:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 
> ---
>  drivers/media/pci/saa7134/saa7134-video.c | 5 ++---
>  drivers/media/platform/via-camera.c       | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
> index 342cabf48064..a8ac94fadc14 100644
> --- a/drivers/media/pci/saa7134/saa7134-video.c
> +++ b/drivers/media/pci/saa7134/saa7134-video.c
> @@ -1008,8 +1008,7 @@ int saa7134_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	 */
>  	if ((dmaq == &dev->video_q && !vb2_is_streaming(&dev->vbi_vbq)) ||
>  	    (dmaq == &dev->vbi_q && !vb2_is_streaming(&dev->video_vbq)))
> -		pm_qos_add_request(&dev->qos_request,
> -			PM_QOS_CPU_DMA_LATENCY, 20);
> +		cpu_latency_qos_add_request(&dev->qos_request, 20);
>  	dmaq->seq_nr = 0;
>  
>  	return 0;
> @@ -1024,7 +1023,7 @@ void saa7134_vb2_stop_streaming(struct vb2_queue *vq)
>  
>  	if ((dmaq == &dev->video_q && !vb2_is_streaming(&dev->vbi_vbq)) ||
>  	    (dmaq == &dev->vbi_q && !vb2_is_streaming(&dev->video_vbq)))
> -		pm_qos_remove_request(&dev->qos_request);
> +		cpu_latency_qos_remove_request(&dev->qos_request);
>  }
>  
>  static const struct vb2_ops vb2_qops = {
> diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via-camera.c
> index 78841b9015ce..1cd4f7be88dd 100644
> --- a/drivers/media/platform/via-camera.c
> +++ b/drivers/media/platform/via-camera.c
> @@ -646,7 +646,7 @@ static int viacam_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	 * requirement which will keep the CPU out of the deeper sleep
>  	 * states.
>  	 */
> -	pm_qos_add_request(&cam->qos_request, PM_QOS_CPU_DMA_LATENCY, 50);
> +	cpu_latency_qos_add_request(&cam->qos_request, 50);
>  	viacam_start_engine(cam);
>  	return 0;
>  out:
> @@ -662,7 +662,7 @@ static void viacam_vb2_stop_streaming(struct vb2_queue *vq)
>  	struct via_camera *cam = vb2_get_drv_priv(vq);
>  	struct via_buffer *buf, *tmp;
>  
> -	pm_qos_remove_request(&cam->qos_request);
> +	cpu_latency_qos_remove_request(&cam->qos_request);
>  	viacam_stop_engine(cam);
>  
>  	list_for_each_entry_safe(buf, tmp, &cam->buffer_queue, queue) {




Cheers,
Mauro
