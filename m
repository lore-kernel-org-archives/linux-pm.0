Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009671;
	b=Vok4oVFN7gUUnOxxW7gJx7DovZ2boWYc3Z1hXkyKrZ3d36pDams3Jb4voPi7GpRlBicq
	 8lrScpKKMONZhgJPSTKalB5teZGd0/PTDOUHFtX5CJ5/zGV3haPrLw77hpxJaF4nxp29K
	 oRO47YlCYZKfB+zKMFW4VQSQAovENMHFw864yOlBPsuHPhMOWT40V3ArQz2rDEscCy1On
	 FWlIhPqipykuj5CBUo4IIYQZ45kIgYZ0rc4ve2GIYJPpdUcGfC+prNzrdCk0FkxEi3wK1
	 Bf2LlTayl+/8qQh/Eg4Vq75ch8t3H/eBM88nUvsv9HeukfWwBKb3a00HYjT2JrbhNyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
	b=obZazttnZShUTVvdn/bKxnZ7g7fOfa+2ZVlLitfjhYs121K24oJ64qvHUwt3meLHPxsE
	 m4ZnYtypdCrnLYmPYJP8csjzJc00NOd+WZ6DFHsMEbHtiaGIZ22cbYCShzd/FLPzQvoR3
	 NbUKYs8ZdgmNZu9ByXIIqumVHv8VTDRVS3YSMJXKFeEap9mTjzlwiwKmjuZkqQU4kiW/T
	 Xn5+4rbIDe1tonNHzJB94PQoie9zsvqtxHN2ztOvRcELmeSMRi0uTAUuSNgU7HZpO0bOt
	 VNnDGGveSBkjLmCVJUDCH0TMaX81fON5UguNiKcNy0TCCwBI0MuFtkjWYpY6zV1VPlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JbPHYrLm;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF695606A320
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF695606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JbPHYrLm
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-49034831bb3so690527f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009669; x=1795614469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
        b=JbPHYrLmilie8tim6UMjJw3y4D2agEMcgJhzkH6d6H1xauaURr5MM7N+XZPWoQN1V9
         JOVnnVBHfON5uLr4iZ9N29pvVyHIP3Zp2uTXc8nIU26s4mf3KUa3WUwkP2/r7ww570sn
         6eY4B7G0Ar8vsyDOhjyN/mj7Od4s+NY0Z87HQVmNXVvlITGAOSIGyasPji3a5NDM11rc
         S1HC55SFRG1U3OddKseqb2KQCT4uIdFOWnfZFC/dC9kyymV5AZsvwe6mFs8p4YRDGlPs
         7wHZSTU/8Vym+5q/IqfvTVUgOux1W3DtW7lkAeOl9hLxiGo7NaT2G1q78jA4gGWQxwqK
         78nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009669; x=1795614469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
        b=BxMN8IUXLVAJ7Gk172ucnjb4z7K623fggTzffVJWqiL9SGzxDJiErL08JTg6RkCRsH
         B/CtKIPlb4tmCbYCQihnMsT+jQJGjZgOqVKPDA3QnU4GWpg/7zG1CWCB17xoHUIZcWQq
         n8jL5tT4X2HbiUwcWUVfivXfdyOqVLkOiVhMXa8gyfZ2kmwIdV9lfidp6NhyNZIN1xEz
         AuoMcT7fhkKYB76E7pRYKHCfWKVqzMMae1kWLljW9qDBdvI1ZvNViVWidi9J4Y2HisQJ
         BdzwokSXaZvcwdZXeqZx+6GvB1bWGp3O8UpVTJwqnfCMe5BvYR1TtBaAxrgy0Ov6tgGV
         2BPA==
X-Forwarded-Encrypted: i=1; AL+hErEC/iw1BjLD9KjkFnAIA5EGFFESS1vEcGbMBB53ClQcpSb9Uwzx2p2kObS6k1Fh33SgrdefqEhHqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xA/fW13/2DlEYh+TZJ+zPqkFrScHxpNPCYPufGe2aPV3CO4S6
	hOQFtEGlQjOMRBVE8aYTYZVOnPOeZPt6YB1ZEuQijnfICZfGLEG1kGFzj8pX3o3jvCR+Fbtf7Ix
	cMKxdwl29L6L3x0CQtA==
X-Received: from wrop10.prod.google.com ([2002:adf:f20a:0:b0:4a7:5aab:c222])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c9:b0:492:b1c5:6db4 with SMTP id ffacd0b85a97d-4a63bbc379bmr5187806f8f.26.1795009668616;
 Wed, 18 Nov 2026 05:47:48 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:47 +0000
In-Reply-To: <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134747.658063-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 2/7] rust: clk: replace `OptionalClk` with `Clk::get_optional()`
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

On Tue, Oct 13, 2026 at 02:07:41PM -0300, Daniel Almeida wrote:
> +        /// Behaves the same as [`Self::get`], except when there is no clock
> +        /// producer. In this case, instead of returning [`ENOENT`], it returns
> +        /// a dummy [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_get_optional`] API.
> +        ///
> +        /// [`clk_get_optional`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
> +        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Self> {

rustdoc appears broken here (putting the URL on the same line as
`[`clk_get_optional`]:` avoids splitting the link definition).

Otherwise LGTM:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
