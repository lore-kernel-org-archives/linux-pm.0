Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802699;
	b=FDOeabNc8cqNXnyUFLBfRwin2VuphEOWAmWT0vva3NTFdA6hHDue4seH0iCVGO0oP5+X
	 3QRQYwRTvb2/K1GdCPs/4kKHKV4p9D+lTsBuMbS/eY1o0UsuWnYxGBHYZtJrs1eoAG43V
	 VDaBkuAyhesM02jwI1ZwvtJ3bjfMmdoMeIOkUroY9I+dp8d7NHmgJ2/kvUAgvA8hr2xPT
	 eKX5FeJqT+rOT/2me2AtAt0WHIHBkZV3baz8U+ysrAeLLIUa/I8LZsyabbUzSf4s5kevP
	 MgVhY17nO34de6YZq7hvKQe61Dr96eZCdFRf2ap2YWCmQJqIKyuKZYrm1VkhvYmF5ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=RqlkJ/I+EH0yMfrfHVvBSdwYQQPjzHS4s9eY4ppBylg=;
	b=KRY04kKw93B5jAZk+aTsTtgWIFXXWWvS76X9pFIQE2MEYbytnuVqenYkHll0rH2D04nc
	 PZBLnsL7SsAKap2ss/QcNahpCkDInfFAZzbpl9BtbdAJyl+r3wKuSPzI8Or+ISwPxndBD
	 bHngfvLCZHl9RWOIKI8n2B2fTM84qeV8eLjnkza4BA16cGqddknR2s62yw0WBiUhN3Wk8
	 JMt5WlKQDP+XF21VV1F9LWBPE4KzVbyqO+PeCknyKNTgrG8s0ZyRVJmpU8a5lh7Utj25G
	 VXj40oSEg6Xh0r0hHLpmM1svzM0pSnKKTkQcSigRwz1dTfO5aQmFnIQlErOXXOW4ecg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Iy9+aEIQ;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DC606A31F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 18:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6DC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Iy9+aEIQ
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so13044317a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795802697; x=1796407497; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RqlkJ/I+EH0yMfrfHVvBSdwYQQPjzHS4s9eY4ppBylg=;
        b=Iy9+aEIQ/sKkgpla/Kw3npoC6iqmm4ymf2V9QCMEc3ojxV5crKQVO3j0cnHzP3E4zH
         VDe45YUOG1Ojd2XuSLfQhsZ/2uHqVH+fPlScXcw0cEB3Nv0u5aj9MjxEAT/MUUc5qpvH
         aW75lYxib8O/r48eqz5Nytk6Sr+3trLin+yzkvuRTo0Mf4tmY3pPTf8F5WbsHohWx5zo
         9XcqlXTnJZ9oYO1CfvignZLNzJtpP1K14ziis2ygXPr6wcSm14s04ME6oU6iLXEXA980
         3zhsdRAkRDcGZS4e3vsRjAiXzxgoVGFLbHwvcr2gcstiPxxpSggocz02Qboy11izNIlH
         NXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795802697; x=1796407497;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqlkJ/I+EH0yMfrfHVvBSdwYQQPjzHS4s9eY4ppBylg=;
        b=20PNEBcHA/IgivG7ntVDMRACuLWp24gJmLAjjzUzUPIFy7HOIPVpAKs+Hcslb8Wsfn
         1LVElupvXYXk8HDbtStPqdtIgpKx45nU/CdSChDonC1n9QobFzxV8xSEPYwFSFYHVxjL
         Die952EkxlZSNYz0RYpioPoQIlCE46kkpkMmLouI51rHd1x7mMOxe18h9mC9jIYovkNI
         Zdt7t5JZhHjqXftpTe9P2mTMg3k95sq3Jxyja/edxKZEusRwz6CkioHyN0JhegagEhVe
         qzyhMsyFz2G83Ftq8bFYyT0WggiMPFF1/9zcDyb97cSqJv3cxrwi2Y57R1i7DzxjvQE5
         U+Xw==
X-Forwarded-Encrypted: i=1; AL+hErEux8mSpDtv2Liy07xtJMf+ywZGrRaHd0RdccUYsi1oCCDDQhYag1n086kkMxrDi3nfXa+U6f7Bxg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zt7s/O7cYPpXYn2I/dYkZeIKPq2FtpKAsgtZRMGMukrx3/IND
	mjmC50kwEukEsmTOZIAHnxKm8K9EJGIR7ydAU6YrGgeTgZHRCjalwvRmsz5cI5C2seo=
