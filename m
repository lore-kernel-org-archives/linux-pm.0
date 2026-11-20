Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193336;
	b=GRD2n7YkArjRX8jCUhdMcynRncnU7mzNV204Nkx0bd2Ry5TM97AHGarHKYEB6NxQvO+a
	 2UmFsfT3lmhLrXkZ317EnakSJckyjXNoexgJK2yKEUdFZAyU2BkRg+wIMQ8Jt4qf32MF/
	 EMrAxDKb2XaphEz3fUVPQRgG0EmdYr8/HUNScF0/EZfhubX9i9p4SyPhMZpBVUva/VWtg
	 mie9B9dzbnYUx+tJ1jzZePpDWiVFtXoBkBE8Dn2y+r7N7quG7+d4IpyUepxNAHArgttxz
	 FbSFuSm/9yhNefpucRrVhKQqfpNiXGBW2RfUgePJy+RtOhtI6ou4v4YPJDh4fgvo05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
	b=FJUzjpULsGn1G4cLUgRjkXm0d3KFM8Y8UXaPVLmKhYkxBffU/774KcqxhAa36iHVFkFI
	 zyMG6fWU4UYptx0fZiBJ/0X4/ENcp6rpUX0sC4Bx2f7p3Y9brcOFDuNrGe4foA2Inx0P2
	 95PazqA1XJ01plBxEw7XArqlxy6zkQ6b/gL5fyFBk6ClXqAkpJiODdOBJbIUC8Zu4aCpt
	 rpqll+4Z4kyNSgX2mwrICv/MO29sGvNME6sAH9BOArYEWZIE59K/r+BHhQ/JwdIbFETMr
	 UXInK9HJuQQSzSOE7LmODxvMidAOFx1n+adGEmVN7OiFWN511xFqK3aor1zpyrtju0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ThqzXs9e;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD795606A330
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD795606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ThqzXs9e
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1037254f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795193334; x=1795798134; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
        b=ThqzXs9ebiZGDM31gPGl6udrq/rds0mEtWQp5ii2kuizKVYwjIt1mRHIaBc6Fzz0d2
         gZA+3ggV2soL3PWUUsf4dGrZlqtGT3N8dW9S0rzOvNQN+sX7aPjYnnjG8vMoBzwfpOwz
         tGsIJXI43jmP1C3DUXG6T02SB7eruboytZi8alvfqyxGspyzlXpROvgdj6SReMSKJXLK
         kDHyIrCBfTy88WmXKjhS4HGD4CbC9N1lhIR5d7S7XuHHH+BaFEQY+gThdDukbyRKw4qQ
         /zWnhCNKVVlyZbltXIvRV9hF2hZzKltNgnSRMcwh1bP3tRso+GxfXCMD6VYbl97yZMt/
         Dyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193334; x=1795798134;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
        b=uOADvPiuvUFCw5xn/XI8BmCFIgVYIYvfInQMujv9ipSxLL2cGlVQQFe65V60IiqN4x
         j1ugDDXNwWPuUtvuN7m2qiDY9M/6HvcL0kUWhWrlNuIvP/feg0epWbHSBOEv37vmE1it
         pGiA9IeZICQSxVl6EZAbTCQDMH/09QmreV/EPKBL/A2jnSNOFD4ek1uvKWycclJ8p9zz
         H2G+Sh6yjbMhczXMj6YE+eZqVTYl4DSb4koEyeVLJVSh+LmlzJXW5hBPCETi5JtS+i8e
         dlWQu3aquPEDtmuTQ0KhSSqp05Gyan5tfzF8rzBHdhnKjrt5hTn+3gO0jSESr4i8jP8N
         PGkA==
X-Forwarded-Encrypted: i=1; AL+hErGB0uQIs/QaU3LvbWhPpQ4RsOzH68S3560SD9KXycDSPr4gTbOIvunkfdDrKExtzWvAw4XQ9g1JKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+K7yGVKh+aK89geK20C2zdtIWqxcva4OmAyZYaQm97qvi7jPaL
	bKFQ1INnk6ADnKHe6WExGmOjnRVlj8xmvy+C41xQz14/1kq8Nag03CKBiqAWwWhsmEY=
