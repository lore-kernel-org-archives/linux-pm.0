Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7137883E
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321518; cv=none; b=Kcw96inhGuys8A/J8ef1r1yS+ONK9FxDuFC4SmqYl8au49uD4jjSjxH4FulNSQA4D4b27v1QisF7N04QI4VTuCzn1UhOilB4MomhVrWsbFlWwzWkMiULn9TkT5PW75ngbASks1DU329LhEz29HlVfKRiRe8aZAKnMlNuYuo0IaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321518; c=relaxed/simple;
	bh=OzuuDAIy99YZMkinN0KNk/KNpMlii3T/YsL6d4inR2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV7yApuRjN26BnqMEaKnrFu+s42Wc23MlQHq5G/uCKgZP9ri/IMvtZ11WGs8xijYeF7m50j1cJvqsclhvbwA7GRH2XmbO7Kn71uEXcF9y/fezgmc84kTPk6/7W8fACDcDAnqJYWAaweN5KyqzcM80nEAIIZ+2hyBwmnnMEvzfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 16 Apr 2026 15:38:24 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 16 Apr 2026 15:38:24 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: align default resume swap with
 image-device checks
Message-ID: <aeCD4H1CMpn1qKsK@yjaykim-PowerEdge-T330>
References: <20260415081213.1732019-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415081213.1732019-1-charsyam@gmail.com>

On Wed, Apr 15, 2026 at 05:12:13PM +0900, DaeMyung Kang wrote:

Hello DaeMyung again :) 

> snapshot_open(O_RDONLY) pins the configured default resume swap area for       
> hibernation image writes, but it does not fully propagate that choice to       
> the image-device checks used by the block layer.                               
>                                                                                
> In particular, snapshot_open() uses swsusp_resume_device without               
> swsusp_resume_block when pinning the default resume swap area, and it          
> leaves snapshot_state.dev unset even after the pin succeeds. As a              
> result, the default resume swap selected at open time is not kept              
> aligned with is_hibernate_resume_dev() and can still be rejected by the        
> block layer in blkdev_write_iter() with -ETXTBSY until user space              
> explicitly selects the same area via SNAPSHOT_SET_SWAP_AREA.                   
>                                                                                
> Use swsusp_resume_block when pinning the default resume swap area and          
> record the device immediately after a successful pin so that the               
> hibernation image-device bookkeeping matches the configured resume             
> area.  Also clear snapshot_state.dev on the open-time error path so it         
> never advertises a session that failed to fully open.                          
>                                                                                
> uswsusp itself is not affected because it always calls                         
> SNAPSHOT_SET_SWAP_AREA right after open, which immediately overrides           
> snapshot_state.dev and re-pins the swap area.  The user-visible change         
> is for minimal hibernation user space that relies on resume= and               
> resume_offset= alone: such tools no longer have to restate the resume          
> area via SNAPSHOT_SET_SWAP_AREA just to satisfy blkdev_write_iter()'s          
> IS_SWAPFILE gate or to obtain SWP_HIBERNATION swapoff protection.  This        
> also matches the intent of the existing "The image device should be            
> accessible" comment in snapshot_open().  For the configured default            
> resume area, this gives snapshot_open() the same pin and                       
> recorded-device state that SNAPSHOT_SET_SWAP_AREA would establish for          
> that same area, so user space relying on resume= and resume_offset=            
> does not need a follow-up SNAPSHOT_SET_SWAP_AREA just to satisfy the           
> IS_SWAPFILE gate and obtain swapoff protection.                                
>                                                                                
> Signed-off-by: DaeMyung Kang &lt;charsyam@gmail.com&gt;                              

So, to summarize: if the resume area and offset are fully specified via
kernel parameters, it should work with hibernation image write properly with just snapshot_open()
without needing an explicit ioctl call, right? And since uswsusp
hibernation tools currently use the ioctl, this hasn't been a visible
issue so far.

> Based on linux-next/master at commit e6efabc0afca ("Add linux-next             
> specific files for 20260414").                                                 
>                                                                                
> Tested in QEMU: with swap on a block device pointed to by                      
> /sys/power/resume, opening /dev/snapshot O_RDONLY and then writing to          
> the swap block device returned -ETXTBSY before this change and -ENOSPC         
> (i.e. no longer rejected by the IS_SWAPFILE gate) after.                       
>                                                                                
>  kernel/power/user.c | 8 ++++++--                                              
>  1 file changed, 6 insertions(+), 2 deletions(-)                               
>                                                                                
> diff --git a/kernel/power/user.c b/kernel/power/user.c                         
> index d0fcfba7ac23..c51b8185de4b 100644                                        
> --- a/kernel/power/user.c                                                      
> +++ b/kernel/power/user.c                                                      
> @@ -69,9 +69,13 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>       data = &snapshot_state;                                                  
>       filp->private_data = data;                                               
>       memset(&data->handle, 0, sizeof(struct snapshot_handle));                
> +     data->dev = 0;                                                           
>       if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {                           
>               /* Hibernating.  The image device should be accessible. */       
> -             data->swap = pin_hibernation_swap_type(swsusp_resume_device, 0); 
> +             data->swap = pin_hibernation_swap_type(swsusp_resume_device,     
> +                                                   swsusp_resume_block);      

I might miss this situation, just using tool as you explain it. 
(cuz it uses ioctl always internally). 
Thank you for catching and addressing it.

For checking, it is side effect of my patch,

I check my patch and did some code archaeology to check the history, and it seems this
behavior (on the snapshot_open handler) has been there since the beginning (around v2.6.20).

1. Passing 0 as the offset parameter
2. Not setting data->dev

Both seem to originate from:
commit 915bae9ebe41 ("[PATCH] swsusp: use partition device and offset to
identify swap areas", Dec 6, 2006).

Shortly after, the SNAPSHOT_SET_SWAP_AREA ioctl support was added in
commit 37b2ba12df88 ("[PATCH] swsusp: add ioctl for swap files support",
Dec 6, 2006). 
This ioctl patch sets the offset and dev from the user appropriately.

Maybe I am wrong or miss somthing. Please correct me or double-check.

If my understanding is correct, this patch looks like a valid improvement.
It also seems to address an issue that has existed for quite some time.

However, I'm not 100% sure whether the original behavior was intentional, 
It would be great to get additional reviews from others.

Best regards,
Youngjun Park.
