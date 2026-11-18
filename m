Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009678;
	b=UCZy6DAG/QqRNF52xMvvvO9CDijXNmh88U56wos37KeQLtcEM7i9xFLnclyWEZsV+e/6
	 dYXfqXadFH9IDqjP4d4TdwsqTRCeUi5A8UuUfP13TIwWrGl+2+e3uS45MPjR8geK7MIUS
	 5reGxBZgJv3NhI/iIJcQ0keKJ+Rb2RnhVaSWEwqDqeFRM9ydhfZwAPLXMY+d5YQSMBQVs
	 UXjlhWHX42rM49j2RJHvi1isAd8Y62mUk9f/Xa4dMxrljRYX95yX9zr+dPWVYZBDK0S3i
	 bYuuumW5v0bttI3eZvdVNISFOUru+RQawD/g+JQSUls2HiNtoZ5vVilAG6aaJiUARTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fp5kGNyd0eTmZJulttSFuV08XJjVgnvokjb06RGq2vw=;
	b=ublBHxPR5vZxzRzRgwrDkX5hFhDZYIw/qJkRUQ50hw+/Tw79y+9l+zYQ1bDxQgHxXkNJ
	 42jOwp5mLYArh0fTSy5nk+zA3uOkOuQCfZp/WC8cf7BSnUsoqKPKyPKlFB5XFsemZNjnG
	 UcCRgp8N9UkmD2j0au9fRShJkhZ6d22L3IgDJt9DSd7mJbRgKIIOuwe1A3lSc0kWC8qIM
	 oBvjgdG/F1TkgnmfnS5C5q4xD1pUnn5xtdvBLp8ZOEOIENBKxQANnVznxvuqcOeDE/2mC
	 S0IjM7Y6sULE4pzquvWFvFHUz+oJ/0+OU6mMHe7IsGkuASwvDL1KdK9CtRVpLBzYXHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNmkEaEl;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26C60A2608
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B26C60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNmkEaEl
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so719473f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009677; x=1795614477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fp5kGNyd0eTmZJulttSFuV08XJjVgnvokjb06RGq2vw=;
        b=dNmkEaElbn7W0RsZzP/CYzFGmyEkXFAnBJjALAYfOzlk5HKf4yBZkElycb3wOmea7O
         caAf+vkZXidQ/di0XnDTfCdqbUOHcyPxFv9vqY7Z/bNPLvL70J5d1tHYO8ykNC99A/AE
         IBC4avKCzgyHpAPYrXcC+Cv78m3zCcxC+bAIZklOa9Vtn6dRcyBR5i+fG1R5s9nJXSSm
         JdNyGZJQhYb3mjD+yjh3nq6zr1VKvAtBWf9uAHjJUBG7g7u0s7jWEDRIIxYC9bbo3DPg
         qIC24zC2EllAlbIaFfpivJ7b85mZTeQzPkJdMKExuftIfOVe0pX+yVbikwHF7SxWdf+q
         MQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009677; x=1795614477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fp5kGNyd0eTmZJulttSFuV08XJjVgnvokjb06RGq2vw=;
        b=YfdoyLol9oiKErsK68Gn6iUD7CzNigm1Av5ax4eZAbzGXwLlFfxwSGK6Tf/BK/8a31
         Fzf0PYI0mb6aTkL9OF7FCgxPbme1r8BS5QwEVC+5RV8IRzBTm7Si/qArEza5aeWQTK/1
         I7qCU02KPqAanVd2QuzXPKwtXkc2tQkCJ9A3vPlO5t2U8cNpTdQ54aoqQ+Dfcx1cPL96
         d6tDUyH4U5dSurb8DFwihiVKXNnpv79LWABWHDy+KbFYhNhY6kGzpSSRdGdMnaztTY0R
         6AqIb7pvkGdWr+xpvdfQ3zIHs0+aRI4GwF+tXn+C5c6DVfIapN88M8FL2xQvs2ogugQO
         ogIQ==
X-Forwarded-Encrypted: i=1; AL+hErHVF4tCIzRlH7rgmx6At/6i+587VcniooSemfhJrMIhHzgBiHYeuXsB/94bp5K+7t/l0zFTsWmRIQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kDw2h/iYkUpzbEoOArRu87PTJNtZRIpnjf9SH6mGeuF9kQFBX
	1dI9gsbAb1nPouJWabfnzBnuTYjyaXrWmlGwnaudoCpN3KI9TqJe/1l2aamkxMFI2ZSMtVNiHgz
	c1Br24+NB+70xsySH9A==
X-Received: from wrbay30.prod.google.com ([2002:a5d:6f1e:0:b0:49b:ed87:ac7b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e002:0:20b0:4a1:a2ed:bc1d with SMTP id ffacd0b85a97d-4a63b6fbe61mr4560158f8f.43.1795009676739;
 Wed, 18 Nov 2026 05:47:56 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:55 +0000
In-Reply-To: <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134755.658603-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 5/7] rust: clk: add devres-managed clks
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

On Tue, Oct 13, 2026 at 02:07:44PM -0300, Daniel Almeida wrote:
> Many drivers only need a clock running for as long as the device is
> bound and never touch it afterwards. In C, devm_clk_get_enabled() and
> devm_clk_get_optional_enabled() cover this case.
>
> Add devm_enable(), devm_enable_optional() and
> devm_enable_optional_with_rate(), which wrap the C helpers. They return
> no handle, so the driver keeps nothing in its data and cannot change the
> state of the clock. The clock is disabled, unprepared and put when the
> device is unbound.
>
> This mirrors regulator::devm_enable() and devm_enable_optional().
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
