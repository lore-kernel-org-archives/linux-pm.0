Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009676;
	b=UQvEn8OoOiML/ETkV64tR1MTQzoe18X7QQot3bC5rpwHuQV4K0q5oocfV+LP100RBADX
	 NNV3dM5NQM0O3ZJznPJes524qp5LXYqJAJJk9V7kMyow9ardHjYyxtiV2Wac8gJ7g5AhC
	 Jr/xWCqlZS/YqrNIevc30TEFf0gIrceIIoEgQYJr/nY1bA2h/PN2G7yoINv77seIQGTTN
	 z58hePbhPof628mmGJ4GkB7zA+6rYL0Wss1sjKEPTNtRTqRx7pX6R8UkfEgCtTcUw2l5O
	 zpIqQ6sU/pIp4gHP0rcBQafhBH0ZMj5cYGPLDNUZ8ekjhqDF48UMKHf3WJSYPVDVjGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ReEzbagpHcp/fcY0hMd4fNtM6diXxUaPoUO44vW/qBI=;
	b=LNX3fPk+xGhvEsV43fQVpoWjPzTZuNX2CbVKI5Fe1DD685fcjocrsmSmLOTViJEQ00hG
	 Hgqwss1mjPzezl0w+t1eJ68ncaZ0n5eluJuYoeiGIPqI9fNiuYgwuH/JcFsAUCt4xt2BQ
	 RUujl7TtaUATG1yBm3e79RAdJbmWWUfrb3mtuKbooTG2tctwJfnHZAI+kwqFjz2dekvjH
	 clGgqqRc4491McWZ38uC14JMyGic1jHm570eSUanVtIUjOCuZsGkjL7tT/p/fwW63k9KF
	 3Ubglkf2H4CsuDZVZydq62Ie6Jv3LiV1koe2ZzoP3DWf6ehvpH1IKY1IBD5MgC4gL4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mD+pK0c+;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3D60A2601
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A3D60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mD+pK0c+
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so7892795e9.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009675; x=1795614475; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ReEzbagpHcp/fcY0hMd4fNtM6diXxUaPoUO44vW/qBI=;
        b=mD+pK0c+M4yqOS0nuRtyleGn08rLkbqa0+ntG2h9RSKQx8HxtzF2uFobMxvKsLhFIF
         u5tuxotsdBlKwuJkGYA8QvBtxl70+ju4T58pnrA8AGomEzyUapTBTEXgFKhkbTLYv31q
         aZeUKsF4hqL9Ma7GkvfyNhUI2vbBkAzmJSvSma0+/1rQVupdCHXJxZeUtpSD7LNrkC1k
         npmLaX+YbPK3Y8usYq0DooJydQ9Fqzi6UCgg72jHJ0ycsGxAWct5tOvTd38kA0Arxpyn
         N75V8uZstRR4Gzlspm0oPGuc2XBc5pSlxw2tTPSZd03qQ7vNPkzi7M5tK411P8HzYeNr
         biDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009675; x=1795614475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ReEzbagpHcp/fcY0hMd4fNtM6diXxUaPoUO44vW/qBI=;
        b=NoQ22qVH4c1OIFYHBM5UmzqY46ROykC6GjugVbS5j/G7Y/i8zOOlg+3CCoLf7enryA
         QfQuLXtRDkBae3aOxnm4GQpmca8Q43MmPY2PM9GwKY+3R58QUuASF2h7dhRmFOB4sawd
         z2kle8zwMR95XW8woHZ2s6fIGBMR5Kdh4RNK41j3vRrInFAaZqUgoQXD+4FLCFsnxVCJ
         U5sD7iRPT3LmrCBQ+vs00Yder6n5XLR1oXpKunAhUguP1O02Mz7ej6Sx4egVsw4pObeJ
         nF2lKMr9cx1Ro5fPdtExDNB7vfoqkxKjlNPvNEkcAmfXB0N+D2eJIQ2HLDCQ5wC4zqS6
         7bIA==
X-Forwarded-Encrypted: i=1; AL+hErHOQCBy+YLlJ9RyzBqZICgVFxDWuv41x/fmO6p506PtnI1Ha/gTx3qvArmHxY3lTWQhA4OfKFbqYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8RQL3Knpo/laI65CLCz7oPgTp9VPpiY+PygaqKXMjIUCOqGWow
	gSps2m4aYmehgwUmAlMAYwulXNPi8gUtQGGWZc3FTWqqx80Lf7eRGQowEgQCakuQBgCWclGZcBg
	CQTnJYsdV9mQT1e2yIg==
X-Received: from wmbgz3.prod.google.com ([2002:a05:600c:8883:b0:4a1:811f:6de2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f56:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb7da12aa6mr55502915e9.10.1795009674222;
 Wed, 18 Nov 2026 05:47:54 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:53 +0000
In-Reply-To: <20261013-clk-type-state-v6-4-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-4-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134753.658399-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 4/7] rust: clk: add guards for scoped prepare and enable
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2026 at 02:07:43PM -0300, Daniel Almeida wrote:
> The state transitions consume the Clk, so a driver that keeps a
> Clk<Prepared> in its data cannot enable it for a short section without
> moving it out and back in. A clock handle also holds at most one count
> of clk_prepare() and one of clk_enable().
>
> Add EnabledGuard, PreparedGuard and PrepareEnabledGuard, returned by
> Clk::enable_guard(), Clk::prepare_guard() and
> Clk::prepare_enable_guard(). Each guard borrows the Clk, takes its count
> when it is created and releases it when it is dropped. It dereferences
> to the clock in the higher state, so a function that takes a
> &Clk<Enabled> also accepts an EnabledGuard. Several guards may borrow the
> same Clk, and the borrow keeps the Clk from being dropped or moved to
> another state while a guard is alive.
>
> There are no users yet.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
