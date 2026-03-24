Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753B3C6607
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335012; cv=none; b=aP7XswHwIc11A5rliNB8AghvVVywwmWgnVaWNU6M/bvVPQB1GGe0pQ6NmQMrSMh5ecOdn31DcqPk8u/I9Q0qYiBS2QwQwXuy1mqEJWzklJKiQOrIvuSq22z5jVV0iceKDOxVD23oxBZ1rj+XHxsRrZvK8ofD7U3vNXh0Fdzqnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335012; c=relaxed/simple;
	bh=mwFOGE+bU77F79Y64GOx+68vYMTCo8BK19WdU3ivPxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+KxqJQ2zGEuyh7ggTslDMv+hVh3d81slL8LMaW4iPtnkU0jOpgiTfupNf8ufbtNRa8ln0NMPHcNKr0ofVj4h8BwIlNmGcnGOjqYfVg+iYxSdyHpCuGo3kAftZoOXVr1HJgfPQ0Bg9/va+WuB0eLXXkIvjBhUf6YGxj3t7SYFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6HGHKCO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6HGHKCO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aecefc7503so37396135ad.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334998; x=1774939798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BtRgbo5SYoBF3YUHMOjmQ4qRhqYMdpWB9iGrbsQFLk=;
        b=H6HGHKCOgu+u4u4AuZvbhWfyBwdNt/LnAr30srgWx2PX3IzN41usgMbLEHlgRoUrNw
         O0nT2CsIwXxb7BEoCi8lfIlF7prpXjESr7TohcmPssZ1rUdUUVwzskiVDVQ2fPZQyELi
         QcnUNDc2Pl2aNkUi2aUBsCSRtWeeKFCHeiTnVQCXmW2I3Djt27WCfG4uxV7U8P1kq3Wg
         7QEIc1uYJnyRq2RAJliH/u+4e0x0eeL1Z4KsK5Y6jokBUAq7ZMFYqq5Ta0r0IPwCRllC
         j7OOk1TjvEpYoBlyt6lNluaz4x5D4/bWSQYgJsidE1/FMwsmdekhIDDpH+ArKyESyPo2
         sf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334998; x=1774939798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BtRgbo5SYoBF3YUHMOjmQ4qRhqYMdpWB9iGrbsQFLk=;
        b=s4cvt+Q8dcWNz6Ne7KxNDZ49QeK7jG2erD4yerT+MH9B/1MrTTtvBXITnaRSa0NyV+
         u4wu50oWEjkkDcabixe22wdB3SncHX6I0JdmDI0KEKfEbAn5vaM8svcQ9pFX+9vUZ9Qy
         PQnvKvbAwOEM4iXg1sv52fsTxfTLqsLHRpMPc+eevGV++8U0D0CXwcA6CMeUyHoWa0vx
         zqfBkK5YgyLaMAh435U7qo7k7lCM8z3V5Pn09PPAWf1SNpYaqUazfuQrd8VeQz64rR7J
         Oz5Y1ST+HTVBfUUh/PdSMhVKfyxoBmGKnICbS12+eTkHegnwlxSP0cwmiC5+nbsZEM7r
         9Xww==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9O7nKHyyoIhiYqU7FJOLRQZ5q0Wn48P0egHGYVCmF9LKvd5gpyu0g9BbIb/uuE5gy+15fZrX1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99Rrgx5UhdIDIQU0oi33LQaMctXznNOYgDJUAADHORteoaiip
	UoA/xKVWnE/zgvxPzWgY3GJZLliIHJ2iDlp04GhjG+IO0Q9rGrsDFO26
X-Gm-Gg: ATEYQzzLuz5xhblE+9AriIMZA+lIwYz2YDv+dwNyJBg4WdaEqag+/gimF+augHusvz8
	GNpZc0cMkxeXiOSYq5Mui6Oj1KfCC/jN6LKoLJHxZHhfF7fwMYqAfvzHF1Qr3yZRFV1RZ1tv8uE
	95SMy9nmnn/H3/XUeXYWvCK8KlIqj15nhS19xLJhv0ipNLYGQth3PEwOx8AYhuscrBAyUPVHNu2
	6bfVsm2rQFMA8PNo8ezUMj48AaCTqV1ihOLhtrLzC1kH3JYkWqMb3SHDHLIULIjVsyXDTzvShkh
	23Raxwj8tVqP4A7bF8Xt/iiCnxN2ahnrCJeOj13yj2ZY5Vh99lm6TIAuZfK7602okzXz7iLywux
	yjwClvCx9Hb1Sj/QVL/LEswW1tsNZbMSnqs7Z87+fvd6Kc8LfRzwFZTCCkftFsMqk/02+JF22rc
	o6A8aoN9gHNuaV7uu+zUA+u8wq73YBfTzd8nXAMf2TWh0IwTiD0QiO00NPZ2at6JELi7px
X-Received: by 2002:a17:902:f70e:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2b08277b109mr133450355ad.29.1774334997612;
        Mon, 23 Mar 2026 23:49:57 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b45sm180639635ad.42.2026.03.23.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:49:57 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:49:52 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Pavel Machek <pavel@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 2/2] mm/swap: remove redundant swap device reference
 in alloc/free
Message-ID: <acIm_7vtj4XETdyP@KASONG-MC4>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
 <20260323160822.1409904-3-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323160822.1409904-3-youngjun.park@lge.com>

On Tue, Mar 24, 2026 at 01:08:22AM +0800, Youngjun Park wrote:
> In the previous commit, uswsusp was modified to pin the swap device
> when the swap type is determined, ensuring the device remains valid
> throughout the hibernation I/O path.
> 
> Therefore, it is no longer necessary to repeatedly get and put the swap
> device reference for each swap slot allocation and free operation.
> 
> For hibernation via the sysfs interface, user-space tasks are frozen
> before swap allocation begins, so swapoff cannot race with allocation.
> After resume, tasks remain frozen while swap slots are freed, so
> additional reference management is not required there either.
> 
> Remove the redundant swap device get/put operations from the
> hibernation swap allocation and free paths.
> 
> Also remove the SWP_WRITEOK check before allocation, as the cluster
> allocation logic already validates the swap device state.
> 
> Update function comments to document the caller's responsibility for
> ensuring swap device stability.
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  mm/swapfile.c | 68 +++++++++++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)

Thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>
