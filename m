Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780516;
	b=rFr86ke9XhvHubhfeGuMuDFP4xA4VKhTQvwtQfonJzF9/zEqWMgFCmghDfu/Rfb0i6hW
	 3ZzkyuYiT7cRA91I6vKRX1jhA6Ig2AWTQOWb2GHgMqWVsUezyepYfscuEZyb5MnaL9FtM
	 W4ErZg/wSy6BvhGHrLt8B94hedmc59iIGz3drZ3pSPn96SKDj35ksvQep7dGcQexKqMNe
	 Juqfl27yF/Iewlmc4X5zIH9Y+gveIzyOLiFYg37NN8ZXAboG8+KI17qv0mYwjEokbJAqO
	 NZe+aEr2zsPx9wANgHY5MSl/HXAEJpiXcLdRaaZ9gX7n7aW61VvPFOAIaue1qBOJUQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oC53DZWwYgEwPzoWhOOW+rI9blG5esMjqlTZQyYiaTo=;
	b=BxWj1/8As+2XrqxtIlET1+uHSMv7bUcLpZAhyzkWeOGrcTqMhT9aLERxdD9OwKLdMZ1u
	 HGATxJV5LrWq91x79pzWH/eebt82D4Bzm6rZofHTGY+5JmY3AMmYCHqymJ0KWwqc2hfot
	 /yMUnJjIu7B8mXvzczYJ3rAZeHuYg/xmhgwfolObK8ATlYS1TtJxMSDr+oIcgZcXDVMs9
	 /t/WusvMR9+hL0hbKBMqs8XQkpv5h7EsScir/XwpQrKLJxa+SAJwSSyxQoiyOGsnSayuq
	 rDU/Il0YuqPaj+yLao0PtuWVXgXCd/wduafgkUFFdfyIxbEOLu+jV8plYaA9+aoVAbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIsy9gn+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0485606A31B;
	Wed,  4 Nov 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIsy9gn+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793780515;
	b=n3pqtd+vyyyXsSIhYvEj9yRFbeJQkV9RcMxKPN6y+ck3G8ByC/jk9Sm1EvPS8ITKqepH
	 90s2GXhroDHXMbnZWYzz8ENGPQM3zVxOtog7meuxQIgqbWnit8I1hVK1IVKiephB44Rnu
	 URbVxCbeoSxCy/zkJwff1f1gF4G7zNDTJQW0Pmt3gFV/nSMwb27Z5e7jXrkD9IcvNod6z
	 aymSAczyed84rvXhZTUzRH12rHqwuRqIw9TGs9eZKVkhBTYM6hN0RkOatbXoUQj8oCeCc
	 8dLk+Wz7+WfhEVxIoWbEcKhDrsvb29ALFZGN2oP+qidjAHohGpZsask46xi2Uehv/EQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793780515;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oC53DZWwYgEwPzoWhOOW+rI9blG5esMjqlTZQyYiaTo=;
	b=voGAuOGCrW8IqH6PdJHkhEDDf69xHEmewA7Zt9VDsQEsfc/tkBxMlhi5P+Nk5sdfIu5h
	 YX9nqg6uXkskjOtLBKXql7obWSTd3h4NqHnBkBLKckLRLX9k4MyDfEp92hfaDb0oGt24T
	 mT5b5CYawDeNdw7uNu2iEZP8Z2d2ErjtXSqZw+ZUN2rz9p85I5K+ROTSrJN92RkCfmEnx
	 Z3ktGUSslA0Kpwox+VqovZTWjSN5P3VBwDIwhKpEmSRvG9oADD4WdvzWlKoDmnOYxvBQQ
	 GE+to5Pa4vXJhHgzSg1/LsC1I3z4zoTZ3wuRYbniOuDJcBD5svUpBlLxPfHwqKM5zPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 8E1421F00919;
	Wed,  4 Nov 2026 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780515;
	bh=oC53DZWwYgEwPzoWhOOW+rI9blG5esMjqlTZQyYiaTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SIsy9gn+qLBWR6bGwuamlupX1rUlZ0R66DblL1HeSB9cx9PjBXvqDY3nEdSf+z/B6
	 w3rrVMjYM2tfELKtZpdLQDWysqmT+gzbcQXw0K5Lj80OGcWNHGvgEho5IGuq47ICHu
	 DRJAAGcQwjkEUMGOgcKBID61rcwYUgFG/reCb0kNmyESrimrHBmMjIQTpyThMjvP2F
	 Yc4fjfOSk1IwPV6tNlgJhpGYyjNB/Slw0ayP7UZzZl/FQRAj4/QKHlbiW502TiztDa
	 yefpXtX7JT6E5qJ8LKidLwwq67s0NugQXFxOj6bhb78l3bo94bLtkn17fpcoToN1Pz
	 b1avreert1lkw==
Date: Wed, 4 Nov 2026 09:21:47 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Fabrice Gasnier
 <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 2/5] PM: runtime: Convert last_busy to atomic64_t
Message-ID: <20261104092147.00002abb@kernel.org>
In-Reply-To: <20261103141442.v2.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
References: <20261103221717.3840215-1-briannorris@chromium.org>
	<20261103141442.v2.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue,  3 Nov 2026 14:14:40 -0800
Brian Norris <briannorris@chromium.org> wrote:

> I want to use the atomic64 compare/exchange helpers. There are no
> similar 32-bit-portable helpers for non-atomic64_t.

IMO starting a commit message with "I want to use" isn't
exactly great...

-- 
Kind regards,
Joshua Crofts