X-Gm-Gg: AZFdTZejKhfOEACV6W+YdfwWlbcjnvE/4lxg+6uU6MZrYbhV7K5AEp2/GZ4rGdNZfHV
	kdjLTZvY3haxpgbnEEvMg2YGdtIbAuydTTxK9WicGDb/DQ8Y5Dgz0MJObQKVkxNlDHqDdo043EK
	x2NUZ/J9vGHOUujG1660UVH7q+LmZUpiNv4hIizLqyJJ+ZYLL0vqFc8AfPYp9zhYoAQ7wJ0PM44
	39e2wWiV53khKzqD4C7yxKZBpr5vSOHM77drFXQK6a3Y0Y9ZLCStevMG/mr7DJ/SLIVn9rxDNYg
	R1v9+MS7GASQhXuQOEp1viQwz4vRKUukake0bXSFY9gqAFKljvcCZMnZqzzpwYF+n4MeharKwIe
	3MVgW7ovV+cJcrom+eNPbDi5T6S+lGHHahjbmp7vKfHjZnnm4U+OCbh8wZ5kpXGRf0dvAWdHU75
	qvigT/E46EosQjUmI/0OJmLXpaRsUrJOTrc3bCIg/9lCDwXmjkEdJr/RXak3xm8MG838969dkuu
	tsVLOS6y/HfUUgH26qYIY8US8NSF673GOdFEuCDGl9S2PzQHcf/HOlK2N9SLJ/rtrVgs4+DEGsQ
	pU5qRDmGQm/1VpUtmfN7UyRLQF+rUCPF12K3a3ChL1mG2t/E
X-Received: by 2002:a05:6000:2c0e:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-4abad5ac62emr8227901f8f.5.1795193333959;
        Fri, 20 Nov 2026 08:48:53 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm6034212f8f.34.2026.11.20.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:53 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
In-Reply-To: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
Date: Fri, 20 Nov 2026 17:48:51 +0100
Message-Id: <179519333138.3795820.61438010297111723.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vYLwHzMkZLjjbU0w6/Ec7PCJHgruiB342xDmGbUK7jQ=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlV+EGpr8GpuXL66eHBu5Y3mWWeFV4a/G+0oUxUrer
 RUIcefpKGVhEONikBVTZKnhrhZ/J6n1ZdZ0ndswc1iZQIYwcHEKwETm3mJk+BtiEpjsotk54bty
 cAsHW8fEZPaiNRy3p1XOeRy6T/PLD0aGzfPKGdIZvNz7xBo2Ljp/6Q+/laCNSwnzT95L3nMcLF+
 wAwA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> The current Clk abstraction can still be improved on the following issues:
> 
> a) It only keeps track of a count to clk_get(), which means that users have
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
> 
> b) It allows repeated calls to prepare() or enable(), but it keeps no track
> of how often these were called, i.e., it's currently legal to write the
> following:
> 
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();

This particular sequence is indeed allowed in C. I don't get why it should not
be ? (in general and/or in rust)

If you dis-allow this in rust, the 2 sides drift apart, don't they ?
I mean they start behaving differently. I suppose this is not something
desirable ?

> 
> And nothing gets undone on drop().
> 
> c) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk is
> enabled via the type system alone.
> 
> Following the Regulator abstraction, switch this abstraction to use the
> type-state pattern instead. It solves both a) and b) by establishing a
> number of states and the valid ways to transition between them. It also
> automatically undoes any call to clk_get(), clk_prepare() and clk_enable()
> as applicable on drop(), so users do not have to do anything special
> before Clk goes out of scope.

So the point the is automatically clean-up (as in disable()) clock when they
go out of scope ? In C, the equivalent would be calling clk_put() with a non
NULL enable/prepare count. We do complain loudly when this happen. I don't
people should encouraged to not actively care for this.

-- 
Jerome

