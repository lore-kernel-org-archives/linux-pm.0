Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF623FA5F0;
	Wed, 22 Jul 2026 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750786; cv=none; b=q3UtJCOXIOQEO7+FUQfZwtuhCnFTnVH5t46Z2tIXv0xa1AoU0Fxkv2p9GF3kmU/V7Km+21+QOhqMcmwPRoGBLT/sEHcIaquSPInAQpVVAD6LMx6RRyQcU5ksCj9I86htm+hBI0J1SD/Kl/guFJQFDFsJ5SAngzN1deGl/0lW2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750786; c=relaxed/simple;
	bh=stshlyFU5jeSS4sb+KL/9qGL6v351n1j1DTdzSeYxms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynp2YjqBeMMaOJxMRbE9C/YMHSOI4+J5r+fxnp+P4t+FSqvPY8M2ULxBC31Pv+y9zr2qfgk1YZEw+5RPBxIEeSX87tDhfqnyl8XIKyJjZkPKadcRoOd6WdvR1bvZrRtWXvBXu1ar3qT/jDkNMzO9hLQkrWM+CfmpxtdDVty7C5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ToqILh9C; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ToqILh9C"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25E6E594;
	Wed, 22 Jul 2026 22:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784750722;
	bh=stshlyFU5jeSS4sb+KL/9qGL6v351n1j1DTdzSeYxms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToqILh9CPGJo0smEwP7rP4LkNeMgmIrJ+Q9iCToV2K2r361f3GHLEh8QgGGyhpyjl
	 ip4IuQea7teP2RyzbNfgzH7OmAUnSK2gT5T1wKtAAixCwsWhGB/HGiMD/k494dvbU8
	 VnXbholLCrbgR3UiGSTBYqggNj3fjvXwk+TWetOI=
Date: Wed, 22 Jul 2026 23:06:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, hansg@kernel.org,
	kernel@uniontech.com, lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com,
	pavel@kernel.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v3 3/3] media: uvcvideo: skip streaming restart after
 hibernation snapshot
Message-ID: <20260722200620.GC648629@killaraus.ideasonboard.com>
References: <20260602032413.1540166-1-tuhaowen@uniontech.com>
 <20260618013133.1047270-1-tuhaowen@uniontech.com>
 <20260618013133.1047270-4-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618013133.1047270-4-tuhaowen@uniontech.com>

On Thu, Jun 18, 2026 at 09:31:33AM +0800, Haowen Tu wrote:
> After the hibernation snapshot is created, devices are resumed with
> PMSG_THAW before the image is written and the system is powered off.
> Restarting an active UVC stream during this phase reinitializes the
> camera and visibly turns its indicator LED back on.
> 
> Skip only the UVC streaming hardware restart while the snapshot is
> available.  The driver's frozen state and clock are still updated before
> the check, and a subsequent UVC suspend can stop the stream and select
> alternate setting 0 as usual.

Why is that desired (both the decision to only block the resume of the
video interface, and the decision to not block the next suspend) ?

> uvcvideo does not provide a shutdown
> callback that requires the streaming hardware to be restarted first.
> 
> This is a device-specific use of pm_hibernation_snapshot_done().  The
> helper does not cause other drivers or USB core to skip THAW resume.

I don't think this sentence belongs to the commit message.

> Tested with hibernation image written to local storage and resumed from
> disk on a system with a USB UVC camera attached; the camera LED remains
> off during image writing and the video stream resumes correctly after
> restore.
> 
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
> ---
> Changes in v3:
> - Clarify that only the UVC streaming hardware restart is skipped.
> - Explain the subsequent UVC suspend and shutdown handling.
> 
> Changes in v2:
> - Use pm_hibernation_snapshot_done() after the PM helper was renamed.
> - Move the check after clearing the frozen state and resetting the clock.
> 
>  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index f6c8e3223796..1744298f4b1f 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -12,6 +12,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
>  #include <linux/videodev2.h>
> @@ -2151,6 +2152,13 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
>  	if (!uvc_queue_streaming(&stream->queue))
>  		return 0;
>  
> +	/*
> +	 * Avoid restarting the streaming hardware during the transient THAW
> +	 * phase after a hibernation snapshot has been created.
> +	 */
> +	if (pm_hibernation_snapshot_done())
> +		return 0;
> +
>  	ret = uvc_commit_video(stream, &stream->ctrl);
>  	if (ret < 0)
>  		return ret;

-- 
Regards,

Laurent Pinchart
