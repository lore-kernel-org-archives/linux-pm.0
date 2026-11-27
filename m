Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792062;
	b=zg9z9uw+wEKabgfJpvKpjETU47naXMui8QhVC3/RFAmGF+vnJ7CmGGVgw7qyJ7CdNYDg
	 WyJWbw1flYxe230PQ4qMko1Qwq4O027vNg1irZCkBG9l0BuBtDFNhbOsd+mL0ugbbgY5q
	 Y9cWSIi+V3iS7+r8PdtVzByU5c4b86YTbe8K+vs0l7TIhy0aCH5jC1kMhA2AMo0czrHWc
	 RVIpEKKH3y/M4qGGYkOWwwqkZmF7ji0zMvroOw8cXRh3g8c1tW82IiDakWG/4++lQThH+
	 0DxsQkxj1caV8CYvuxUtlhYqLDS1eQv4lI9cyzPoXaTe/FO3GAeucscpjv8mUsnVAIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792062;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B1JU7lg2T8L0m5ZEAkBP94dZnHfIjswLiNifCR+ExCE=;
	b=SBozuxRLC46ZP4oCbLutob487MXCPryUylQAyANMYBdU5ZM0WOynpbclFWnlwGbJWt9/
	 oWMj0er/WMfL4bkvao0093JBrhChnodTxat/dJ3fkLTaTvhbCi3gfq7KQ056Vq2gxAIE9
	 8bZwqfnKUHkWAOtqnsvp3GW2Z89ZOGdyeRxOcxE2AhVcd2QrdfvGDoBVHz5Pgk4XekwyF
	 ldi7KSnWzdd5QBauKX9Hf7jVTnvnebIEDkOjX74icfd7HGPVsQOCe6334n5sUhAfsQkEY
	 UTQuqt0EvrZ+Gi440x2eZsssjNX6I5M06zcMyy9zR9Gn5A/prZ2mSv946JKofT1mT6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBjySMbB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67895606A329
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBjySMbB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E706E1F0092F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792061;
	bh=B1JU7lg2T8L0m5ZEAkBP94dZnHfIjswLiNifCR+ExCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FBjySMbBR7eUwJuheODIvsJroAC/vclIrYEF0Quw6jv/X9xjR6ZXFnUP6xhZRECsY
	 U2Ga7KBzz7PnXRGCFeXdB1xD3Luc74zSTPw+CTRZ+KnYLJMQy3MbCytcJLt/9jBY58
	 kd1oZlNBxhc7yVCJG5e6rltm5oOvh7jB4aTIZn9AFIrWHfgUexTZke3LSJAx+ccjJ7
	 0qF13C8BDxt5BSa82qlqQtFWRwWQDsYDKDEBvOOjJAjZbOOh15l4MUVLXWWi0BTDSd
	 dYLxmY4TViW77YGor+9eGRysykAF1QrvcvVTivN738EzAZ3rvbZHm5xOR6WQwdkwsX
	 dlVPvrRm5T7xQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae22dcfdc3so67283921fa.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 07:07:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHA85Igl7oDZR+GPEwJhi0vZr7fwNqOocPuPiZ6nvil3c9u/+ZvaJ8TQZt2auR8SHcceRXnFlkkeA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+SJzdfJTRvb9h0bKhwbtybRqDcNJnIhIuTkpd0a9xYA6m126Lr
	JXUaCHIP4zlfcwU7M1UDlaM6GhsNdNgWf5NEQkdo51rd9fE6UIVw9xo72evwF+uLZncRVKjxX2r
	VOjpqpCCbHYIGlJmKcU89kkpBR0AOuBo=
X-Received: by 2002:a05:6512:2348:b0:5c1:4d49:cd74 with SMTP id
 2adb3069b0e04-5c1bc7bcd31mr7766055e87.17.1795792060284; Fri, 27 Nov 2026
 07:07:40 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org>
