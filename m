Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D556423A9B;
	Wed, 29 Jul 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310158; cv=none; b=mGR+l/rZSul2IHajhpPB6b8NyX75GfsUdqDAHjBPHQxxP/Npu95JsHJN4n0H0abj2SJjPNoKF+VAbWgwTjsX1jfPaDYhfVOaH2vrHjPHY1YACBNJ3SSpZ0IryqjEsSEUireH7Xx8znNMCt3zyWUuDl3TNwOQOes7w8G2hhEQs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310158; c=relaxed/simple;
	bh=0GPxDcwyimw4bHAA4qTNOyDQJhuAQtZVF3rC79tiNd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QArgq9cYDfHBaGMdslkmAc1M3vVqrnE5BkI+qHsZD1HqnFawfNPi+FYvYbHRhC+vXCAVVhdFjTKZ9dQnUs+4RJ2+gvPzo1oKkQqLfiDsgdR6e0frPhrQcvAf6JCLNFREve1jLb1ko/uP9xGmSTP2m5W4djO68NVMbLZpvA2kHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGc5cJjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGc5cJjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CFE1F000E9;
	Wed, 29 Jul 2026 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785310147;
	bh=dDJuyxTx89l+wBrZp9SB2fXDrF6LUCjF+IHLy2dmd0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HGc5cJjZpDotJJMikzDYnOwgbeDbIueRd7ncAspKugQzpn0hlBnKc6e8XSSbqlAvr
	 mahD/qvYqIJKlJDyq1vFXZyXXEA03d9MONzxOptjM3OywB9pVvENNaAj49ROa24S93
	 T881DM5z086V1IoVHqX/cdiHI7cg3HahhL5nzdL2b5k3hzfGqRcbGpF3X/4rWIxxgi
	 xHb+QXNVGkqfaOQ7pfmoG5HC+e+o9X4uP85ZM9FNySarTnmgoRV7tofo10rid7Rorr
	 h8VD3Ek68Sp5MYE+zQaUw3gEm5ZMJhUzO6F7K5IVHTqtudcmd97X1MWwgtunXa1aor
	 WeUaNXgNWvbVQ==
Message-ID: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
Date: Wed, 29 Jul 2026 09:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after
 hibernation snapshot
To: Haowen Tu <tuhaowen@uniontech.com>, laurent.pinchart@ideasonboard.com,
 rafael@kernel.org
Cc: gregkh@linuxfoundation.org, kernel@uniontech.com, lenb@kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org,
 oneukum@suse.com, pavel@kernel.org, stern@rowland.harvard.edu
References: <20260723084633.GE648629@killaraus.ideasonboard.com>
 <cover.1785226280.git.tuhaowen@uniontech.com>
 <6179cdb467414a1949fabbd4d8dec29affe9c3ea.1785226280.git.tuhaowen@uniontech.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <6179cdb467414a1949fabbd4d8dec29affe9c3ea.1785226280.git.tuhaowen@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Haowen,

Thank you for your work on this.

On 29-Jul-26 09:11, Haowen Tu wrote:
> When a UVC camera is streaming and the system enters hibernation, the
> streaming interface is frozen before the snapshot is created. The
> original kernel then resumes devices with PMSG_THAW so it can write the
> hibernation image.
> 
> Restarting UVC streaming during this transient phase can turn the camera
> LED back on and generate USB traffic even though the normal successful
> path writes the image and powers off.

Right, so the purpose here is to avoid the LED turning back on and
to speedup the hibernate?

IOW except for the LED turning back on and things taking slightly
longer everything works correctly with the current code, right ?

I'm wondering if it would not be better to solve this in userspace
and have userspace stop the streaming before hibernation ?

Things like network connections will also get disrupted so some sort
of system-is-going-to-suspend notification to userspace processes
sounds useful ?   This could e.g. also be used for program to save
any unsaved work (e.g. save unsaved changes in an editor to
a recovery file).

> USB interface resume callbacks do
> not receive the PM message,

Hmm, the way you word this sound like this is a problem at the USB
layer. But I think this is more of a short-coming in the generic
device model.

To clarify AFAIK the actual USB device to which the interfaces belong
also does not get a specific PM message here, right ?

The reason I'm asking is because the way this is worded in the commit
message makes it sounds like this might be something which could
be solved in the USB subsystem which I do not think is the case ?

Regards,

Hans




