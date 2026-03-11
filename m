Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D73AE6EC
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214310; cv=none; b=AxM4bMtCuVjjprfvXR83wR/Q9Jd6nyYuKCSRggrHXrr2xQsLfPUAWLNT13vzsjPpoodQnzChnMX7FFleK+OS+p1ncwSP4Zxb0Xgh7y2g2a/LsTw2u05R7iNAzaixQux0jwx0xgG8fPWRK/wgB8nvvDb4qFcHiZt89ttUs1NNFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214310; c=relaxed/simple;
	bh=3V4xHLccw4r7xXUFmzGLCC246uQfgynbB+kat8hm+Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqyVaELhZsGbRpX1p4acEV+Kq8io35ByZVIN0DfRWl4zQheanrf8kAfo49Bw7hjWXBahk8lK6h7wSN4oJfpp0Z1bcwMnZdayeDI9/at8Q1ifi8WVhzxIjFi01apPdGpjIgxB4bjK+xC7a91OsE2qZ66yCW8lPq+19SryujLD/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFVjoH0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFVjoH0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B397EC2BCB2
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 07:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773214309;
	bh=3V4xHLccw4r7xXUFmzGLCC246uQfgynbB+kat8hm+Bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CFVjoH0kIm7TgHiBi2WgNXveLq1CZfPSaXIF9qI7Xt7Hr6Hop9QSbbDrR0PlwhNT/
	 7VZu9JHaOecyn6gXGe68L1rsGqG2+i9oomt8UqOCu+FC5sJoyV13ycuupFl/Jk3O4K
	 uwewpZod5ZRoVz9uBprcK85QHt10kgJKi9HfTsN5iaM74LYGPvEZ+mK706UVbIy03t
	 oAQ1Uhshk9Ntt05Rc3vBAz22v4RaUXCnqR3S55SDfYMY0SpR3Tz3eecbo/9UETbkxC
	 KEHoioDqc7O4MJF5UVSu6nIOYj84w3uP8SsM+E/z6ZfaXurVbazpx8q/z2/JbYSq9V
	 wnQ/QY/oaKxcA==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9c8f8783so759572d50.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 00:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWf6D3yHMR+4bzH/z670UE8MPzzolqiB2XEMhz7QWst/1IJ6+vYZmkQD6ntxfPjMOP5OQj1IYtOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY0rvEOKl8u0AYfMrMVz4qESJLB1fxEOmJzaW7OgB7SYYwcJW
	jQ26bIPj9iRdC2qoPD5mqWTXV2SUIcZ8QANuEpn9MVNeWKHlp9Xz1ZHLwDP9TTh7BhIGkolaQUv
	zFHGJff9R9l7xVqX6IuLGf1ANV4nfzLExEfh7ssLfKA==
X-Received: by 2002:a05:690e:1347:b0:64c:9bf0:3055 with SMTP id
 956f58d0204a3-64d656602afmr1277629d50.6.1773214308943; Wed, 11 Mar 2026
 00:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306024608.1720991-1-youngjun.park@lge.com>
 <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
 <aaqKJQeO8wLQL7Zn@yjaykim-PowerEdge-T330> <CACePvbVp=9PM=LUdL=aq8G2Svy+v04pBnf3ygRY+xW3WEHNm9A@mail.gmail.com>
 <aa551UFgiq+gUl/T@yjaykim-PowerEdge-T330>
In-Reply-To: <aa551UFgiq+gUl/T@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 11 Mar 2026 00:31:37 -0700
X-Gmail-Original-Message-ID: <CACePvbW_t+dqFVZfde6aXxbREaX4iiSxd4knFGKQyDkbxprH6A@mail.gmail.com>
X-Gm-Features: AaiRm52Adgj8vkv6Psup88AW1ywMhrtnpWIBzQ3U1LbmgXHrKe1Ii1Zg4gMoYBU
Message-ID: <CACePvbW_t+dqFVZfde6aXxbREaX4iiSxd4knFGKQyDkbxprH6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device reference
 across swap operation
To: YoungJun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, kasong@tencent.com, 
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org, hyungjun.cho@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 12:42=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Sun, Mar 08, 2026 at 11:43:20PM -0700, Chris Li wrote:
>
> > Agree. That place needs fixing. We will make two patches.
> >
> > Patch 1. Fix the swap off  racing between lookup and first allocation
> > on suspend.
> > swap_type_of() is very tricky for the device swap because of the
> > conditional lookup of the si->start_block matching the offset or not.
> > That make this patch very complex.
> >
> > One idea to brainstorm:
> >
> > So we can get the reference count on during snapshot_open(), after
> > checking "root_swap" still points to valid swsusp_resume_device.
> > Then we release the reference count on "root_swap" during snapshot_rele=
ase().
> >
> > That might side step the complexity of  swap_type_of() doing the
> > si->start_block checking.
> >
> > It should fix the bug you described here more simply.
>
> While that approach would be great as a minimal fix, I think we still
> cannot avoid the following situation.
>
> Until the first swap offset is allocated, we cannot guarantee that swapof=
f
> won't happen. To be safe, I think it is difficult to prevent swapoff
> without holding the swap_lock.

Grab the swap device reference at the beginning of `snapshot_open`,
before any swap_offset allocation, until `snapshot_close`. That should
prevent the swapoff? The swapoff must wait until the reference is
dropped at snapshot_close().
I assume the swap entry allocation happens between snapshot_open() and
snapshot_close().

> So, to stick to the minimal fix principle and only address the currently
> possible bug in uswsusp, we could consider:
>
> 1) Creating a separate function to grab the reference for uswsusp, and
>    put it in snapshot_close().
Ack.

> 2) Adding a parameter to swap_type_of() to decide whether to acquire the
>    reference or not, and put it in swsusp_close()

In my mind, shouldn't the first point 1) be enough? Not sure 2) is needed.

Chris




>
> On all strategies, we do not grab the
> reference when taking an in-kernel snapshot, and do not add alloc/free
> get/put.
>
> > > My proposal is to grab the reference at the lookup point to close thi=
s
> > > initial race.
> >
> > That is my suggested patch 1.
> >
> > > If we do that, I believe we can remove the per-slot
> > > get/put calls entirely, as the initial reference is sufficient to kee=
p the
> >
> > I suggest that as the patch 2. It is an optimization to eliminate the
> > get/put pairs. It is optional. without it is fine in terms of
> > correctness. Might not worth the trouble for patch 2.
>
> Yes, I agree. I will split the patch into two as you suggested and think
> about it further.
>
> > > device alive until the operation completes.
> > >
> > > Regarding the reference release strategy in this patch:
> > >
> > > 1. uswsusp: The reference is released when the snapshot device file
> > >    is closed(snapshot_release) and error paths.
> > > 2. not uswsusp`: I only added reference release in the error paths.
> >
> > That part makes this patch complex and harder to review. Need to
> > carefully check whether we take the reference count or not.
> >
> > >
> > > About 2.. I conclude that on a successful resume, the system state re=
verts to
>
> > > the snapshot point, making an explicit release unnecessary. However,
> > > I am not 100% certain if this holds true for the swap reference
> > > context.
> >
> > That is the part I try to avoid: the very fragmented error condition
> > for reference counting.
> > Hopefully, with patch 1 idea we don't need that complexity.
>
> I agree with you.
> But, I believe it can be a safe modification that can be sufficiently
> verified through review.
>
> I would love to hear the thoughts of the hibernation maintainers and othe=
r
> reviewers on this. Although there are some complex parts, I think this
> modification has clear benefits.
>
> Thanks
>
> Best regards,
> Youngjun Park
>
