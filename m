Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF740EB89
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762407; cv=none; b=Zq0fo55nC8h9uvwbPtibZTDIBBSVPmJ8L+Qvy1BKBC/hHjNwzkgxDz+Mh2Q33u5Pn/K8nbvhifD6Xi9Kr6h7B6zC1ZHn0cR6m8DEkhR78Q1tupTsOTEotIWoyzGk+ROqDhKKzu9OAbksQrCGMKpuIHgWx4V6hmtR41PK/mbqVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762407; c=relaxed/simple;
	bh=V+e6I8CNt2H2Pif5e46ZpWFaoWmgkmQxUFOA2DWiX2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXL+E2psXfxTBPXWW6HB6w2ufvyGhn6pzF2kk1VNTLdgFwi4IufiLKG54vv8nu1oFLwYrlyENzw9MPV10mxNBEjpCkaKHSKbTXiPHmdrYhk/wExW8oRSx/G+FDcHz5EPgNuqAUx6hXdN/luz/ZT0TVRG+vl7MYhbjupv0meOhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWzmIaEm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwmXXkHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWzmIaEm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwmXXkHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785762404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpAYiTbcaQ0jvMB05FtqLWtuoGIYX5W9PtOm3b1H6mI=;
	b=NWzmIaEmuRBw0JqzstOT/3P0mRw4i7sh7ByLWIk9CsthhZ7kPxuQhU1tPH77fpyqYH/A/l
	DW9niF5VbY9fSnCLm43ZN05/xc/zmYEoX1aSymVw8gYb4wGWvwg9jreQwikqtRWoiphTNP
	cb+Pg/6Ri4YOS1reIJoIV4XQEIU3gWs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-OirL43L9MYGyi7SYKYkT2Q-1; Mon, 03 Aug 2026 09:06:28 -0400
X-MC-Unique: OirL43L9MYGyi7SYKYkT2Q-1
X-Mimecast-MFC-AGG-ID: OirL43L9MYGyi7SYKYkT2Q_1785762388
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81aea53d559so79037077b3.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785762388; x=1786367188; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpAYiTbcaQ0jvMB05FtqLWtuoGIYX5W9PtOm3b1H6mI=;
        b=gwmXXkHxlMhUC9p3O9WzEBcFg7SVvS+Lpdnx91DLLJ/OfQI7CAuYH1WujAsmvGGJ+m
         8nSTP01ZE2yJnqL0TMdnsmCDAq5CtF+Y7uFCVVZ+DRFxH/JbNKf61IxHU8Or3i+u8s6O
         JkQYCqi3/ieF+ICBuDKTQyJ9oyG5TbhLTDxawdKRkFTGiM/GFYD/0jTEzXl5MBkHnN00
         1zS145zzq2cIjWzReobMwZxyns1RdwBz+ddBWXan++yeBoyl/Ast5/60iPFCRGvUa2Rg
         p6ULOf9eXAH/21+5I1yqqZdYryc06b1JGHQToJHMcdzM2RSAGeM6WboiSVFk3ln7F8gI
         KfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785762388; x=1786367188;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TpAYiTbcaQ0jvMB05FtqLWtuoGIYX5W9PtOm3b1H6mI=;
        b=e1WL/SSaBI91WWMKVWf/vnGpDbMGnpbsRjG1CgLZva6DZw42qvpkfT1/Q0LBiImzmy
         tYVRWAVkEu+635Zf+1xDDGlJ87+pjkrAmjXkYU40vea/sjGA/54xYC8lIs5TekA27yyA
         nuOqE5YP7aGOiL6xMcp2g86tuwJmQlQl1adSHpJiBntQyGxF4h9L18b3Q8TYWn1FvVte
         gnzI2Jl6v8Xs+U3cpvLkP2AWjcFlUnm33jkQ2oczFNQHz16MWwtW/GiTdU7AJt8Qfj8P
         e79BUKnXA/Xt8LNI9zNe6tgv5AHEDeDETpcFOf+iatJ6Wkje7RWWYL0d0TQhFPVP6GGe
         Rdtg==
