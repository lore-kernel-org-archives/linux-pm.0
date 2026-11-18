Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009674;
	b=Vt0Ly6o6Ny8nbYQKQKllJMVXDb85cFVTIgFG9LXjYvFciQ1Cwk4CQ1kF4BvE9xB7Iove
	 S3+nF2Twxuj/qTvyUinNXUCp3JuGg0TCEXxmIqzNSUoXrybvzWg5YovASKvpdGNq9R4lI
	 7QWfyLmY9h0bNEhtxrKXm7IsXhihCO7XrzPIS5uXoQDnEsVGGKK2++jKNd2ak4Pjlmnb/
	 M9ZIWT2Dr1qy2i4X49zP+MBMwCoOfkkbk15nea9VWebEGRLlKMp5FEjMaJEFBW1bDQJLl
	 eQopW7aHDUOlzObt1oS11b3k3xqSvFD8PhWmGIL777/vAabtJfZYcxL+VSNqV5uG8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zquXBrMDSkgmhzVSBU9n1JfbEE6tjoTWMroKtZE+aJ8=;
	b=4YGsZZaZTXJsz2Ko7ibKC5zEcww1sHgbYU2Kv3diCNZ83FSmpFCHcG6o9SnuZMCytAK3
	 acvs/jESe0fMSK8oHfIcdMrVuGKy9Eb1gsR3Z/dIfPigGOLR3OmjE0OqKCDGYsQ0nOi3e
	 8/fhvzfvAAcnkT20HmdMZ5mkZUiOvZYv9lurdnAFWIYSNRAxSssHoJCJjMekY1Rmh2vK3
	 MxztsYvwSTUtI4enBYrq+/+HUxPOG1fH5CIHPrhozuvqbSPOpABQOzOeG2jg7y/r1fpxq
	 AXKGCHmf3ZYQ3cOQElJPr7IsraCDJzbFCN+ZZjDL0NQNTAOTO2LBFT322O86eiCSoyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VTi+CFM3;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DF606A330
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05DF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VTi+CFM3
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4925ef75fc4so786619f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009672; x=1795614472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zquXBrMDSkgmhzVSBU9n1JfbEE6tjoTWMroKtZE+aJ8=;
        b=VTi+CFM3r96ENufgUf1BqcL6oF6r8eAjhz50y8tV4dBbtCWsQYlSrWVc9xQKUvbKC5
         X0BcAjgiGtS3p4ezRH9yLP/L9XR75gtjGPDGBmtt3X2mgFIixhYAq1jItVf8T+1KTiU3
         l6yL5B0ruXP09ejvczDzmfWGsnLQaV4/PnsONB0m1ghoqerB4pMFY3Af41GgmVFXMXNS
         YyRkYnog584Oy8leIF/0nbwK6L42giCZD48stK7Q0sucf50uEfN2R33jDMvq6mo9oW7+
         d2lYNXLylRILKoJCz4dRzSTo4D1yJEIUE31B8I8sWZQsqixGdzViclQLFTF9cd+TwY0R
         ml4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009672; x=1795614472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zquXBrMDSkgmhzVSBU9n1JfbEE6tjoTWMroKtZE+aJ8=;
        b=M8c3hnI+EDuheeeVHmWf63K8665qsV0BcTQ4dttFS8DvP4WivK/xr5J7cPFeM4xRw3
         HcIFz2ruehFdf9ajUIJkx+dH8MnaXGJrgza6G010eyO9e7nRgBeB6+abtuQruGwIOXCf
         qQruoPcUOygvljVGTj7+kd7rc7GVfGBU4/Yg4z37GmIbAV/xP8yOZfH5tecwN3U/Uxoy
         bpNtKIsccdx7zoOyYdo3UNR5zs21JliJB9zPn8BwEY0eP1w033pkVIbgCVOaqOsuJ90q
         +J1owRu7YlSDniSfjFImqrf2J1nggt/Wp6xivmzqux0idpkjwZPyTDL8Xqk9yZSd0Mmy
         Ju5g==
X-Forwarded-Encrypted: i=1; AL+hErHqfpy19tNLp7aWVNs1e0Lm39myPBnUMV/dRR51T9avNG8bqlJUkkz+cqGhIQx6bjuG2e7LefjkmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tnEYyd4W+b5UAcr6etSEus+ky/vN5VG3P40XKGRFE6prlAxbf
	JgomYSd3GYp7z7MJg99900Tcveu3ZkIzGsK12vvFVv4JcOAJIRVVIYuT8q/fy1ooXYJuS7jVqF8
	Y+rLd4ixJhM1L7e5hAw==
X-Received: from wrqt12.prod.google.com ([2002:a5d:460c:0:b0:4a4:28a2:fcf9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d84:0:b0:4a7:150e:cfe5 with SMTP id ffacd0b85a97d-4a7150ef4dcmr3970052f8f.42.1795009671601;
 Wed, 18 Nov 2026 05:47:51 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:50 +0000
In-Reply-To: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134750.658250-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
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

On Tue, Oct 13, 2026 at 02:07:42PM -0300, Daniel Almeida wrote:
> +    /// Drivers that need to change a clock's state at runtime (for example to
> +    /// enable it on resume and disable it on suspend) can keep it in an enum
> +    /// and move between the variants:
> +    ///
> +    /// ```
> +    /// use kernel::clk::{Clk, Enabled, Prepared};
> +    /// use kernel::error::Result;
> +    ///
> +    /// enum DeviceClk {
> +    ///     Suspended(Clk<Prepared>),
> +    ///     Resumed(Clk<Enabled>),
> +    /// }

Nit: looks like this doctest missed the vertical import style from patch 1
(and `Result` is already in the prelude).

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
