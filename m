Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85028D831;
	Mon,  3 Aug 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763537; cv=pass; b=PRxcUX/VME+Iwtk6OSflbr1bh7RunztCV/LIBUfLOt5w+3p0WIv9O9FpYiBH2geeCHWTHimake4s7XZ+KzKK3j4+Lgb9QSCnvNnTuIC8ZCZNj7QX3/rnu47OMPEukMnfSEGDZWdyiLcgt3uoGrh3lHkg04QHMnNG2ysgA8CW/Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763537; c=relaxed/simple;
	bh=lQ7W80MyLGC4g6TQVRHVS4jqxiCOFRgPhA4MHHto2h4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HbutwilvEsERANRuq5OXKgbj2HcfRakz+CJUngs5/NSd02Nlb8SREpCZzfnXOJ6ShzEFmslxvvq2eukQUuuuBNKcOeyFXEmdnrlm04ef7i6e+S3lw082rzCL5CjcJTI8lEn2QLLy6mzhqyPI+kSBBe0KXUdqwsmjViR/IQLCYXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=C2BVDXKK; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="C2BVDXKK"
ARC-Seal: i=1; a=rsa-sha256; t=1785763466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iQda+jXa4ObWd1OpAuOfe8pVvgRFkZcFAhHlQVrSgVPc49t25B1clVVSA2q8yt1BMqT1ETiDUJKcEk6JFPydngJtZTsRQ+mJTDYMDiraUs5nah1xlEwQSLgaC3gvzl/bim1jYqDLI5Y2Fqpiskdei4r+H5HuoO9rqzq3vCP22W8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785763466; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lQ7W80MyLGC4g6TQVRHVS4jqxiCOFRgPhA4MHHto2h4=; 
	b=DQO+XsfpR4SuneJRvJMVC1mIiH+N/OrSB7YkVAKjfdxuP0X3shK7JVCGRTrHB1b5J8oyBWsg4Sy/KUXbK0zRQto5y/Kc7iQgkawU2WSYTi4JrLpJfmyXoAZ21EvXmwqYkFszWPRIh/uMwSfvz87Q+EcQLhyt74KWmMddIDxqef4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785763466;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
	bh=lQ7W80MyLGC4g6TQVRHVS4jqxiCOFRgPhA4MHHto2h4=;
	b=C2BVDXKK+fe1ExBLpGmi9cFtGO/+HeSpprIrmumVp09xPwoaNmpviVgltTRkd+8f
	9/rwc0v3QEmaWg15gQzCjpdVCq2sL+g4WGiy4yANNvkx70g2YbDmvvuW5bM5f9PIldB
	smcOO220uadEIoYOO+35eQt2Qzrxg24+3mCkTzwo=
Received: by mx.zohomail.com with SMTPS id 1785763465078767.4008380254238;
	Mon, 3 Aug 2026 06:24:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 0/4] Clk improvements
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <anCSTCxDpFtKmOgj@redhat.com>
Date: Mon, 3 Aug 2026 10:24:02 -0300
Cc: Maurice Hieronymus <mhi@mailbox.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Boqun Feng <boqun@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6441EFC-C2E4-437A-9FDF-F18E2CAD36C3@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260731183735.15036-1-mhi@mailbox.org>
 <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
 <anCSTCxDpFtKmOgj@redhat.com>
To: Brian Masney <bmasney@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Brian,

> I can also provide an Acked-by here for clk. I'll admit that I'm not a
> rust programmer yet (planning to learn this coming Winter), however if =
the
> rust maintainers are happy with this, then I'm good.
>=20
> It looks like there may be some outstanding comments on this series =
just
> skimming the comments. I'll wait for the next version to leave an
> Acked-by.
>=20
> Brian
>=20

Yeah, more people chimed in :)

Cool, I will ping you again when I send a new version.

=E2=80=94 Daniel=
