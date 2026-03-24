Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34F274B4D
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331620; cv=none; b=QNDYq7AP6XqctxDeMFSmnxEutEGVQ/qgCXm3E9sojyEMq/yWrfHl7xi1GMyAtr23/I3Du+kZXd2I8T4rRRu1L2tsgOrB9B3mW0DR94PWP3YKoE/Rmuz97z4E+biEMj0ZoJabHwIk8VUrSvpqs/PwWxSjs5EGLKuQ0kRlvgAepK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331620; c=relaxed/simple;
	bh=ovU9FIMdPboyZUBnOOMg6cl+QBtI03tFkK3Z0PkwlKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY1tv+Po/oAzakPsDocJ+ffiFgxbwTsAC/kbrnXqZ/TIx9Reiz4Pwp9ijLpVZDxR1rd/pExnizxnVOV3N0wrkyIwpsA+cw9odx2Px5awDgOSw3eDGlsdnTFsU6WUQum7HozFOysThbYeBrWygTPTmIz1qbPe2ujOfpIujtUpp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/MOkSRq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/MOkSRq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9516a653so4361465ad.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774331619; x=1774936419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzbNzyvofSkHDrmxsguNNuZmsCaCuOfcET+64uHO95w=;
        b=S/MOkSRqmM+IXt4Tmr7FemVApCsNMenLN0yctJniGmEY24SSkYQcw7fujHZAkR3xT5
         N6YOnPVPzv6oiWMGXt9X+Wdi9+GZQbhjOM6XcCOXmI24dIpdWqBx+7JR/NSQ1yKAxEtB
         a8iW6A3YVK7pRhh6EFXyUtmei3xeeeSc1EhrEUhp2wD7+4zYBSiFOdxcSeRKzEObk8V+
         AVITKYe1QxuRo5Tz+/dskxjtmK3y+LnA65xln2FL/yHxoZ8cPJr6C9nqWhIeBT3qMgf/
         TlEdL26u4lmNgg191ARaPgkY9qz7215mSEH/G7DTRC1X3c5mrr90mYgcolCBYHtDKGAr
         rExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774331619; x=1774936419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzbNzyvofSkHDrmxsguNNuZmsCaCuOfcET+64uHO95w=;
        b=FGCQgoGqhNPuPzBXDsumaz1KI7HMlCthRTj0qZy15eNveg3jMDjT0jG44wMQMsKtyK
         jKC3+Zgr+qohl4xo3/C41goEr7zE66xVAyJ8A9kcq3TqJATaqvtzMHgxZwEVvsBBWhc0
         VYZgbXg+Weqq1tlm83mo9kKYBfzgKrjF9j6R7C+G4ma1gIX0hxdpHqwXFhNLhRGkgTua
         LMOTRcKBgHDR33rMyKUtPx/x9HkWd8mDKhLfXGJVXu0FKHaBWLdrgD9dn22hHSW92Q1Z
         Vn+a7A1R2C/yUHx3wSCzrCy7VGn+hpb1AfJcFUs20zWCjOQkEUi/83uVd0+BcVLpEfPL
         EjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWLfHigrW7TQbNtQ7NRgLrgnEhGuaRKRXgshpeqIUPoaWI6UX8t/nb7r/myuI6MairMS60pSjfoNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8UKfkjkEl5CN3iRky4l9G9wBlCIQWYikI4qflMuLGeX1Jxgu
	IvwQ4VOf41+OSjvkoB/iUQO4TM+SlZZwErCdL1cXQjtfi+WNnwiFdtrGaj7E1TL/B4c=
X-Gm-Gg: ATEYQzwUgxynLSrgnABv3og38LrFgB+E1g6W/37t1tCqQFXqdR0cphUTtQ6cRF4Vpw7
	vKj9tGjYeTct+h1JzqofHAbYoLCPrnN/9ea6apnMM9eCZk5L2NVfCWJZt68b8EE/MYqf7ix+Kfd
	sFa5gNmSZm5+LcUJV3j9qTBflYbkMqWGQWBLpCRx9ogd8Oc1agBSk+W3s3XFUr86FS/3EOLYTIP
	NpLLMmHTD7A7RnpdP9h+1Qw8eoGmwKAKcKndhAhkNYkbmVJfhRfMomG2WJhRPZ4DxXm6EH9rsIM
	WyTax1bQtuIGEWj8uECQ4BkGymoCnGnMWd8q+izQSaH7IVzOjdftvDny9VyU6ygEx0t3z/n91G0
	m4X6TE/n3XK2iPmOeZGuyRvU0gDBA45/xA266QXwQj+/3ANJM3kQNV4tOYiNMxEajf92kIIfp6A
	rwHOH82gf1JtkMkVwvKF4vf2QaUsHCp5/766u2L44bzh5rLh4Ogs+BLCW/AJuCAiQMo/b1
X-Received: by 2002:a17:902:d582:b0:2b0:708f:4dc7 with SMTP id d9443c01a7336-2b08278afb0mr138908715ad.29.1774331618826;
        Mon, 23 Mar 2026 22:53:38 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516194sm128476465ad.4.2026.03.23.22.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:53:38 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:53:33 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Pavel Machek <pavel@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 1/2] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by pinning swap device
Message-ID: <acH_svpUwaNtFeJN@KASONG-MC4>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
 <20260323160822.1409904-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323160822.1409904-2-youngjun.park@lge.com>

On Tue, Mar 24, 2026 at 01:08:21AM +0800, Youngjun Park wrote:
> Hibernation via uswsusp (/dev/snapshot ioctls) has a race window:
> after selecting the resume swap area but before user space is frozen,
> swapoff may run and invalidate the selected swap device.
> 
> Fix this by pinning the swap device with SWP_HIBERNATION while it is
> in use.  The pin is exclusive, which is sufficient since
> hibernate_acquire() already prevents concurrent hibernation sessions.
> 
> The kernel swsusp path (sysfs-based hibernate/resume) uses
> find_hibernation_swap_type() which is not affected by the pin.  It
> freezes user space before touching swap, so swapoff cannot race.
> 
> Introduce dedicated helpers:
> - pin_hibernation_swap_type(): Look up and pin the swap device.
>   Used by the uswsusp path.
> - find_hibernation_swap_type(): Lookup without pinning.
>   Used by the kernel swsusp path.
> - unpin_hibernation_swap_type(): Clear the hibernation pin.

Looks good to me, thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>

Just one trivial nit picks below.

> +/**
> + * unpin_hibernation_swap_type - Unpin the swap device for hibernation
> + * @type: Swap type previously returned by pin_hibernation_swap_type()
> + *
> + * Clear the hibernation pin on the given swap device, allowing
> + * swapoff() to proceed normally.
> + *
> + * If @type does not refer to a valid swap device, this function
> + * does nothing.
> + */
> +void unpin_hibernation_swap_type(int type)
> +{
> +	struct swap_info_struct *si;
> +
> +	spin_lock(&swap_lock);
> +	si = swap_type_to_info(type);
> +	if (!si) {
> +		spin_unlock(&swap_lock);
> +		return;
> +	}
> +	si->flags &= ~SWP_HIBERNATION;

Will the code will be simpler if you just:

if (si)
	si->flags &= ~SWP_HIBERNATION;

Just personal taste, free feel to ignore.

And as you mentioned this is on top of swap table p3 so you based
it on mm-new - but isn't p3 already in mm-unstable? Maybe we can
have it there? Not sure how much conflict are there with PM.

The code and design looks OK.
