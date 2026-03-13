Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052C3932C8
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408030; cv=none; b=XN1VdEqsjjyBqh+vWmLOs34qhKAGfm9uohi1DBgFNCQTZ0zDQh131lzAxwWth50bTQXFSNTZRX+NO/bBGylgge3GtmlLmStgslcCts/MqfO/OsCCwHk4Th8tzq9TcPrSr4KUAnDa8xplLC3nX3D8UcZExtj/CQ7jHljmgu4IjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408030; c=relaxed/simple;
	bh=hUnA+rIPkW1wM0a8bkjeSRBzeMwug1gurq+k8zxB9Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUZmPR/321li1WCS1AAnCDb0OEV11FWAG3T2FggUQerYre2dEIpmcfnl69ZJ06gJwNBXkySJeMvBHjy024k974qpVGvswrybV+F9+IJO9zfYnCpbsLOpnmQXUcS40w0lE7m5GueTKZLwzHsVcJF0pki2oIc0jaafQmouD30hKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UksqfsnE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UksqfsnE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-827270d50d4so2069851b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408028; x=1774012828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtYxAWvnxsRsKhiXmWj0Ro8VXp9REalj1qqx623yKyQ=;
        b=UksqfsnE0DlvGCK7uND3YOCW9Xyhl8m1hGlvBsgqO2aOfKOsLlAZC8k5hD1tjaumaX
         8HmfUfFAtywViA43KpEBsk8RQGX5lYYS3hPxNQ+g0gnqN3CiA8jFLBxSNkFEqV0V6Czl
         Ty0JW06r9SCTu8Uwv8jB7Bi3YohkiYOJnj0R4pmjlFkCb0ieD+OvTnnaLp5rdABKOj0m
         CNFDT2N1JWP7zS1geYwperAPaMh70o3nSumIYKpejAuNhya69LM34elvpsU6ILB9C+wc
         kYZK2ptMWelpAOiW5mt4tkHt0mgih6ZORSiMj0IGA5StMjJIb1CvkYam2RLNJfwTC7OZ
         oczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408028; x=1774012828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtYxAWvnxsRsKhiXmWj0Ro8VXp9REalj1qqx623yKyQ=;
        b=O+DdV2OUPhhiY12EFSs6LpDntI5QqIeCwnnbSSzUncjIb69eCVIXBQD9pjBsS4LJZl
         McWs2Xsx4Uxadck6rsp5U8PIy1HQMgdCPMQKDEA94OFov46UB2cLchAC5f+vUPSJIXJG
         7INmTEcKm6nxgw5BDVqXcO6kDhLDKI/ojQrQCE2SFVwrxIvViAlbAj6lCAZdNFmErSkv
         bUt7HKws6q+0WlrQDSm2/xSsHLQJhhPbzB/Cpa6wZqxrvwemW/dMzx0sbbvgsTZj7F03
         e1FRpTCSAXmjDPdLRFIBjWVWr1JQ4asYuej6tn0S8ALWui+0SrHbK9k/Qnni1MdK+CCt
         i3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1Dl4OrIiF7KYGoDYqCCvKBY75sQgIMd5xZkJmDMrjHGsmyPkp4R+suOiJq6GWAEgEqAJlO04ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eVcKm8AsGqoj1TwKx0HnVZ3r0zjMWCfApt3fUNeczYXPS4Na
	gLAJM6Mmcpg52i039BG0Hy5SKLjNs1QVq92QKT8Lsqnb7ioLSoiLfqfI
X-Gm-Gg: ATEYQzz7ptmj/A6i9PP/uvkkzgtp3E0E4hWCD+2Idug9BKBqvOCwgrCkM0CFKouANbo
	Co4ff5QTMkXE5GDUFTTMBHN9ugE5lY8P7G6Ji/Yln/v/j+ESUwX44ve54ZlSLYEVG8Je6wBTBn2
	reb6r/VMvlSY1TQXtfWVGnJ586Mm2G32NYFKy1XVLxzFQyHYun/vtkvtCNuQQLp+biccjGiZb6m
	vtibvSGbVe5Z9ewNgJriJ37OwTMlx9G0Zn4l5lpdCy0GlvnJxFmBw4APJMeSFYqBvxnyGQwN2hD
	c9vEMvZoID8j7gav+MymHQbkEhIZtOFEwOBb+S7qbTnOdlXZAHIqvnaAHkBNG1HLT9acBpoF96q
	wI1AE4WM/J7gSXZQT9UZkyPMa3RoTgeFiZ6Fu1FSabwsM/NJ5hJ4COBqpRhZJec67PmeaNmktlW
	RSWwseGg3i6JMb/b3IywFcqDxgRlOpdectpWkl1L2HBqF7+T08eLHWGfDMdgs=
X-Received: by 2002:a05:6a00:3699:b0:829:72f5:29da with SMTP id d2e1a72fcca58-82a19704709mr2714792b3a.11.1773408028404;
        Fri, 13 Mar 2026 06:20:28 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07382e6csm5967044b3a.54.2026.03.13.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:20:27 -0700 (PDT)
Date: Fri, 13 Mar 2026 21:20:22 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RESEND RFC PATCH v3 1/2] mm/swap, PM: hibernate: fix swapoff
 race in uswsusp by getting swap reference
Message-ID: <abQMiv6Y4WEKTLng@KASONG-MC4>
References: <20260312112511.3596781-1-youngjun.park@lge.com>
 <20260312112511.3596781-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312112511.3596781-2-youngjun.park@lge.com>

