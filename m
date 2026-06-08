Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9363806B8
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925883; cv=none; b=gytUYNrY3j5UJsbofddG7x+tbCrmRY5tHzdD9YOD4zsGUTGIw9UrpBkt8mXRc9ADEKohKxoTzFVluOu8dfxWrc7Pq+OhcQlX2NUTy1TP3jOX7YE9RQ/H0MPxXvJxJPN57iD2ieWSpmCfEragfWd+P9RUsVuw1Avim+rNJeOW0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925883; c=relaxed/simple;
	bh=zCcw2+qts7Aj3wFa8UA9gM99HXt4/JSIPWSV4liCQOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRU2uAp3G4HuKRxmsKvYAQ/4bo4cQSXfKLzHRw2Tmfgm1z26W0BCEWdVdA8QhuWeuRZim/z8p6htucZUQs8S22KKlG38K3qU67pwpzF93Fq6zFcE2LuQs2/BxNlvYa1C6X8oQBSkb30sPmo9Iogbe+Il+kejZMDDZqnjwVSviAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayptnb9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayptnb9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551551F0089B
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925881;
	bh=qj+sR19VEmefC20wRB6EfkwdSsp50unjWzwkSYFOQcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ayptnb9ATxsFBMB17Mch3scKuef1+da9hZtj1lYL6XKQFZOphsVBJEj1k6gjMYZAX
	 Y5arFiCvFgfEA6WFfRP+cgE8iREUWRC+3bBsc2cWgfEK/BVLlhlULncylqT8BiTHz2
	 YluC1JJeqn+F+YJEK2CBkaeagxC5hipNqiZycLj9+I1bBJIoveGL9mFawGh1faL3M9
	 o5lL8aWQcGLx4NvzE/mXhwA6WqOAb7HNgvZw+AbyMTRhlxK7PgaHKzwqltlDw2/FKw
	 oHeuOWlQ/uen0gojMqdvWIgkR0yDrmG9Hv1o7spMrfWF8FeK0TCgjoHOGMLqZvBo8K
	 4xK3nPZ5+NMfg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967725a77fso43640541fa.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+B31pHJy1k+zBI8u6K1A34yE5xLhgqp+XRuDXnsmP6x+8T1HFrGL9dwBDm7N4YsYAJEOCi4sjL/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTLK+mELpw/2DwMzleGIOWWrarYt2cGWm1OvzTiDmGRTM2RCc
	saisYAQrHP5/Q/WgNQADAh1TGJnIsUKzh7c0KCxF1vtXg12uRDU0fgFp4AhCwriRhieCTUqvLwv
	lDmtIv4SilpX090/zjBZYbTuJ5FFnSpM=
X-Received: by 2002:a05:6512:b9e:b0:5aa:753c:d8b6 with SMTP id
 2adb3069b0e04-5aa87a11437mr4247784e87.0.1780925879677; Mon, 08 Jun 2026
 06:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607110555.53248-1-adinata.softwareengineer@gmail.com>
In-Reply-To: <20260607110555.53248-1-adinata.softwareengineer@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:37:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jy1rWwx9FkJPKKNm7SHrU0RDxLHqKMOnhrc15Qmy8P1A@mail.gmail.com>
X-Gm-Features: AVVi8CfXCfvS1hj_bx0a2aMYy53cvy2Bd1ZfDO-oN6x8vA0YeQpecejNUvg173A
Message-ID: <CAJZ5v0jy1rWwx9FkJPKKNm7SHrU0RDxLHqKMOnhrc15Qmy8P1A@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix kernel-doc comment for add_rtree_block()
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: rafael@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 1:06=E2=80=AFPM Adi Nata
<adinata.softwareengineer@gmail.com> wrote:
>
> The kernel-doc comment for add_rtree_block() was missing @param
> descriptions for all four of its parameters (zone, gfp_mask,
> safe_needed, ca), causing build-time warnings (make W=3D1)
>
> kernel/power/snapshot.c:469: warning: Function parameter or
>   member 'zone' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or
>   member 'gfp_mask' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or
>   member 'safe_needed' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or
>   member 'ca' not described in 'add_rtree_block'
>
> Add the missing @param tags, reusing the wording from the
> neighbouring alloc_rtree_node() for the shared parameters.
>
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>

It's a static function that doesn't require a kerneldoc comment.

If you just want the warning to go away, replace the kerneldoc comment
marker /** with a regular comment marker /* in that comment.

Thanks!

> ---
>  kernel/power/snapshot.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index a564650734dc..cd582be86412 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -459,9 +459,13 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp=
_mask, int safe_needed,
>  }
>
>  /**
> - * add_rtree_block - Add a new leave node to the radix tree.
> + * add_rtree_block - Add a new leaf node to the radix tree of a memory z=
one.
> + * @zone: The memory zone's radix tree bitmap to extend with a new leaf =
block.
> + * @gfp_mask: GFP mask for the allocation.
> + * @safe_needed: Get pages not used before hibernation (restore only)
> + * @ca: Pointer to a linked list of pages ("a chain") to allocate from
>   *
> - * The leave nodes need to be allocated in order to keep the leaves
> + * The leaf nodes need to be allocated in order to keep the leaves
>   * linked list in order. This is guaranteed by the zone->blocks
>   * counter.
>   */
> --
> 2.47.3
>
>
