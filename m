Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275D478E52;
	Fri, 31 Jul 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523403; cv=none; b=uI3zdD97UxSV8MFYws9EZwZ845Zo64Vggnr0tJrH6nKFyYC7je4S3IZS8BcmHsEQn8fA227eRNElEc72nfV+GF70ALicksoh6LHSeSGR4QXPk0RZOnjvryuF1g4tG0tbvlZLEdd33CBRMfLQqXDXAxfr3IKjw5KscprKrdYxalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523403; c=relaxed/simple;
	bh=QX8ngt/RJVbMf++KJL/LBPCKbYcnuLZIg6/5Rygib5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6acxYHVUPUomp3wa6xV1WW28ezIMNaUbGiM9Xn0ZTWI8jIJzm7aazRTBKbmBZdY58zlHFuAsfe1HgXAgdp7P5JfHUIUEk9DVhSdYPnAMcka1/mbZDzKDastSJraVSLM8x04wwqnSkeFjoWHCdWlTZJnvTM+Z7Qear9ET8mtyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gzoExSRN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CRle3Rz5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gzoExSRN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CRle3Rz5"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hBZZ64kDxzMlGX;
	Fri, 31 Jul 2026 20:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785523070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QX8ngt/RJVbMf++KJL/LBPCKbYcnuLZIg6/5Rygib5s=;
	b=gzoExSRNvHZcdOCPoO55JXjok5xMfupZPyI/NBgzPnR63eLTEuB//AEwjHH0xiPHUdU6UX
	Je/NQrriZ+RAHLA6bLfodoQa70ANfsPdI0B9c1GVpg0o+C6MYvuzZtGCFMhRiqBtJM+rve
	5zC8tVzK4v2wbmpfhBthQbe17HY6AWGMyP0NAbd1RP3T9GcGI7Z+KLCAnV/J8dDWSBYzNl
	w/J4tqvtxKkPAW2buNOFJ2krpAj42XHbKJ1pNTiy1FW1vyoiHwMRSuRPqmT9rOfcUIW8ZA
	8ww8GZH4bxTTX31rCvQRqsatj34bREJAzIUqGm6b9za6eYjAIijraDua+rbaKw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785523068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QX8ngt/RJVbMf++KJL/LBPCKbYcnuLZIg6/5Rygib5s=;
	b=CRle3Rz5W/Z6Iu/JZeK7rglhJKdRD8g1Qv6wYQ0gghE+uslGkZb85l2Cy/MCTCAz3ahKc7
	wMfxejBSJPhmN9ykA53tH7BtzuhLaCY5KLbQ/QmqamAxYjs7HBuJGchwqt/I1crtHTekvD
	CR/cz3jc5DfB41DJb+4GM3/7hZ9dJZd4fFPQSettPWa7ywhQt2Nb0Jeu8klf2nKLe/XbHp
	i/cd4x5t2E8BzG95QG9GVu5iPYboX98nvpuCSff0uhc4OHrSzd14nSJjM8ngH4/ec3eSrs
	I/VkWDh4O4WA0GTj6EwuGpJJlN9J1I4iuH8KkzBeCR/8Oc4bbKHf8Rq64xxAfw==
To: Daniel Almeida <daniel.almeida@collabora.com>
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Boqun Feng <boqun@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Clk improvements
Date: Fri, 31 Jul 2026 20:37:33 +0200
Message-ID: <20260731183735.15036-1-mhi@mailbox.org>
In-Reply-To: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xyozd5q8pkgd7wa6h1p6spxmwcpuquit
X-MBO-RS-ID: 693f47d480cfe3c056c

Hi Daniel,

at your suggestion [0] I rebased my `clk_rate_exclusive_get()` binding for
pwm-th1520 on top of this series, so it is now waiting on it to land. As v5
has not seen any comments in the last few weeks, I wanted to ask what the
current status is.

If there are no blockers left and you expect it to be merged soon, I am
happy to keep waiting. Otherwise I would offer to send my series standalone
against the current `Clk` API and let you rebase on top of mine - it is the
much smaller of the two, touching only `Clk::rate_exclusive_get()` and
pwm_th1520.rs.

[0]: https://lore.kernel.org/rust-for-linux/140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com/

Thanks a lot,

Maurice