X-Gm-Gg: AZFdTZdW4B8s+dSg0EgLaQbwH0AY689rOj5MuECy2uKGm/VT5XeFXx3v73pHe+Uw7QL
	5lKjSOn1cUEunqG0nvsxRctcojXMFxLDEOSv42XeBOVrb9fi1iOyLFJgcWdNWp8iVsFUHH24ssN
	2nDvxTj4CF4NePWBwT4DJt3yCi1zCUP1cNw51RXfN3Gz5cPO8Rb2DP/P32efIoW3mB/gRkOABUi
	CqAdpIUDhIyvLAos7Tr3kdvtDTFwvhz7V8p57sgaOUYRH93kmPlFBvQYywe2ehLR7PFdm45Soe4
	aE9HtLoCUHGEGv/398I1mRaVA39hXm4bt4Ka3a58KAgwuikkhC0CCPXyhLlr3ruC++zQPjfsI+h
	e3q8Gt7YQBUGVyn7DoiZSzk8QHFVWjoJvy/x8FlZ+zyf1Ub3i1svofKXCqDRfdIe3qF7YE2BoU9
	nwKDG5VhJpK/hJwH4WufB6zb+RduHdjrhYY5G1E67tFe2zvHVxmegfwVZSkaoE/vKKUZsxiRH1I
	8j9mGwTCajI+TGkRQwLPVC+B58s3izBl8FKTNCVzyoTSm3MNwrCw/68tj5JDxA3ouZ8fjQ7T+Vr
	sw0PVHhcgxAruYDn0nBaL72p7BhVnCehP7OstI6TTR/i2bwS
X-Received: by 2002:aa7:d94b:0:b0:6b7:df0c:18bc with SMTP id 4fb4d7f45d1cf-6ba37d3b56bmr13992034a12.17.1795802696609;
        Fri, 27 Nov 2026 10:04:56 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba9b131d3bsm8376099a12.34.2026.11.27.10.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:04:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 5/7] rust: clk: add devres-managed clks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <189F36A9-D1C1-478A-A195-F94D037E4376@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
 <DMYELN5M09W3.1SYPKW7DZ70E1@garyguo.net>
 <189F36A9-D1C1-478A-A195-F94D037E4376@collabora.com>
Date: Fri, 27 Nov 2026 19:04:53 +0100
Message-Id: <179580269373.2809466.3866997464599192193.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=EVdcrIGg5JsCx0X3upJdG2WoVOOBbQm+FMplR+16eVc=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcx1wf2nxO/vlS7391p4r88j3CD8rvTtqo+zJHx/l4O
 F/jc7mfHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZiImTYjwzur9Ptm8U6ip4rk
 vVaFZW/7m3dS40HhpwtLzNJM1yWbmDP8s+KdsNvXYe+JLxfuuvhc1WqSbtuQczJ5c3eeFEuIet0
 GNgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On 2026-11-18 11:47 -0300, Daniel Almeida wrote:
> 
> 
> > On 18 Nov 2026, at 11:24, Gary Guo <gary@garyguo.net> wrote:
> > 
> > On Tue Oct 13, 2026 at 6:07 PM BST, Daniel Almeida wrote:
> >> Many drivers only need a clock running for as long as the device is
> >> bound and never touch it afterwards. In C, devm_clk_get_enabled() and
> >> devm_clk_get_optional_enabled() cover this case.
> >> 
> >> Add devm_enable(), devm_enable_optional() and
> >> devm_enable_optional_with_rate(), which wrap the C helpers. They return
> >> no handle, so the driver keeps nothing in its data and cannot change the
> >> state of the clock. The clock is disabled, unprepared and put when the
> >> device is unbound.
> >> 
> >> This mirrors regulator::devm_enable() and devm_enable_optional().
> >> 
> >> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > 
> > Given all the device resource lifetime changes, do we still need this now, or
> > would putting a guard in driver private data to be dropped automatically upon
> > unbind be sufficient?
> 
> I think we should still provide this. Many drivers only care that the clock be
> enabled at a given rate, and do not care about the handle. I think this has
> little to do with C or Rust and should be supported in Rust too.
> 
> — Daniel

Gary, is this OK with you ? if it is, I can take as it is.

-- 
Jerome