> so use pm_hibernation_snapshot_done() to
> detect this phase and defer the streaming restart.
> 
> The deferred state is kept in the UVC stream. If image writeout succeeds,
> the system powers off and no restart is needed. If image writeout fails,
> the PM core sends PM_HIBERNATION_IMAGE_WRITE_FAILED before userspace is
> thawed; the UVC PM notifier then restarts streams whose resume was
> deferred. If that recovery restart fails, fall back to the existing
> streamoff error path so userspace is notified instead of waiting on
> buffers indefinitely.
> 
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 56 +++++++++++++++++++++++++++++-
>  drivers/media/usb/uvc/uvc_video.c  | 19 +++++++++-
>  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
>  3 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 31b4ac3b48c1..3cf861e0fa95 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -13,6 +13,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/usb.h>
>  #include <linux/usb/quirks.h>
>  #include <linux/usb/uvc.h>
> @@ -38,6 +39,8 @@ unsigned int uvc_dbg_param;
>  unsigned int uvc_timeout_param = UVC_CTRL_STREAMING_TIMEOUT;
>  
>  static struct usb_driver uvc_driver;
> +static LIST_HEAD(uvc_pm_devices);
> +static DEFINE_MUTEX(uvc_pm_mutex);
>  
>  /* ------------------------------------------------------------------------
>   * Utility functions
> @@ -2200,6 +2203,7 @@ static int uvc_probe(struct usb_interface *intf,
>  	INIT_LIST_HEAD(&dev->entities);
>  	INIT_LIST_HEAD(&dev->chains);
>  	INIT_LIST_HEAD(&dev->streams);
> +	INIT_LIST_HEAD(&dev->pm_list);
>  	kref_init(&dev->ref);
>  	atomic_set(&dev->nmappings, 0);
>  
> @@ -2346,6 +2350,10 @@ static int uvc_probe(struct usb_interface *intf,
>  	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
>  		usb_enable_autosuspend(udev);
>  
> +	mutex_lock(&uvc_pm_mutex);
> +	list_add_tail(&dev->pm_list, &uvc_pm_devices);
> +	mutex_unlock(&uvc_pm_mutex);
> +
>  	uvc_dbg(dev, PROBE, "UVC device initialized\n");
>  
>  	return 0;
> @@ -2370,6 +2378,10 @@ static void uvc_disconnect(struct usb_interface *intf)
>  	    UVC_SC_VIDEOSTREAMING)
>  		return;
>  
> +	mutex_lock(&uvc_pm_mutex);
> +	list_del_init(&dev->pm_list);
> +	mutex_unlock(&uvc_pm_mutex);
> +
>  	uvc_unregister_video(dev);
>  	kref_put(&dev->ref, uvc_delete);
>  }
> @@ -2447,6 +2459,41 @@ static int uvc_reset_resume(struct usb_interface *intf)
>  	return __uvc_resume(intf, 1);
>  }
>  
> +static int uvc_pm_notify(struct notifier_block *nb, unsigned long action,
> +			 void *data)
> +{
> +	struct uvc_device *dev;
> +	struct uvc_streaming *stream;
> +	int ret;
> +
> +	if (action != PM_HIBERNATION_IMAGE_WRITE_FAILED)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&uvc_pm_mutex);
> +	list_for_each_entry(dev, &uvc_pm_devices, pm_list) {
> +		list_for_each_entry(stream, &dev->streams, list) {
> +			if (!stream->hibernate_resume_deferred)
> +				continue;
> +
> +			stream->hibernate_resume_deferred = 0;
> +			ret = uvc_video_resume(stream, 0);
> +			if (ret < 0) {
> +				mutex_lock(&stream->queue.mutex);
> +				vb2_streamoff(&stream->queue.queue,
> +					      stream->queue.queue.type);
> +				mutex_unlock(&stream->queue.mutex);
> +			}
> +		}
> +	}
> +	mutex_unlock(&uvc_pm_mutex);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block uvc_pm_nb = {
> +	.notifier_call = uvc_pm_notify,
> +};
> +
>  /* ------------------------------------------------------------------------
>   * Module parameters
>   */
> @@ -3291,8 +3338,15 @@ static int __init uvc_init(void)
>  
>  	uvc_debugfs_init();
>  
> +	ret = register_pm_notifier(&uvc_pm_nb);
> +	if (ret < 0) {
> +		uvc_debugfs_cleanup();
> +		return ret;
> +	}
> +
>  	ret = usb_register(&uvc_driver);
>  	if (ret < 0) {
> +		unregister_pm_notifier(&uvc_pm_nb);
>  		uvc_debugfs_cleanup();
>  		return ret;
>  	}
> @@ -3303,6 +3357,7 @@ static int __init uvc_init(void)
>  static void __exit uvc_cleanup(void)
>  {
>  	usb_deregister(&uvc_driver);
> +	unregister_pm_notifier(&uvc_pm_nb);
>  	uvc_debugfs_cleanup();
>  }
>  
> @@ -3313,4 +3368,3 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRIVER_VERSION);
> -
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index f6c8e3223796..2c57b7042856 100644
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
> @@ -2151,11 +2152,27 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
>  	if (!uvc_queue_streaming(&stream->queue))
>  		return 0;
>  
> +	/*
> +	 * Defer restarting the streaming hardware during the transient THAW
> +	 * phase after a hibernation snapshot has been created. If writing the
> +	 * image succeeds, the system powers off and the restart is not needed.
> +	 * If writing fails, the PM core notifies the driver before userspace is
> +	 * thawed so deferred streams can be restarted.
> +	 */
> +	if (pm_hibernation_snapshot_done()) {
> +		stream->hibernate_resume_deferred = 1;
> +		return 0;
> +	}
> +
>  	ret = uvc_commit_video(stream, &stream->ctrl);
>  	if (ret < 0)
>  		return ret;
>  
> -	return uvc_video_start_transfer(stream, GFP_NOIO);
> +	ret = uvc_video_start_transfer(stream, GFP_NOIO);
> +	if (!ret)
> +		stream->hibernate_resume_deferred = 0;
> +
> +	return ret;
>  }
>  
>  /* ------------------------------------------------------------------------
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 0a0c01b2420f..c87eaaaf2749 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -475,6 +475,7 @@ struct uvc_streaming {
>  
>  	/* Buffers queue. */
>  	unsigned int frozen : 1;
> +	unsigned int hibernate_resume_deferred : 1;
>  	struct uvc_video_queue queue;
>  	struct workqueue_struct *async_wq;
>  	void (*decode)(struct uvc_urb *uvc_urb, struct uvc_buffer *buf,
> @@ -604,6 +605,7 @@ struct uvc_device {
>  
>  	/* Video Streaming interfaces */
>  	struct list_head streams;
> +	struct list_head pm_list;
>  	struct kref ref;
>  
>  	/* Status Interrupt Endpoint */