In-Reply-To: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 16:07:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jD4ddgeW=jBH1_zkOkF3poAoQGo5VAok+ZeVY73__krA@mail.gmail.com>
X-Gm-Features: Aa3M54oAzWYbG2wgSYSwI7YqTjR2p9stV9PlCJrVbgpM4NlUJkuGnzg0-go2ovM
Message-ID: <CAJZ5v0jD4ddgeW=jBH1_zkOkF3poAoQGo5VAok+ZeVY73__krA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Fix netlink performance-domain dump pagination
To: Shubhang Kaushik <sh@gentwo.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Changwoo Min <changwoo@igalia.com>, Shubhang Kaushik <shubhangpk@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 7:10=E2=80=AFPM Shubhang Kaushik <sh@gentwo.org> wr=
ote:
>
> GET_PERF_DOMAINS dumps performance domains through:
>
>   netlink_dump()
>     -> dev_energymodel_nl_get_perf_domains_dumpit()
>       -> for_each_em_perf_domain()
>         -> __em_nl_get_pd_for_dump()
>
> The dump handler rebuilds its local cursor from cb->args[0] on each
> callback. When the response skb fills, it returns -EMSGSIZE and the
> netlink core sends the nonempty skb before retrying the dump. However,
> the updated cursor is not saved in cb->args[0], so the retry restarts at
> domain zero.
>
> For example, if domains 0 and 1 fit in the first skb but domain 2 does
> not, every subsequent callback emits domains 0 and 1 again and never
> progresses beyond domain 2. The handler also advances the cursor before
> encoding the domain and finalizes its partially encoded message on
> failure.
>
> Advance the cursor only after a domain has been encoded successfully,
> cancel incomplete messages, and store the next domain index in
> cb->args[0]. Return skb->len whenever data was written so netlink_dump()
> sends the current chunk and continues the dump, propagating errors only
> when skb->len is zero.
>
> Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL =
spec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik <sh@gentwo.org>
> ---
> Changes in v2:
> - Return skb->len whenever data has been written to the skb, propagating
>   negative error codes only when skb->len =3D=3D 0.
>
> Testing:
> - Validated dev-energymodel YNL spec and exercised GET_PERF_DOMAINS
>   dumps via tools/net/ynl/pyynl/cli.py on an 80-core Ampere Altra,
>   including registering 4 test performance domains and forcing
>   per-domain -EMSGSIZE splits across multiple netlink_dump() chunks.
>
> Link to v1: https://lore.kernel.org/r/20261124-pm-em-dump-v1-1-8f9167d437=
bc@gentwo.org

Sashiko has feedback on this:

https://sashiko.dev/#/patchset/20261125-pm-em-dump-v2-1-a28e132f8b0c%40gent=
wo.org

which looks valid to me.  Isn't it?

Sashiko flagged this on the v1 too, AFAICS.

> ---
>  kernel/power/em_netlink.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 1f68d456a713c08d7a4f690e88c03182f6ee3ef1..4e85439ed76d240e013cf372d=
cbc77b3af28d598 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -80,19 +80,25 @@ static int __em_nl_get_pd_for_dump(struct em_perf_dom=
ain *pd, void *data)
>         void *hdr;
>         int ret;
>
> -       if (ctx->idx++ < ctx->start)
> +       if (ctx->idx < ctx->start) {
> +               ctx->idx++;
>                 return 0;
> +       }
>
>         info =3D genl_info_dump(ctx->cb);
>         hdr =3D genlmsg_iput(ctx->skb, info);
> -       if (!hdr) {
> -               genlmsg_cancel(ctx->skb, hdr);
> +       if (!hdr)
>                 return -EMSGSIZE;
> -       }
>
>         ret =3D __em_nl_get_pd(pd, ctx->skb);
> +       if (ret) {
> +               genlmsg_cancel(ctx->skb, hdr);
> +               return ret;
> +       }
> +
>         genlmsg_end(ctx->skb, hdr);
> -       return ret;
> +       ctx->idx++;
> +       return 0;
>  }
>
>  struct em_nl_doit_ctx {
> @@ -166,7 +172,15 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struc=
t sk_buff *skb,
>                 .cb =3D cb,
>         };
>
> -       return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
> +       int ret;
> +
> +       ret =3D for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
> +       cb->args[0] =3D ctx.idx;
> +
> +       if (ret && !skb->len)
> +               return ret;
> +
> +       return skb->len;
>  }
>
>  static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
>
> ---
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
> change-id: 20261124-pm-em-dump-00f32b88fd6c
>
> Best regards,
> --
> Shubhang Kaushik <sh@gentwo.org>
>
