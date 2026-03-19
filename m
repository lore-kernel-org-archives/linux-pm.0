Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE93B19A9
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927224; cv=none; b=V/vV7LX+A4smQb+fslJMoO0uIvR7MlILc5IdtLqf2LDnQjVMyPLrKSTzRELlt8HU8kE1u3W0EIpXIzAIp6KjsnYW+vH4HYzb3EQcCTzANR3MTc4Bu8+xxZqo56w3DuW4qsg2d1Vk02Vl362WlN7eT6i70oibR2oH+KigOtdaC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927224; c=relaxed/simple;
	bh=Dm5NKjKvqYl+3avboOzUu7vWJxbH+jX5bwpvt7ZbXmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwA6F9XzSPx5ZiWsbKVIwwq4th+y7fzx0xq/C+NbTttVtCy0B+a3Aq5k3UPgtQvCDXiDzbzO6JFiyp3IRf4C+UsGpEhA6zQAt/jVPpAkxXuvKyZVEhBj2qR4tBDPFITMQWCBaE8N1YAMgrw4g4VyTimff3hgUzw9MZoY+9nbLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBWCl3aS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBWCl3aS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3723C2BCB0
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927223;
	bh=Dm5NKjKvqYl+3avboOzUu7vWJxbH+jX5bwpvt7ZbXmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vBWCl3aSlRIt9q6Ez7UQVnyLA2tz01gTMvyrUfBQUTXeb8Eyu53iq24c8yLKzqzRL
	 qgW5hTvsTHYDjO7lU8liynoYG+bS5C1bhJlWzaHcT4bsrUwMzn+jLKcznFNElKELwE
	 Zd89QfmUjywogG+p5ZTFAxkO8MT0POs9JTZnqjyBRLXusP87oY7fB0nZ2tatMqhCZf
	 w3DwRcZtJ6zpDal/KDbyxVGqNi4RGIDll1QVnGGS0J8gE6VX8cFEh8ZsCvLkkNaPOa
	 AbvPxfM/74lR2f4MFmO+BvDXxHhMOvziuqozyzlH1Wp6TN8mS3bWYjkPE9uxoxfPtB
	 Xx3VubDVDYfUA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67ba5b0e00dso292304eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 06:33:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4MDlFQkGe8F/9alTkwCv9rgl3kmppjb5S6TxsbYQ7LM6EmvRoxpUQbFcNQOy8/fKjAsks+8Lf3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSM30NXKbjlnlQ1fNGOwwPeBOqvZgEu0OIPBJw4GvPALbvzl9
	nqOu0wKGFNIUtwvpjxdaeoCiq09fnrq5RJ9euO3kcp18ynAzQoNGVbCfHo0TV2MULi1vEWUVq8w
	BGCr6okxGVWsD6ZOBTu/Dtc9bguMlxMI=
X-Received: by 2002:a05:6820:2014:b0:67b:c368:135a with SMTP id
 006d021491bc7-67c0dabccf0mr5608217eaf.19.1773927222682; Thu, 19 Mar 2026
 06:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317181318.2517015-1-youngjun.park@lge.com>
In-Reply-To: <20260317181318.2517015-1-youngjun.park@lge.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2026 14:33:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iOh46gM9YVFnvN6bYcG5_kcqASqS+38brRg2BWAtOOzw@mail.gmail.com>
X-Gm-Features: AaiRm52jELOb6Ko_0-wwNDTuvZw8N5aHWBrJf9TOBTOkGixQcbO_z3u4Hjo8Jhc
Message-ID: <CAJZ5v0iOh46gM9YVFnvN6bYcG5_kcqASqS+38brRg2BWAtOOzw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:13=E2=80=AFPM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.
>
> Additionally, grabbing and releasing the swap device reference on every
> slot allocation is inefficient across the entire hibernation swap path.
>
> This patch series addresses these issues:
> - Patch 1: Fixes the swapoff race in uswsusp by holding the swap device
>   reference from the point the swap device is looked up.
> - Patch 2: Removes the overhead of per-slot reference counting in alloc/f=
ree
>   paths and cleans up the redundant SWP_WRITEOK check.
> - Patch 3: Fixes a spurious WARNING in the uswsusp GFP mask restore path.
>   (Founded during uswsusp test)
>
> Links:
> RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.a=
rif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
> RFC v2: https://lore.kernel.org/linux-mm/20260306024608.1720991-1-youngju=
n.park@lge.com/
> RFC v3: https://lore.kernel.org/linux-mm/20260312112511.3596781-1-youngju=
n.park@lge.com/
>
> Testing:
> - Hibernate/resume via sysfs
>   (echo reboot > /sys/power/disk && echo disk > /sys/power/state)
> - Hibernate with suspend via sysfs
>   (echo suspend > /sys/power/disk && echo disk > /sys/power/state)
> - Hibernate/resume via uswsusp (suspend-utils s2disk/resume on QEMU)
>   - Verified swap I/O works correctly after resume.
>   - Verified swapoff succeeds after snapshot resume completes.
>   - Verified pm_restore_gfp_mask() WARNING no longer triggers (Patch 3).
> - swapoff during active uswsusp session:
>   - Verified swapoff blocks while uswsusp holds swap reference.
>   - Verified swapoff can be cancelled by signal (e.g. Ctrl+C).
>   - Verified swapoff succeeds after uswsusp process terminates.
>
> Changelog:
> rfc v3 -> v4:
>  - Introduced get/find/put_hibernation_swap_type() helpers per Kairui's
>    feedback. find_ for lookup-only, get/put for reference management.
>  - Switched to swap_type_to_info() and added type < 0 check per
>    Kairui's suggestion.
>  - Fixed get_hibernation_swap_type() return when ref =3D=3D false (Review=
d by Kairui)
>  - Made swapoff wait interruptible to prevent hang when uswsusp
>    holds a swap reference.
>  - Fixed spurious WARN_ON in pm_restore_gfp_mask() by introducing
>    pm_restore_gfp_mask_safe() (Patch 3).
>  - Updated commit messages and added comments for clarity.
>  - Rebased onto latest mm-new tree.
>
>  Note: Kairui suggested adding WARN on NULL in put_hibernation_swap_type(=
),
>  but kept silent return instead, as type can legitimately be -1 when
>  snapshot_open() fails to find a matching swap device. swap_type_to_info(=
)
>  returns NULL for type < 0, so the cleanup path stays simple.
>
> rfc v2 -> rfc v3:
>  - Split into 2 patches per Chris Li's feedback.
>  - Simplified by not holding reference in normal hibernation path
>    per Chris Li's suggestion.
>  - Removed redundant SWP_WRITEOK check.
>  - Rebased onto f543926f9d0c3f6dfb354adfe7fbaeedd1277c6b.
>
> rfc v1 -> rfc v2:
>  - Squashed into single patch per Usama Arif's feedback.
>
> Youngjun Park (3):
>   mm/swap, PM: hibernate: fix swapoff race in uswsusp by getting swap
>     reference
>   mm/swap: remove redundant swap device reference in alloc/free
>   PM: hibernate: fix spurious GFP mask WARNING in uswsusp path
>
>  include/linux/suspend.h |   1 +
>  include/linux/swap.h    |   4 +-
>  kernel/power/main.c     |   7 ++
>  kernel/power/swap.c     |   2 +-
>  kernel/power/user.c     |  19 +++--
>  mm/swapfile.c           | 154 +++++++++++++++++++++++++++-------------
>  6 files changed, 132 insertions(+), 55 deletions(-)
>
> --

Which kernel version does this series apply to?

It doesn't apply for me on top of 7.0-rc4, so please consider rebasing.
