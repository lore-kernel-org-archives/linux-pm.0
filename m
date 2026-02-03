Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0921396D0D;
	Tue,  3 Feb 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112059; cv=none; b=Bm8n+DRyWZ0ylJxN7dxmaaZOmEzhD6mx/WVUlPZ309UYY9sPDe7Hyu95ZByGYeFXcWSWSHJNK1fvAE1BbC2tqbAyoxT33JBqv5v73F1h3/w7Ai5399D5BqFWLJN7hXTg7PJPa2y+F5JXyF6/HQ1Sko9FE7rM1q+orET/auBS8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112059; c=relaxed/simple;
	bh=SJgibaHQ0szc37inrLGCwLbR+73hqXSTWiGCcnfOEc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaEJGG5ecY1UznrAG5jSJaofLb5NgWARXeOfmM5wSh7IBAT6vF7+c93+hsKcb0o9JBda1GLujG7bIDzjPexAoRQ1ApEOyKZbfLWaUi6KQqnNf2GXZEiyqkcAwqUuJ72bheDJSNDKcLlEtBU3hg6ueCI27QN/BtdGTJ+g/vcAlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PmdE215r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PmdE215r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770112055;
	bh=SJgibaHQ0szc37inrLGCwLbR+73hqXSTWiGCcnfOEc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PmdE215r9KrduIfUmhLkRCuOYfk6uHTuy+nhv5COdt4yzi2k0B0QRR6KCcTxXvvAD
	 nQSQ58J6vL4sryTrppeY0+ysfwmJTs9G22I6zMcSDY4F/1e7RYdofbnD/Cq+YhQvqU
	 npqOGJr+/Yl8q4AXszsNLMDZg4HbOUFrxOYPsWEnbI6B3fkf3NqTcDpGYT8I0/GWZ3
	 SMuVVQgpON9mBztp3Fmz5GVxJojHTbJ0xh85RanMmxEvtYcmOxojIHXU0HXifZ7MYr
	 IPmai1V/XYW1mL2y7z5oDy73AbND3prY1QiZF6z2NnMY1MmvJRNwAaqN2Yw2eUdFAM
	 KZHal4V1/u/kg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D55117E1149;
	Tue,  3 Feb 2026 10:47:34 +0100 (CET)
Date: Tue, 3 Feb 2026 10:47:31 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203104731.1918559a@fedora>
In-Reply-To: <20260203100913.6d224657@fedora>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
	<20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
	<DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
	<20260202171038.10e51e18@fedora>
	<20260203100913.6d224657@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 10:09:13 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Hello Daniel,
> 
> On Mon, 2 Feb 2026 17:10:38 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > > > -#[pin_data(PinnedDrop)]
> > > > +#[pin_data]
> > > >  pub(crate) struct TyrData {
> > > >      pub(crate) pdev: ARef<platform::Device>,
> > > >  
> > > > @@ -92,13 +92,9 @@ fn probe(
> > > >          pdev: &platform::Device<Core>,
> > > >          _info: Option<&Self::IdInfo>,
> > > >      ) -> impl PinInit<Self, Error> {
> > > > -        let core_clk = Clk::get(pdev.as_ref(), Some(c_str!("core")))?;
> > > > -        let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c_str!("stacks")))?;
> > > > -        let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c_str!("coregroup")))?;
> > > > -
> > > > -        core_clk.prepare_enable()?;
> > > > -        stacks_clk.prepare_enable()?;
> > > > -        coregroup_clk.prepare_enable()?;
> > > > +        let core_clk = Clk::<Enabled>::get(pdev.as_ref(), Some(c_str!("core")))?;      
> > > 
> > > Ah, more turbofish.. I'd really want to avoid them if possible.
> > > 
> > > Any disadvantage on just ask the user to chain `.get().prepare_enable()?`? This
> > > way it is also clear that some action is performed.    
> > 
> > I've just disc  
> 
> Sorry, I've hit the reply button before I had finished writing my
> answer. So I was about to say that I had started writing something
> similar without knowing this series existed, and I feel like we'd don't
> really need those prepare_enable() shortcuts that exist in C. We might
> has well just go:
> 
> 	Clk::get(dev, Some(c_str!("core"))).prepare()?.enable()?;

If we want this pattern to work, we also need:

    impl<State: ClkState> From<Error<State>> for kernel::error::Error {
        fn from(e: Error<State>) -> kernel::error::Error {
            e.error
        }
    }

> 
> and have the following variant-specofoc functions
> 
> - Clk<Unprepared>::get[_optional]() (no get on Prepared and Enabled
>   variants)
> - Clk<Unprepared>::prepare()
> - Clk<Prepared>::{enable,unprepare}()
> - Clk<Enabled>::{disable}()
> 
> Regards,
> 
> Boris
> 