On Thu, Mar 12, 2026 at 08:25:10PM +0800, Youngjun Park wrote:
> Hibernation can be triggered either via the sysfs interface or via the
> uswsusp utility using /dev/snapshot ioctls.
> 
> In the case of uswsusp, the resume device is configured either by the
> boot parameter during snapshot_open() or via the SNAPSHOT_SET_SWAP_AREA
> ioctl. However, a race condition exists between setting this swap area
> and actually allocating a swap slot via the SNAPSHOT_ALLOC_SWAP_PAGE
> ioctl. For instance, if swapoff is executed and a different swap device
> is enabled during this window, an incorrect swap slot might be allocated.
> 
> Hibernation via the sysfs interface does not suffer from this race
> condition because user-space processes are frozen before proceeding,
> making it impossible to execute swapoff.
> 
> To resolve this race in uswsusp, modify swap_type_of() to properly
> acquire a reference to the swap device using get_swap_device().
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  include/linux/swap.h |  3 ++-
>  kernel/power/swap.c  |  2 +-
>  kernel/power/user.c  | 11 ++++++++---
>  mm/swapfile.c        | 28 +++++++++++++++++++++-------
>  4 files changed, 32 insertions(+), 12 deletions(-)

Hi, YoungJun

Nice work! Thanks for improving the swap part of hibernation.

Some comments below:

> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7a09df6977a5..ecf19a581fc7 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -433,8 +433,9 @@ static inline long get_nr_swap_pages(void)
>  }
>  
>  extern void si_swapinfo(struct sysinfo *);
> -int swap_type_of(dev_t device, sector_t offset);
> +int swap_type_of(dev_t device, sector_t offset, bool ref);
>  int find_first_swap(dev_t *device);
> +void put_swap_device_by_type(int type);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);

I think the `ref` parameter here is really confusing. Maybe at lease
add some comment that some caller will block swapoff so no ref needed.

Or could we use a new helper to grab the device? Or better, is it
possible to grab the swap device then keep allocating it, instead of
check the device every time from hibernation side?

The combination of swap_type_of & put_swap_device_by_type call pair
really doesn't look good.

> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 4401cfe26e5c..7ade4d0aa846 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -71,7 +71,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>  	memset(&data->handle, 0, sizeof(struct snapshot_handle));
>  	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
>  		/* Hibernating.  The image device should be accessible. */
> -		data->swap = swap_type_of(swsusp_resume_device, 0);
> +		data->swap = swap_type_of(swsusp_resume_device, 0, true);
>  		data->mode = O_RDONLY;
>  		data->free_bitmaps = false;
>  		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
> @@ -90,8 +90,10 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>  			data->free_bitmaps = !error;
>  		}
>  	}
> -	if (error)
> +	if (error) {
> +		put_swap_device_by_type(data->swap);
>  		hibernate_release();
> +	}
>  
>  	data->frozen = false;
>  	data->ready = false;
> @@ -115,6 +117,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
>  	data = filp->private_data;
>  	data->dev = 0;
>  	free_all_swap_pages(data->swap);
> +	put_swap_device_by_type(data->swap);
>  	if (data->frozen) {
>  		pm_restore_gfp_mask();
>  		free_basic_memory_bitmaps();
> @@ -235,11 +238,13 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
>  		offset = swap_area.offset;
>  	}
>  
> +	put_swap_device_by_type(data->swap);
> +
>  	/*
>  	 * User space encodes device types as two-byte values,
>  	 * so we need to recode them
>  	 */
> -	data->swap = swap_type_of(swdev, offset);
> +	data->swap = swap_type_of(swdev, offset, true);

For example this put_swap_device_by_type followed by swap_type_of
looks very strange. I guess here you only want to get the swap type
without increasing the ref.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d864866a35ea..5a3d5c1e1f81 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2149,7 +2149,7 @@ void swap_free_hibernation_slot(swp_entry_t entry)
>   *
>   * This is needed for the suspend to disk (aka swsusp).
>   */
> -int swap_type_of(dev_t device, sector_t offset)
> +int swap_type_of(dev_t device, sector_t offset, bool ref)
>  {
>  	int type;
>  
> @@ -2163,13 +2163,16 @@ int swap_type_of(dev_t device, sector_t offset)
>  		if (!(sis->flags & SWP_WRITEOK))
>  			continue;
>  
> -		if (device == sis->bdev->bd_dev) {
> -			struct swap_extent *se = first_se(sis);
> +		if (device != sis->bdev->bd_dev)
> +			continue;
>  
> -			if (se->start_block == offset) {
> -				spin_unlock(&swap_lock);
> -				return type;
> -			}
> +		struct swap_extent *se = first_se(sis);
> +		if (se->start_block != offset)
> +			continue;
> +
> +		if (ref && get_swap_device_info(sis)) {
> +			spin_unlock(&swap_lock);
> +			return type;

This part seems wrong, if ref == false, it never returns a usable
type value.

>  		}
>  	}
>  	spin_unlock(&swap_lock);
> @@ -2194,6 +2197,17 @@ int find_first_swap(dev_t *device)
>  	return -ENODEV;
>  }
>  
> +void put_swap_device_by_type(int type)
> +{
> +	struct swap_info_struct *sis;
> +
> +	if (type < 0 || type >= MAX_SWAPFILES)
> +		return;

Maybe we better have a WARN if type is invalid? Caller should
never do that IMO.

> +
> +	sis = swap_info[type];

We have __swap_type_to_info and swap_type_to_info since reading
swap_info have some RCU context implications (see comment in
__swap_type_to_info) and these helpers have better debug checks too.

Maybe you can just use swap_type_to_info and add a check for
type < 0 in swap_type_to_info, and WARN on NULL in
put_swap_device_by_type. How do you think?
