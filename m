Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EF1D95A3;
	Fri, 31 Jul 2026 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533650; cv=pass; b=rZb6ujd5xb/grIUW9InKwRbrLFRTs5xfNr+Wi4Iewwui9Tm0HCApkzyJ0TN7w7tSQBWmglALcz2n3lYDLy2FSDmVL9yI1ngYLsPuDLZHN4kTVqakoSqKQcYE3Rr1UCNZwLI4qGg4QQgHbygelY8wgJt7IoYYNXLZiZMSL3IGPLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533650; c=relaxed/simple;
	bh=28SYLaxEswFYrX7pB/BBBjg3ucFfM5uxTXPR0tHPjcc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J0pUB0iAWulU8qW0CUexzJKDLZrdmsduhvL3BFa4jfyzTcTnZkoKM+n2rz4+R64+uAUgHrLBqRJNidn2MnIXh58xD52DBhOH2d/I42TLxg+RvjxPaXRV1z0ZKp5vvTYt+8V7m7NDqaDnl5dwydrQsaKnmLHGDDVK93TfKttji8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hv8bf7ml; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hv8bf7ml"
ARC-Seal: i=1; a=rsa-sha256; t=1785533593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gHWANFQFZoJJaYEhuKmaZUxWUFD+rkzqPNoml4H2CAPw9Eir1vP5sTf8FH55AQFSTqXbJsRM4yw6PQGOM3+kOK3r7L8MauTZbozYas9fQW65jLiuw5EycL0OsVg5TO4UsvIAt6uzxShq3/IXxF0gXXTGZxTO6NkOGsqXv11V2UU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785533593; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=28SYLaxEswFYrX7pB/BBBjg3ucFfM5uxTXPR0tHPjcc=; 
	b=i9xAT7I6wpEq5+55Y74aQJDsqPQN2QZYJAo6dyuwFyrXGYK6n0G4QS3yvwaIgiUukMsstV9j9UnOUru03iQu3tpTSKc8NBqBw12A1m0IaT/lICrjJ2XXiPUwRW0CKH/UhDz8g4VaX7/e2TkzPCXoFT47bwxxweCbYOXkFnNFTUM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785533593;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
	bh=28SYLaxEswFYrX7pB/BBBjg3ucFfM5uxTXPR0tHPjcc=;
	b=hv8bf7mlLR3lRI+e3WrpA+6efQ42RwhE8qX5b9m1qEMxfc9CGh7FGc46xbl6ss+l
	VAF4ZyymF+yxhahxdJCFv82nK+92hoPQyWArswJxbPIlUignAZgCeUgrBJk8aUD9AWe
	bpwEq29KEJWbNIYk7JBR1AT6NZeaCco7hOSh9vog=
Received: by mx.zohomail.com with SMTPS id 1785533591479424.44668881936855;
	Fri, 31 Jul 2026 14:33:11 -0700 (PDT)
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
In-Reply-To: <20260731183735.15036-1-mhi@mailbox.org>
Date: Fri, 31 Jul 2026 18:32:48 -0300
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-Id: <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260731183735.15036-1-mhi@mailbox.org>
To: Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Maurice,

> On 31 Jul 2026, at 15:37, Maurice Hieronymus <mhi@mailbox.org> wrote:
>=20
> Hi Daniel,
>=20
> at your suggestion [0] I rebased my `clk_rate_exclusive_get()` binding =
for
> pwm-th1520 on top of this series, so it is now waiting on it to land. =
As v5
> has not seen any comments in the last few weeks, I wanted to ask what =
the
> current status is.

Nobody has replied so far. I don=E2=80=99t think there are any further =
comments.

>=20
> If there are no blockers left and you expect it to be merged soon, I =
am
> happy to keep waiting. Otherwise I would offer to send my series =
standalone
> against the current `Clk` API and let you rebase on top of mine - it =
is the
> much smaller of the two, touching only `Clk::rate_exclusive_get()` and
> pwm_th1520.rs.
>=20
> [0]: =
https://lore.kernel.org/rust-for-linux/140FE1B3-73CA-45EA-B978-648A1A48B57=
7@collabora.com/
>=20
> Thanks a lot,
>=20
> Maurice

Your series might hit the same blocker as this one. Perhaps we can try =
to get
both merged at the same time?

@Stephen gentle ping here :)

=E2=80=94 Daniel