X-Forwarded-Encrypted: i=1; AHgh+RpQeN+DbKvv6Lk23GHIU7a32miB4yDU2y7WM/faCPSz+yhfRC1TMo3999IlWBOs5/tdGPbPSD0Vfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKtploJPcZqxHfksgOAh+0sn//OoPrzJGpkEVbU1nrF1qenb9
	54/dLFbDdgHzISFOrUp8PiVwMrPiGwHntNfg0qEGYEMu9+adqTqzCq1tIBX0QHdc+6PgM1AxNNf
	ZfkrHHWaNmvVocmLGca3TlQ7g2swXlrpOkES0JJpf98Jdzqzuz5wiUge6FZIh
X-Gm-Gg: AR+sD11CwdLyjvOeSeGY/NZzXF5duL+qKO3CXGjRbgz+4kTZbYT9sjcXPBrTKbqL3xz
	iHwERSZ9PEWCjxQbRSSqMpH6V1IeIeHC2qQpIOTYG5LACnVG+b80DJ50mYnRTKnfnUk7+D5dNSV
	y+5ZCY6ymh9AdUlG+ROcmSi82nKhK0coPTXTCbugtuqVmfURxxkL278BpcAhOJaDnbnVGQKp+Dg
	DQrkrmNeR9M6xAsJGyKt1wspgYBnGovHOCafRxVZ96dYQbHyJgsiP6A+Svz76QguRjGVBITRdhF
	AHyBxJEI6BWVvSW+amY9YX4BZ8L4hb299ojpyMzTHeDdLDKBfMkdieGWe35gmJluW4U6K+II6Ln
	6lmrYb3EI6b0RuVzIAcQuBNgdK75R/Z2HRHI=
X-Received: by 2002:a05:690c:4b11:b0:81c:872a:5152 with SMTP id 00721157ae682-81fd4bda24fmr120206867b3.30.1785762387675;
        Mon, 03 Aug 2026 06:06:27 -0700 (PDT)
X-Received: by 2002:a05:690c:4b11:b0:81c:872a:5152 with SMTP id 00721157ae682-81fd4bda24fmr120206447b3.30.1785762387273;
        Mon, 03 Aug 2026 06:06:27 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf60a76sm54295687b3.13.2026.08.03.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:06:26 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:06:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Boqun Feng <boqun@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Clk improvements
Message-ID: <anCSTCxDpFtKmOgj@redhat.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260731183735.15036-1-mhi@mailbox.org>
 <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Daniel,

On Fri, Jul 31, 2026 at 06:32:48PM -0300, Daniel Almeida wrote:
> > On 31 Jul 2026, at 15:37, Maurice Hieronymus <mhi@mailbox.org> wrote:
> > at your suggestion [0] I rebased my `clk_rate_exclusive_get()` binding for
> > pwm-th1520 on top of this series, so it is now waiting on it to land. As v5
> > has not seen any comments in the last few weeks, I wanted to ask what the
> > current status is.
> 
> Nobody has replied so far. I don’t think there are any further comments.
> 
> > 
> > If there are no blockers left and you expect it to be merged soon, I am
> > happy to keep waiting. Otherwise I would offer to send my series standalone
> > against the current `Clk` API and let you rebase on top of mine - it is the
> > much smaller of the two, touching only `Clk::rate_exclusive_get()` and
> > pwm_th1520.rs.
> > 
> > [0]: https://lore.kernel.org/rust-for-linux/140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com/
> > 
> > Thanks a lot,
> > 
> > Maurice
> 
> Your series might hit the same blocker as this one. Perhaps we can try to get
> both merged at the same time?
> 
> @Stephen gentle ping here :)

I can also provide an Acked-by here for clk. I'll admit that I'm not a
rust programmer yet (planning to learn this coming Winter), however if the
rust maintainers are happy with this, then I'm good.

It looks like there may be some outstanding comments on this series just
skimming the comments. I'll wait for the next version to leave an
Acked-by.

Brian

