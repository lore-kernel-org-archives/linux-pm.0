Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976336;
	b=1/tcNX6BpQ8VkLfwi465Dh08WGiS9tgXH3UVfKm3waLG0BcwQ1s7qK2LFJ3bwyKGdCNE
	 fc+8WIFVi20DCob5W9mJlbcYnuBtIi42wJKvOzKhB44KhT2e2NVbuktdymlGUi0dvD8Hj
	 n4Fb8zMc0exSHHgYRxL4+WlSMYT0tiAJeBI1TUYjyLPp/RbikXe3d2/39UfhRUEPKPICs
	 Ccjy4UqHdHuxU51BO+Y8fF9+v/pSU8Xe0IGAQ6IDftLK/kbfMncI7bke9jg//pUdDfLwH
	 s1TMHJkbKFLt5B5soH4ZAggSsjONRFOW/frw06D4qkSReTGCFfabGkvHRKuRm5KsWQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976336;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ix/l4F38jVO434HYVq6V6akB5byYgkaeLNf8LFk6zM0=;
	b=t3toCnjsGz22YSb+mMHBZGmUhGPbM+m11uM6ZH83XgO+sa84zTzsyfN4NegBl1kkNOg4
	 aFUGhXTHiMFgVVK7iq2ey0H2KSjRzoyez0dsolR+CD2hdlRMGZ3NG6yfyYjiUw38mdPZ3
	 PhsVP7Ug7QjmOtScGqGON1/xPn62fTrzg75rb3gky7JK1STRaJF7wnfmRwapKRhTAOP7B
	 oViFnhGMV7CrktWpaVWgpHabUL/dkjXPemYslVITPu/3DiE+4f4zVJjDE1SRVafGnefaN
	 BxM8mzGUvtcShvpHyKJyXQJ9KC1lxDw6nD1IiPBUG1B5s8auuc9csznx8Eev/b31Ekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMC0Hc+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0B606A31B;
	Mon, 26 Oct 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMC0Hc+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD5A1F01825;
	Mon, 26 Oct 2026 00:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792976335;
	bh=ix/l4F38jVO434HYVq6V6akB5byYgkaeLNf8LFk6zM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HMC0Hc+4lrHMQ3t+0WbVY5OOKtbtWsxcj2p21qN0U1cfvHeXJtF7ZXKviEiq7d7Z8
	 YkJOzOKOuLVQULTmnnnyzrpSRZn22lYU+tk2c6D63GwiD/diW85va2ZsXCWZjO2gBL
	 t4dW1EN7gmsW0ONvBl1V+QGqHMnejrkRPCXNa1Rh0mHVFAAgj1OZHQ71Jj0sQzd5ny
	 o02J6td3J8sDy5lX0RcOqqWepX9O4KxU5tGvxDXgYXKgvUve4cOfFc8pw7qcQhzv4c
	 tpyr6Uq9umCtf72EVZf/6lamQSLi3WdV7G1309mnpq3VGECL+jTm+EOxuYCUazDGwo
	 CyRGOHSIgAv2Q==
Date: Mon, 26 Oct 2026 00:58:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] iio: light: rpr0521: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026005850.0dde6ec1@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.15.I31ffc98637199185bab952631d880c1d38d64b7c@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.15.I31ffc98637199185bab952631d880c1d38d64b7c@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:57:16 -0700
Brian Norris <briannorris@chromium.org> wrote:

> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
This one is complex. However I don't see low hanging fruit for
taking the cleanup further.  As such I'm going to pick this
one up now.  Maybe someone will look at this in the near future
but this particular one isn't going to be me!

Applied to the testing branch of iio.git

Thanks,

Jonathan
