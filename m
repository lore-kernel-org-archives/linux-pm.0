Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451733;
	b=2jzO/IaQP9Oi14WYTCt+swFXqPqf4zU1F7Swwc/etHcF34wxob7ylawxGN0/rZj/Km9T
	 cZ+G70MqEMs82B+RLGXTO0Wa2RpINEVTm3Hd6tPdgr9IGpAG0851kNHKRR2V1r7DcnDsu
	 q+5lgn3O0JbD41AX5C8enkI2yr05FmNhRlZ2xJGeU8yPgj4+IY9D8WGvdKPH8BXTrwEgf
	 kpANOlc2xVDRkiXIIFBbDQ0heAqNK4DzinqIeiO9LLDSNRZFyHnBf2CqJ3IqlVYPtiRXb
	 qiBOUFz17roQS0wavTkGElxZePgiuO3jn9lvnYXC3SUtzq8wVovoA0FHtIr2/C6cz7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451733;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=QonMcWfZhIMNw5CEeHP+f4vnHBs+VjAaV445fAEQw3U=;
	b=1MrK3ZIDOOhMLE4fo6KwQoXUxTwJpVDG3YL2vf3NXno+d+KQF4yhmHB3R/UTyI67L69x
	 sSu8O1PV6VHpzDI/zrzv7sgpZYnz4YVD3xpgfbjnJhzkEl11vV3eRei2q6jQGTToP/9Y4
	 hb3Arwi61m3grLOj4cxnlKTmfHjA6lNUXopsphoqimuYpkIMuFhQHyYpEX+rR89QJU2TB
	 taqAjZfn8qUAY84Noj4dCy3MZ0IOJUoAaUo3Vd6PvNXq8wpKzQuwPa0EBV7KT5//BrztR
	 Nsu9zHqGt1yX4UqotHirslWI6I+AeRPoaXut80jkgdeIG5Yl5z8rnFzsVfUqmd2lVKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GAI6E7T6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C4606A31E;
	Mon, 23 Nov 2026 16:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593C4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GAI6E7T6
ARC-Seal: i=1; a=rsa-sha256; t=1795451652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZbOvI+mjMOJdnFUKfoizUppJ6Ex6hbrHj2jxYtGHugqpZ/j92pi6Tu8fPa6z+YesJmcS5LTOgGJXZUsQEQZeANA77QkFFntTa8oUCzlsIRNbUxNOQscyMFVdMuM9wp1aeymCBkDSvpK6lYGDi7Ry7l5QcSyo0GF5tP1Us9l4sho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795451652; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QonMcWfZhIMNw5CEeHP+f4vnHBs+VjAaV445fAEQw3U=; 
	b=eueo9JlUODZxmwySjUsVy3NbbUU3IYimCIEQg5PbyjbjMsD/n4RzU9wTVwSr13IHzmxhOyT9Dr/ukXJqbz6vbb7xT/EH+DjjWoI9wZWEnsaR5adGXRNq3fdI0PRVX9q86X6sV9j2TzQ2/MJsY3Jg68cMCskDUSgt8s1xS1AijdY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=GAI6E7T6ob6Nh6q2zHxKPJSqCvgf5vpe25pUS58M/13XUUw2gND7vz4tmSwlpFi/h7R/lAgfsRj9i+/r7Totl7fqnIyBRHU7OcXoxH3I7xTnNpAO3NAWGfg3QFMRRlMi5Tc6rS84L8JVg1WvfeNHFhFhPe5TjibnvVfcQD9RHpQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=QonMcWfZhIMNw5CEeHP+f4vnHBs+VjAaV445fAEQw3U=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795451645257569.0456820205015;
	Mon, 23 Nov 2026 08:34:05 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <179519333138.3795820.61438010297111723.b4-review@b4>
Date: Mon, 23 Nov 2026 13:33:47 -0300
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Maurice Hieronymus <mhi@mailbox.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FF31142-6624-4A90-9BE2-F654D896EF22@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
 <179519333138.3795820.61438010297111723.b4-review@b4>
To: Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External

Hi Jerome,


> On 20 Nov 2026, at 13:48, Jerome Brunet <jbrunet@baylibre.com> wrote:
>=20
>> clk.prepare();
>> clk.enable();
>> clk.enable();
>=20
> This particular sequence is indeed allowed in C. I don't get why it =
should not
> be ? (in general and/or in rust)
>=20
> If you dis-allow this in rust, the 2 sides drift apart, don't they ?
> I mean they start behaving differently. I suppose this is not =
something
> desirable ?


The problem with the current API is that it does not enforce a proper
order for the calls, i.e.: prepare() -> enable() -> disable() ->
unprepare().

For example, getting a clk and repeatedly disabling it is allowed:

while true {
  clk.disable();
}

There is also a problem of balancing the refcounts. As you can see from
the example above, it is trivial to have a decrement without a
corresponding increment, or the other way around.

What this series aims to do is use Rust's type system to address the two
points above by enforcing a legal transition between states using a
small FSM via this "typestate" technique. As a bonus, this also solves
the balancing problem, because each state owns the appropriate count.

With this series, the broken example above doesn=E2=80=99t even compile =
anymore.

Note that taking more than one count is still possible. Patch 4 adds
guards for that: each enable_guard() does a clk_enable(), and the
matching clk_disable() happens when that guard goes away. So the
sequence you quoted can still be written. What you can no longer do is
call disable() without having called enable() first, or forget to
release the prepare/enabled counts you acquired.

Notice that this doesn't, in and of itself, preclude the usage of the
old API. Someone can add a new state that allows the old behavior, as a
Clk<Unknown> or some other name, but if so, they should provide a user,
and we should _really_ ensure that their usecase can't be adequately
described by the safer API above.

So no, I do not think it is a deviation from C, more like a safer
veneer, because Rust makes it much easier for us to provide one.



>=20
>>=20
>> And nothing gets undone on drop().
>>=20
>> c) It does not let a user express the state of the clk through the
>> type system. For example, there is currently no way to encode that a =
Clk is
>> enabled via the type system alone.
>>=20
>> Following the Regulator abstraction, switch this abstraction to use =
the
>> type-state pattern instead. It solves both a) and b) by establishing =
a
>> number of states and the valid ways to transition between them. It =
also
>> automatically undoes any call to clk_get(), clk_prepare() and =
clk_enable()
>> as applicable on drop(), so users do not have to do anything special
>> before Clk goes out of scope.
>=20
> So the point the is automatically clean-up (as in disable()) clock =
when they
> go out of scope ? In C, the equivalent would be calling clk_put() with =
a non
> NULL enable/prepare count. We do complain loudly when this happen. I =
don't
> people should encouraged to not actively care for this.
>=20
> --=20
> Jerome

Actually, the point would be to forbid this using the type system. By
using the new types, the abstraction knows which counts it must
release before calling clk_put.

IOW, a Clk<Enabled> knows, on drop, that it must release one count of
enable, and one count of prepare before clk_put is called. Clk<Prepared>
knows it must release one count of prepare before clk_put is called, and
Clk<Unprepared> can simply call clk_put directly. The type states make
the situation you described unrepresentable in Rust.

This is not new on the C side either: devm_clk_get_enabled() already
runs clk_disable_unprepare() and clk_put() on its own when the device
is unbound. Here the same happens when the value goes away.

=E2=80=94 Daniel

